# Load MPI package and read in file of helper functions
# This file incluse: getcounts, getnormcount
using MPI
include("word_count_helpers.jl")

# Call MPI.init() and get communicator, rank, and nprocs
MPI.Init()
comm = MPI.COMM_WORLD
rank = MPI.Comm_rank(comm)
nprocs = MPI.Comm_size(comm)

# Load the file names
dataLoc = "data";
fnames = joinpath.(dataLoc,readdir(dataLoc))

# Distribute filenames by rank
myfnames = fnames[rank+1:nprocs:length(fnames)]

# Calculate the word counts
mycounts =  getcounts.(myfnames)

# Gather all counts onto Process 0 and merge
if rank > 0
    
    # Send mycounts to rank 0
    println("$rank: Sending mycounts $rank -> 0\n")
    MPI.send(mycounts, 0, rank+nprocs, comm)
    
else # rank == 0
    
    # Recieve counts from each rank
    allcounts = Array{Array{Dict,1},1}(undef,nprocs)
    allcounts[1] = mycounts
    for i = 1:nprocs-1
        allcounts[i+1],statrcv = MPI.recv(i, i+nprocs, comm)
    end
    
    # Use merge to get the overall counts
    allcounts = vcat(allcounts...)
    overallcounts = merge(+,allcounts...)
end

# Now send the overall counts to all the other Processes
if rank == 0
    for i in 1:nprocs-1
        println("$rank: Sending overallcounts $rank -> $i\n")
        MPI.send(overallcounts, i, i+(nprocs*2), comm)
    end
else
    overallcounts,statrcv = MPI.recv(0, rank+(nprocs*2), comm)
end

# Calculate and print the normalized counts
normcount = getnormcount.(mycounts,Ref(overallcounts))
        
for i in 1:length(myfnames)
    fname = basename(myfnames[i])
    top5 = normcount[i][1:min(5,length(normcount[i])),:]
    top5 = join(first.(top5), ", ",", and ")
    println("$rank: Top 5 words for document $fname are $top5")
end

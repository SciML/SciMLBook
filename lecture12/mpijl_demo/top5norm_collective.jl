# Load packages and helper functions
using MPI, Statistics
include("word_count_helpers.jl")

# Call MPI.init() and 
MPI.Init()
comm = MPI.COMM_WORLD
rank = MPI.Comm_rank(comm)
nprocs = MPI.Comm_size(comm)
root = 0

# Load the file names
dataLoc = "data";
fnames = joinpath.(dataLoc,readdir(dataLoc))

# Distribute filenames by rank
myfnames = fnames[rank+1:nprocs:length(fnames)]

# Calculate the word counts
mycounts =  getcounts.(myfnames)

# Do an initial merge so we only send one dictionary
myoverall = merge(+,mycounts...)

# Gather all counts onto Process 0

# First we have to serialize the dictionary so we can send it
msg = MPI.serialize(myoverall)

# Since each msg size is different we have to get the length of each one
msglengths = MPI.Allgather(Int32(length(msg)),comm)

# Then we can gather on process 0 (root)
res = MPI.Gatherv(msg, msglengths, root, comm)

# And deserialize and merge the counts to get the overall word counts
if rank == 0
    
    # res is one long vector, first split it up
    idx = [0; cumsum(msglengths)]
    res = [res[idx[i]+1:idx[i+1]] for i in 1:length(idx)-1]
    
    # Once it's split we can deserialized each dictionary and merge
    allcounts = MPI.deserialize.(res)
    overallcounts = merge(+,allcounts...)
else
    overallcounts = nothing
end

# Then we can use Broadcast to send these counts to the rest of the processes
overallcounts = MPI.bcast(overallcounts, root, comm)

# Calculate the normalized counts
normcount = getnormcount.(mycounts,Ref(overallcounts))

for i in 1:length(myfnames)
    fname = basename(myfnames[i])
    top5 = normcount[i][1:min(5,length(normcount[i])),:]
    top5 = join(first.(top5), ", ",", and ")
    println("$rank: Top 5 words for document $fname are $top5")
end

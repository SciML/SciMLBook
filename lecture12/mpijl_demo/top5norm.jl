# Read in file of helper functions
# This file incluse: getcounts, getnormcount

include("word_count_helpers.jl")

# Load the file names
dataLoc = "data/";
fnames = dataLoc.*readdir(dataLoc)

# Find word counts for all books
allcounts = getcounts.(fnames)

# Get overall counts for each word
overallcounts = merge(+,allcounts...)

# Calculate and print the normalized counts
normcount = getnormcount.(allcounts,Ref(overallcounts))
        
for i in 1:length(fnames)
    fname = basename(fnames[i])
    top5 = normcount[i][1:min(5,length(normcount[i])),:]
    top5 = join(first.(top5), ", ",", and ")
    println("Top 5 words for document $fname are $top5")
end
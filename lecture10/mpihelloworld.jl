# steps to setting up MPI
# 1. Pkg.add, using
# 2. MPI.install_mpiexecjl()
# 3. mpiexecjl --project=/path/to/project -n 20 julia script.jl
# 4. mpiexecjl -np 6 julia mpihelloworld.jl  
#
#also
#export PATH=/Applications/Julia-1.7.app/Contents/Resources/julia/bin:$PATH
#export PATH=/Users/alanedelman/.julia/bin:$PATH
#also https://juliaparallel.github.io/MPI.jl/latest/configuration/#Julia-wrapper-for-mpiexec

using MPI

# Initialize MPI environment
MPI.Init()

# Get MPI process rank id
rank = MPI.Comm_rank(MPI.COMM_WORLD)

# Get number of MPI processes in this communicator
nproc = MPI.Comm_size(MPI.COMM_WORLD)

# Print hello world message
print("Hello world, I am rank $(rank) of $(nproc) processors\n")
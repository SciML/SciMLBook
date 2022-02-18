using BenchmarkTools, LinearAlgebra
Threads.nthreads()
BLAS.set_num_threads(1)

# BASIC LOOP
n= 200
stuff = [rand(n,n) for i=1:10]
function busywork(stuff)
    for i=1:10
        stuff[i] = inv(stuff[i])
    end
end

# Time the Basic Loop
busywork(stuff)
print(" 1  thread: ")
@time busywork(stuff)

# WITH THREADS  -- really a PARFOR
# in 1.8 this will always be dynamic by default,
4

busywork_with_threads(stuff)
print("$(Threads.nthreads()) threads: ")
@time busywork_with_threads(stuff)

# DYNAMIC SCHEDULING -- # feels like there is a computational graph in your mind
# In 1.8 this is no longer a good example for non-uniform work loads
# but even now is a great example for traversing binary trees etc.
# (PARFOR @threads could have been implemented from @spawn's but is more specialized for performance)
function busywork_with_threads_dynamic_scheduling(stuff)
 @sync for  i=1:length(stuff)  # @sync is for the timing  #also a parfor
    Threads.@spawn stuff[i] = inv(stuff[i])
 end
end

busywork_with_threads_dynamic_scheduling(stuff)
print("dynamic scheduling threads: ")
@time busywork_with_threads_dynamic_scheduling(stuff)


stuff = [rand( i ,i) for i∈ [ fill(800,3);fill(100,18)]];
@time busywork_with_threads(stuff)
@time busywork_with_threads(stuff)
@time busywork_with_threads(stuff)
@time busywork_with_threads(stuff)
@time busywork_with_threads(stuff)
println("----------------------------")
@time busywork_with_threads_dynamic_scheduling(stuff)
@time busywork_with_threads_dynamic_scheduling(stuff)
@time busywork_with_threads_dynamic_scheduling(stuff)
@time busywork_with_threads_dynamic_scheduling(stuff)
@time busywork_with_threads_dynamic_scheduling(stuff)


function lorenz!(du,u,p)
    α,σ,ρ,β = p
    @inbounds begin
      du[1] = u[1] + α*(σ*(u[2]-u[1]))
      du[2] = u[2] + α*(u[1]*(ρ-u[3]) - u[2])
      du[3] = u[3] + α*(u[1]*u[2] - β*u[3])
    end
  end
  function solve_system_save_iip!(u,f,u0,p,n)
    @inbounds u[1] = u0
    @inbounds for i in 1:length(u)-1
      f(u[i+1],u[i],p)
    end
    u
  end
  p = (0.02,10.0,28.0,8/3)
  u = [Vector{Float64}(undef,3) for i in 1:1000]
  @btime solve_system_save_iip!(u,lorenz!,[1.0,0.0,0.0],p,1000)
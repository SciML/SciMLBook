using BenchmarkTools, LinearAlgebra, Random
Threads.nthreads()
BLAS.set_num_threads(1)

n= 2000
stuff = [rand(n,n) for i=1:10]
function busywork(stuff)
    for i=1:10
        stuff[i] = inv(stuff[i])
    end
end

busywork(stuff)
print(" 1  thread: ")
@time busywork(stuff)

function busywork_with_threads(stuff)
    Threads.@threads for i=1:10
        stuff[i] = [sum(stuff[i]);;]
    end
end

busywork_with_threads(stuff)
print("$(Threads.nthreads()) threads: ")
@time busywork_with_threads(stuff)

function busywork_with_threads_dynamic_scheduling(stuff)
 @sync for  i=1:10
    #Threads.@spawn stuff[i] = inv(stuff[i])
    Threads.@spawn stuff[i] = [sum(stuff[i]) ;;]
 end
end

busywork_with_threads_dynamic_scheduling(stuff)
print("dynamic scheduling threads: ")
@time busywork_with_threads_dynamic_scheduling(stuff)


stuff = [rand( i ,i) for i∈ 2 .* shuffle(2000:8:3000  ) ];
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



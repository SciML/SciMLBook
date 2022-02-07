### Introduction

@btime a = 100;  # This goes on the stack (0 allocations)
# All arrays live on the heap
@btime a = rand(10,10); # This creates one pointer (1 allocation)
@btime a = rand(100,10);  
@btime a = rand(100,100); # why 2 allocations? (wrapper and buffer)
@btime a = rand(1000,100); # why 2 allocations? (wrapper and buffer)

# One KiB = 1024 Bytes

function lots_of_allocations(a)
    for i=1:size(a,1), j=1:size(a,2)
        val = [a[i,j]]  # <-- every step this is placed on the heap
    end
end 

a = rand(100,100)
@btime lots_of_allocations(a);

a = rand(100,100)
b = rand(100,100)
c = similar(a)  # this is preallocated

function add_and_store!(c,a,b)  # function changes it's first argument
    for i=1:100, j=1:100
        c[i,j] = a[i,j]+b[i,j]
    end
end
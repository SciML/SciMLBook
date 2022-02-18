# SIMD EXAMPLE (look for the "fmul <4 x double>" in "vector.body" etc.)
function f(v)
    for i in 1:length(v)
      @inbounds v[i] *= 2
      #v[i] *= 2
    end
 end

 v = zeros(100)
 @code_llvm f(v)


 # arrays of structs vs structs of arrays
 struct MyComplex
    real::Float64
    imag::Float64
  end
  arr = [MyComplex(rand(),rand()) for i in 1:100]
  # this is real,imag,real,imag,...

  struct MyComplexes # notice the "es" 
    real::Vector{Float64}
    imag::Vector{Float64}
  end
  arr2 = MyComplexes(rand(100),rand(100))
  # this is real,real,real,...,imag,imag,imag...
display("---------")
Base.:+(x::MyComplex,y::MyComplex) = MyComplex(x.real+y.real,x.imag+y.imag)
Base.:/(x::MyComplex,y::Int) = MyComplex(x.real/y,x.imag/y)
average(x::Vector{MyComplex}) = sum(x)/length(x)
@code_llvm average(arr) # look for the [2 x double] etc?

# explicit SIMD (not recommended for beginners)
using SIMD
v = Vec{4,Float64}((1,2,3,4))
@show v+v # basic arithmetic is supported
@show sum(v) # basic reductions are supported
@code_llvm v+v
@code_llvm sum(v)

# compilers are really smart, this just returns N
function f(N)
    acc = 0
    for i in 1:N
      acc += 1
    end
    return acc
end
@code_llvm f(100)
# may seem unreadable but 
# %0 is the N  
# the select is essentially (N>0):N:0
# the output is i64

  Threads.nthreads()


#using Base.Threads   # lets you leave out the Threads.xyz

#here none of this will happen
# but the answer doesn't seem right
acc = 0  # this is a global, always on the heap
@btime acc=0 # doesn't show it
@btime acc=Ref(0) # does
# ? Ref
Threads.@threads for i in 1:10_000
    global acc
    acc += 1
end
acc
#Why? reads from heap, computes on stack, and writes to heap at the same time


# atomics fixes (does the blocking) but performance
acc = Atomic{Int64}(0)
Threads.@threads for i in 1:10_000
    atomic_add!(acc, 1)
end
acc


# SpinLock (unsafe if you do locks within locks)
const acc_lock = Ref{Int64}(0)
const splock = SpinLock()
function f1()
    @threads for i in 1:10_000
        lock(splock)
        acc_lock[] += 1
        unlock(splock)
    end
end

# Reentrant lock (safe but slower)
const rsplock = ReentrantLock()
function f2()
    @threads for i in 1:10_000
        lock(rsplock)
        acc_lock[] += 1
        unlock(rsplock)
    end
end

# atomic, we've seen already
acc2 = Atomic{Int64}(0)
function g()
  @threads for i in 1:10_000
      atomic_add!(acc2, 1)
  end
end

# just serial
const acc_s = Ref{Int64}(0)
function h()
  global acc_s
  for i in 1:10_000
      acc_s[] += 1
  end
end

# serial without tricks
non_const_len = 10000
function h3()
  global acc_s
  global non_const_len
  len2::Int = non_const_len
  for i in 1:len2
      acc_s[] += 1
  end
end
@btime h3()


@btime f1()
@btime f2()
@btime f()
@btime g()



#threads work in any order
const a2 = zeros(nthreads()*10)
const acc_lock2 = Ref{Int64}(0)
const splock2 = SpinLock()
function f_order()
    @threads for i in 1:length(a2)
        lock(splock2)
        acc_lock2[] += 1
        a2[i] = acc_lock2[]
        unlock(splock2)
    end
end
f_order()
a2
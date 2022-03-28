### A Pluto.jl notebook ###
# v0.18.2

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 9e2563d9-0a3d-4d2e-a968-dfec0792dbf3
using Compose, Gadfly

# ╔═╡ 5e724594-c97f-49c0-a8ce-594aaf9cf379
using PlutoUI

# ╔═╡ abd3d725-1e21-4533-abe8-e791d242a357
using StatsBase

# ╔═╡ e5cb6242-dcf0-48ec-87ef-61ac695aa785
using LinearAlgebra

# ╔═╡ d5a3a2a5-7c28-4a0e-9343-1f84949c9917
using Base.Threads

# ╔═╡ 43b0c9a5-b1d0-4ee4-a156-b87bc15a64f2
using BenchmarkTools

# ╔═╡ eb8801f1-d9da-4fc5-8a51-e5802b86ec93
using PlutoTest

# ╔═╡ 2ed0ca4d-d7bd-4d5b-87b2-653623e0047b
reduce(*, 1:8), prod(1:8) # factorials

# ╔═╡ 347733f5-6683-444b-a673-d834609aa65f
begin
boring(a,b)=a
@show reduce(boring, 1:8)
boring2(a,b)=b
@show reduce(boring2, 1:8)
end

# ╔═╡ 2101aa7f-c71d-4ee8-bc04-cd23a2001430
M=[1 1; 1 0]

# ╔═╡ fb1f4393-482d-4e44-9a05-a49c37196ce1
reduce(*,fill(M,3))

# ╔═╡ e7ae3a69-ee05-4918-bd4e-216ce37f929e
prod(fill(M,3))

# ╔═╡ 1c4df22a-caaf-4cd0-b228-769933640d2f


# ╔═╡ a3aac2e7-987a-46a7-be95-005d20e6cf73
@bind big_M_size Slider(1:100)

# ╔═╡ 758b1b92-955d-4201-b57d-77a6b0b41fee
prod(fill(M, big_M_size))

# ╔═╡ bc7c75c5-effe-49a8-af37-107d173023ed


# ╔═╡ 4b8f2ae1-76f5-4567-bdf1-df31888d0eba
fib(j)=reduce(*, fill(M,j))


# ╔═╡ 3d3774d4-1a42-4c1d-bb11-6415db591ff3
fib.([4,7])

# ╔═╡ 64c27b03-2a71-405d-bc39-f2caf8b99b9c
# [A B]
# If A is m x n
# If B is p x q
# then kron(A,B) is mp x nq and has all the elements of A times all of the elements of B

# ╔═╡ cbf0be02-9712-43f9-b723-f221c8f83503
⊗(A,B)=kron(A,B)

# ╔═╡ 327572d4-581f-4136-bd9a-2e42bd52fdb1
let
	A=[1 2;3 4]
	B=[10 100; 1 -10]
	
	
	M=[ 1 1;1 -1]
	H=⊗(⊗(⊗(M,M),M),M)
	H*H'
end

# ╔═╡ 4d8c53b8-8881-4f25-928c-2ef08b667500
Hadamard(n) = reduce(⊗, fill([ 1 1;1 -1],n))

# ╔═╡ 4003b79a-abea-4109-b1c6-213007df5c36
H = Hadamard(3)

# ╔═╡ 37de7151-91e8-4c64-9ba0-5bff68c7703d
H'H

# ╔═╡ 90386705-57fa-4b77-b194-6fe224746956
H*H' #This is a legitimate Hadamard matrix

# ╔═╡ 6851cf30-0f8f-4cec-85e0-c0be241b9fe1
#Reduction of matrix multiplications
Ms = [rand(-3:3,2,2) for i=1:4]


# ╔═╡ 2cdbdf33-96e9-4594-a515-209dc39a98e4
Ms[4] * Ms[3] * Ms[2] * Ms[1]

# ╔═╡ b1f0c31f-eb13-4628-be1c-90cdd6fa6482
reduce((A,B)->B*A, Ms) #backward multiply

# ╔═╡ ba465290-8243-494a-ad16-0e3f275cad9e
reduce(*, Ms)          #forward multiply

# ╔═╡ 20446b3f-b7d2-4fbb-a6de-c9e0248f8a4e
(sin ∘ cos)(1), sin(cos(1))

# ╔═╡ 05733599-2c43-4b8f-b97f-1c801cdfb112
((-) ∘ sin)(1), -sin(1)

# ╔═╡ e2c6e19d-70ae-45dc-880a-186c96a51bdc
( (!) ∘ )

# ╔═╡ 9c0446a0-6c0b-44ca-9ec2-7999ed1ce318
# h=reduce( (f,g) -> (x->f(g(x))), [sin cos tan])
h=reduce(∘, [sin cos tan])

# ╔═╡ a2a14308-5f10-4d0a-82ec-717903b52d4c
[h(π) sin(cos(tan(π)))]

# ╔═╡ 02b3e05a-0d3e-4bdb-8d0e-06557cf66786
cumsum(1:8)  # It is useful to know that cumsum is a linear operator
# You can use power method! Below is the underlying matrix

# ╔═╡ 2ad106c3-71e9-4ae7-9aac-820871517318
Atril = tril(ones(Int,8,8)) 

# ╔═╡ 1ff2583e-e748-4602-9a7b-0c311c5f4097
[Atril * (1:8), cumsum(1:8)]

# ╔═╡ 4de971cd-2ec0-4f7a-990a-2c6241ca5bf9
begin
	
	mutable struct DummyArray
	    length :: Int
	    read :: Vector
	    history :: Vector{Any}
	    DummyArray(length, read=[], history=[])=new(length, read, history)
	end
	
	Base.length(A::DummyArray) = A.length
	
	function Base.getindex(A::DummyArray, i)
	    push!(A.read, i)
	    nothing
	end
	
	function Base.setindex!(A::DummyArray, x, i)
	    push!(A.history, (A.read, [i]))
	    A.read = []
	end
end

# ╔═╡ 21e1ccc7-a20e-431d-90de-5c737968dfdb
md"""


This notebook accompanies the [workshop paper](http://jiahao.github.io/parallel-prefix/) by Jiahao Chen and Alan Edelman entitled "Parallel Prefix Polymorphism Permits Parallelization, Presentation & Proof" and will appear in the proceedings of the [First Workshop for High Performance Technical Computing in Dynamic Languages](http://jiahao.github.io/hptcdl-sc14/), held in conjunction with [SC14: The International Conference on High Performance Computing, Networking, Storage and Analysis](http://sc14.supercomputing.org/).


"""

# ╔═╡ 3d1e281d-ac52-49c2-bdf7-50ff6006f940
md"""
# `reduce()`

Reduction applies a binary operator to a vector repeatedly to return a scalar. Thus + becomes sum, and * becomes prod.

It is considered a basic parallel computing primitive.


"""

# ╔═╡ e8c2fcad-8691-4e65-b79b-1d083696402f
md"""
You can also use reduce to compute Fibonacci numbers using their recurrences.

```math
\begin{pmatrix} f_2 \\f_1 \end{pmatrix} = \begin{pmatrix} f_1 + f_0 \\ f_1 \end{pmatrix}
= \begin{pmatrix} 1 & 1 \\ 1 & 0 \end{pmatrix} \begin{pmatrix} f_1 \\ f_0 \end{pmatrix}
```

```math
\begin{pmatrix} f_{n+1} \\ f_n \end{pmatrix} = \dots
= \begin{pmatrix} 1 & 1 \\ 1 & 0 \end{pmatrix}^n \begin{pmatrix} f_1 \\ f_0 \end{pmatrix}
```

From this, you can show that

```math
\begin{pmatrix} 1 & 1 \\ 1 & 0 \end{pmatrix}^n  = \begin{pmatrix} f_{n+1} & f_n \\ f_n & f_{n-1} \end{pmatrix}
```

(this applies reduce to the same argument over and over again -- there are of course other ways)
"""

# ╔═╡ b6521fc4-2b46-49c2-aa25-941dcee93786
md"""
You can solve recurrences of any complexity using `reduce`. For example, `reduce` can compute a Hadamard matrix from its definition in terms of its submatrices:

$$H_2 = \begin{pmatrix} H_1 & H_1 \\ H_1 & -H_1 \end{pmatrix} = \begin{pmatrix} 1 & 1 \\ 1 & -1 \end{pmatrix} \otimes H_1$$

and so on.

(Note: this is just using reduce to compute a matrix power.
One can think of alternative ways for sure.)
"""

# ╔═╡ 88a8575f-698e-4e4e-ad0f-2e377117b737
md"""
In the following example we apply `reduce()` to  function composition:
"""

# ╔═╡ 48955a36-fcd8-40d4-810a-58fb2ed29a9f
md"""
# `prefix`
"""

# ╔═╡ 4b167e93-a723-4264-b7ba-94ccee8b489e
md"""
Having discussed `reduce`, we are now ready for the idea behind prefix sum.
Prefix or scan is long considered an important parallel
primitive as well.

Suppose you wanted to compute the partial sums of a vector, i.e. given
`y[1:n]`, we want to overwrite the vector `y` with the vector of partial sums

```julia
new_y[1] = y[1]
new_y[2] = y[1] + y[2]
new_y[3] = y[1] + y[2] + y[3]
...
```

At first blush, it seems impossible to parallelize this, since

```julia
new_y[1] = y[1]
new_y[2] = new_y[1] + y[2]
new_y[3] = new_y[2] + y[3]
...
```

which appears to be an intrinsically serial process.
"""

# ╔═╡ 626046b4-0f6d-4810-9ec1-5853dbd05284
function prefix_serial!(y, +)
    for i=2:length(y)
        y[i] = y[i-1] + y[i]
	end
    y
end

# ╔═╡ 798c2d71-31a7-41d1-bf22-06917c674b10
prefix_serial!([1:8;],*)

# ╔═╡ 1d83a3a4-6f56-48cb-bb1a-91b95bd06fb9
prefix_serial!([rand(1:5,2,2) for i=1:4],*)

# ╔═╡ 95e5b24b-8715-4055-a790-cbda9816415e
md"""
However, it turns out that because addition (`+`) is associative, we can regroup the _order_ of how these sums are carried out. (This of course extends to other associative operations such as multiplication.) Another ordering of 8 associative operations is provided by `prefix8!`:
"""

# ╔═╡ 6e5b1286-3048-41f4-8663-f0eb676182c8
# Eight only for pedagogy
function prefix8!(y, ⋅)
    length(y)==8 || error("length 8 only")
    for i in [2,4,6,8]; y[i] = y[i-1] ⋅ y[i]; end
    for i in [  4,  8]; y[i] = y[i-2] ⋅ y[i]; end
    for i in [      8]; y[i] = y[i-4] ⋅ y[i]; end
    for i in [    6  ]; y[i] = y[i-2] ⋅ y[i]; end
    for i in [ 3,5,7 ]; y[i] = y[i-1] ⋅ y[i]; end
    y
end


# ╔═╡ 841c999d-a0e9-4caa-851e-c47be81620ce
function prefix!(y, +)
    l=length(y)
    k=ceil(Int, log2(l))
    @inbounds for j=1:k, i=2^j:2^j:min(l, 2^k)              #"reduce"
        y[i] = y[i-2^(j-1)] + y[i]
    end
    @inbounds for j=(k-1):-1:1, i=3*2^(j-1):2^j:min(l, 2^k) #"broadcast"
        y[i] = y[i-2^(j-1)] + y[i]
    end
    y
end

# ╔═╡ db62a15b-cb59-49f1-a544-5a855483179e
prefix!([1:12;],*)

# ╔═╡ 6e3a222a-807b-4f8e-aa69-10f7ddc49ba2
md"""
# Polymorphism for visualization
"""

# ╔═╡ b6ccdd83-156c-4631-8259-37b061bfd844
md"""
We can visualize the operations with a little bit of trickery. In Julia, arrays are simply types that expose the array protocol. In particular, they need to implement  methods for the generic functions `length`, `getindex` and `setindex!`. The last two are used in indexing operations, since statements

    y = A[1]
    A[3] = y
    
get desugared to

    y = getindex(A, 1)
    setindex!(A, y, 3)
    
respectively.

We can trace through the iterable by introduce a dummy array type, `DummyArray`, which stores no useful information but records every access to `getindex` and `setindex!`.

Specifically:

- `length(A::DummyArray)` returns an integer that is stored internally in the `A.length` field
- `getindex(A::DummyArray, i)` records read access to the index `i` in the `A.read` field and always retuns `nothing`.
- `setindex!(A::DummyArray, x, i)` records write access to the index `i`. The `A.history` field is appended with a new tuple consisting of the current `A.read` field and the index `i`. 

The way `DummyArray` works, it assumes an association between a single `setindex!` call and and all the preceding `getindex` calls since the previous `setindex!` call, which is sufficient for the purposes of tracing through prefix calls.
"""

# ╔═╡ b2cdfca7-b00b-40ba-8080-13fa1fbd41a0
Base.:+(a::Nothing, b::Nothing) = a

# ╔═╡ 4b3a588f-757f-4a92-a13b-01fe6a2aaa25
reduce(+, 1:8), sum(1:8)  # triangular numbers

# ╔═╡ bedc8de1-77ef-404d-bf14-448a22eb94ac
rolldice() = rand(1:6)+rand(1:6)

# ╔═╡ 5c86ed59-d29f-4827-a271-7dff0a97b195
rolls(n)=fit(Histogram,[rolldice() for i=1:n ],2:12,closed=:left)

# ╔═╡ a07e7217-af8a-4226-b6d8-6a19c2964f30
rolls(1000)

# ╔═╡ c8e347ce-6555-4c81-93c3-0ec0aeddba22
[rolls(100) for i=1:10]

# ╔═╡ 59ab4f63-b53d-422b-a3d0-2f2e154ab4e5
reduce(merge,[rolls(100) for i=1:10])

# ╔═╡ 7b896749-5e5e-423d-816c-290c70a79432
dummy = let
	M = DummyArray(4)
	M[7] = M[3] + M[2]
	M
end

# ╔═╡ 565a1758-3c91-4ce3-826e-a8f621a8b8d4
@bind dummy_mutation_index Slider(1:100)

# ╔═╡ f2eed06c-a2b7-4349-83f8-bdce6277afc2
let
	i = dummy_mutation_index
	
    M = DummyArray(4)
    M[i] = M[i-2] + M[2*i]
    M
end

# ╔═╡ 0a22d01f-44d5-481d-af35-9f2ccf35710f
md"""
We also need a dummy associative operator to pass to the prefix call.
"""

# ╔═╡ b5119831-0e27-4d76-b769-a31581077e82
let
	A = prefix8!(DummyArray(8),+)
	A.history
end

# ╔═╡ 4d7a4383-ebda-4c66-ad4a-0160d822ac7b
md"""
Now let's visualize this! Each entry in `A.history` is rendered by a gate object:
"""

# ╔═╡ 1241e6bf-a6ad-4f38-bf54-7f127a7aeb10
struct Gate
    ins :: Vector
    outs:: Vector
end

# ╔═╡ 66e0954c-7024-4a12-8e4c-0d09de4e0f7d
function Gadfly.render(G::Gate, x₁, y₁, y₀; rᵢ=0.1, rₒ=0.25)
    ipoints = [(i, y₀+rᵢ) for i in G.ins]
    opoints = [(i, y₀+0.5) for i in G.outs]
    igates  = [Compose.circle(i..., rᵢ) for i in ipoints]
    ogates  = [Compose.circle(i..., rₒ) for i in opoints]
    lines = [line([i, j]) for i in ipoints, j in opoints]
    compose(context(units=UnitBox(0.5,0,x₁,y₁+1)),
    compose(context(), stroke(colorant"black"), fill(colorant"white"),
            igates..., ogates...),
    compose(context(), linewidth(0.3mm), stroke(colorant"black"),
            lines...))
end

# ╔═╡ 784e1612-80a3-4529-a710-aa53755fef6c
A = Gate([1,2],[2])

# ╔═╡ a07cf99a-35aa-49ab-9ea1-7b28b0b5aadb
Gadfly.render(A,2,0,0)

# ╔═╡ decde0fc-9195-4bed-916e-2d6bb7c40393
md"""
Now we render the whole algorithm. We have to scan through the trace twice; the first time merely calculates the maximum depth that needs to be drawn and the second time actually generates the objects.
"""

# ╔═╡ 6fdfa820-0aca-4b14-9e4d-cc1033670fa1
function render(A::DummyArray)
    #Scan to find maximum depth
    olast = depth = 0
    for y in A.history
        (any(y[1] .≤ olast)) && (depth += 1)
        olast = maximum(y[2])
    end
    maxdepth = depth
    
    olast = depth = 0
    C = []
    for y in A.history
        (any(y[1] .≤ olast)) && (depth += 1)
        push!(C, Gadfly.render(Gate(y...), A.length, maxdepth, depth))
        olast = maximum(y[2])
    end
    
    push!(C, compose(context(units=UnitBox(0.5,0,A.length,1)),
      [line([(i,0), (i,1)]) for i=1:A.length]...,
    linewidth(0.1mm), stroke(colorant"grey")))
    compose(context(), C...)
end

# ╔═╡ a814915d-33a5-48ed-99a3-c5027519748f
render(prefix!(DummyArray(8), +))

# ╔═╡ 00fa9590-c9aa-4323-b4b6-37985f69d668
md"""
Now we can see that `prefix!` rearranges the operations to form two spanning trees:
"""

# ╔═╡ e23b1508-5d66-4dc5-bb33-eb5b6d5b02bc
render(prefix!(DummyArray(120),+))

# ╔═╡ 376b9bf4-5719-40fc-8b5e-d054b50dec26
#Look at the compose tree
#render(prefix8!(AccessArray(8),+)) |> introspect

# ╔═╡ 3be50c16-8697-4c86-9cb0-1423ce2618c1
md"""
as contrasted with the serial code:
"""

# ╔═╡ 666797e6-e6ca-4bef-b0ef-10a528f53e76
render(prefix_serial!(DummyArray(8),+))

# ╔═╡ 2574f71d-9a4d-4103-baea-8e40cef0efff
md"""
### Interactive

"""

# ╔═╡ 6b460112-3efd-452c-846e-d594b8291700
@bind npp Slider(1:180; default=10)

# ╔═╡ 059646fa-a259-49da-86db-cab457fc2e31
render(prefix!(DummyArray(npp),+))

# ╔═╡ e94a577a-3c5a-48c1-aad1-cf7a220a7f77
render(prefix_serial!(DummyArray(npp),+))

# ╔═╡ b98027d0-18d7-4b1a-8b6f-5759843f5c24
md"""
# Polymorphism for parallel operations
"""

# ╔═╡ 5b237373-a496-4318-ac26-86f0e4285234
md"""
Now let's run `prefix` in parallel on every core on the CPU. Use `addprocs` to attach additional worker processes.
"""

# ╔═╡ 2bf2097b-7c30-4307-a708-6402e1d19204
import Base: fetch, length, +, *
fetch(t::Vector) = map(fetch, t) #Vectorize fetch

#Define elementary operations on remote data
length(r1::RemoteRef)=length(fetch(r1))
+(r1::RemoteRef,r2::RemoteRef)=@spawnat r2.where fetch(r1)+fetch(r2)
*(r1::RemoteRef,r2::RemoteRef)=@spawnat r2.where fetch(r1)*fetch(r2)

# ╔═╡ 7593b09f-3733-4703-964a-3f76025e3d9e
md"""
For 8 processes, the serial version requires 7 operations. The parallel version uses 11 operations, but they are grouped into 5 simultaneous chunks of operations. Hence we expect that the parallel version runs in 5/7 the time needed for the naïve serial code.
"""

# ╔═╡ b1195d7e-a92e-450c-a86b-cf8703b7e273


# ╔═╡ ada3dec1-a546-49f3-bfd9-3ef0f10777a7
# #Before timing, force Julia to JIT compile the functions
# [f([randn(3,3) for i=1:2], *) for f in (prefix_serial!, prefix!)]

# addprocs(max(0, Sys.CPU_CORES-nprocs())) #Add all possible processors


# timings = Dict{Int,Tuple{Float64,Float64}}()
# for np in 2:nprocs()
#     gc_enable(false) #Disable garbage collector for timing purposes
#     n=1024#4096#3072
    
#     #Create RemoteRefs on np processes
#     r=[@spawnat p randn(n,n) for p in procs()[1:np]]
#     s=fetch(r) #These are in-memory matrices

#     #Repeat timings a couple of times and take smallest
#     t_ser = minimum([(tic(); prefix_serial!(s, *); toc()) for i=1:2])
#     t_par = minimum([(tic(); @sync prefix!(r, *) ; toc()) for i=1:2])
#     timings[np] = (t_ser, t_par)
#     gc_enable(true)
# end
# timings

# ╔═╡ 8d099c79-2342-4eef-be04-bdf762c61024
import Distributed

# ╔═╡ 5161300c-4645-4ade-836f-b40c9d8aff1f
# timings2 = let

# 	timings = Dict{Int,Tuple{Float64,Float64}}()
# 	n = 1024


# 	for num_parallel in 2:Threads.nthreads()
# 		rs = [rand(n,n) for p in 1:num_parallel]
# 		rs_copy = copy.(rs)

# 		t_ser = @belapsed $prefix_serial!($rs_copy, *) seconds=.1

# 		calc() = @threads for _np in 1:num_parallel
# 			tid = Threads.threadid()
# 			r = rs[tid]
# 			prefix!(r, *)
# 		end
# 		t_par = @belapsed $calc() seconds=.1
		
# 		timings[num_parallel] = (t_ser, t_par)
# 	end

# 	timings
	
# end

# ╔═╡ 504fe8b5-65ff-4c7f-af01-ce0cc4c639ef
# @threads for i in 8:10
# 	sleep(i/10)
# end

# ╔═╡ db17150c-2c08-4d50-8c93-80084c4d7dda
# sort(pairs(timings2); by=first)

# ╔═╡ 2b424712-bcc6-4c55-8d99-a628d9e92bea
# timings4 = let

# 	timings = Dict{Int,Tuple{Float64,Float64}}()
# 	n = 1024

# 	procs = Distributed.remotecall_eval(Main, 1, :(import Distributed; Distributed.addprocs(Sys.CPU_THREADS)))
# 	try

# 		Distributed.@everywhere procs begin
# 			function prefix!(y, +)
# 			    l=length(y)
# 			    k=ceil(Int, log2(l))
# 			    @inbounds for j=1:k, i=2^j:2^j:min(l, 2^k)              #"reduce"
# 			        y[i] = y[i-2^(j-1)] + y[i]
# 			    end
# 			    @inbounds for j=(k-1):-1:1, i=3*2^(j-1):2^j:min(l, 2^k) #"broadcast"
# 			        y[i] = y[i-2^(j-1)] + y[i]
# 			    end
# 			    y
# 			end
		
		
# 		for num_parallel in 2:length(procs)
# 			pool = procs[1:num_parallel]

# 			rs = [rand(n,n) for p in 1:num_parallel]
# 			rs_copy = copy(rs)


# 			# for i in 1:num_parallel
# 			# 	Distributed.remotecall_eval(Main, procs[i], :(r = $(rs[i])))
# 			# end

# 			t_ser = @belapsed prefix_serial!($rs_copy, *) seconds=.5

# 			calc() = Distributed.remotecall_eval(Main, pool, :(prefix!($(rs[1]), *)))
# 			t_par = @belapsed $calc() seconds=.5
			
# 			timings[num_parallel] = (t_ser, t_par)
# 		end
		
# 		timings
# 	finally
# 		Distributed.remotecall_eval(Main, 1, :(import Distributed; wait(Distributed.rmprocs($procs))))
# 	end

# 	timings
# end

# ╔═╡ 7b3c6433-b8db-44f5-833f-836198c84904
# timings3 = let

# 	timings = Dict{Int,Tuple{Float64,Float64}}()
# 	n = 1024

# 	procs = Distributed.remotecall_eval(Main, 1, :(import Distributed; Distributed.addprocs(Sys.CPU_THREADS)))
# 	try

# 		Distributed.@everywhere procs function prefix!(y, +)
# 		    l=length(y)
# 		    k=ceil(Int, log2(l))
# 		    @inbounds for j=1:k, i=2^j:2^j:min(l, 2^k)              #"reduce"
# 		        y[i] = y[i-2^(j-1)] + y[i]
# 		    end
# 		    @inbounds for j=(k-1):-1:1, i=3*2^(j-1):2^j:min(l, 2^k) #"broadcast"
# 		        y[i] = y[i-2^(j-1)] + y[i]
# 		    end
# 		    y
# 		end
		
		
# 		for num_parallel in 2:length(procs)
# 			pool = procs[1:num_parallel]

# 			rs = [rand(n,n) for p in 1:num_parallel]
# 			rs_copy = copy(rs)


# 			# for i in 1:num_parallel
# 			# 	Distributed.remotecall_eval(Main, procs[i], :(r = $(rs[i])))
# 			# end

# 			t_ser = @belapsed prefix_serial!($rs_copy, *) seconds=.5

# 			calc() = Distributed.remotecall_eval(Main, pool, :(prefix!($(rs[1]), *)))
# 			t_par = @belapsed $calc() seconds=.5
			
# 			timings[num_parallel] = (t_ser, t_par)
# 		end
		
# 		timings
# 	finally
# 		Distributed.remotecall_eval(Main, 1, :(import Distributed; wait(Distributed.rmprocs($procs))))
# 	end

# 	timings
# end

# ╔═╡ 11d8781d-8dc7-40eb-8e9b-f1b24a12562c
# sort(pairs(timings3); by=first)

# ╔═╡ c9a9768e-c81c-48da-a70e-b8b6aec0d627
# Distributed.procs()

# ╔═╡ 3d2f2449-954b-4d4b-a04d-07dcbc9d8d37
timings = #Data from julia.mit.edu
Dict(
    1 => ( 15.585,  15.721),
    2 => ( 16.325,  15.893),
    3 => ( 32.079,  31.678),
    4 => ( 46.037,  33.257),
    5 => ( 61.947,  51.412),
    6 => ( 77.247,  50.769), 
    7 => ( 92.588,  67.796),
    8 => (108.057,  65.185),
    9 => (123.556,  68.197),
   10 => (138.408,  66.658),
   11 => (153.392,  82.580),
   12 => (168.874,  83.373),
   13 => (184.227,  82.875),
   14 => (199.741,  83.098),
   15 => (215.881, 101.271),
   16 => (230.531, 104.860),
   17 => (246.576, 103.229),
   18 => (261.412, 102.497),
   19 => (276.926, 103.367),
   20 => (294.404, 104.162),
   21 => (308.995, 104.944),
   22 => (323.287, 104.838),
   23 => (340.173, 121.495),
   24 => (353.717, 119.729),
   25 => (369.113, 120.281),
   26 => (384.638, 118.710),
   27 => (402.484, 119.237),
   28 => (417.036, 119.980),
   29 => (431.273, 120.463),
   30 => (446.288, 120.560),
   31 => (461.756, 137.209),
   32 => (476.653, 135.873),
   33 => (493.989, 138.150),
   34 => (508.089, 137.998),
   35 => (523.703, 139.059),
   36 => (539.305, 135.201),
   37 => (554.201, 138.242),
   38 => (569.276, 137.470),
   39 => (585.268, 137.261),
   40 => (599.921, 137.871),
   41 => (615.718, 137.887),
   42 => (632.463, 137.579),
   43 => (647.355, 138.181),
   44 => (664.344, 139.917),
   45 => (678.899, 138.382),
   46 => (695.815, 138.354),
   47 => (717.068, 154.826),
   48 => (730.902, 155.603),
   49 => (745.608, 154.549),
   50 => (756.012, 154.244),
   51 => (769.611, 154.000),
   52 => (793.350, 152.893),
   53 => (801.568, 155.276),
   54 => (818.174, 153.436),
   55 => (832.994, 155.923),
   56 => (849.526, 155.721),
   57 => (863.337, 155.289),
   58 => (881.577, 156.188),
   59 => (893.735, 157.889),
   60 => (911.597, 155.557),
   61 => (925.117, 157.048),
   62 => (940.897, 153.338),
   63 => (954.825, 173.942),
   64 => (990.757, 173.236),
   65 => (987.457, 172.005),
   66 => (1009.688, 173.869),
   67 => (1022.357, 173.303),
   68 => (1043.536, 175.044),
   69 => (1052.156, 173.361),
   70 => (1067.174, 172.230),
   71 => (1079.543, 173.491),
   72 => (1101.516, 174.311),
   73 => (1119.993, 174.057),
   74 => (1136.092, 175.804),
   75 => (1154.758, 175.075),
   76 => (1170.732, 173.453),
   77 => (1184.598, 171.936),
   78 => (1190.922, 172.809),
   79 => (1204.645, 172.878),
)

# ╔═╡ eb69d0fe-5cc0-4977-9fef-e15b8fa4bb33
speedup(p::Integer) = ((p-1)/(floor(Int, log2(p)) + 1 + floor(Int, log2(p/3))))

# ╔═╡ 4a7f3410-e1c9-44c6-a711-ff1ccf6e3dbd
#for (np, (t_ser, t_par)) in sort!([x for x in timings])
#    @printf("np: %3d Serial: %.3f sec  Parallel: %.3f sec  speedup: %.3fx (theory=%.3fx)\n",
#        np, t_ser, t_par, t_ser/t_par, speedup(np))
#end

xend = 1 + maximum(keys(timings))

# ╔═╡ d85f1238-4654-49c9-9ec8-ec1df21d3942
theplot = plot(
	layer(
		x=2:xend, 
		y=map(speedup, 2:xend), 
		Geom.line(), 
		Theme(default_color=colorant"darkkhaki")
	),
	layer(
		x=[np+1 for (np, (t_ser, t_par)) in timings],
		y=[t_ser/t_par for (np, (t_ser, t_par)) in timings],
		Geom.point, 
		Theme(
			default_color=colorant"firebrick",
			point_size=1.25pt, 
			highlight_width=0pt
		)
	),
    Guide.xlabel("Number of processors, p"), 
	Guide.ylabel("Speedup, r"),
)

# ╔═╡ 74606381-e5a3-47ff-9184-86291244d4bf
labeledplot = compose(
	Gadfly.render(theplot),
	compose(
		context(), 
		stroke(colorant"purple"), #Powers of 2
		
		text(0.21, 0.73, "2"), text(0.24, 0.72, "4"), text(0.27, 0.7, "8"), text(0.33, 0.63, "16"), text(0.47, 0.53, "32"), text(0.76, 0.35, "64")
	),
	compose(
		context(), 
		stroke(colorant"green"), #3x powers of 2

		text(0.25, 0.62, "6"), text(0.28, 0.57, "12"), text(0.39, 0.49, "24"), text(0.63, 0.32, "48"),
	),
)

# ╔═╡ 9e2f7b8d-d749-4bbd-bc7c-67ef76ecf3d1
md"""
The exact same serial code now runs in parallel thanks to multiple dispatch!
"""

# ╔═╡ 0db8cf13-18f8-4e55-8e45-1ed51de896da
md"""
# Formal verification

Julia allows us to implement very easily the interval of summations monoid technique for verifying the correctness of prefix sums ([doi:10.1145/2535838.2535882](http://dx.doi.org/10.1145/2535838.2535882)).
"""

# ╔═╡ c2c3e458-cfc9-413c-8c99-ebcefb088ba8
begin
	#Definition 4.3 of Chong et al., 2014
	abstract type ⊤ end
	abstract type Id end
	const 𝕊 = Union{UnitRange, ⊤, Id}
end

# ╔═╡ 703018c6-29dd-4881-8e48-a211610ac7e2
begin
	⊕(I::UnitRange, J::UnitRange) = I.stop+1==J.start ? (I.start:J.stop) : ⊤
	⊕(::Type{Id}, ::Type{Id}) = Id
	⊕(I::𝕊, ::Type{Id}) = I
	⊕(::Type{Id}, I::𝕊) = I
	⊕(I::𝕊, J::𝕊) = ⊤
end

# ╔═╡ a6625abe-80f8-4720-b20f-014cff542671
md"""
Wrong kernels produce type errors!
"""

# ╔═╡ f4a1407f-1783-44c0-bcdb-1381999cdb49
@manipulate for npp=1:10
    render(prefix_wrong!(AccessArray(npp),+))
end

# ╔═╡ 22a2ab5f-b812-46c2-87a7-364e661a0e96
md"""
# Experimental code which doesn't work

In this section I play with other parallel prefix algorithms. All the ones here suffer from read antidependencies and they break the logic I used to draw the gates.
"""

# ╔═╡ 89600216-fbdd-4a6b-8a06-f4d0747094f7
Base.copy(A::AccessArray) = A


# ╔═╡ c6f03f9e-1a71-4a93-9c10-f5eba188fc13
let
	M = rand(10,10)
	Mc = copy(M)
	prefix!(M, *)
end

# ╔═╡ e3ff0c81-1d23-4ba4-a3c2-d454a81d1d57
function prefix_wrong!(y, +)
    l = length(y)
    offset = 1
    z = copy(y)
    while offset < l
        for i=offset+1:l
            z[i] = y[i-offset] + z[i]
        end
        offset += 2
        y = copy(z)
    end
    y
end

# ╔═╡ 4d109297-185a-4f94-87eb-e53c560ca619
#Kogge-Stone variant
#Works but doesn't render properly
function prefix_ks!(y, operator)
    l = length(y)
    offset = 1
    z = copy(y)
    while offset < l
        for i=offset+1:l
            z[i] = operator(y[i-offset], z[i])
        end
        offset *= 2
        y = copy(z)
    end
    y
end

# ╔═╡ df6f0d98-86f1-42e2-912a-24dc31ac32b8
@test prefix_ks!(ones(8), +) == [1:8;]

# ╔═╡ 1093be97-0070-4075-8379-250c6d073ff4

render(prefix_ks!(AccessArray(8),+))

# ╔═╡ d2691cf1-782a-43e5-8dc4-a89d8b92128b
#Hillis-Steele = Kogge-Stone
function prefix_hs!(y, +)
    l = length(y)
    lk = floor(Int, log2(l))
    for d=1:lk
        for k=2d:l
            y[k] = y[k-2^(d-1)] + y[k]
        end
    end
    y
end

# ╔═╡ 214f3e6c-9450-4c82-ba4a-8d4c61be2a1f
prefix_hs!(ones(4), +)

# ╔═╡ ff7ecb30-e561-4e7e-b73a-a18754b83b88
render(prefix_hs!(AccessArray(4), +))

# ╔═╡ 9bf537b4-5541-4cfa-b970-2b69606418ef
#Sklansky
function prefix_s!(y, +)
    n = length(y)
    for d=1:floor(Int,log2(n))
        for k=1:n÷2+1
            block = 2 * (k - (mod(k, 2^d)))
            me = block + mod(k, 2^d) + 2^d
            spine = block + 2^d - 1
            if spine ≤ n && me ≤ n
                y[me] = y[me] + y[spine]
            end
        end
    end
    y
end

# ╔═╡ 903daf33-58c0-4b8a-b7a8-718967f8f8c5
1:floor(Int,log2(6))

# ╔═╡ 20c11b01-518f-4bf0-b2ee-f898f174de24
prefix_s!(ones(4), +)

# ╔═╡ 232bf87a-8f32-457b-b68a-eb4cbde42bf9
function prefix(v,⊕)
    @show v
    k=length(v)
    k≤1 && return v
    v[2:2:k] = @show v[1:2:k-1]⊕v[2:2:k]  # Line 1
    v[2:2:k] = @show prefix(v[2:2:k],⊕)   # Line 2
    v[3:2:k] = @show v[2:2:k-1]⊕v[3:2:k]  # Line 3
    v
end

# ╔═╡ 8a33b3aa-b09b-483a-8c06-1fd1870f43c5
prefix(ones(8),+)

# ╔═╡ 0761849b-3a0f-44b3-bf21-fe4118e2422d
function ⊕(v1::Vector{T}, v2::Vector{T}) where T<:AbstractRange
    for v in (v1, v2), i in 1:length(v)-1
        @assert v[i].stop + 1 == v[i+1].start
    end
    if length(v1)>0 && length(v2)>0
        @assert v1[end].stop + 1 == v2[1].start
        v1[1].start:v2[end].stop
    elseif length(v1)>0 #&& length(v2)==0
        v1[1].start:v1[end].stop
    elseif length(v2)>0 #&& length(v1)==0
        v2[1].start:v2[end].stop
    else #Both are empty
        v1
    end
end

# ╔═╡ 1e3f1381-eea1-4c28-b104-d06e67b7efba
for kernel in (prefix_serial!, prefix!), n=1:1000
    @assert kernel([k:k for k=1:n], ⊕) == [1:k for k=1:n]
end

# ╔═╡ bbe64029-61ef-4de1-a679-3411c71dbb55
prefix_wrong!([k:k for k=1:8], ⊕) #Should produce conversion error

# ╔═╡ 2e60087c-5ec9-4109-a027-31915fcb1060
for kernel in (prefix,), n=1:100#(prefix_serial!, prefix!, prefix_ks!), n=1:100
    @assert kernel([k:k for k=1:n], ⊕) == [1:k for k=1:n]
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
BenchmarkTools = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
Compose = "a81c6b42-2e10-5240-aca2-a61377ecd94b"
Distributed = "8ba89e20-285c-5b6f-9357-94700520ee1b"
Gadfly = "c91e804a-d5a3-530f-b6f0-dfbca275c004"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
PlutoTest = "cb4044da-4d16-4ffa-a6a3-8cad7f73ebdc"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
StatsBase = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"

[compat]
BenchmarkTools = "~1.3.1"
Compose = "~0.9.3"
Gadfly = "~1.3.4"
PlutoTest = "~0.2.2"
PlutoUI = "~0.7.37"
StatsBase = "~0.33.16"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.1"
manifest_format = "2.0"

[[deps.AbstractFFTs]]
deps = ["ChainRulesCore", "LinearAlgebra"]
git-tree-sha1 = "6f1d9bc1c08f9f4a8fa92e3ea3cb50153a1b40d4"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.1.0"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "af92965fb30777147966f58acb05da51c5616b5f"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.3.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.AxisAlgorithms]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "WoodburyMatrices"]
git-tree-sha1 = "66771c8d21c8ff5e3a93379480a2307ac36863f7"
uuid = "13072b0f-2c55-5437-9ae7-d433b7a33950"
version = "1.0.1"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BenchmarkTools]]
deps = ["JSON", "Logging", "Printf", "Profile", "Statistics", "UUIDs"]
git-tree-sha1 = "4c10eee4af024676200bc7752e536f858c6b8f93"
uuid = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
version = "1.3.1"

[[deps.Calculus]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f641eb0a4f00c343bbc32346e1217b86f3ce9dad"
uuid = "49dc2e85-a5d0-5ad3-a950-438e2897f1b9"
version = "0.5.1"

[[deps.CategoricalArrays]]
deps = ["DataAPI", "Future", "Missings", "Printf", "Requires", "Statistics", "Unicode"]
git-tree-sha1 = "109664d3a6f2202b1225478335ea8fea3cd8706b"
uuid = "324d7699-5711-5eae-9e2f-1d82baa6b597"
version = "0.10.5"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "9950387274246d08af38f6eef8cb5480862a435f"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.14.0"

[[deps.ChangesOfVariables]]
deps = ["ChainRulesCore", "LinearAlgebra", "Test"]
git-tree-sha1 = "bf98fa45a0a4cee295de98d4c1462be26345b9a1"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.2"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[deps.Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "96b0bc6c52df76506efc8a441c6cf1adcb1babc4"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.42.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Compose]]
deps = ["Base64", "Colors", "DataStructures", "Dates", "IterTools", "JSON", "LinearAlgebra", "Measures", "Printf", "Random", "Requires", "Statistics", "UUIDs"]
git-tree-sha1 = "9a2695195199f4f20b94898c8a8ac72609e165a4"
uuid = "a81c6b42-2e10-5240-aca2-a61377ecd94b"
version = "0.9.3"

[[deps.Contour]]
deps = ["StaticArrays"]
git-tree-sha1 = "9f02045d934dc030edad45944ea80dbd1f0ebea7"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.5.7"

[[deps.CoupledFields]]
deps = ["LinearAlgebra", "Statistics", "StatsBase"]
git-tree-sha1 = "6c9671364c68c1158ac2524ac881536195b7e7bc"
uuid = "7ad07ef1-bdf2-5661-9d2b-286fd4296dac"
version = "0.2.0"

[[deps.DataAPI]]
git-tree-sha1 = "cc70b17275652eb47bc9e5f81635981f13cea5c8"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.9.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "3daef5523dd2e769dad2365274f760ff5f282c7d"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.11"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.DensityInterface]]
deps = ["InverseFunctions", "Test"]
git-tree-sha1 = "80c3e8639e3353e5d2912fb3a1916b8455e2494b"
uuid = "b429d917-457f-4dbc-8f4c-0cc954292b1d"
version = "0.4.0"

[[deps.Distances]]
deps = ["LinearAlgebra", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "3258d0659f812acde79e8a74b11f17ac06d0ca04"
uuid = "b4f34e82-e78d-54a5-968a-f98e89d6e8f7"
version = "0.10.7"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.Distributions]]
deps = ["ChainRulesCore", "DensityInterface", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SparseArrays", "SpecialFunctions", "Statistics", "StatsBase", "StatsFuns", "Test"]
git-tree-sha1 = "5a4168170ede913a2cd679e53c2123cb4b889795"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.53"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "b19534d1895d702889b219c382a6e18010797f0b"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.8.6"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.DualNumbers]]
deps = ["Calculus", "NaNMath", "SpecialFunctions"]
git-tree-sha1 = "5837a837389fccf076445fce071c8ddaea35a566"
uuid = "fa6b7ba4-c1ee-5f82-b5fc-ecf0adba8f74"
version = "0.6.8"

[[deps.FFTW]]
deps = ["AbstractFFTs", "FFTW_jll", "LinearAlgebra", "MKL_jll", "Preferences", "Reexport"]
git-tree-sha1 = "505876577b5481e50d089c1c68899dfb6faebc62"
uuid = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
version = "1.4.6"

[[deps.FFTW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c6033cc3892d0ef5bb9cd29b7f2f0331ea5184ea"
uuid = "f5851436-0d7a-5f13-b9de-f02708fd171a"
version = "3.3.10+0"

[[deps.FillArrays]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "Statistics"]
git-tree-sha1 = "246621d23d1f43e3b9c368bf3b72b2331a27c286"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "0.13.2"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.Gadfly]]
deps = ["Base64", "CategoricalArrays", "Colors", "Compose", "Contour", "CoupledFields", "DataAPI", "DataStructures", "Dates", "Distributions", "DocStringExtensions", "Hexagons", "IndirectArrays", "IterTools", "JSON", "Juno", "KernelDensity", "LinearAlgebra", "Loess", "Measures", "Printf", "REPL", "Random", "Requires", "Showoff", "Statistics"]
git-tree-sha1 = "13b402ae74c0558a83c02daa2f3314ddb2d515d3"
uuid = "c91e804a-d5a3-530f-b6f0-dfbca275c004"
version = "1.3.4"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.Hexagons]]
deps = ["Test"]
git-tree-sha1 = "de4a6f9e7c4710ced6838ca906f81905f7385fd6"
uuid = "a1b4810d-1bce-5fbd-ac56-80944d57a21f"
version = "0.2.0"

[[deps.HypergeometricFunctions]]
deps = ["DualNumbers", "LinearAlgebra", "SpecialFunctions", "Test"]
git-tree-sha1 = "65e4589030ef3c44d3b90bdc5aac462b4bb05567"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.8"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
git-tree-sha1 = "2b078b5a615c6c0396c77810d92ee8c6f470d238"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.3"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.IndirectArrays]]
git-tree-sha1 = "012e604e1c7458645cb8b436f8fba789a51b257f"
uuid = "9b13fd28-a010-5f03-acff-a1bbcff69959"
version = "1.0.0"

[[deps.IntelOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "d979e54b71da82f3a65b62553da4fc3d18c9004c"
uuid = "1d5cc7b8-4909-519e-a0f8-d0f5ad9712d0"
version = "2018.0.3+2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Interpolations]]
deps = ["AxisAlgorithms", "ChainRulesCore", "LinearAlgebra", "OffsetArrays", "Random", "Ratios", "Requires", "SharedArrays", "SparseArrays", "StaticArrays", "WoodburyMatrices"]
git-tree-sha1 = "b15fc0a95c564ca2e0a7ae12c1f095ca848ceb31"
uuid = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"
version = "0.13.5"

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "91b5dcf362c5add98049e6c29ee756910b03051d"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.3"

[[deps.IrrationalConstants]]
git-tree-sha1 = "7fd44fd4ff43fc60815f8e764c0f352b83c49151"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.1"

[[deps.IterTools]]
git-tree-sha1 = "fa6287a4469f5e048d763df38279ee729fbd44e5"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.4.0"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.Juno]]
deps = ["Base64", "Logging", "Media", "Profile"]
git-tree-sha1 = "07cb43290a840908a771552911a6274bc6c072c7"
uuid = "e5e0dc1b-0480-54bc-9374-aad01c23163d"
version = "0.8.4"

[[deps.KernelDensity]]
deps = ["Distributions", "DocStringExtensions", "FFTW", "Interpolations", "StatsBase"]
git-tree-sha1 = "591e8dc09ad18386189610acafb970032c519707"
uuid = "5ab0869b-81aa-558d-bb23-cbf5423bbe9b"
version = "0.6.3"

[[deps.LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Loess]]
deps = ["Distances", "LinearAlgebra", "Statistics"]
git-tree-sha1 = "46efcea75c890e5d820e670516dc156689851722"
uuid = "4345ca2d-374a-55d4-8d30-97f9976e7612"
version = "0.5.4"

[[deps.LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "58f25e56b706f95125dcb796f39e1fb01d913a71"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.10"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MKL_jll]]
deps = ["Artifacts", "IntelOpenMP_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "Pkg"]
git-tree-sha1 = "e595b205efd49508358f7dc670a940c790204629"
uuid = "856f044c-d86e-5d09-b602-aeab76dc8ba7"
version = "2022.0.0+0"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "3d3e902b31198a27340d0bf00d6ac452866021cf"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.9"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Measures]]
git-tree-sha1 = "e498ddeee6f9fdb4551ce855a46f54dbd900245f"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.1"

[[deps.Media]]
deps = ["MacroTools", "Test"]
git-tree-sha1 = "75a54abd10709c01f1b86b84ec225d26e840ed58"
uuid = "e89f7d12-3494-54d1-8411-f7d8b9ae1f27"
version = "0.5.0"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "bf210ce90b6c9eed32d25dbcae1ebc565df2687f"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.2"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.NaNMath]]
git-tree-sha1 = "737a5957f387b17e74d4ad2f440eb330b39a62c5"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.0"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.OffsetArrays]]
deps = ["Adapt"]
git-tree-sha1 = "043017e0bdeff61cfbb7afeb558ab29536bbb5ed"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.10.8"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "e8185b83b9fc56eb6456200e873ce598ebc7f262"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.7"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "85b5da0fa43588c75bb1ff986493443f821c70b7"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.2.3"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlutoTest]]
deps = ["HypertextLiteral", "InteractiveUtils", "Markdown", "Test"]
git-tree-sha1 = "17aa9b81106e661cffa1c4c36c17ee1c50a86eda"
uuid = "cb4044da-4d16-4ffa-a6a3-8cad7f73ebdc"
version = "0.2.2"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "bf0a1121af131d9974241ba53f601211e9303a9e"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.37"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "d3538e7f8a790dc8903519090857ef8e1283eecd"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.2.5"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Profile]]
deps = ["Printf"]
uuid = "9abbd945-dff8-562f-b5e8-e1ebf5ef1b79"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "78aadffb3efd2155af139781b8a8df1ef279ea39"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.4.2"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Ratios]]
deps = ["Requires"]
git-tree-sha1 = "dc84268fe0e3335a62e315a3a7cf2afa7178a734"
uuid = "c84ed2f1-dad5-54f0-aa8e-dbefe2724439"
version = "0.4.3"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "bf3188feca147ce108c76ad82c2792c57abe7b1f"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.7.0"

[[deps.Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "68db32dff12bb6127bac73c209881191bf0efbb7"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.3.0+0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SpecialFunctions]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "5ba658aeecaaf96923dce0da9e703bd1fe7666f9"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.1.4"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "4f6ec5d99a28e1a749559ef7dd518663c5eca3d5"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.4.3"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "c3d8ba7f3fa0625b062b82853a7d5229cb728b6b"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.2.1"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "8977b17906b0a1cc74ab2e3a05faa16cf08a8291"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.16"

[[deps.StatsFuns]]
deps = ["ChainRulesCore", "HypergeometricFunctions", "InverseFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "25405d7016a47cf2bd6cd91e66f4de437fd54a07"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "0.9.16"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "de67fa59e33ad156a590055375a30b23c40299d3"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "0.5.5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╟─21e1ccc7-a20e-431d-90de-5c737968dfdb
# ╠═9e2563d9-0a3d-4d2e-a968-dfec0792dbf3
# ╠═5e724594-c97f-49c0-a8ce-594aaf9cf379
# ╟─3d1e281d-ac52-49c2-bdf7-50ff6006f940
# ╠═4b3a588f-757f-4a92-a13b-01fe6a2aaa25
# ╠═2ed0ca4d-d7bd-4d5b-87b2-653623e0047b
# ╠═347733f5-6683-444b-a673-d834609aa65f
# ╟─e8c2fcad-8691-4e65-b79b-1d083696402f
# ╠═2101aa7f-c71d-4ee8-bc04-cd23a2001430
# ╠═fb1f4393-482d-4e44-9a05-a49c37196ce1
# ╠═e7ae3a69-ee05-4918-bd4e-216ce37f929e
# ╟─1c4df22a-caaf-4cd0-b228-769933640d2f
# ╠═a3aac2e7-987a-46a7-be95-005d20e6cf73
# ╠═758b1b92-955d-4201-b57d-77a6b0b41fee
# ╟─bc7c75c5-effe-49a8-af37-107d173023ed
# ╠═4b8f2ae1-76f5-4567-bdf1-df31888d0eba
# ╠═3d3774d4-1a42-4c1d-bb11-6415db591ff3
# ╟─b6521fc4-2b46-49c2-aa25-941dcee93786
# ╠═64c27b03-2a71-405d-bc39-f2caf8b99b9c
# ╠═cbf0be02-9712-43f9-b723-f221c8f83503
# ╠═327572d4-581f-4136-bd9a-2e42bd52fdb1
# ╠═4d8c53b8-8881-4f25-928c-2ef08b667500
# ╠═4003b79a-abea-4109-b1c6-213007df5c36
# ╠═37de7151-91e8-4c64-9ba0-5bff68c7703d
# ╠═90386705-57fa-4b77-b194-6fe224746956
# ╠═abd3d725-1e21-4533-abe8-e791d242a357
# ╠═bedc8de1-77ef-404d-bf14-448a22eb94ac
# ╠═5c86ed59-d29f-4827-a271-7dff0a97b195
# ╠═a07e7217-af8a-4226-b6d8-6a19c2964f30
# ╠═c8e347ce-6555-4c81-93c3-0ec0aeddba22
# ╠═59ab4f63-b53d-422b-a3d0-2f2e154ab4e5
# ╠═6851cf30-0f8f-4cec-85e0-c0be241b9fe1
# ╠═2cdbdf33-96e9-4594-a515-209dc39a98e4
# ╠═b1f0c31f-eb13-4628-be1c-90cdd6fa6482
# ╠═ba465290-8243-494a-ad16-0e3f275cad9e
# ╟─88a8575f-698e-4e4e-ad0f-2e377117b737
# ╠═20446b3f-b7d2-4fbb-a6de-c9e0248f8a4e
# ╠═05733599-2c43-4b8f-b97f-1c801cdfb112
# ╠═e2c6e19d-70ae-45dc-880a-186c96a51bdc
# ╠═9c0446a0-6c0b-44ca-9ec2-7999ed1ce318
# ╠═a2a14308-5f10-4d0a-82ec-717903b52d4c
# ╠═02b3e05a-0d3e-4bdb-8d0e-06557cf66786
# ╠═e5cb6242-dcf0-48ec-87ef-61ac695aa785
# ╠═2ad106c3-71e9-4ae7-9aac-820871517318
# ╠═1ff2583e-e748-4602-9a7b-0c311c5f4097
# ╟─48955a36-fcd8-40d4-810a-58fb2ed29a9f
# ╟─4b167e93-a723-4264-b7ba-94ccee8b489e
# ╠═626046b4-0f6d-4810-9ec1-5853dbd05284
# ╠═798c2d71-31a7-41d1-bf22-06917c674b10
# ╠═1d83a3a4-6f56-48cb-bb1a-91b95bd06fb9
# ╟─95e5b24b-8715-4055-a790-cbda9816415e
# ╠═6e5b1286-3048-41f4-8663-f0eb676182c8
# ╠═841c999d-a0e9-4caa-851e-c47be81620ce
# ╠═db62a15b-cb59-49f1-a544-5a855483179e
# ╟─6e3a222a-807b-4f8e-aa69-10f7ddc49ba2
# ╟─b6ccdd83-156c-4631-8259-37b061bfd844
# ╠═4de971cd-2ec0-4f7a-990a-2c6241ca5bf9
# ╠═b2cdfca7-b00b-40ba-8080-13fa1fbd41a0
# ╠═7b896749-5e5e-423d-816c-290c70a79432
# ╠═565a1758-3c91-4ce3-826e-a8f621a8b8d4
# ╠═f2eed06c-a2b7-4349-83f8-bdce6277afc2
# ╟─0a22d01f-44d5-481d-af35-9f2ccf35710f
# ╠═b5119831-0e27-4d76-b769-a31581077e82
# ╟─4d7a4383-ebda-4c66-ad4a-0160d822ac7b
# ╠═1241e6bf-a6ad-4f38-bf54-7f127a7aeb10
# ╠═66e0954c-7024-4a12-8e4c-0d09de4e0f7d
# ╠═784e1612-80a3-4529-a710-aa53755fef6c
# ╠═a07cf99a-35aa-49ab-9ea1-7b28b0b5aadb
# ╟─decde0fc-9195-4bed-916e-2d6bb7c40393
# ╠═6fdfa820-0aca-4b14-9e4d-cc1033670fa1
# ╠═a814915d-33a5-48ed-99a3-c5027519748f
# ╟─00fa9590-c9aa-4323-b4b6-37985f69d668
# ╠═e23b1508-5d66-4dc5-bb33-eb5b6d5b02bc
# ╠═376b9bf4-5719-40fc-8b5e-d054b50dec26
# ╟─3be50c16-8697-4c86-9cb0-1423ce2618c1
# ╠═666797e6-e6ca-4bef-b0ef-10a528f53e76
# ╟─2574f71d-9a4d-4103-baea-8e40cef0efff
# ╠═6b460112-3efd-452c-846e-d594b8291700
# ╟─059646fa-a259-49da-86db-cab457fc2e31
# ╠═e94a577a-3c5a-48c1-aad1-cf7a220a7f77
# ╟─b98027d0-18d7-4b1a-8b6f-5759843f5c24
# ╟─5b237373-a496-4318-ac26-86f0e4285234
# ╠═2bf2097b-7c30-4307-a708-6402e1d19204
# ╟─7593b09f-3733-4703-964a-3f76025e3d9e
# ╠═d5a3a2a5-7c28-4a0e-9343-1f84949c9917
# ╠═b1195d7e-a92e-450c-a86b-cf8703b7e273
# ╠═ada3dec1-a546-49f3-bfd9-3ef0f10777a7
# ╠═8d099c79-2342-4eef-be04-bdf762c61024
# ╠═5161300c-4645-4ade-836f-b40c9d8aff1f
# ╠═504fe8b5-65ff-4c7f-af01-ce0cc4c639ef
# ╠═db17150c-2c08-4d50-8c93-80084c4d7dda
# ╠═2b424712-bcc6-4c55-8d99-a628d9e92bea
# ╠═7b3c6433-b8db-44f5-833f-836198c84904
# ╠═11d8781d-8dc7-40eb-8e9b-f1b24a12562c
# ╠═43b0c9a5-b1d0-4ee4-a156-b87bc15a64f2
# ╠═c9a9768e-c81c-48da-a70e-b8b6aec0d627
# ╠═c6f03f9e-1a71-4a93-9c10-f5eba188fc13
# ╠═3d2f2449-954b-4d4b-a04d-07dcbc9d8d37
# ╠═eb69d0fe-5cc0-4977-9fef-e15b8fa4bb33
# ╠═4a7f3410-e1c9-44c6-a711-ff1ccf6e3dbd
# ╠═d85f1238-4654-49c9-9ec8-ec1df21d3942
# ╠═74606381-e5a3-47ff-9184-86291244d4bf
# ╟─9e2f7b8d-d749-4bbd-bc7c-67ef76ecf3d1
# ╟─0db8cf13-18f8-4e55-8e45-1ed51de896da
# ╠═c2c3e458-cfc9-413c-8c99-ebcefb088ba8
# ╠═703018c6-29dd-4881-8e48-a211610ac7e2
# ╠═1e3f1381-eea1-4c28-b104-d06e67b7efba
# ╟─a6625abe-80f8-4720-b20f-014cff542671
# ╠═e3ff0c81-1d23-4ba4-a3c2-d454a81d1d57
# ╠═bbe64029-61ef-4de1-a679-3411c71dbb55
# ╠═f4a1407f-1783-44c0-bcdb-1381999cdb49
# ╟─22a2ab5f-b812-46c2-87a7-364e661a0e96
# ╠═4d109297-185a-4f94-87eb-e53c560ca619
# ╠═df6f0d98-86f1-42e2-912a-24dc31ac32b8
# ╠═eb8801f1-d9da-4fc5-8a51-e5802b86ec93
# ╠═89600216-fbdd-4a6b-8a06-f4d0747094f7
# ╠═1093be97-0070-4075-8379-250c6d073ff4
# ╠═d2691cf1-782a-43e5-8dc4-a89d8b92128b
# ╠═214f3e6c-9450-4c82-ba4a-8d4c61be2a1f
# ╠═ff7ecb30-e561-4e7e-b73a-a18754b83b88
# ╠═9bf537b4-5541-4cfa-b970-2b69606418ef
# ╠═903daf33-58c0-4b8a-b7a8-718967f8f8c5
# ╠═20c11b01-518f-4bf0-b2ee-f898f174de24
# ╠═232bf87a-8f32-457b-b68a-eb4cbde42bf9
# ╠═8a33b3aa-b09b-483a-8c06-1fd1870f43c5
# ╠═0761849b-3a0f-44b3-bf21-fe4118e2422d
# ╠═2e60087c-5ec9-4109-a027-31915fcb1060
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002

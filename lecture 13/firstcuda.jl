using CUDA
CUDA.version()
CUDA.functional()

A = [1 2 3;4 5 6;7 8 9]
cA = CuArray(A)
Array(cA)

Array{Int}(undef,3,3)

CuArray{Int}(undef,3,3)

c=CUDA.rand(Float64,3,3)
v=CUDA.rand(1000)
sum(v)

map( x->sin(cos(x))+exp(x)  ,v )

using LinearAlgebra
q,r = qr(c)
CUDA.allowscalar(true)

using SparseArrays
c = CuArray([1 0 2;0 0 3; 0 0 4])
sparse(Array(c))
#sparse(c) #not working?

using FFTW
fft(Array(c))
fft(c)


## implicit vectorization
C = CUDA.zeros(Int64, 64)


function kernel2!(A)
    i = threadIdx().x
    A[i] = i
    return
end

@cuda threads=128 kernel2!(C)
C
using ForwardDiff

map( x->ForwardDiff.derivative(sin,x), v)
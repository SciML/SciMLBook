using BenchmarkTools
using StaticArrays
using Plots
using OrdinaryDiffEq
using InteractiveUtils
using Flux
using LinearAlgebra
using Statistics
using SIMD
using Base.Threads
using CUDA
using Distributed
using Dagger
using MPI
using DifferentialEquations
using Sundials
using ParameterizedFunctions
using ForwardDiff
using DiffEqBase
using Distributions
using DiffEqBase.EnsembleAnalysis
using StatsPlots
using KernelDensity
using Sobol
using LatinHypercubeSampling
using Traceur
using Profile
using Measurements
using IntervalArithmetic
using DiffEqUncertainty
using SparseArrays

# BenchmarkTools
A = rand(100, 100)
B = rand(100, 100)
C = rand(100, 100)
@btime A[50, 50]
map((a) -> a^2 , A);

# StaticArrays
@SVector ones(2)

@show A[1]
E = @view A[1:5, 1:5]
E[1] = 2.0
@show A[1]
@belapsed A .* 2

# Plots
plot(1:5, rand(5))

# OrdinaryDiffEq
h(u, p, t) = p[1] * u
u0 = [0.1]
ps = [0.1]
tspan = (0.0, 100.0)
prob = ODEProblem(h, u0, tspan, ps)
sol = solve(prob)
plot(sol)

# InteractiveUtils
f(x, y) = 2x + y
function g(x, y)
    a = 4
    b = 2
    c = f(x, a)
    d = f(b, c)
    f(d, y)
end
@code_llvm g(2, 5)
@code_warntype g(2, 5)
@code_native g(2, 5)

# Flux
NN2 = Chain(Dense(10,32,tanh),
           Dense(32,32,tanh),
           Dense(32,5))
NN2(rand(10))

# LinearAlgebra
lu(A)
mul!(C, A, B)

# Statistics
mean(rand(20))

# SIMD
v = Vec{4,Float64}((1,2,3,4))
@show v+v # basic arithmetic is supported
@show sum(v) # basic reductions are supported

# Base.Threads
Threads.nthreads() # should not be 1

# CUDA
N = 2^20
x_d = CUDA.fill(1.0f0, N)  # a vector stored on the GPU filled with 1.0 (Float32)
y_d = CUDA.fill(2.0f0, N)  # a vector stored on the GPU filled with 2.0
# Pass to the GPU
cuA = cu(A); cuB = cu(B)
cuC = cuA*cuB
# Pass to the CPU
C = Array(cuC)

# Distributed
addprocs(4)
@everywhere f(x) = x.^2 # Define this function on all processes
t = remotecall(f,2,randn(10))
xsq = fetch(t)

# Dagger
add1(value) = value + 1
add2(value) = value + 2
combine(a...) = sum(a)
p = delayed(add1)(4)
q = delayed(add2)(p)
r = delayed(add1)(3)
s = delayed(combine)(p, q, r)

# MPI
MPI.Init()
comm = MPI.COMM_WORLD
rank = MPI.Comm_rank(comm)
size = MPI.Comm_size(comm)

# DifferentialEquations
function lorenz(du,u,p,t)
  du[1] = p[1]*(u[2]-u[1])
  du[2] = u[1]*(p[2]-u[3]) - u[2]
  du[3] = u[1]*u[2] - p[3]*u[3]
end
u0 = [1.0,0.0,0.0]
tspan = (0.0,100.0)
p = (10.0,28.0,8/3)
prob = ODEProblem(lorenz,u0,tspan,p)
sol = solve(prob)
plot(sol)
plot(sol,idxs=(1,2,3))
sol(0.5)

# Sundials, ParameterizedFunctions
@ode_def LotkaVolterra begin
  dx = a*x - b*x*y
  dy = -c*y + d*x*y
end a b c d
function rober(du,u,p,t)
  y₁,y₂,y₃ = u
  k₁,k₂,k₃ = p
  du[1] = -k₁*y₁+k₃*y₂*y₃
  du[2] =  k₁*y₁-k₂*y₂^2-k₃*y₂*y₃
  du[3] =  k₂*y₂^2
end
prob = ODEProblem(rober,[1.0,0.0,0.0],(0.0,1e5),(0.04,3e7,1e4))
sol = solve(prob,Rosenbrock23())
plot(sol)

# ForwardDiff
ForwardDiff.gradient( xx -> ( (x, y) = xx; x^2 * y + x*y ), [1, 2])

# DiffEqBase
# Distributions
# DiffEqBase.EnsembleAnalysis
function lotka_volterra(du,u,p,t)
  du[1] = p[1] * u[1] - p[2] * u[1]*u[2]
  du[2] = -p[3] * u[2] + p[4] * u[1]*u[2]
end
θ = [1.5,1.0,3.0,1.0]
u0 = [1.0;1.0]
tspan = (0.0,10.0)
θ = [Uniform(0.5,1.5),Beta(5,1),Normal(3,0.5),Gamma(5,2)]
prob_func = function (prob,i,repeat)
  remake(prob,p=rand.(θ))
end
ensemble_prob = EnsembleProblem(ODEProblem(lotka_volterra,u0,tspan,θ),
                                prob_func = prob_func)
sol = solve(ensemble_prob,Tsit5(),EnsembleThreads(),trajectories=1000)
plot(EnsembleSummary(sol))

# StatsPlots
X = Normal(5,1)
x = [rand(X) for i in 1:100]
histogram(x)
histogram([rand(X) for i in 1:10000],normed=true)
plot!(X,lw=5)

# KernelDensity
plot(kde([rand(X) for i in 1:10000]),lw=5)
plot!(X,lw=5)

# Sobol
s = SobolSeq(2)
p = hcat([next!(s) for i = 1:1024]...)'
scatter(p[:,1], p[:,2])

# LatinHypercubeSampling
p = LHCoptim(120,2,1000)
scatter(p[1][:,1],p[1][:,2])

# Traceur
function naive_sum(xs)
  s = 0
  for x in xs
    s += x
  end
  return s
end
@trace naive_sum([1.])

# Profile
function lorenz(du,u,p,t)
  du[1] = 10.0(u[2]-u[1])
  du[2] = u[1]*(28.0-u[3]) - u[2]
  du[3] = u[1]*u[2] - (8/3)*u[3]
end
u0 = [1.0;0.0;0.0]
tspan = (0.0,100.0)
prob = ODEProblem(lorenz,u0,tspan)
sol = solve(prob,Tsit5())
@profile for i in 1:100 sol = solve(prob,Tsit5()) end

# Measurements
gaccel = measurement(9.79, 0.02); # Gravitational constants
L = measurement(1.00, 0.01); # Length of the pendulum
u₀ = [measurement(0, 0), measurement(π / 3, 0.02)] # Initial speed and initial angle
tspan = (0.0, 6.3)
function simplependulum(du,u,p,t)
    θ  = u[1]
    dθ = u[2]
    du[1] = dθ
    du[2] = -(gaccel/L) * sin(θ)
end
prob = ODEProblem(simplependulum, u₀, tspan)
sol = solve(prob, Tsit5(), reltol = 1e-6)
plot(sol,plotdensity=100,vars=2)

# IntervalArithmetic
x = interval(0.1,0.2)
0.1..0.2

# DiffEqUncertainty
function fitz(du,u,p,t)
  V,R = u
  a,b,c = p
  du[1] = c*(V - V^3/3 + R)
  du[2] = -(1/c)*(V -  a - b*R)
end
u0 = [-1.0;1.0]
tspan = (0.0,20.0)
p = (0.2,0.2,3.0)
prob = ODEProblem(fitz,u0,tspan,p)
cb = DiffEqUncertainty.AdaptiveProbIntsUncertainty(5) # 5th order method
sol = solve(prob,Tsit5())
ensemble_prob = EnsembleProblem(prob)
sim = solve(ensemble_prob,Tsit5(),trajectories=100,callback=cb)

# SparseArrays
sparse([1,2,3,4])
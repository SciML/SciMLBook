# 18.337J/6.338J: Parallel Computing and Scientific Machine Learning

There are two main branches of technical computing: machine learning and
scientific computing. Machine learning has received a lot of hype over the
last decade, with techniques such as convolutional neural networks and TSne
nonlinear dimensional reductions powering a new generation of data-driven
analytics. On the other hand, many scientific disciplines carry on with
large-scale modeling through differential equation modeling, looking at
stochastic differential equations and partial differential equations describing
scientific laws.

However, there has been a recent convergence of the two disciplines. This field,
scientific machine learning, has been showcasing results like how partial
differential equation simulations can be accelerated with neural networks.
New methods, such as probabilistic and differentiable programming, have
started to be developed specifically for enhancing the tools of this domain.
However, the techniques in this field combine two huge areas of computational
and numerical practice, meaning that the methods are sufficiently complex.
How do you backpropagate an ODE defined by neural networks? How do you perform
unsupervised learning of a scientific simulator?

In this class we will dig into the methods and understand what they do, why
they were made, and thus how to integrate numerical methods across fields to
accentuate their pros while mitigating their cons. This class will be a survey
of the numerical techniques, showcasing how many disciplines are doing the
same thing under different names, and using a common mathematical language
to derive efficient routines which capture both data-driven and mechanistic-based
modeling.

However, these methods will quickly run into a scaling issue if naively coded.
To handle this problem, everything will have a focus on performance-engineering.
We will start by focusing on algorithm which are inherently serial and
learn to optimize serial code. Then we will showcase how logic-heavy
code can be parallelized through multithreading and distributed computing
techniques like MPI, while direct mathematical descriptions can be parallelized
through GPU computing.

The final part of the course will be a unique project which pulls together these
techniques. As a new field, the students will be exposed to the "low hanging
fruit" and will be directed towards an area which they can make a quick impact.
For the final project, students will team up to solve a new problem in the field of
scientific machine learning, and receive helping writing up a publication-quality
analysis about their work.

Syllabus
--------

**Lectures**: Monday/Wednesday 9:30-11am (4-163). **Office Hours:** Tuesday 12–2pm (32-G785, the Julia Lab).

**Prerequisites**: While this course will be mixing ideas from high performance
computing, numerical analysis, and machine learning, no one in the course is
expected to have covered all of these topics before. Understanding of calculus,
linear algebra, and programming is essential. 18.337 is a graduate-level
subject so mathematical maturity and the ability to learn from primary
literature is necessary. Problem sets will involve use of
[Julia](http://julialang.org/), a Matlab-like environment (little or no prior
experience required; you will learn as you go).

**Textbook & Other Reading**: There is no textbook for this course or the field
of scientific machine learning. Some helpful resources are
[Hairer and Wanner's Solving Ordinary Differential Equations I & II](https://www.springer.com/gp/book/9783540566700)
and [Gilbert Strang's Computational Science and Engineering](https://www.amazon.com/Computational-Science-Engineering-Gilbert-Strang/dp/0961408812).
Much of the reading will come in the form of primary literature from journal
articles posted here.

**Grading**: 66% problem sets, 34% **final project + presentation** due the last
day of class. Problem sets and final projects will be submitted electronically.

**Collaboration policy**: Make an effort to solve the problem on your own before
discussing with any classmates. When collaborating, write up the solution on
your own and acknowledge your collaborators.

## Final Project

The final project is a 10-20 page paper using the style
template from the [_SIAM Journal on Numerical Analysis_](http://www.siam.org/journals/auth-info.php)
(or similar). The final project must include code for a high performance
(parallelized) implementation of the algorithm in a form that is usable by others.
A thorough performance analysis is expected. Model your paper on academic
review articles (e.g. read _SIAM Review_ and similar journals for examples).

One possibility is to review an interesting algorithm not covered in the course
and develop a high performance implementation. Some examples include:

- High performance PDE solvers for specific PDEs like Navier-Stokes
- Common high performance algorithms (Ex: Jacobian-Free Newton Krylov for PDEs)
- Recreation of a parameter sensitivity study in a field like biology,
  pharmacology, or climate science
- [Augmented Neural Ordinary Differential Equations](https://arxiv.org/abs/1904.01681)
- [Neural Jump Stochastic Differential Equations](https://arxiv.org/pdf/1905.10403.pdf)
- Parallelized stencil calculations
- Distributed linear algebra kernels
- Parallel implementations of statistical libraries, such as survival statistics
  or linear models for big data. Here's [one example parallel library)](https://github.com/harrelfe/rms)
  and a [second example](https://bioconductor.org/packages/release/data/experiment/html/RegParallel.html).
- Parallelization of data analysis methods
- Type-generic implementations of sparse linear algebra methods
- A fast regex library

Another possibility is to work on state-of-the-art performance engineering.
This would be implementing a new auto-parallelization or performance enhancement.
For these types of projects, implementing an application for benchmarking is not
required, and one can instead benchmark the effects on already existing code to
find cases where it is beneficial (or leads to performance regressions).
Possible examples are:

- [Create a system for automatic multithreaded parallelism of array operations](https://github.com/JuliaLang/julia/issues/19777) and see what kinds of packages end up more efficient
- [Setup BLAS with a PARTR backend](https://github.com/JuliaLang/julia/issues/32786)
  and investigate the downstream effects on multithreaded code like an existing
  PDE solver
- [Investigate the effects of work-stealing in multithreaded loops](https://github.com/JuliaLang/julia/issues/21017)
- Fast parallelized type-generic FFT. Starter code by Steven Johnson (creator of FFTW)
  and Yingbo Ma [can be found here](https://github.com/YingboMa/DFT.jl)
- Type-generic BLAS. [Starter code can be found here](https://github.com/JuliaBLAS/JuliaBLAS.jl)
- Implementation of parallelized map-reduce methods. For example, `pmapreduce`
  [extension to `pmap`](https://docs.julialang.org/en/v1/manual/parallel-computing/index.html)
  that adds a paralellized reduction, or a fast GPU-based map-reduce.
- Investigating auto-compilation of full package codes to GPUs using tools like
  [CUDAnative](https://github.com/JuliaGPU/CUDAnative.jl) and/or
  [GPUifyLoops](https://github.com/vchuravy/GPUifyLoops.jl).
- Investigating alternative implementations of databases and dataframes.
  [NamedTuple backends of DataFrames](https://github.com/JuliaData/DataFrames.jl/issues/1335), alternative [type-stable DataFrames](https://github.com/FugroRoames/TypedTables.jl), defaults for CSV reading and other large-table formats
  like [JuliaDB](https://github.com/JuliaComputing/JuliaDB.jl).

Additionally, Scientific Machine Learning is a wide open field with lots of
low hanging fruit. Instead of a review, a suitable research project can be
used for chosen for the final project. Possibilities include:

- Acceleration methods for adjoints of differential equations
- Improved methods for Physics-Informed Neural Networks
- New applications of neural differential equations
- Parallelized implicit ODE solvers for large ODE systems
- GPU-parallelized ODE/SDE solvers for small systems

Final project topics must be declared by October 11 with a 1 page extended
abstract.

## Schedule of Topics

Each topic is a group of three pieces: a numerical method, a performance-engineering
technique, and a scientific application. These three together form a complete
usable program that is demonstrated.

Homework 0: Using HPC Clusters

- The basics of scientific simulators (Week 1-2)
  - What is Scientific Machine Learning?
  - Optimization of serial code.
  - Introduction to discrete and continuous dynamical systems.
- Introduction to Parallel Computing (Week 2-3)
  - Tutorial on using the Supercloud HPC (Get an account setup!)
  - Forms of parallelism and applications
  - Parallelizing differential equation solvers
  - Optimal local parallelism via multithreading
  - Linear Algebra libraries you should know

Homework 1: Parallelized global sensitivity analysis of discrete and continuous
dynamical systems

- Continuous Dynamics (Week 4)
  - Ordinary differential equations as the language for ecology, Newtonian mechanics,
    and beyond.
  - Numerical methods for non-stiff ordinary differential equations
  - Definition of stiffness
  - Efficiently solving stiff ordinary differential equations
  - Stiff differential equations arising from biochemical interactions in developmental
    biology and ecology
  - Utilizing type systems and generic algorithms as a mathematical tool
  - Forward-mode automatic differentiation for solving f(x)=0
  - Matrix coloring and sparse differentiation
- Partial differential equations, neural networks, and array-based parallelism (Week 4-5)
  - Cache optimization in numerical linear algebra
  - Discretizations of PDEs
  - Basics of neural networks and definitions
  - The relationship between convolutional neural networks and PDEs
  - Parallelism through array operations
  - How to optimize algorithms for GPUs

Homework 2: Use Convolutional Neural Network Primitives to GPU-accelerate a
PDE solver

- Inverse problems and Differentiable Programming (Week 6)
  - Definition of inverse problems with applications to clinical pharmacology
    and smartgrid optimization
  - Adjoint methods for fast gradients
  - Automated adjoints through reverse-mode automatic differentiation (backpropogation)
- Physics-Informed Neural Networks and Neural Differential Equations (Week 6-7)
  - Adjoints of differential equations
  - Using neural ordinary differential equations as a memory-efficient RNN for
    deep learning
  - Automatic discovery of differential equations
  - Solving differential equations with neural networks

Homework 3: Solving 100 dimensional PDEs with deep learning

- Distributed parallel computing (Jeremy Kepner: Weeks 7-8)
  - Forms of parallelism
  - Using distributed computing vs multithreading
  - Message passing and deadlock
  - Map-Reduce as a framework for distributed parallelism
  - Implementing distributed parallel algorithms with MPI
- Probabilistic Programming, AKA Bayesian Estimation on Programs (Week 9)
  - The connection between optimization and Bayesian methods: Bayesian posteriors
    vs MAP optimization
  - Introduction to Markov-Chain Monte Carlo methods
  - Hamiltonian Monte Carlo is just a symplectic ODE solver
  - Uncertainty quantification of parameter estimates through posteriors
- Methods for understanding the fitness of models (Week 10)
  - Global sensitivity analysis
  - Fast methods for uncertainty quantification
  - Surrogate modeling techniques for accelerating sensitivity calculations
- Final Project Presentations (Weeks 11-12)

# Homeworks

- [Homework 0, due September 25th](https://mitmath.github.io/18337/hw0/hw0)

# Lecture Summaries and Handouts

Note that lectures are broken down by topic, not by day. Some lectures are more
than 1 class day, others are less.

## Lecture 0 (Optional): Introduction to Julia

Learn Julia Session, offered by Steven Johnson. Friday September 6, 5-7pm. Location: 32-141.
[Lecture Notes in Julia for Numerical Computation in MIT Courses](https://github.com/mitmath/julia-mit).

This is an optional session for learning to use Julia. It assumes no prior
programming experience.

## Lecture 1: Introduction to Scientific Machine Learning

#### Lecture Notes

- [What is Scientific Machine Learning?](https://mitmath.github.io/18337/lecture1/scientific_ml.pptx)

#### Optional pre-reading materials

- [The Essential Tools of Scientific Machine Learning](http://www.stochasticlifestyle.com/the-essential-tools-of-scientific-machine-learning-scientific-ml/)
- [Workshop videos on Scientific Machine Learning](https://icerm.brown.edu/events/ht19-1-sml/)

#### Summary

We will start off by setting the stage for the course. The field of scientific
machine learning and its span across computational science to applications in
climate modeling and aerospace will be introduced. The methodologies that will be
studied, in their various names, will be introduced, and the general formula that
is arising in the discipline will be laid out: a mixture of scientific simulation
tools like differential equations with machine learning primitives like neural
networks, tied together through differentiable programming to achieve results
that were previously not possible.

## Lecture 2: Introduction to Code Optimization

##### Lecture Notes

- [Optimizing Serial Code](https://mitmath.github.io/18337/lecture2/optimizing)

##### Optional pre-reading materials

- [Optimizing Your DiffEq Code](http://tutorials.juliadiffeq.org/html/introduction/03-optimizing_diffeq_code.html)
- [Type-Dispatch Design: Post Object-Oriented Programming for Julia](http://www.stochasticlifestyle.com/type-dispatch-design-post-object-oriented-programming-julia/)
- [Performance Matters](https://www.youtube.com/watch?v=r-TLSBdHe1A)
- [You're doing it wrong (B-heaps vs Binary Heaps and Big O)](http://phk.freebsd.dk/B-Heap/queue.html)

#### Summary

You will get nowhere in scientific machine learning with slow code. We need to
jam together partial differential equations and neural networks, and so we need
to know how to program both in an efficient manner. Here we will build a mental
model for the computer to understand how caches, heap allocations, function calls,
etc. make a program either fast or slow. We will also introduce the ideas of
type inference, multiple dispatch, and showcase how these features can be utilized
to generate fast code. JIT compilers don't make fast code: embedding knowledge
about the routine makes fast code.

## Lecture 3: Introduction to High Performance Computing Clusters (Supercloud)

### Guest Lecturer Lauren E Milechin

#### Note to students: [Get a supercloud account](https://supercloud.mit.edu/requesting-account)

- [Supercloud Cheatsheet](https://mitmath.github.io/18337/lecture3/TX-E1_Reference_Guide_020819.pdf)
- [MIT Supercloud Getting Started](https://supercloud.mit.edu/getting-started)
- [Supercloud Teaching Examples](https://github.com/llsc-supercloud/teaching-examples)

#### Summary

This lecture went over the basics of using the MIT Supercloud cluster: logging
on, submitting jobs, checking the job list, etc.

## Lecture 4: Introduction to Dynamical Systems

#### Lecture Notes

- [How Loops Work, An Introduction to Discrete Dynamics](https://mitmath.github.io/18337/lecture4/dynamical_systems)

#### Optional pre-reading materials

- [Strogatz: Nonlinear Dynamics and Chaos](https://www.amazon.com/Nonlinear-Dynamics-Chaos-Applications-Nonlinearity/dp/0738204536)
- [Stability of discrete dynamics equilibrium](https://mathinsight.org/equilibria_discrete_dynamical_systems_stability)
- [Behavior of continuous linear dynamical systems](http://chrisrackauckas.com/assets/Papers/ChrisRackauckas-ContinuousDynamics.pdf)

Once the stage is set, we will start by developing the basics of our scientific
simulators: differential and difference equations. A quick overview of geometric
results in the study of differential and difference equations will set the stage
for understanding nonlinear dynamics, which we will quickly turn to numerical
methods to visualize. Here, the routines of numerical differential equations,
such as the Runge-Kutta and Adams-Bashforth methods, will shown as a way to
translate a continuous description of a system into a discrete one that is
amenable to computational simulation.

The discretization of a differential equation has some curious aspects which must
be appropriately handled in order to arrive at a suitably scalable scientific simulator.
This lecture will end by going into how serial scalar-heavy codes can be optimized.
SIMD, in-place operations, broadcasting, heap allocations, and static arrays will be
used to get fast codes for dynamical system simulation. These simulations will then
be used to reveal some intriguing properties of dynamical systems which will be
further explored through the rest of the course.

## Lecture 5: Array-Based Parallelism, Embarrassingly Parallel Problems, and Data-Parallelism

#### Lecture Notes

- [The Basics of Single Node Parallel Computing](https://mitmath.github.io/18337/lecture5/parallelism_overview)

#### Optional Pre-Reading Materials

Now that we have a concrete problem, let's start investigating ways to parallelize
its solution. We will first see that many systems have an almost automatic way
of parallelizing through array operations, which we will call array-based
parallelism. The ability to easily parallelize large blocked linear algebra
will be discussed, along with libraries like OpenBLAS, Intel MKL, CuBLAS (GPU
parallelism) and Elemental.jl. This gives a form of Within-Method Parallelism
which we can use to optimize specific algorithms which utilize linearity.
Another form of parallelism is to parallelize over the inputs. We will describe
how this is a form of data parallelism, and use this as a framework to
introduce shared memory and distributed parallelism. The interactions between
these parallelization methods and application considerations will be discussed.

## Lecture 6: Ordinary Differential Equations Across the Sciences

## Lecture 7: Numerical Methods for ODEs

## Lecture 8: Designing ODE Methods for Within-Method Parallelism

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

**Grading**: 66% problem sets, 34% **final project** (due December 16th).
Problem sets and final projects will be submitted electronically.

**Collaboration policy**: Make an effort to solve the problem on your own before
discussing with any classmates. When collaborating, write up the solution on
your own and acknowledge your collaborators.

## Final Project

The final project is a 10-20 page paper using the style
template from the [_SIAM Journal on Numerical Analysis_](http://www.siam.org/journals/auth-info.php)
(or similar). The final project must include code for a high performance
(or parallelized) implementation of the algorithm in a form that is usable by others.
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
- Math library primitives (exp, log, etc.)

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

Final project topics must be declared by October 18th with a 1 page extended
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

Homework 2: Parameter estimation in dynamical systems and overhead of parallelism

- Inverse problems and Differentiable Programming (Week 6)
  - Definition of inverse problems with applications to clinical pharmacology
    and smartgrid optimization
  - Adjoint methods for fast gradients
  - Automated adjoints through reverse-mode automatic differentiation (backpropogation)
  - Adjoints of differential equations
  - Using neural ordinary differential equations as a memory-efficient RNN for
    deep learning
- Neural networks, and array-based parallelism (Week 8)
  - Cache optimization in numerical linear algebra
  - Parallelism through array operations
  - How to optimize algorithms for GPUs
- Distributed parallel computing (Jeremy Kepner: Weeks 7-8)
  - Forms of parallelism
  - Using distributed computing vs multithreading
  - Message passing and deadlock
  - Map-Reduce as a framework for distributed parallelism
  - Implementing distributed parallel algorithms with MPI

Homework 3: Training neural ordinary differential equations (with GPUs)

- Physics-Informed Neural Networks and Neural Differential Equations (Week 9-10)
  - Automatic discovery of differential equations
  - Solving differential equations with neural networks
  - Discretizations of PDEs
  - Basics of neural networks and definitions
  - The relationship between convolutional neural networks and PDEs
- Probabilistic Programming, AKA Bayesian Estimation on Programs (Week 10-11)
  - The connection between optimization and Bayesian methods: Bayesian posteriors
    vs MAP optimization
  - Introduction to Markov-Chain Monte Carlo methods
  - Hamiltonian Monte Carlo is just a symplectic ODE solver
  - Uncertainty quantification of parameter estimates through posteriors
- Globalizing the understanding of models (Week 11-12)
  - Global sensitivity analysis
  - Global optimization
  - Surrogate Modeling
  - Uncertainty Quantification

# Homeworks

- [Homework 0, due September 25th](https://mitmath.github.io/18337/hw0/hw0.html)
- [Homework 1, due October 16th](https://mitmath.github.io/18337/hw1/hw1.html)
- [Homework 2, due November 13th](https://mitmath.github.io/18337/hw2/hw2.html) (Extended to the 15th!)
- [Homework 3, due December 4th](https://mitmath.github.io/18337/hw3/hw3.html)

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
- [SciML Open Source Scientific Machine Learning](https://sciml.ai/)

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

## Lecture 6: Styles of Parallelism

#### Lecture Notes

- [Styles of Parallelism](https://mitmath.github.io/18337/lecture6/styles_of_parallelism)

Here we continue down the line of describing methods of parallelism by giving
a high level overview of the types of parallelism. SIMD and multithreading
are reviewed as the basic forms of parallelism where message passing is not a
concern. Then accelerators, such as GPUs and TPUs are introduced. Moving further,
distributed parallel computing and its models are showcased.

## Lecture 7: Ordinary Differential Equations: Applications and Discretizations

#### Lecture Notes

- [Discretizing Ordinary Differential Equations](https://mitmath.github.io/18337/lecture7/discretizing_odes)

In this lecture we will describe ordinary differential equations, where they
arise in scientific contexts, and how they are solved. We will see that
understanding the properties of the numerical methods requires understanding
the dynamics of the discrete system generated from the approximation to the
continuous system, and thus stability of a numerical method is directly tied
to the stability properties of the dynamics. This gives the idea of stiffness,
which is a larger computational idea about ill-conditioned systems.

## Lecture 8: Automatic Differentiation

#### Lecture Notes

- [Automatic Differentiation and Applications](https://mitmath.github.io/18337/lecture8/automatic_differentiation)

### Guest Lecturer David Sanders

As we will soon see, the ability to calculate derivatives underpins a lot of
problems in both scientific computing and machine learning. We will specifically
see it show up in later lectures on solving implicit equations f(x)=0 for stiff
ordinary differential equation solvers, and in fitting neural networks. The
common high performance way that this is done is called automatic
differentiation. This lecture introduces the methods of forward and reverse
mode automatic differentiation to setup future studies uses of the technique.

## Lecture 9: Solving Stiff Ordinary Differential Equations

#### Lecture Notes

- [Forward-Mode AD via High Dimensional Algebras](https://mitmath.github.io/18337/lecture9/autodiff_dimensions)
- [Solving Stiff Ordinary Differential Equations](https://mitmath.github.io/18337/lecture9/stiff_odes)

#### Additional Readings on Convergence of Newton's Method

- [Newton's Method](https://link.springer.com/chapter/10.1007%2F978-1-4612-0701-6_8)
- [Relaxed Newton's Method](https://pdfs.semanticscholar.org/1844/34b366f337972aa94a601fabd251d0baf62f.pdf)
- [Convergence of Pure and Relaxed Newton Methods](https://www.sciencedirect.com/science/article/pii/S00243795130067820)
- [Smale's Alpha Theory for Newton Convergence](http://cswiercz.info/2016/01/20/narc-talk.html)
- [alphaCertified: certifying solutions to polynomial systems](https://arxiv.org/abs/1011.1091)
- [Improved convergence theorem for Newton](https://arxiv.org/ftp/arxiv/papers/1503/1503.03543.pdf)
- [Generalizations of Newton's Method](https://www.math.uwaterloo.ca/~wgilbert/Research/GilbertFractals.pdf)

Solving stiff ordinary differential equations, especially those which arise
from partial differential equations, are the common bottleneck of scientific
computing. The largest-scale scientific computing models are generally using
heavy compute power in order to tackle some implicitly timestepped PDE solve!
Thus we will take a deep dive into how the different methods which are combined
to create a stiff ordinary differential equation solver, looking at different
aspects of Jacobian computations and linear solving and the effects that they
have.

## Lecture 10: Basic Parameter Estimation, Reverse-Mode AD, and Inverse Problems

- [Basic Parameter Estimation, Reverse-Mode AD, and Inverse Problems](https://mitmath.github.io/18337/lecture10/estimation_identification)

Now that we have models, how do you fit the models to data? This lecture goes
through the basic shooting method for parameter estimation, showcases how
it's equivalent to training neural networks, and gives an in-depth discussion
of how reverse-mode automatic differentiation is utilized in the training
process for the efficient calculation of gradients.

## Lecture 11: Differentiable Programming and Neural Differential Equations

- [Differentiable Programming and Neural Differential Equations](https://mitmath.github.io/18337/lecture11/adjoints)
- [Universal Differential Equations for Scientific Machine Learning](https://arxiv.org/abs/2001.04385)

Given the efficiency of reverse-mode automatic differentiation, we want to see
how far we can push this idea. How could one implement reverse-mode AD without
computational graphs, and include problems like nonlinear solving and ordinary
differential equations? Are there methods other than shooting methods that can
be utilized for parameter fitting? This lecture will explore where reverse-mode
AD intersects with scientific modeling, and where machine learning begins to
enter scientific computing.

## Lecture 12: MPI.jl

- [MPI.jl](https://mitmath.github.io/18337/lecture12/MPI.jl.pptx)
- [MPI.jl Examples](https://github.com/llsc-supercloud/teaching-examples/tree/master/Julia/word_count/Parallel/mpi)

In this lecture we went over the basics of MPI (Message Passing Interface) for
distributed computing and examples on how to use `MPI.jl`.

## Lecture 13: GPU computing

#### Lecture Notes

- [GPU computing in Julia](https://mitmath.github.io/18337/lecture13/gpus)
- [Lecture slides](https://docs.google.com/presentation/d/1JfxmqJx7BdVyfBSL0N4bzBYdy8RIJ6hSSTHHJfPAo1o/edit?usp=sharing)

#### Optional pre-reading materials

- [Styles of Parallelism](https://mitmath.github.io/18337/lecture6/styles_of_parallelism)
- [Computer Architecture 6ed: Chapter 4.4](https://dl.acm.org/citation.cfm?id=3207796)
- [NVIDIA devblog](https://devblogs.nvidia.com/gpu-computing-julia-programming-language/)
- [CuArrays tutorial](https://juliagpu.gitlab.io/CuArrays.jl/tutorials/generated/intro/)

We will revisit parallel architectures and the programming models associated with them,
before focusing on GPU programming in Julia.

## Lecture 14: Partial Differential Equations and Convolutional Neural Networks

#### Lecture Notes

- [PDEs, Convolutions, and the Mathematics of Locality](https://mitmath.github.io/18337/lecture14/pdes_and_convolutions)

In this lecture we will continue to relate the methods of machine learning to
those in scientific computing by looking at the relationship between convolutional
neural networks and partial differential equations. It turns out they are more
than just similar: the two are both stencil computations on spatial data!

## Lecture 15: Algorithms which Connect Differential Equations and Machine Learning

- [Mixing Differential Equations and Neural Networks for Physics-Informed Learning](https://mitmath.github.io/18337/lecture15/diffeq_machine_learning)

Neural ordinary differential equations are only the tip of the iceberg. In this
lecture we will look into other algorithms which are utilizing the connection
between neural networks and machine learning. First we will generalize to
neural differential equations with DiffEqFlux.jl, which now allows for stiff
equations, stochasticity, delays, constraint equations, event handling, etc.
to all take place in a neural differential equation format. Then we will look
into how ordinary and partial differential equations can be solved using neural
networks and the same backpropagation ideas that we had developed earlier. Next
we dig into physics-informed neural networks (PINNs), a new methodology which
utilizes a known physical equation (a partial differential equation) to relax
the data towards to allow for a data-efficient machine learning algorithm. Then
we will dig into the methods for solving high dimensional partial differential
equations through transformations to backwards stochastic differential equations
(BSDEs), and the applications to mathematical finance through Black-Scholes along
with stochastic optimal control through Hamilton-Jacobi-Bellman equations.
To end it, we will look into methods for accelerating differential equation
solving through neural surrogate models, and uncover the true idea of what's
going on, along with understanding when these applications can be used effectively.

## Lecture 16: Probabilistic Programming

- [From Optimization to Probabilistic Programming](https://mitmath.github.io/18337/lecture16/probabilistic_programming)

All of our previous discussions lived in a deterministic world. Not this one.
Here we turn to a probabilistic view and allow programs to have random variables.
Forward simulation of a random program is seen to be simple through Monte Carlo
sampling. However, parameter estimation is now much more involved, since in this
case we need to estimate not just values but probability distributions. It turns
out that Bayes' rule gives a framework for performing such estimations. We see
that classical parameter estimation falls out as a maximization of probability
with the "simplest" form of distributions, and thus this gives a nice generalization
even to standard parameter estimation and justifies the use of L2 loss functions
and regularization (as a perturbation by a prior). Next, we turn to estimating
the distributions, which we see is possible for small problems using Metropolis
Hastings, but for larger problems we develop Hamiltonian Monte Carlo. It turns
out that Hamiltonian Monte Carlo has strong ties to both ODEs and differentiable
programming: it is defined as solving ODEs which arise from a Hamiltonian, and
derivatives of the likelihood are required, which is essentially the same idea
as derivatives of cost functions! We then describe an alternative approach:
Automatic Differentiation Variational Inference (ADVI), which once again is using
the tools of differentiable programming to estimate distributions of probabilistic
programs.

## Lecture 17: Global Sensitivity Analysis

- [Global Sensitivity Analysis](https://mitmath.github.io/18337/lecture17/global_sensitivity)

Our previous analysis of sensitivities was all local. What does it mean to example
the sensitivities of a model globally? It turns out the probabilistic programming
viewpoint gives us a solid way of describing how we expect values to be changing
over larger sets of parameters via the random variables that describe the program's
inputs. This means we can decompose the output variance into indices which can
be calculated via various quadrature approximations which then give a tractable
measurement to "variable x has no effect on the mean solution".

## Lecture 18: Code Profiling

- [Code Profiling](https://mitmath.github.io/18337/lecture18/code_profiling)

Here we take a small diversion back towards code performance and take a quick
look at tools for profiling code and use this to understand how to find the
correct lines to improve our code's timings. This is something that will be
essential in many research codes (including your project!)

## Lecture 19: Uncertainty Programming and Generalized Uncertainty Quantification

- [Uncertainty Programming](https://mitmath.github.io/18337/lecture19/uncertainty_programming)

We end the course by taking a look at another mathematical topic to see whether
it can be addressed in a similar manner: uncertainty quantification (UQ). There are
ways which it can be handled similar to automatic differentiation. Measurements.jl
gives a forward-propagation approach, somewhat like ForwardDiff's dual numbers,
through a number type which is representative of normal distributions and pushes
these values through a program. This has many advantages, since it allows for
uncertainty quantification without sampling, but turns the number types into a
value that is heap allocated. Other approaches are investigated, like interval
arithmetic which is rigorous but limited in scope. But on the entirely other end,
a non-general method for ODEs is shown which utilizes the trajectory structure
of the differential equation solution and doesn't give the blow up that the
other methods see. This showcases that uses higher level information can be
helpful in UQ, and less local approaches may be necessary.

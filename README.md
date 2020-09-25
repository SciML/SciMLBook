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

## Note About COVID-19

During the Fall of 2020, the special circumstances call for special approaches
to teaching. In order to accommodate the lack of in-person treatment, the course
will be very project-based, helping students grow as researchers in the area of
parallel computing and scientific machine learning. The goal of this approach
will be to help train students to become successful in the modern international
online open research environment. As such, lectures will be done by pre-recorded
videos. A Slack will be created for asynchronous communication (all students
registered for the course will receive an email invitation. Students who wish
to follow along with the course should email to receive an invite). Drop in online
office hours will be available to discuss the topic with the instructor and
other students over a video chat (time TBD depending on the current environment
of the students).

Half of the assessment will be based on homework assignments. These will be timed
to ensure that the students are keeping up-to-date with the course material. The
other half of the grade will be from a final project.

## Syllabus

**Lectures**: Pre-recorded online **Office Hours:** TBD.

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

**Grading**: 50% problem sets, 10% for the final project proposal (due October 30th),
and 40% for the **final project** (due December 18th). Problem sets and final
projects will be submitted electronically.

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

- The basics of scientific simulators (Week 1-2)
  - What is Scientific Machine Learning?
  - Optimization of serial code.
  - Introduction to discrete and continuous dynamical systems.
- Introduction to Parallel Computing (Week 2-3)
  - Forms of parallelism and applications
  - Parallelizing differential equation solvers
  - Optimal local parallelism via multithreading
  - Linear Algebra libraries you should know

Homework 1: Parallelized dynamical system simulations and ODE integrators

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

- [Homework 1: Parallelized Dynamics. Due October 1st](https://mitmath.github.io/18337/hw1/hw1)

# Lecture Summaries and Handouts

Note that lectures are broken down by topic, not by day. Some lectures are more
than 1 class day, others are less.

## Lecture 1: Introduction and Syllabus

### Lecture and Notes

- [Introduction and Syllabus (Lecture)](https://youtu.be/3IoqyXmAAkU)

This is to make sure we're all on the same page. It goes over the syllabus and
what will be expected of you throughout the course. If you have not joined the Slack,
please use the link from the introduction email (or email me if you need the link!).

## Lecture 1.1: Getting Started with Julia

### Lecture and Notes

- [Getting Started with Julia for Experienced Programmers (Lecture)](https://youtu.be/-lJK92bEKow)
- [Julia for Numerical Computation in MIT Courses](https://github.com/mitmath/julia-mit)
- [Steven Johnson: MIT Julia Tutorial](https://mit.zoom.us/rec/play/E4zN_2MXQmCjX12admWsmsbG6hIlWJztnMmFjlfDEBnlAj8V2qisRn-CLI_WVnUGJFZ4bV6JGM-41m-u.LeAWxiLriV5HwqBK?startTime=1599594382000)

### Optional Extra Resources

If you are not comfortable with Julia yet, here's a few resources as sort of a
"crash course" to get you up an running:

- [The Julia Manual](https://docs.julialang.org/en/v1/)
- [Developing Julia Packages](https://youtu.be/QVmU29rCjaA)
- [Julia Tutorial (Youtube Video by Jane Herriman)](https://www.youtube.com/watch?v=8h8rQyEpiZA)

Some deeper materials:

- [ThinkJulia](https://benlauwens.github.io/ThinkJulia.jl/latest/book.html)
- [Julia Wikibook](https://en.wikibooks.org/wiki/Introducing_Julia)
- [Intro To Julia for Data Science and Scientific Computing (With Problems and Answers)](http://ucidatascienceinitiative.github.io/IntroToJulia/)
- [QuantEcon Cheatsheet](https://cheatsheets.quantecon.org/)
- [Julia Noteworthy Differences from Other Languages](https://docs.julialang.org/en/v1/manual/noteworthy-differences/)

Steven Johnson will be running a Julia workshop on 9/8/2020 for people who are
interested. More details TBA.

## Lecture 2: Optimizing Serial Code

### Lecture and Notes

- [Optimizing Serial Code in Julia 1: Memory Models, Mutation, and Vectorization (Lecture)](https://youtu.be/M2i7sSRcSIw)
- [Optimizing Serial Code in Julia 2: Type inference, function specialization, and dispatch (Lecture)](https://youtu.be/10_Ukm9wr9g)
- [Optimizing Serial Code (Notes)](https://mitmath.github.io/18337/lecture2/optimizing)

### Optional Extra Resources

- [Optimizing Your DiffEq Code](https://tutorials.sciml.ai/html/introduction/03-optimizing_diffeq_code.html)
- [Type-Dispatch Design: Post Object-Oriented Programming for Julia](https://www.stochasticlifestyle.com/type-dispatch-design-post-object-oriented-programming-julia/)
- [Performance Matters](https://www.youtube.com/watch?v=r-TLSBdHe1A0)
- [You're doing it wrong (B-heaps vs Binary Heaps and Big O)](http://phk.freebsd.dk/B-Heap/queue.html)
- [Bjarne Stroustrup: Why you should avoid Linked Lists](https://www.youtube.com/watch?v=YQs6IC-vgmo)
- [What scientists must know about hardware to write fast code](https://biojulia.net/post/hardware/)

Before we start to parallelize code, build huge models, and automatically learn
physics, we need to make sure our code is "good". How do you know you're writing
"good" code? That's what this lecture seeks to answer. In this lecture we'll go
through the techniques for writing good serial code and checking that your code
is efficient.

## Lecture 3: Introduction to Scientific Machine Learning Through Physics-Informed Neural Networks

- [Introduction to Scientific Machine Learning 1: Deep Learning as Function Approximation (Lecture)](https://youtu.be/C3vf9ZFYbjI)
- [Introduction to Scientific Machine Learning 2: Physics-Informed Neural Networks (Lecture)](https://youtu.be/hKHl68Fdpq4)
- [Introduction to Scientific Machine Learning through Physics-Informed Neural Networks (Notes)](https://mitmath.github.io/18337/lecture3/sciml.html)

### Optional Extra Resources

- [Doing Scientific Machine Learning (4 hour workshop)](https://www.youtube.com/watch?v=QwVO0Xh2Hbg)
- [Universal Differential Equations for Scientific Machine Learning](https://www.youtube.com/watch?v=5zaB1B4hOnQ)
- [JuliaCon 2020 | Keynote: Scientific Machine Learning | Prof Karen Willcox (High Level)](https://www.youtube.com/watch?v=Bk4PJnjuPps)
- [DOE Workshop Report on Basic Research Needs for Scientific Machine Learning](https://www.osti.gov/servlets/purl/1478744)

Now let's take our first stab at the application: scientific machine learning.
What is scientific machine learning? We will define the field by looking at a
few approaches people are taking and what kinds of problems are being solved
using scientific machine learning. The field of scientific machine learning and
its span across computational science to applications in climate modeling and
aerospace will be introduced. The methodologies that will be studied, in their
various names, will be introduced, and the general formula that is arising in
the discipline will be laid out: a mixture of scientific simulation tools like
differential equations with machine learning primitives like neural networks,
tied together through differentiable programming to achieve results that were
previously not possible. After doing a survey, we while dive straight into
developing a physics-informed neural network solver which solves an ordinary
differential equation.

## Lecture 4: Introduction to Discrete Dynamical Systems

- [How Loops Work 1: An Introduction to the Theory of Discrete Dynamical Systems (Lecture)](https://www.youtube.com/watch?v=GhBARuHEydM)
- [How Loops Work 2: Computationally-Efficient Discrete Dynamics (Lecture)](https://youtu.be/AXHLyHfyEuA)
- [How Loops Work, An Introduction to Discrete Dynamics (Notes)](https://mitmath.github.io/18337/lecture4/dynamical_systems.html)

### Optional Extra Resources

- [Strogatz: Nonlinear Dynamics and Chaos](https://www.amazon.com/Nonlinear-Dynamics-Chaos-Applications-Nonlinearity/dp/0738204536)
- [Stability of discrete dynamics equilibrium](https://mathinsight.org/equilibria_discrete_dynamical_systems_stability)
- [Behavior of continuous linear dynamical systems](https://chrisrackauckas.com/assets/Papers/ChrisRackauckas-ContinuousDynamics.pdf)
- [Golden Ratio Growth Argument](https://github.com/facebook/folly/blob/master/folly/docs/FBVector.md)
- [Golden Ratio Growth PR and timings](https://github.com/JuliaLang/julia/pull/16305)

Now that the stage is set, we see that to go deeper we will need a good grasp
on how both discrete and continuous dynamical systems work. We will start by
developing the basics of our scientific simulators: differential and difference
equations. A quick overview of geometric results in the study of differential
and difference equations will set the stage for understanding nonlinear dynamics,
which we will quickly turn to numerical methods to visualize. Even if there is
not analytical solution to the dynamical system, overarching behavior such as
convergence to zero can be determined through asymptotic means and linearization.
We will see later that these same techniques for the basis for the analysis
of numerical methods for differential equations, such as the Runge-Kutta and
Adams-Bashforth methods.

Since the discretization of differential equations is indeed a discrete dynamical
system, we will use this as a case study to see how serial scalar-heavy codes
should be optimized. SIMD, in-place operations, broadcasting, heap allocations,
and static arrays will be used to get fast codes for dynamical system simulation.
These simulations will then be used to reveal some intriguing properties of
dynamical systems which will be further explored through the rest of the course.

## Lecture 5:

- [The Basics of Single Node Parallel Computing (Lecture)](https://youtu.be/eca6kcFntiE)
- [The Basics of Single Node Parallel Computing (Notes)](https://mitmath.github.io/18337/lecture5/parallelism_overview.html)

### Optional Extra Resources

- [Chart of CPU Operation Costs](http://ithare.com/wp-content/uploads/part101_infographics_v08.png)

Now that we have a concrete problem, let's start investigating ways to
parallelize its solution. We will first see that many systems have an almost
automatic way of parallelizing through array operations, which we will call
array-based parallelism. The ability to easily parallelize large blocked linear
algebra will be discussed, along with libraries like OpenBLAS, Intel MKL, CuBLAS
(GPU parallelism) and Elemental.jl. This gives a form of Within-Method
Parallelism which we can use to optimize specific algorithms which utilize
linearity. Another form of parallelism is to parallelize over the inputs. We
will describe how this is a form of data parallelism, and use this as a
framework to introduce shared memory and distributed parallelism. The
interactions between these parallelization methods and application
considerations will be discussed.

## Lecture 6: Styles of Parallelism

- [The Different Flavors of Parallelism: Parallel Programming Models (Lecture)](https://youtu.be/EP5VWwPIews)
- [The Different Flavors of Parallelism (Notes)](https://mitmath.github.io/18337/lecture6/styles_of_parallelism.html)

Here we continue down the line of describing methods of parallelism by giving a
high level overview of the types of parallelism. SIMD and multithreading are
reviewed as the basic forms of parallelism where message passing is not a
concern. Then accelerators, such as GPUs and TPUs are introduced. Moving
further, distributed parallel computing and its models are showcased. What we
will see is that what kind of parallelism we are doing actually is not the main
determiner as to how we need to think about parallelism. Instead, the determining
factor is the parallel programming model, where just a handful of models, like
task-based parallelism or SPMD models, are seen across all of the different
hardware abstractions.

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
and 40% for the **final project** (due December 14th). Problem sets and final
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

Final project topics must be declared by October 30th with a 1 page extended
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
- [Homework 2: Parameter Estimation in Dynamical Systems and Bandwidth Maximization. Due November 5th](https://mitmath.github.io/18337/hw2/hw2)
- [Homework 3: Neural Ordinary Differential Equation Adjoints. Due December 9th](https://mitmath.github.io/18337/hw3/hw3)

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

## Lecture 5: Array-Based Parallelism, Embarrassingly Parallel Problems, and Data-Parallelism: The Basics of Single Node Parallel Computing

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

## Lecture 7: Ordinary Differential Equations: Applications and Discretizations

- [Ordinary Differential Equations 1: Applications and Solution Characteristics (Lecture)](https://youtu.be/riAbPZy9gFc)
- [Ordinary Differential Equations 2: Discretizations and Stability (Lecture)](https://youtu.be/HMmOk9GIhsw)
- [Ordinary Differential Equations: Applications and Discretizations (Notes)](https://mitmath.github.io/18337/lecture7/discretizing_odes.html)

In this lecture we will describe ordinary differential equations, where they arise in scientific contexts, and how they are solved. We will see that understanding the properties of the numerical methods requires understanding the dynamics of the discrete system generated from the approximation to the continuous system, and thus stability of a numerical method is directly tied to the stability properties of the dynamics. This gives the idea of stiffness, which is a larger computational idea about ill-conditioned systems.

## Lecture 8: Forward-Mode Automatic Differentiation

- [Forward-Mode Automatic Differentiation (AD) via High Dimensional Algebras (Lecture)](https://youtu.be/zHPXGBiTM5A)
- [Forward-Mode Automatic Differentiation (AD) via High Dimensional Algebras (Notes)](https://mitmath.github.io/18337/lecture8/automatic_differentiation.html)

As we will soon see, the ability to calculate derivatives underpins a lot of problems in both scientific computing and machine learning. We will specifically see it show up in later lectures on solving implicit equations f(x)=0 for stiff ordinary differential equation solvers, and in fitting neural networks. The common high performance way that this is done is called automatic differentiation. This lecture introduces the methods of forward and reverse mode automatic differentiation to setup future studies uses of the technique.

## Lecture 9: Solving Stiff Ordinary Differential Equations

#### Lecture Notes

- [Solving Stiff Ordinary Differential Equations (Lecture)](https://youtu.be/bY2VCoxMuo8)
- [Solving Stiff Ordinary Differential Equations (Notes)](https://mitmath.github.io/18337/lecture9/stiff_odes)

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

- [Basic Parameter Estimation, Reverse-Mode AD, and Inverse Problems (Lecture)](https://youtu.be/XQAe4pEZ6L4)
- [Basic Parameter Estimation, Reverse-Mode AD, and Inverse Problems (Notes)](https://mitmath.github.io/18337/lecture10/estimation_identification)

Now that we have models, how do you fit the models to data? This lecture goes through the basic shooting method for parameter estimation, showcases how it's equivalent to training neural networks, and gives an in-depth discussion of how reverse-mode automatic differentiation is utilized in the training process for the efficient calculation of gradients.

## Lecture 11: Differentiable Programming and Neural Differential Equations

- [Differentiable Programming Part 1: Reverse-Mode AD Implementation (Lecture)](https://youtu.be/fXcekZZP-1A)
- [Differentiable Programming Part 2: Adjoint Derivation for (Neural) ODEs and Nonlinear Solve (Lecture)](https://youtu.be/KCTfPyVIxpc)
- [Differentiable Programming and Neural Differential Equations (Notes)](https://mitmath.github.io/18337/lecture11/adjoints)

### Additional Readings on AD Implementations

- [Non-local compiler transformations in the presence of dynamic dispatch (Diffractor.jl and higher order AD via Category Theory)](https://youtu.be/mQnSRfseu0c)
- [JAX: accelerated machine learning research via composable function transformations in Python](https://youtu.be/BzuEGdGHKjc)

Given the efficiency of reverse-mode automatic differentiation, we want to see
how far we can push this idea. How could one implement reverse-mode AD without
computational graphs, and include problems like nonlinear solving and ordinary
differential equations? Are there methods other than shooting methods that can
be utilized for parameter fitting? This lecture will explore where reverse-mode
AD intersects with scientific modeling, and where machine learning begins to
enter scientific computing.

## Lecture 12.1: MPI for Distributed Computing

Guest Lecturer: Lauren E. Milechin, MIT Lincoln Lab and the MIT Supercloud
Guest Writer: Jeremy Kepner, MIT Lincoln Lab and the MIT Supercloud

- [Introduction to MPI.jl (Lecture)](https://www.youtube.com/watch?v=LCIJj0czofo)
- [Introduction to MPI.jl (Notes: PDF)](https://github.com/mitmath/18337/blob/master/lecture12/MPI.jl.pdf)

In this lecture we went over the basics of MPI (Message Passing Interface) for distributed computing and examples on how to use MPI.jl to write parallel programs that work efficiently over multiple computers (or "compute nodes"). The MPI programming model and the job scripts required for using MPI on the MIT Supercloud HPC were demonstrated.

## Lecture 12.2: Mathematics of Machine Learning and High Performance Computing

Guest Lecturer: Jeremy Kepner, MIT Lincoln Lab and the MIT Supercloud

- [Mathematics of Big Data and Machine Learning (Lecture)](https://youtu.be/0sKPkJME2Jw?t=26)
- [Mathematical Foundations of the GraphBLAS and Big Data (Lecture)](https://youtu.be/gZSNp6XbOK8?t=17)
- [AI Data Architecture (Lecture)](https://youtu.be/RpPlj2HnuWg?t=1412)
- [Performance Metrics and Software Architecture (Book Chapter)](https://github.com/mitmath/18337/blob/master/lecture12/PerformanceMetricsSoftwareArchitecture.pdf)
- [Optimizing Xeon Phi for Interactive Data Analysis (Paper)](https://github.com/mitmath/18337/blob/master/lecture12/OptimizingXeonPhi-PID6086383.pdf)

In this lecture we went over the mathematics behind big data, machine learning, and high performance computing. Pieces like Amdahl's law for describing maximal parallel compute efficiency were described and demonstrated to showcase some hard ceiling on the capabilities of parallel computing, and these laws were described in the context of big data computations in order to assess the viability of distributed computing within that domain's context.

## Lecture 13: GPU Computing

Guest Lecturer: Valentin Churavy, MIT Julia Lab

- [Parallel Computing: From SIMD to SIMT (Lecture)](https://youtu.be/KCYlEub_8xc)
- [GPU Computing in Julia](https://youtu.be/v9bFRg4rUfk)
- [Parallel Computing: From SIMD to SIMT (Notes)](https://docs.google.com/presentation/d/1C1dt8zeNW7spgswr2CmLrE0G-ayj0ItvoEWHdX_0kYc/edit#slide=id.g76b4384d33_0_5)
- [GPU Computing in Julia (Notes)](https://docs.google.com/presentation/d/1QvHE_xVDKnPA3-nowzpZY1lUdXr7B8rLCu2usOz8KT8/edit#slide=id.gb00e54ec3a_0_477)

In this lecture we take a deeper dive into the architectural differences of GPUs
and how that changes the parallel computing mindset that's required to arrive
at efficient code. Valentin walks through the compilation process and how the
resulting behaviors are due to core trade-offs in GPU-based programming and direct
compilation for such hardware.

## Lecture 14: Partial Differential Equations and Convolutional Neural Networks

- [PDEs, Convolutions, and the Mathematics of Locality (Lecture)](https://youtu.be/apkyk8n0vBo)
- [PDEs, Convolutions, and the Mathematics of Locality (Notes)](https://mitmath.github.io/18337/lecture14/pdes_and_convolutions)

### Additional Readings

- [Deep Neural Networks Motivated by Partial Differential Equations](https://arxiv.org/abs/1804.04272)

In this lecture we will continue to relate the methods of machine learning to
those in scientific computing by looking at the relationship between convolutional
neural networks and partial differential equations. It turns out they are more
than just similar: the two are both stencil computations on spatial data!

## Lecture 15: More Algorithms which Connect Differential Equations and Machine Learning

- [Mixing Differential Equations and Neural Networks for Physics-Informed Learning (Lecture)](https://youtu.be/VHtugbwyNKg)
- [Mixing Differential Equations and Neural Networks for Physics-Informed Learning (Notes)](https://mitmath.github.io/18337/lecture15/diffeq_machine_learning)

Neural ordinary differential equations and physics-informed neural networks are
only the tip of the iceberg. In this lecture we will look into other algorithms
which are utilizing the connection between neural networks and machine learning.
We will generalize to augmented neural ordinary differential equations and
universal differential equations with DiffEqFlux.jl, which now allows for stiff
equations, stochasticity, delays, constraint equations, event handling, etc. to
all take place in a neural differential equation format. Then we will dig into
the methods for solving high dimensional partial differential equations through
transformations to backwards stochastic differential equations (BSDEs), and the
applications to mathematical finance through Black-Scholes along with stochastic
optimal control through Hamilton-Jacobi-Bellman equations. We then look into
alternative training techniques using reservoir computing, such as continuous-time
echo state networks, which alleviate some of the gradient issues associated with
training neural networks on stiff and chaotic dynamical systems. We showcase a
few of the methods which are being used to automatically discover equations in
their symbolic form such as SINDy. To end it, we look into methods for
accelerating differential equation solving through neural surrogate models, and
uncover the true idea of what's going on, along with understanding when these
applications can be used effectively.

## Lecture 16: Probabilistic Programming

- [From Optimization to Probabilistic Programming (Lecture)](https://youtu.be/32rAwtTAGdU)
- [From Optimization to Probabilistic Programming (Notes)](https://mitmath.github.io/18337/lecture16/probabilistic_programming)

All of our previous discussions lived in a deterministic world. Not this one.
Here we turn to a probabilistic view and allow programs to have random variables.
Forward simulation of a random program is seen to be simple through Monte Carlo
sampling. However, parameter estimation is now much more involved, since in this
case we need to estimate not just values but probability distributions. It turns
out that Bayes' rule gives a framework for performing such estimations. We see
that classical parameter estimation falls out as a maximization of probability
with the "simplest" form of distributions, and thus this gives a nice
generalization even to standard parameter estimation and justifies the use of
L2 loss functions and regularization (as a perturbation by a prior). Next, we
turn to estimating the distributions, which we see is possible for small
problems using Metropolis Hastings, but for larger problems we develop
Hamiltonian Monte Carlo. It turns out that Hamiltonian Monte Carlo has strong
ties to both ODEs and differentiable programming: it is defined as solving ODEs
which arise from a Hamiltonian, and derivatives of the likelihood are required,
which is essentially the same idea as derivatives of cost functions! We then
describe an alternative approach: Automatic Differentiation Variational
Inference (ADVI), which once again is using the tools of differentiable
programming to estimate distributions of probabilistic programs.

## Lecture 17: Global Sensitivity Analysis

- [Global Sensitivity Analysis (Lecture)](https://youtu.be/wzTpoINJyBQ)
- [Global Sensitivity Analysis (Notes)](https://mitmath.github.io/18337/lecture17/global_sensitivity)

Our previous analysis of sensitivities was all local. What does it mean to example the sensitivities of a model globally? It turns out the probabilistic programming viewpoint gives us a solid way of describing how we expect values to be changing over larger sets of parameters via the random variables that describe the program's inputs. This means we can decompose the output variance into indices which can be calculated via various quadrature approximations which then give a tractable measurement to "variable x has no effect on the mean solution".

## Lecture 18: Code Profiling and Optimization

- [Code Profiling and Optimization (Lecture)](https://youtu.be/h-xVBD2Pk9o)
- [Code Profiling and Optimization (Notes)](https://mitmath.github.io/18337/lecture18/code_profiling)

How do you put everything together in this course? Let's take a look at a PDE
solver code given in a method of lines form. In this lecture I walk through the
code and demonstrate how to serial optimize it, and showcase the interaction
between variable caching and automatic differentiation.

## Lecture 19: Uncertainty Programming and Generalized Uncertainty Quantification

- [Uncertainty Programming (Lecture)](https://youtu.be/MRTXK2Vc0YE)
- [Uncertainty Programming (Notes)](https://mitmath.github.io/18337/lecture19/uncertainty_programming)

We end the course by taking a look at another mathematical topic to see whether
it can be addressed in a similar manner: uncertainty quantification (UQ). There
are ways which it can be handled similar to automatic differentiation.
Measurements.jl gives a forward-propagation approach, somewhat like
ForwardDiff's dual numbers, through a number type which is representative of
normal distributions and pushes these values through a program. This has many
advantages, since it allows for uncertainty quantification without sampling,
but turns the number types into a value that is heap allocated. Other
approaches are investigated, like interval arithmetic which is rigorous but
limited in scope. But on the entirely other end, a non-general method for ODEs
is shown which utilizes the trajectory structure of the differential equation
solution and doesn't give the blow up that the other methods see. This
showcases that uses higher level information can be helpful in UQ, and less
local approaches may be necessary. We end by showcasing the Koopman operator
as the adjoint of the pushforward of the uncertainty measure, and as an adjoint
method it can give accelerated computations of uncertainty against cost functions.

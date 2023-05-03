+++
title = "Course Overview"
weave = false
+++

# Course Overview

## Syllabus

**Pre-recorded online lectures are available to complement the lecture notes**

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

### Schedule of Topics

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
  - Automated adjoints through reverse-mode automatic differentiation (backpropagation)
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

### Homeworks

- [Homework 1: Parallelized Dynamics. Due October 1st](/homework/01/)
- [Homework 2: Parameter Estimation in Dynamical Systems and Bandwidth Maximization. Due November 5th](/homework/02/)
- [Homework 3: Neural Ordinary Differential Equation Adjoints. Due December 9th](/homework/03/)

### Lecture Summaries and Handouts

Note that lectures are broken down by topic, not by day. Some lectures are more
than 1 class day, others are less.

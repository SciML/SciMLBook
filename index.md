+++
title = "Parallel Computing and Scientific Machine Learning (SciML): Methods and Applications"
descr = "Parallel Computing and Scientific Machine Learning (SciML): Methods and Applications, MIT Course 18.337J/6.338J. Includes physics-informed learning, scientific machine learning, science-guided AI, neural differential equations, and more."
rss = "Parallel Computing and Scientific Machine Learning (SciML): Methods and Applications, MIT Course 18.337J/6.338J. Includes physics-informed learning, scientific machine learning, science-guided AI, neural differential equations, and more."
weave = false
+++

# Parallel Computing and Scientific Machine Learning (SciML): Methods and Applications

**This book is a compilation of lecture notes from the MIT Course 18.337J/6.338J: Parallel Computing and Scientific Machine Learning.
Links to the old notes https://mitmath.github.io/18337 will redirect here**

[This repository]({{ source_url }}) is meant to be a
live document, updating to continuously add the latest details on methods from
the field of scientific machine learning and the latest techniques for
high-performance computing.

\note{
    You can help improve this course!
    \\
    Please [report mistakes](https://github.com/SciML/SciMLBook/issues/new?assignees=&labels=bug&template=bug-report.md&title=Fix+Mistake) you find in the content.
    \\
    Similarly, [suggest improvements](https://github.com/SciML/SciMLBook/issues/new?assignees=&labels=enhancement&template=feature_request.md&title=New+Feature) to the organization and navigation of this site.
}

## Introduction to Parallel Computing and Scientific Machine Learning

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

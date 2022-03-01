# Hints and Tricks for HW2. 
# Note: any format submission (e.g. pdf, notebooks, zip) is fine



** Motivation: In this problem you will learn to do scientific machine learning.  Yay!  
We will generate some artificial data, and find parameters to fit a differential equation.

## Problem 1:

Many people are impressed by differential equation solvers such as the ones that appear
in commonly used packages.   The feeling is they must be so much more
complicated than the Euler methods one sees in the basic classes.
Here we will demonstrate that it is remarkably simple
to build these solvers yourself.  Everybody should do this once in their lifetimes.

All you really need is the data in [the Dormand Prince Wikipedia article ](https://en.wikipedia.org/wiki/Dormand%E2%80%93Prince_method) and the algorithm in the [the Butcher Wikipedia article](https://en.wikipedia.org/wiki/Runge%E2%80%93Kutta_methods#Explicit_Runge.E2.80.93Kutta_methods) .  There is also discussion
about this method in the class notes [Lecture 7](https://book.sciml.ai/notes/07/) search for Higher Order Methods
towards the bottom of the page.

For the data, you can just copy and paste (and maybe use Static Vectors):
```julia
s = 7
a =
b = @SVector[35/384,	0,	500/1113,	125/192,	−2187/6784,	11/84,	0]
c =
```








 


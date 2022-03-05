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
const s = 7
const a = @SVector[
    1/5,
    3/40, 9/40,
    44/45, −56/15, 32/9,
    19372/6561, −25360/2187, 64448/6561, −212/729,
    9017/3168, −355/33, 46732/5247, 49/176, −5103/18656,
    35/384, 0, 500/1113, 125/192, −2187/6784, 11/84,
]
const b = @SVector[35/384, 0, 500/1113, 125/192, −2187/6784, 11/84, 0]
const c = @SVector[0, 1/5, 3/10, 4/5, 8/9, 1, 1]
```
For Part 2 of Problem 1 see [[pdf file]](https://github.com/mitmath/18337/blob/master/hw2/hw2_hint.pdf)
I believe setting the initial conditions to 0 for the 8 new parameters should work just fine.

Part 3: use the data from all the timesteps








 


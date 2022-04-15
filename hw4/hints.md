# Hints for https://book.sciml.ai/homework/03/

This problem has many moving parts, but should be very satisfying once you get this to work properly.  When you reach ``the finish line" (Boston marathon is Monday after all) please
stop and think how this idea can be used and adapted for many other problems.


## Problem 1

* Part 1: The definition of pullback first appears in [CR Lecture 10][10].  In particular the input of the pullback B has the size of the output of f.  The output value of B has the shape of the  inputs to f.  A scalar function f of many variables has a B with input a scalar and an output  the shape of the variables.

A gradient (∇) of a scalar function of a column vector is traditionally a column vector.
The Jacobian of the same scalar function is the corresponding row vector.  More generally
the gradient of a scalar function of any combination of shapes has the same shapes as the input.

vjp refers to vector jacobian product. (Not a great name.
In part because it's not clear, and in part because we are going
to more consistently compute "Jacobian transpose"*vector.
)  Computationally one does not often form Jacobians these days as they are too expensive, but rather vjp's.
A function from R^n to R^m has a Jacobian that is mxn.  
The resulting vjp then is a vector of size m.    (Note Julia's vectors are not rows or columns, they are just one dimensional.)  In one place in Chris' notes he treats it as a row vector, but more consistent and simpler is to think column vector.

* For part 2 see https://book.sciml.ai/notes/10/, specifically equations 36-41 will be relevant to part 2

Note the input of the pullback here is a 2-vector and the output has the same shape  of the five objects, u,W1,W2,b1,b2.


* Part 3: Use https://diffeq.sciml.ai/stable/features/callback_library/#PresetTimeCallback for adding the jumps for $\lambda$

When going forward just use t going from 0 to 1.  No need to think about the .1's just yet.
u(0) is an arbitrary 2-vector for now, but in part 4 it will be [2,0].

As a finale, compare the theoretical value of the known solution with the trained solution.

[10]:https://book.sciml.ai/notes/10/
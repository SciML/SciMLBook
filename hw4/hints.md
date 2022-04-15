# Hints for https://book.sciml.ai/homework/03/

## Problem 1

* Part 1: The definition of pullback first appears in [CR Lecture 10][10].  In particular the input of the pullback B has the size of the output of f.  The output value of B has the shape of the inputs to f.  A scalar function f of many variables has a B with input a scalar and an output the shape of the variables.
* For parts 1+2 see https://book.sciml.ai/notes/10/, specifically equations 36-41 will be relevant to part 2
* Part 3: Use https://diffeq.sciml.ai/stable/features/callback_library/#PresetTimeCallback for adding the jumps for $\lambda$

[10]:https://book.sciml.ai/notes/10/
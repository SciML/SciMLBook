# Hints for https://book.sciml.ai/homework/03/

This problem has many moving parts, but should be very satisfying once you get this to work properly.  When you reach ``the finish line" (Boston marathon is Monday after all) please
stop and think how this idea can be used and adapted for many other problems.


## Problem 1

* Part 1: The definition of pullback first appears in [CR Lecture 10][10].  In particular the input of the pullback B has the size of the output of f.  The output value of B has the shape of the  inputs to f.  A scalar function f of many variables has a B with input a scalar and an output  the shape of the variables.

A gradient (∇) of a scalar function of a column vector is traditionally a column vector.
The Jacobian of the same scalar function is the corresponding row vector.  More generally
the gradient of a scalar function of any combination of shapes has the same shapes as the input.


For problem 1, I would have said that B(1) is the gradient not the transpose, i.e. it is a column vector.
I will be completely consistent.

vjp refers to vector jacobian product. (Not a great name.
In part because it's not clear, and in part because we are going
to more consistently compute "Jacobian transpose"*vector.
)  Computationally one does not often form Jacobians these days as they are too expensive, but rather vjp's.
A function from R^n to R^m has a Jacobian that is mxn.  
The resulting vjp then is a vector of size m.    (Note Julia's vectors are not rows or columns, they are just one dimensional.)  In one place in Chris' notes he treats it as a row vector, but more consistent and simpler is to think column vector.

* For part 2 see https://book.sciml.ai/notes/10/, specifically equations 36-41 will be relevant to part 2

Perhaps define a function with firstline `function pullback(y,u, W₁, W, b₁, b₂)` which can be called
`ū, W̄₁, W̄₂, b̄₁, b̄₂ = pullback(y, u, W₁, W, b₁, b₂)`.

Note the input `y` of the pullback here is a 2-vector and the output has the same shape  of the five objects, u,W1,W2,b1,b2.
 
For the ODE, in Part 3 you'll then need to flatten those into a vector. Perhaps write a function
`p = flatten(u, W₁, W, b₁, b₂)` and `u, W₁, W, b₁, b₂ = unflatten(p)`.

You can do `[vec.(B_NN(y))...]` to flatten and for unflattening, use slicing and perhaps reshaping (e.g. `reshape(µ[1:10], 2, 5)`) for the final µ to use in the gradient descent step to optimize the weights.

Notice that equations (36) to (41) give expressions for `W̄₁, W̄₂, b̄₁, b̄₂` but while `x` serves as the `u` , in those equations it is not considered a parameter and so you will have to figure out the right expression for `ū`.
Hint: `u` just appears as matrix times vector, so perhaps looking at equation (38) might help you see the right answer.

* Part 3: Use https://diffeq.sciml.ai/stable/features/callback_library/#PresetTimeCallback for adding the jumps for $\lambda$.  A nice example of difeqs with jumps and how to run the software
may be found here: https://diffeq.sciml.ai/stable/features/callback_functions/#PresetTimeCallback .

Part 3 consists first of a forward pass to obtain u(t). We might recommend just saving the solution, but you can also just save u(T) and then (re)compute u in reverse with the  λ and μ.  The second requirement of Part 3 is
 a backward pass `tspan=(1.0,0.0)` with the primary goal 
to obtain the final value of μ(0) which is the flattened version of the gradient that we seek.
Notice that μ would be expressed on a blackboard as a simple integral, but as a memory saving trick
(we don't need to store the λ's, we can use them on the fly) we express this as a differential equation.

Following our convention, we might recommend (you can do it either way) thinking of λ as a column vector.
So you are solving λ' = -fᵤᵀλ + (jumps when appropriate) and μ' = -f_pᵀλ .  
(We won't take jumps for μ because our loss function will not depend explicitly on the parameters, i.e., g_p=0
.)

Notice that you will not compute fᵤᵀλ but rather you will use the ū result of the pullback function that you wrote in Part 2 calling for example,    `pullback(λ, u, W₁, W, b₁, b₂)`. Don't worry the
 `W̄₁, W̄₂, b̄₁, b̄₂`   parts will not go to waste as you need them for the f_pᵀλ.


To solve for λ you will need Cᵤ for the initial condition at T=1 and Cᵤ at 0:.1:.9 for the jumps.
The only time you will use Cᵤ for λ is T=1, for all other λ(t) you will be solving the differential
equation λ' = fᵤᵀλ + (jumps when appropriate), where the jumps which will also be Cᵤ.
Anticipating part 4, we can use the explicit values Cᵤ = 2(u(t)-û(t)), where u(t) is at the forward pass and û(t) is the known theoretical solution. (Those of you who are following will note that Cᵤ plays
the role of gᵤᵀ hence it is a column vector so λ' = fᵤᵀλ +gᵤᵀ  at the jumps.)

When going forward just use t going from 0 to 1.  No need to think about the .1's just yet.
u(0) is an arbitrary 2-vector for now, but in part 4 it will be [2,0]. When going backward t
run from 1 to 0 (not just at the discrete time steps of multiples of .1)

* Part 4: you now have the ability to maneuver around p space and train.  You will need to do gradient
descent with the old problem of figuring out what multiple of the gradient to take, i.e. the stepsize.
If you know some fancy methods you may give it a try, but you can also take stepsizes around .1 or .01 and
then if necessary reduce this until convergence seems reasonable.  Plotting the loss function is recommended
for this purpose.

As a finale, compare the theoretical value of the known solution with the trained solution.

[10]:https://book.sciml.ai/notes/10/
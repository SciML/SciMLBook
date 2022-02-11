# Hints and Tricks for HW1. More will be added.

## Problem 1:

**Note: g is a function from Rⁿ to Rⁿ**

* Part 1: Should be straightforward. Think about x converging to the fixed point.
* Part 2: Write your answer in terms of J_n the Jacobian of g at x_n and J_0 the Jacobian of g at x_0 and the Identity.

  **Hint:** What is the Jacobian of the function `x->x-inv(J0)\*g(x)` at x=x_n? That is the matrix you need to write down.

  **Hint:** You may use the fact that if `x_0 - x*` is small, then `J_0 ≈ J_n ≈ J_*`. More precisely, assume that `J_x⁻¹ J_y = I + O(|x - y|)`
  
  **Hint:** If  a matrix is small then the eigenvalues of the matrix are small.

* Part 4: Remember that the eigenvalues of `α * M` are α times the eigenvalues of M, and the problem says the eigenvalues are positive.

## Problem 2:

* Part 2: The prompt to make use of multiple dispatch might be a little bit misleading. You don't need to define multiple methods for `my_quantile` itself, but ideally you should take advantage of how Distributions.jl uses multiple dispatch. Distributions.jl defines methods for the functions `mean`, `pdf` and `cdf` for all `Distribution` objects, so if you implement `my_quantile` right, it should just work for any distribution.

  **Hint:** You can get the CDF and PDF of a `Distribution` object `d` at point `x` with `cdf(d, x)` or `pdf(d, x)` respectively. You don't have to derive the PDF yourself.
  
  **Hint:** Julia allows you to compute default values for (keyword) arguments in the function signature itself, so your function definition could look like:
  ```julia
  function my_quantile(d, y; x₀=mean(d))
      # the actual implementation
  end
  ```

## Problem 3:

* Part 1: Some were a bit confused by the signature given for `calc_attractor!`. It's probably easiest if you write your function something like this:
  ```julia
  function calc_attractor!(out, r, x₀; warmup=400)
      num_attract = length(out)
      # first do warmup then write each step to `out`
  end
  ```
  If you want you can generalize this to arbitrary systems given by some recurrence relation `f`, but this is not required.
  
  **Hint** You Julia, can get uninitialized arrays with the constructor `Array{Float64}(undef, dim1, dim2, ...)`, which will be slightly more efficient than `zeros` if you are overwriting each entry anyways.
  
  **Hint** For Parts 2-5, the function `eachcol` might be useful, which iterates over each column of a matrix as views.
  
  Multithreading and distributed computing in general and in Julia specifically will be further discussed in class.

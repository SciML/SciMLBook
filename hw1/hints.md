# Hints and Tricks for HW1. More will be added.
# Note: any format submission (e.g. pdf, notebooks, zip) is fine

## Problem 1:

**Note: g is a function from Rⁿ to Rⁿ**  
**Note: Understand that the goal of the problem is to understand the stability of these basic iterations as they will become critical
for understanding the use of neural networks and other methods**

**Reminder: Stability of x(n) = g(x(n-1)) is proved by taking the jacobian of g and showing its eigenvalues have absolute value < 1.**

* Part 1: Should be straightforward. Think about x converging to the fixed point.
* Part 2: Write your answer in terms of J_n the Jacobian of g at x_n and J_0 the Jacobian of g at x_0 and the Identity.

  **Hint:** What is the Jacobian of the function `x->x-J_0⁻¹g(x)` at x=x_n? That is the matrix you need to write down.

  **Hint:** You may use the fact that if `x_0 - x*` is small, then `J_0 ≈ J_n ≈ J_*`. More precisely, assume that `J_x⁻¹ J_y = I + O(|x - y|)`
  
  **Hint:** If  a matrix is small then the eigenvalues of the matrix are small.

* Part 4: Remember that the eigenvalues of `α * M` are α times the eigenvalues of M, and the problem says the eigenvalues are positive.

*  Part 4
Better wording: create a new dynamical system that converges to a value x_e such that g(x_e) = 0.

## Problem 2:
* Part 1: If you do part 1 as a Julia program (rather than as text), then Part 1 and Part 2 are the same.  There really is no part 1.

* Part 2: The prompt to make use of multiple dispatch might be a little bit misleading. You don't need to define multiple methods for `my_quantile` itself, but ideally you should take advantage of how Distributions.jl uses multiple dispatch. Distributions.jl defines methods for the functions `mean`, `pdf` and `cdf` for all `Distribution` objects, so if you implement `my_quantile` right, it should just work for any distribution.

  For those of you that are new to Julia, you can find a quick explanation of what multiple dispatch is [here](https://stackoverflow.com/questions/58700879/what-is-multiple-dispatch-and-how-does-one-use-it-in-julia). If you are more curious, you can also check out [this blog post explaining it in more detail](https://opensourc.es/blog/basics-multiple-dispatch/#what_is_dispatch) or [this video](https://www.youtube.com/watch?v=kc9HwsxE1OY) by Stefan explaining why this is actually so useful.

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
  
  **Optional Optimization** In Julia, you can get uninitialized arrays with the constructor `Array{Float64}(undef, dim1, dim2, ...)`, which will be slightly more efficient than `zeros` if you are overwriting each entry anyways.
  
  **Optional Julia Syntax** For Parts 2-5, the function `eachindex` or `eachcol` might be useful, which iterates over each index of an array or each column of a matrix as views.

  If a vector is 1-based there is no difference between `for i = 1:length(vector)`
  and `for i = eachindex(vector)`.  

  * Part 3: (Use `@threads`) to parallelize an embarassingly parallel for loop.

  Note you can not change the number of threads inside of a Julia session so you must start Julia with something like `julia -t 4` or use the vscode setting like you saw in class.  (Code-->Preferences-->Settings-->threads) on a mac it's (Command-Comma)

  * Part 4: We didn't get a chance to talk about `@distributed` in class, but here is  an example.  (This works on distributed memory computers but you can also run it on your shared memory laptop.  By contrast `@threads` asummes shared memory.)

    One can use `@distributed` in the same way as `@threads` (to parallelize a loop)  but it also has the nice property of allowing reductions.  In the following example, we will use `(+)` and `hcat` which are summation and  a horizontal concatenation, meaning package everything up in an array. (Note `sum` is wrong, the reduction should
    be a binary operation.)


    ```julia
    using Distributed
    println(workers())

    if nworkers()==1
      addprocs(5)  # Unlike threads you can addprocs in the middle of a julia session
      println(workers())
    end

    @everywhere function f(i)
        return rand(10)*i
    end   
    
    r = 1:10000

    @distributed (+) for i in r
          f(i)
    end

    @distributed hcat for i in r
          f(i)
    end 



    
    ```


@Simeon,  we need an example of `pmap` in a similar way

@simeon: pmap has a head node which sends the data to the other processors.....
with load balancing???
distributed has each node setting the computation 

@simeon: for computations where there is a ton of data to send around
pmap can be very inefficient, but for this computation i hardly expect
much difference, perhaps slightly different overheads.


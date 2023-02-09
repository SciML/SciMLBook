### A Pluto.jl notebook ###
# v0.19.14

using Markdown
using InteractiveUtils

# ╔═╡ 9c384715-5bf5-4308-94ef-db4f26be45a4
md"_Homework 1, version 1 -- 18.337 -- Spring  2023_"

# ╔═╡ 7679b2c5-a644-4341-a7cc-d1335727aacd
# edit the code below to set your name and kerberos ID (i.e. email without @mit.edu)

student = (name = "Philip the Corgi", kerberos_id = "ptcorgi")

# press the ▶ button in the bottom right of this cell to run your edits
# or use Shift+Enter

# you might need to wait until all other cells in this notebook have completed running.
# scroll down the page to see what's up

# ╔═╡ f8750fa4-8d49-4880-a53e-f40a653c84ea
md"HW is to be submitted on Canvas in the form of a .jl file and .pdf file (use the browser print)"

# ╔═╡ bec48cfd-ac3b-4dae-973f-cf529b3cdc05
md"""
# Homework 1: Getting up and running and  Matrix Calculus

HW1 release date: Thursday, Feb 9, 2023.

**HW1 due date: Thursday, Feb 16, 2023, 11:59pm EST**, _but best completed before Wednesday's lecture if possible_.

First of all, **_welcome to the course!_** We are excited to teach you about parallel computing and scientific machine lerning, using the same tools that we work with ourselves.


Without submitting anything we'd also like you to login and try out Juliahub, which we will use later especially when we use GPUs.  You might also try vscode on your own computer.
"""

# ╔═╡ 0da73ecd-5bda-4098-8f13-354af436d231
md"## (Required) Exercise 0 - _Making a basic function_

Computing $x^2+1$ is easy -- you just multiply $x$ with itself and add 1.

##### Algorithm:

Given: $x$

Output: $x^2+1$

1. Multiply $x$ by $x$ and add 1"

# ╔═╡ 963f24f5-a442-4590-b355-300703b0cf86
function basic_function(x)
	return x*x # this is wrong, write your code here!
end

# ╔═╡ b6f5abbb-1c32-46d0-b92a-2d0c6c806348
let
	result = basic_function(5)
	if !(result isa Number)
		md"""
!!! warning "Not a number"
    `basic_square` did not return a number. Did you forget to write `return`?
		"""
	elseif abs(result - (5*5 + 1)) < 0.01
		md"""
!!! correct
    Well done!
		"""
	else
		md"""
!!! warning "Incorrect"
    Keep working on it!
		"""
	end
end

# ╔═╡ 172bd4bd-5ea9-475f-843d-abb86ffaed34


# ╔═╡ 20ed1521-fb1d-43cd-8c6f-15041fc512ec
if student.kerberos_id === "ptcorgi"
	md"""
!!! danger "Oops!"
    **Before you submit**, remember to fill in your name and kerberos ID at the top of this notebook!
	"""
end

# ╔═╡ ceaf29f7-df04-481e-9836-68298a9f64c7
md"""# Installation
Before being able to run this notebook succesfully locally, you will need to [set up Julia and Pluto.](https://computationalthinking.mit.edu/Spring21/installation/)

One you have Julia and Pluto installed, you can click the button at the top right of this page and follow the instructions to edit this notebook locally and submit.
"""

# ╔═╡ 4ba96121-453d-400e-877a-61db02928ffb
md"""
# Matrix calculus
"""

# ╔═╡ 6996372a-0150-4522-8aa4-3fec36a0dcbb
md"""
For each function $f(x)$, work out the linear transformation $f'(x)$ such that $df = f'(x) dx$.
Check your answers numerically using Julia by computing $f(x+e)-f(x)$ for some random $x$ and (small) $e$, and comparing with $f'(x)e$.
We use lowercase $x$ for vectors and uppercase $X$ for matrices.

For the written part write the answer in the form f'(x)[dx]. 

For the numerical part write a function that works for all $x$ and $e$ and run
on a few random inputs.
"""

# ╔═╡ 6067b7d5-a8d4-4922-a761-210418032da5
md"""
## Question 1

 $f \colon x \in \mathbb{R}^n \longmapsto (x^\top x)^2$. 

$f'(x)[dx]=?$
Note: dx is a column vector.  Be sure your answer makes sense in terms
of row and column vectors.
"""

# ╔═╡ 7b2550d6-422d-4b8b-a86c-7e49314ac6c9


# ╔═╡ f95d162c-0522-4cb1-9251-7659fee4711e
md"""
## Question 2

 $f \colon x \in \mathbb{R}^n \longmapsto \sin.(x)$, meaning the elementwise application of the $\sin$ function to each entry of the vector $x$, whose result is another vector in $\mathbb{R}^n$.
"""

# ╔═╡ a02e8536-0360-4043-90e7-4fb28966393d


# ╔═╡ e5738862-51f5-4dde-81a8-6db7d3638270


# ╔═╡ bc655179-19a3-42c7-ab8b-776d3158a8c6
md"""
## Question 3

 $f \colon X \in \mathbb{R}^{n \times m} \longmapsto \theta^\top X$, where $\theta \in R^n$ is a vector
"""

# ╔═╡ 2721e816-327b-468e-8121-2dec969d2021
md"""
## Question 4

 $f \colon X \in \mathbb{R}^{n \times n} \longmapsto X^{-2}$, where $X$ is non-singular. 
"""

# ╔═╡ 675fd3c3-063e-4b34-a43d-e2486ca514ae


# ╔═╡ 29d955a0-0410-4d8e-89a8-81a63229126c
# Your code goes here

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.0-rc4"
manifest_format = "2.0"
project_hash = "da39a3ee5e6b4b0d3255bfef95601890afd80709"

[deps]
"""

# ╔═╡ Cell order:
# ╠═9c384715-5bf5-4308-94ef-db4f26be45a4
# ╠═7679b2c5-a644-4341-a7cc-d1335727aacd
# ╟─f8750fa4-8d49-4880-a53e-f40a653c84ea
# ╟─bec48cfd-ac3b-4dae-973f-cf529b3cdc05
# ╠═0da73ecd-5bda-4098-8f13-354af436d231
# ╠═963f24f5-a442-4590-b355-300703b0cf86
# ╟─b6f5abbb-1c32-46d0-b92a-2d0c6c806348
# ╠═172bd4bd-5ea9-475f-843d-abb86ffaed34
# ╟─20ed1521-fb1d-43cd-8c6f-15041fc512ec
# ╟─ceaf29f7-df04-481e-9836-68298a9f64c7
# ╟─4ba96121-453d-400e-877a-61db02928ffb
# ╟─6996372a-0150-4522-8aa4-3fec36a0dcbb
# ╟─6067b7d5-a8d4-4922-a761-210418032da5
# ╠═7b2550d6-422d-4b8b-a86c-7e49314ac6c9
# ╟─f95d162c-0522-4cb1-9251-7659fee4711e
# ╠═a02e8536-0360-4043-90e7-4fb28966393d
# ╠═e5738862-51f5-4dde-81a8-6db7d3638270
# ╟─bc655179-19a3-42c7-ab8b-776d3158a8c6
# ╟─2721e816-327b-468e-8121-2dec969d2021
# ╠═675fd3c3-063e-4b34-a43d-e2486ca514ae
# ╠═29d955a0-0410-4d8e-89a8-81a63229126c
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002

### A Pluto.jl notebook ###
# v0.16.0

using Markdown
using InteractiveUtils

# ╔═╡ 670f41d2-882c-11ec-1232-b53f49123cfe
using PlutoUI, BenchmarkTools

# ╔═╡ 5dccaff9-d326-4a71-a54a-7b3288bddecf
using StaticArrays

# ╔═╡ 3f72ae62-29dd-44c9-9571-075e0e87175f
md"""
## Allocations
"""

# ╔═╡ b5d0c163-b718-4954-b50c-37532941ae79
	with_terminal() do
		@btime a = 100;  # This goes on the stack (0 allocations)
# All arrays live on the heap
@btime a = rand(10,10); # This creates one pointer (1 allocation)
@btime a = rand(100,10);  
@btime a = rand(100,100); # why 2 allocations? (wrapper and buffer)
@btime a = rand(1000,100); # why 2 allocations? (wrapper and buffer)
	end

# ╔═╡ 3ae89b96-7b73-4b52-a52d-f2808ed72b39
md"""
  Note:  One KiB = 1024 Bytes
"""

# ╔═╡ 7d03d114-c17e-4581-a4b6-8213ebc907b2
md"""
## Lots of Allocations
"""

# ╔═╡ 640e141a-9e00-4280-9c4e-da6461a753c5
function lots_of_allocations(a)
	    for i=1:size(a,1), j=1:size(a,2)
	        val = [a[i,j]]  # <-- every step this is placed on the heap
	    end
end

# ╔═╡ c9db43b8-b80c-4d98-9994-caf5177a1f02
lots_of_allocations(rand(100,100))

# ╔═╡ 6d2e2671-7063-4c1f-9915-fb767db291b3
a = rand(100,100)

# ╔═╡ 80304bdb-e390-4f00-b4d6-43c1c3ef8237
with_terminal() do 
     @btime $lots_of_allocations(a);
end

# ╔═╡ 24aa362b-5758-4354-9faf-654a48c5ceed
md"""
## No allocations (well it's been preallocated!)

Note the difference in time
"""

# ╔═╡ 6fbda23b-30f0-4e95-936e-71c9a9f286a2
begin
	with_terminal() do
		
	# a = rand(100,100)
    b = rand(100,100)
    c = similar(a)  # this is preallocated

	function add_and_store!(c,a,b)  # function changes it's first argument
      for i=1:100, j=1:100
        c[i,j] = a[i,j]+b[i,j]
      end
	end

	
		@btime $add_and_store!($c,$a,$b)  # dollar sign is really annoying, hope it will go away.  Something to do with benchmarktools and pluto, not needed in repl, jupyter, vscode
	end
end

# ╔═╡ 31062988-22c8-4543-ab50-038edf1e8a98
md"""
## Objects in languages such as Python, R, Java have to go on the heap.
"""

# ╔═╡ 7e240df0-aed4-4d5d-b3ec-a3269bfd3aee
struct Object
	a::Int
	b::Int
end

# ╔═╡ c90543f8-5c73-463e-b796-28755223e7e8
A = Object(10,1)

# ╔═╡ 8b7d204d-2774-4f39-90c0-9abd4b92d970
# analog would  work in python
   A.c = 5

# ╔═╡ 8a7995c0-d616-4381-a16e-081da762b9c9
md"""
Convenient, yes, but now you understand the loss of performance. 
"""

# ╔═╡ a0eca1c3-49c1-4057-b688-25e994cd0a69
md"""
## Example: Static arrays for small vectors
"""

# ╔═╡ 2c14ce3d-9a68-4363-aaee-04ac7a2e5e40
val = SVector{3,Float64}(1.0,2.0,3.0)  # braces are "type parameters"

# ╔═╡ 53057c8c-47d8-4446-8ce1-96ac9189a289
typeof(val)

# ╔═╡ d6d55818-ddc1-44ce-bbad-b8c1f9ba9dbc
typeof( [1.0,2.0,3.0])  # the type doesn't know

# ╔═╡ e7b79d83-4a0a-494d-bfa5-f09d544ce75d
@SVector  [1.0,2.0,3.0]   # "Macro" shorthand for SVector{3,Float64}(1.0,2.0,3.0) 

# ╔═╡ b904916b-c102-4ab7-9357-47639d4f212b
function add_and_store_slow!(c,a,b)  # function changes it's first argument
      for j=1:100, i=1:100
        c[i,j] = [a[i,j]+b[i,j] ][1]   #Artificial I know!
      end
	end

# ╔═╡ bf06883d-fda1-4966-9001-a439d5283230
function add_and_store_fast!(c,a,b)  # function changes it's first argument
        for j=1:100
			 for i=1:100
           c[i,j] = (@SVector [a[i,j]+b[i,j] ])[1]
      end
	  end
	end

# ╔═╡ 9aa390a3-e599-4d8c-90f5-abe591591e49


# ╔═╡ 8f8bc783-3f0b-49e5-8726-778c560f6916
	let

		a = rand(100,100)
		b = rand(100,100)
		c = rand(100,100)
		
	

	

    with_terminal() do
       @btime $add_and_store_slow!($c,$a,$b)
	   @btime $add_and_store_fast!($c,$a,$b)
	end

	end

# ╔═╡ cafae1f5-8f9e-4ff6-a3cb-8b38256d3d5f
md"""
Static Arrays:
    Fast for small arrays, but only have so much space in your stack.  If you try to stuff a 100x100 array on the stack, not only will it be slow, as the stack pushes and pops from the top, but the compiler will have a terribly tough time as well.  It would be like compiling a 10,000 line code.
"""

# ╔═╡ b2e4e674-8b07-4b0a-98cd-ad92544167be
md"""
# Mutation
"""

# ╔═╡ 3fcb879d-fb60-481d-b149-e60de152a56e
md"""
So what to do for fast arrays? Mutation.  You've alreay seen it.  Change an existing allocated array.
"""

# ╔═╡ 7a9618d3-36fe-4145-a2cb-adc55d25bdaa
begin
   X = rand(100,100)
   Y = rand(100,100)
   D = similar(Y)

   function just_plus(A,B)
	     return A+B
   end

	function just_add_and_store!(D,A,B)
		for j=1:100
			for i=1:100
			D[i,j] = A[i,j] +B[i,j]
				end
		end
	end
	
	with_terminal() do
      @btime E=$just_plus($X,$Y)
	  @btime $just_add_and_store!($D,$X,$Y)  
	 
	end
end


# ╔═╡ 975c2dd5-931a-41ee-a227-1dbada1b263e
md"""
## Broadcasting (loop fusion)
"""

# ╔═╡ dd1da75c-e123-46ee-a835-d3ee694381b7
let
	 A =  rand(100,100)
	 B  = rand(100,100)
	 C =  rand(100,100)
	  C = A.*B
end

# ╔═╡ 513262a6-5a49-45fe-96f0-2549571915fc
let
	 A =  rand(100,100)
	 B  = rand(100,100)
	 C =  rand(100,100)
	 D =  similar(C)
	 D .=  A.*B.*C
end

# ╔═╡ 2e7e7cae-c659-43f3-a781-6f6c22eb1f6b
md"""
  think what may be happening
"""

# ╔═╡ 22f9c847-b09c-4052-981a-34f873e370f7



let
	 A =  rand(100,100)
	 B  = rand(100,100)
	 C =  rand(100,100)
	 D =  similar(C)
	tmp = similar(C)
	tmp2 = similar(C)

	for  i = 1:length(A)
	   tmp[i]= A[i] * B[i]
	  tmp2[i] = tmp[i] * C[i]
		D[i] = tmp2[i]
	end

end

# ╔═╡ c32f3f81-40d4-45d2-8ea6-bdcdaacd7afd
let
	 A =  rand(100,100)
	 B  = rand(100,100)
	 C =  rand(100,100)
		 
	 map((a,b)->a*b, map( (a,b)-> a*b, A, B), C)
end

# ╔═╡ 00ad2dd8-76db-48e3-a0ea-6fac1598c92e
let
	 A =  rand(100,100)
	 B  = rand(100,100)
	 C =  rand(100,100)
		 
	 map((a,b,c)->a*b*c, A,B,C) # create one compiled function
end

# ╔═╡ d4c933fb-8b17-47bc-9e14-81f5da7fc1ad
md"""
This sort of issue is more pronounced on GPUs type architectures

Python, R doesn't generate the fast code for fused loops, as it can't know all possible cases without JIT compilation.
"""

# ╔═╡ 08758ca8-4a7f-46af-8a5b-4d4586c66a46
md"""
# Slicing
"""

# ╔═╡ 70d1e7b6-8522-4b5a-a0f0-c4d7905cc8f5
let
	 A = rand(100,100)
	 x = @view A[:,3]  # does not allocate
	 x[3] = 12345
	 A[1:3,1:3]
end

# ╔═╡ b1b0dc0a-2a46-410d-8db5-b7eb473a4cef
md"""
 # Bounds Checking
"""

# ╔═╡ 8fa83e64-d6a8-4e2c-894d-b1151542080c
let
	A = rand(100,100)
	A[10001]
end

# ╔═╡ Cell order:
# ╠═670f41d2-882c-11ec-1232-b53f49123cfe
# ╟─3f72ae62-29dd-44c9-9571-075e0e87175f
# ╠═b5d0c163-b718-4954-b50c-37532941ae79
# ╟─3ae89b96-7b73-4b52-a52d-f2808ed72b39
# ╟─7d03d114-c17e-4581-a4b6-8213ebc907b2
# ╠═640e141a-9e00-4280-9c4e-da6461a753c5
# ╠═c9db43b8-b80c-4d98-9994-caf5177a1f02
# ╠═6d2e2671-7063-4c1f-9915-fb767db291b3
# ╠═80304bdb-e390-4f00-b4d6-43c1c3ef8237
# ╟─24aa362b-5758-4354-9faf-654a48c5ceed
# ╠═6fbda23b-30f0-4e95-936e-71c9a9f286a2
# ╟─31062988-22c8-4543-ab50-038edf1e8a98
# ╠═7e240df0-aed4-4d5d-b3ec-a3269bfd3aee
# ╠═c90543f8-5c73-463e-b796-28755223e7e8
# ╠═8b7d204d-2774-4f39-90c0-9abd4b92d970
# ╠═8a7995c0-d616-4381-a16e-081da762b9c9
# ╟─a0eca1c3-49c1-4057-b688-25e994cd0a69
# ╠═5dccaff9-d326-4a71-a54a-7b3288bddecf
# ╠═2c14ce3d-9a68-4363-aaee-04ac7a2e5e40
# ╠═53057c8c-47d8-4446-8ce1-96ac9189a289
# ╠═d6d55818-ddc1-44ce-bbad-b8c1f9ba9dbc
# ╠═e7b79d83-4a0a-494d-bfa5-f09d544ce75d
# ╠═b904916b-c102-4ab7-9357-47639d4f212b
# ╠═bf06883d-fda1-4966-9001-a439d5283230
# ╠═9aa390a3-e599-4d8c-90f5-abe591591e49
# ╠═8f8bc783-3f0b-49e5-8726-778c560f6916
# ╠═cafae1f5-8f9e-4ff6-a3cb-8b38256d3d5f
# ╟─b2e4e674-8b07-4b0a-98cd-ad92544167be
# ╠═3fcb879d-fb60-481d-b149-e60de152a56e
# ╠═7a9618d3-36fe-4145-a2cb-adc55d25bdaa
# ╠═975c2dd5-931a-41ee-a227-1dbada1b263e
# ╠═dd1da75c-e123-46ee-a835-d3ee694381b7
# ╠═513262a6-5a49-45fe-96f0-2549571915fc
# ╠═2e7e7cae-c659-43f3-a781-6f6c22eb1f6b
# ╠═22f9c847-b09c-4052-981a-34f873e370f7
# ╠═c32f3f81-40d4-45d2-8ea6-bdcdaacd7afd
# ╠═00ad2dd8-76db-48e3-a0ea-6fac1598c92e
# ╠═d4c933fb-8b17-47bc-9e14-81f5da7fc1ad
# ╠═08758ca8-4a7f-46af-8a5b-4d4586c66a46
# ╠═70d1e7b6-8522-4b5a-a0f0-c4d7905cc8f5
# ╠═b1b0dc0a-2a46-410d-8db5-b7eb473a4cef
# ╠═8fa83e64-d6a8-4e2c-894d-b1151542080c

### A Pluto.jl notebook ###
# v0.18.0

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

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
BenchmarkTools = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[compat]
BenchmarkTools = "~1.2.2"
PlutoUI = "~0.7.34"
StaticArrays = "~1.3.4"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.1"
manifest_format = "2.0"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BenchmarkTools]]
deps = ["JSON", "Logging", "Printf", "Profile", "Statistics", "UUIDs"]
git-tree-sha1 = "940001114a0147b6e4d10624276d56d531dd9b49"
uuid = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
version = "1.2.2"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
git-tree-sha1 = "2b078b5a615c6c0396c77810d92ee8c6f470d238"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.3"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "0b5cfbb704034b5b4c1869e36634438a047df065"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.2.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "8979e9802b4ac3d58c503a20f2824ad67f9074dd"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.34"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Profile]]
deps = ["Printf"]
uuid = "9abbd945-dff8-562f-b5e8-e1ebf5ef1b79"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "a635a9333989a094bddc9f940c04c549cd66afcf"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.3.4"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

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
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002

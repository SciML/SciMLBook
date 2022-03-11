### A Pluto.jl notebook ###
# v0.18.0

using Markdown
using InteractiveUtils

# ╔═╡ d5559dba-9fe4-11ec-3744-ebd1408e7dc4
using LegibleLambdas, AbstractTrees, PlutoUI

# ╔═╡ 99b6ab91-a022-449c-988c-0e5c5719c910
begin
	struct Tracked{T} <: Number
		x::T
		name::Symbol
		df
		deps::Vector{Any}
	end
	Tracked{T}(x, name=gensym()) where {T} = Tracked{T}(x, name, nothing, Any[])
	Base.promote_rule(::Type{Tracked{S}}, ::Type{T}) where {S<:Number, T<:Number} = Tracked{promote_type(S, T)}
end

# ╔═╡ 13487e65-5e48-4a37-9bea-f262dd7b6d56
function Base.:+(x::Tracked, y::Tracked)
	Tracked(x.x + y.x, gensym(), @λ(Δ -> (Δ, Δ)), Any[x, y])
end

# ╔═╡ b0cc4665-eb45-48ea-9a33-5acf56d2a283
function Base.:-(x::Tracked, y::Tracked)
	Tracked(x.x - y.x, gensym(), @λ(Δ -> (Δ, -Δ)), Any[x, y])
end

# ╔═╡ 73d638bf-30c1-4694-b3a8-4b29c5e3fa65
function Base.:*(x::Tracked, y::Tracked)
	Tracked(x.x * y.x, gensym(), @λ(Δ -> (Δ * y.x, Δ * x.x)), Any[x, y])
end

# ╔═╡ ac097299-0a31-474c-ab26-a4fb24bb9046
function Base.:^(x::Tracked, n::Int)
	Tracked(x.x^n, gensym(), @λ(Δ -> (Δ * n * x.x^(n-1),)), Any[x,])
end

# ╔═╡ 2141849b-675e-406c-8df4-34b2706507af
function Base.:/(x::Tracked, y::Tracked)
	Tracked(x.x / y.x, gensym(), @λ(Δ -> (Δ / y.x, -Δ / x.x^2)), Any[x, y])
end

# ╔═╡ 7429ffcb-dcee-4090-972e-ffde8393a37a
begin
	AbstractTrees.children(x::Tracked) = x.deps
	function Base.show(io::IO, x::Tracked)
		if x.df === nothing
			print(io, Base.isgensym(x.name) ? x.x : x.name)
		else
			print(io, "Tracked(")
			show(io, x.x)
			print(io, ", ")
			show(io, x.df)
			print(io, ")")
		end
	end
	Base.show(io::IO, ::MIME"text/plain", x::Tracked) = print_tree(io, x)
end

# ╔═╡ 0b5e6560-81fd-4182-bba5-aca702fb3048
x = Tracked{Int}(1, :x)

# ╔═╡ 63720313-9fb2-4bad-be02-d19aca43be17
y = 2x + (x-1)^2

# ╔═╡ 527b1006-a292-44ca-ae5f-dd6961d92c5c
E = :(2x+(x-1)^2)

# ╔═╡ 4d087814-489e-4820-b5b2-09d708da42ef
Dump(E)

# ╔═╡ 99a3507b-ca03-429f-acde-e2d1ebb32054
function grad(f::Tracked)
	d = Dict{Any, Any}(f => 1)
	for x in PreOrderDFS(f)
		x.df === nothing && continue
		for (y, dy) in zip(x.deps, x.df(d[x]))
			y === nothing && continue
			d[y] = get(d, y, 0) + dy
		end
	end
	return d
end

# ╔═╡ d4e9b202-242e-4420-986b-12d2ab57af93
grad(f::Tracked, x::Tracked) = grad(f)[x]

# ╔═╡ fc8aeed7-2806-438a-85f7-c155b0b222e6
grad(y, x)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
AbstractTrees = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
LegibleLambdas = "f1f30506-32fe-5131-bd72-7c197988f9e5"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
AbstractTrees = "~0.3.4"
LegibleLambdas = "~0.3.0"
PlutoUI = "~0.7.37"
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

[[deps.AbstractTrees]]
git-tree-sha1 = "03e0550477d86222521d254b741d470ba17ea0b5"
uuid = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
version = "0.3.4"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

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
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.LegibleLambdas]]
deps = ["MacroTools"]
git-tree-sha1 = "7946db4829eb8de47c399f92c19790f9cc0bbd07"
uuid = "f1f30506-32fe-5131-bd72-7c197988f9e5"
version = "0.3.0"

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

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "3d3e902b31198a27340d0bf00d6ac452866021cf"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.9"

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
git-tree-sha1 = "85b5da0fa43588c75bb1ff986493443f821c70b7"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.2.3"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "bf0a1121af131d9974241ba53f601211e9303a9e"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.37"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

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
# ╠═d5559dba-9fe4-11ec-3744-ebd1408e7dc4
# ╠═99b6ab91-a022-449c-988c-0e5c5719c910
# ╠═13487e65-5e48-4a37-9bea-f262dd7b6d56
# ╠═b0cc4665-eb45-48ea-9a33-5acf56d2a283
# ╠═73d638bf-30c1-4694-b3a8-4b29c5e3fa65
# ╠═2141849b-675e-406c-8df4-34b2706507af
# ╠═ac097299-0a31-474c-ab26-a4fb24bb9046
# ╠═7429ffcb-dcee-4090-972e-ffde8393a37a
# ╠═0b5e6560-81fd-4182-bba5-aca702fb3048
# ╠═63720313-9fb2-4bad-be02-d19aca43be17
# ╠═527b1006-a292-44ca-ae5f-dd6961d92c5c
# ╠═4d087814-489e-4820-b5b2-09d708da42ef
# ╠═99a3507b-ca03-429f-acde-e2d1ebb32054
# ╠═d4e9b202-242e-4420-986b-12d2ab57af93
# ╠═fc8aeed7-2806-438a-85f7-c155b0b222e6
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002

### A Pluto.jl notebook ###
# v0.18.0

using Markdown
using InteractiveUtils

# ╔═╡ d5559dba-9fe4-11ec-3744-ebd1408e7dc4
using LegibleLambdas, AbstractTrees

# ╔═╡ 99b6ab91-a022-449c-988c-0e5c5719c910
begin
	struct Tracked{T} <: Number
		# The numerical result when doing the forward pass
		val::T
		name::Symbol
		# The pullback map for the reverse pass
		df
		# All the other variables this variable directly depends on
		deps::Vector{Tracked}
	end
	Tracked{T}(x, name=gensym()) where {T} = Tracked{T}(x, name, nothing, Tracked[])
	# This tells Julia to convert any number added to a `Tracked` to a `Tracked` first
	Base.promote_rule(::Type{Tracked{S}}, ::Type{T}) where {S<:Number, T<:Number} = Tracked{promote_type(S, T)}
end

# ╔═╡ 13487e65-5e48-4a37-9bea-f262dd7b6d56
# calculate the sum, but also remember the pullback map and input variables for the reverse pass which we'll need to calculate the gradient
# `@λ` is just for the nicer printing, we could have replaced `@λ(Δ -> (Δ, Δ))` with `Δ -> (Δ, Δ)` if we didn't care about that
function Base.:+(x::Tracked, y::Tracked)
	Tracked(x.val + y.val, :+, @λ(Δ -> (Δ, Δ)), Tracked[x, y])
end

# ╔═╡ b0cc4665-eb45-48ea-9a33-5acf56d2a283
function Base.:-(x::Tracked, y::Tracked)
	Tracked(x.val - y.val, :-, @λ(Δ -> (Δ, -Δ)), Tracked[x, y])
end

# ╔═╡ 73d638bf-30c1-4694-b3a8-4b29c5e3fa65
function Base.:*(x::Tracked, y::Tracked)
	Tracked(x.val * y.val, :*, @λ(Δ -> (Δ * y.val, Δ * x.val)), Tracked[x, y])
end

# ╔═╡ ac097299-0a31-474c-ab26-a4fb24bb9046
function Base.:^(x::Tracked, n::Int)
	Tracked(x.val^n, Symbol("^$n"), @λ(Δ -> (Δ * n * x.val^(n-1),)), Tracked[x,])
end

# ╔═╡ 2141849b-675e-406c-8df4-34b2706507af
function Base.:/(x::Tracked, y::Tracked)
	Tracked(x.val / y.val, :/, @λ(Δ -> (Δ / y.val, -Δ * x.val / y.val^2)), Tracked[x, y])
end

# ╔═╡ 7429ffcb-dcee-4090-972e-ffde8393a37a
begin
	# `Tracked` is a tree, we just need to tell AbstractTrees.jl how to get the children for each node
	AbstractTrees.children(x::Tracked) = x.deps
	# All this is just for nicer printing
	function Base.show(io::IO, x::Tracked)
		if x.df === nothing
			print(io, Base.isgensym(x.name) ? x.val : "$(x.name)=$(x.val)")
		else
			print(io, "Tracked(")
			show(io, x.val)
			print(io, ", ")
			print(io, x.name)
			#print(io, ", ")
			#show(io, x.df)
			print(io, ")")
		end
	end
	Base.show(io::IO, ::MIME"text/plain", x::Tracked) = print_tree(io, x)
end

# ╔═╡ 0b5e6560-81fd-4182-bba5-aca702fb3048
begin
   x = Tracked{Int}(3, :x)
   y  = Tracked{Int}(5,:y)
end

# ╔═╡ 2cc054d3-470d-421c-8628-c5c2b0e5e402


# ╔═╡ 81eb8a2d-a3a9-45af-a5a5-b96aefd48712
y.val # The regular result of `2x + (x-1)^2`

# ╔═╡ e52aa672-69a9-419b-a992-e7a3d1364fb6
# PreOrderDFS traverses this tree from the top down
Text.(collect(PreOrderDFS(y*x+x^2)))

# ╔═╡ f0814e23-6f75-4db8-b277-d21d4926f876
y*x+x^2

# ╔═╡ 99a3507b-ca03-429f-acde-e2d1ebb32054
# produces a dict with all the intermediate gradient
function grad(f::Tracked)
	d = Dict{Any, Any}(f => 1)
	for x in PreOrderDFS(f) # recursively traverse all dependents
		x.df === nothing && continue # ignore untracked variables like constants
		dy = x.df(d[x]) # evaluate pullback
		for (yᵢ, dyᵢ) in zip(x.deps, dy)
			# store the gradient in d
			# if we have already stored a gradient for this variable, we need to add them
			d[yᵢ] = get(d, yᵢ, 0) + dyᵢ
		end
	end
	return d
end

# ╔═╡ d4e9b202-242e-4420-986b-12d2ab57af93
grad(f::Tracked, x::Tracked) = grad(f)[x]

# ╔═╡ dc62ff81-dbb8-4416-8fc7-8878e16bdf85
grad(y)

# ╔═╡ fc8aeed7-2806-438a-85f7-c155b0b222e6
#grad(y, x)

# ╔═╡ a34a0941-6e7e-4a40-affa-7941c54a10b9
y

# ╔═╡ 18b1c55d-a6b5-44f6-b0b3-50bdb0aa9d96
w = x*y + x

# ╔═╡ 506d408e-dc2b-4e12-b917-286e3f4079a2
grad(w)

# ╔═╡ e8b19887-d7b6-40e4-b099-a08ddc776e74
cumsum(1:5)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
AbstractTrees = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
LegibleLambdas = "f1f30506-32fe-5131-bd72-7c197988f9e5"

[compat]
AbstractTrees = "~0.3.4"
LegibleLambdas = "~0.3.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.1"
manifest_format = "2.0"

[[deps.AbstractTrees]]
git-tree-sha1 = "03e0550477d86222521d254b741d470ba17ea0b5"
uuid = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
version = "0.3.4"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.LegibleLambdas]]
deps = ["MacroTools"]
git-tree-sha1 = "7946db4829eb8de47c399f92c19790f9cc0bbd07"
uuid = "f1f30506-32fe-5131-bd72-7c197988f9e5"
version = "0.3.0"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "3d3e902b31198a27340d0bf00d6ac452866021cf"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.9"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
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
# ╠═2cc054d3-470d-421c-8628-c5c2b0e5e402
# ╠═81eb8a2d-a3a9-45af-a5a5-b96aefd48712
# ╠═e52aa672-69a9-419b-a992-e7a3d1364fb6
# ╠═f0814e23-6f75-4db8-b277-d21d4926f876
# ╠═99a3507b-ca03-429f-acde-e2d1ebb32054
# ╠═d4e9b202-242e-4420-986b-12d2ab57af93
# ╠═dc62ff81-dbb8-4416-8fc7-8878e16bdf85
# ╠═fc8aeed7-2806-438a-85f7-c155b0b222e6
# ╠═a34a0941-6e7e-4a40-affa-7941c54a10b9
# ╠═18b1c55d-a6b5-44f6-b0b3-50bdb0aa9d96
# ╠═506d408e-dc2b-4e12-b917-286e3f4079a2
# ╠═e8b19887-d7b6-40e4-b099-a08ddc776e74
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002

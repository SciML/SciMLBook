### A Pluto.jl notebook ###
# v0.18.2

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ d5559dba-9fe4-11ec-3744-ebd1408e7dc4
using LegibleLambdas, AbstractTrees, PlutoUI, HypertextLiteral, PlutoTest

# ╔═╡ 20571e1a-9687-4d42-98b3-b3bc0b207b3b
md"## Let's write our own reverse-mode AD!"

# ╔═╡ 5e02b2c0-10cf-4746-840d-7017648f89f8
md"""
We will use Julia's dispatch system for simplicity. This means we create a type `Tracked` for keeping track of our input variables and everything we'll need to calculate the gradient later.
"""

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
	Base.convert(T::Type{Tracked{S}}, x::Tracked) where {S} = T(convert(S, x.val), x.name, x.df, x.deps)
	# This tells Julia to convert any number added to a `Tracked` to a `Tracked` first
	Base.promote_rule(::Type{Tracked{S}}, ::Type{T}) where {S<:Number, T<:Number} = Tracked{promote_type(S, T)}
end

# ╔═╡ 885cd51d-895f-4996-a23b-780498b5b810
md"""
All overloads will do the operation (e.g. sum `x` and `y`), but also remember the pullback map and input variables for the reverse pass.

`@λ` (from the *LegibleLambdas.jl* package) is just for the nicer printing, we could have replaced `@λ(Δ -> (Δ, Δ))` with `Δ -> (Δ, Δ)` if we didn't care about that
"""

# ╔═╡ 13487e65-5e48-4a37-9bea-f262dd7b6d56
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

# ╔═╡ 8ab0f55d-a393-4a8a-a48c-9ced26033f57
function Base.sin(x::Tracked)
	Tracked(sin(x.val), :sin, @λ(Δ -> (Δ * cos(x.val),)), Tracked[x,])
end

# ╔═╡ af586f15-35c0-4c90-92c4-86049c8c0631
function Base.exp(x::Tracked)
	Tracked(exp(x.val), :exp, @λ(Δ -> (Δ * exp(x.val),)), Tracked[x,])
end

# ╔═╡ 4bfc2f7d-a5b0-44c7-8bb6-f1b834c1cc51
md"""
`Tracked` is a tree -- We just need to tell *AbstractTrees.jl* how to get the children for each node and we get tree printing and iteration over all nodes for free.
"""

# ╔═╡ 2188a663-5a85-4ce4-bc8d-20383481e59b
AbstractTrees.children(x::Tracked) = x.deps

# ╔═╡ 00da514b-c6be-4d95-a0de-aed486615f3a
md"""
Let's also overload `show` for nicer output:
"""

# ╔═╡ 7429ffcb-dcee-4090-972e-ffde8393a37a
begin
	# All this is just for nicer printing
	function Base.show(io::IO, x::Tracked)
		if x.df === nothing
			print(io, Base.isgensym(x.name) ? x.val : "$(x.name)=$(x.val)")
		else
			print(io, "(")
			show(io, x.val)
			print(io, ", ")
			print(io, x.name)
			print(io, ")")
		end
	end
	Base.show(io::IO, ::MIME"text/plain", x::Tracked) = print_tree(io, x)
end

# ╔═╡ 727b2de3-1ee7-4f14-897f-46d263fa12ee
md"""
Create some variables we want to eventually differentiate with respect to.
"""

# ╔═╡ 0b5e6560-81fd-4182-bba5-aca702fb3048
begin
   x = Tracked{Int}(2, :x)
   y = Tracked{Int}(7, :y)
end

# ╔═╡ ccafd0b9-95aa-4e58-8afc-26cd3ee61cc9
md"""
Straight away we get the primal result of our calculation:
"""

# ╔═╡ 81eb8a2d-a3a9-45af-a5a5-b96aefd48712
(2x*y + (x-1)^2).val # The result of `2x*y + (x-1)^2`

# ╔═╡ 01eacbd4-ef37-4524-aecc-2ef9a1044cf8
md"""
To also get the gradient, we'll use `PreOrderDFS` to traverse the tree we just created from the top down.
"""

# ╔═╡ f0814e23-6f75-4db8-b277-d21d4926f876
z = (2x*y + (x-1)^2)

# ╔═╡ e52aa672-69a9-419b-a992-e7a3d1364fb6
# `PreOrderDFS` traverses this tree from the top down
Text.(collect(PreOrderDFS(z)))

# ╔═╡ d5565717-239b-41ab-b311-d59b383130ed
md"""
Ok, let's create our function `grad` which will accumulate all intermediate gradients into a dictionary:
"""

# ╔═╡ 99a3507b-ca03-429f-acde-e2d1ebb32054
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

# ╔═╡ 7fcccb65-4a7b-4527-97be-d25f481f6eaf
md"""
We can verify that it does the right thing:
"""

# ╔═╡ 18b1c55d-a6b5-44f6-b0b3-50bdb0aa9d96
w = x*y + x

# ╔═╡ 506d408e-dc2b-4e12-b917-286e3f4079a2
grad(w)

# ╔═╡ a7c8cb6a-6e17-4d8f-8958-fe3527c5b8e7
grad(w, x), grad(w, y)

# ╔═╡ e55dfad2-db50-459f-ab54-fa7637fc3638
md"""
## How can we visualize both the forward and the reverse pass?

We can further visualize each steps we just took. First we do the forwards calculation, where we also build up our tree, then we go down the tree in the opposite direction to accumulate our gradient.
"""

# ╔═╡ d9304d8d-9a34-46f2-908d-42d5cc5f5c5f
👽 = Tracked{Int}(12, :👽)

# ╔═╡ 27b39d7d-fc08-4ccc-aea4-b64f8a4f5726
#ex = :(3y*x + 2(x-1)*x)
# ex = :(x^3 + y + sin(👽))
ex = :(x*exp( (-.5)*(x^2+y^2)))

# ╔═╡ a6c2d3a2-326a-41dd-864d-aa3662466222
x,y

# ╔═╡ 5696b588-21c8-41cf-a28b-0b148a13dfa4
html"<span style='color: red; font-size: 1.5em'>Move me!</span>"

# ╔═╡ bcff2aa8-2387-44c7-a28f-39cd505a7adf
md"""
We can also visualize what Julia does in the forward pass on the code itself:
"""

# ╔═╡ d82adc20-4c8c-4f2c-9839-d03ad7e7f581
begin
	struct EX
		x::Any
		function EX(ex)
			if Meta.isexpr(ex, :call) && ex.args[1] === :+ && length(ex.args) > 3
				new(Expr(:call, :+, Expr(:call, :+, ex.args[2:end-1]...), ex.args[end]))
			else
				new(ex)
			end
		end
	end
	show_tree(ex::Expr) = show_tree(EX(ex))
	function Base.show(io::IO, ex::EX)
		Base.show_unquoted(io, Meta.isexpr(ex.x, :call) ? ex.x.args[1] : ex.x)
		if Meta.isexpr(ex.x, :call) && ex.x.args[1] === :^
			print(io, ex.x.args[3])
		end
	end
	function AbstractTrees.children(ex::EX)
		if Meta.isexpr(ex.x, :call)
			ex.x.args[1] === :^ ? [EX(ex.x.args[2])] : EX.(ex.x.args[2:end])
		else
			EX[]
		end
	end
	Base.:(==)(ex1::EX, ex2::EX) = ex1.x == ex2.x
	Base.hash(ex::EX, i::UInt) = hash(ex.x, i)
end

# ╔═╡ 8110f306-a7bb-43a2-bb36-6182c59b4b2e
begin
	struct TTREE
		x
		d::Dict{Any, Any}
	end
	function Base.show(io::IO, x::TTREE)
		show(io, x.x)
		print(io, " ")
		show(io, MIME("text/html"), get(x.d, x.x, @htl("")))
	end
	AbstractTrees.children(x::TTREE) = (TTREE(i, x.d) for i in children(x.x))
end

# ╔═╡ 1f1b384a-6588-45a5-9dd3-6de3face8bfb
function ad_steps(x::Expr; color_fwd="red", color_bwd="green", font_size=".8em")
	x = EX(x)
	repr(x) = sprint(show, x; context=:compact=>true)
	span_fwd = @htl "<span style='color: $color_fwd; font-size: $font_size'>"
	span_bwd = @htl "<span style='color: $color_bwd; font-size: $font_size'>"

    d1 = Dict(
		let e = eval(i.x)
			i => @htl "&ensp;$(span_fwd)$(repr(e isa Tracked ?  e.val : e))</span>"
		end
		for i in PostOrderDFS(x) if isempty(children(i))
	)
	
	res = accumulate(Iterators.filter(x -> !isempty(children(x)), PostOrderDFS(x)); init=d1) do d,i
		d = copy(d)
		e = eval(i.x)
		d[i] = @htl "&ensp;$(span_fwd)$(repr(e isa Tracked ?  e.val : e))</span>" 
		d
	end
	
	pushfirst!(res, d1)
	
	f = eval(x.x)
	d = Dict{Any, Any}(f => 1)
	let d1 = copy(res[end])
		d1[x] = @htl "$(d1[x])&ensp;$(span_bwd)1</span>"
		push!(res, d1)
	end
	for (x, e) in zip(PreOrderDFS.((f, x))...)
		x.df === nothing && continue
		dy = x.df(d[x])
		for (yᵢ, dyᵢ, e) in zip(x.deps, dy, children(e))
			d1 = copy(res[end])
			if haskey(d, yᵢ)
				d1[e] = @htl "$(get(d1, e, ""))$(span_bwd) + $(repr(dyᵢ))</span>"
			else
				d1[e] = @htl "$(get(d1, e, ""))&ensp;$(span_bwd)$(repr(dyᵢ))</span>"
			end
			push!(res, d1)
			d[yᵢ] = get(d, yᵢ, 0) + dyᵢ
		end
	end
	res
end

# ╔═╡ 5585e9bb-7160-4cbf-b072-eb482edb8771
steps = ad_steps(ex);

# ╔═╡ 419842ed-fc24-420b-84eb-c9f9e575b860
i = @bind i Slider(1:length(steps))

# ╔═╡ 1a154bb7-93a3-4973-8908-788db77ac294
s2 = @htl """
<link rel="stylesheet" href="https://fperucic.github.io/treant-js/Treant.css"/>
<style>
.Treant > .node {
	padding: 5px; border: 2px solid #484848; border-radius: 8px;
	box-sizing: unset;
	min-width: fit-content;
	font-size: 1.6em;
}
.Treant > .node > span {
	vertical-align: middle;
}

.Treant .collapse-switch { width: 100%; height: 100%; border: none; }
.Treant .node.collapsed { background-color: var(--main-bg-color); }
.Treant .node.collapsed .collapse-switch { background: none;}
</style>

<script src="https://fperucic.github.io/treant-js/vendor/jquery.min.js"></script>
<script src="https://fperucic.github.io/treant-js/vendor/jquery.easing.js"></script>
<script src="https://fperucic.github.io/treant-js/vendor/raphael.js"></script>
<script src="https://fperucic.github.io/treant-js/Treant.js"></script>
"""

# ╔═╡ 6b1fb808-e993-4c2b-b81b-6710f8206de7
function to_json(x)
	d = Dict{Symbol, Any}(
		:innerHTML => sprint(AbstractTrees.printnode, x),
		:children => Any[to_json(c) for c in children(x)],
		#:collapsed => !isempty(children(x)),
	)
end

# ╔═╡ 437285d4-ec53-4bb7-9966-fcfb5352e205
function show_tree(x; height=400)
	s2
	id = gensym()
	@htl """
	<div id="$id" style="width:100%; height: $(height)px"> </div>
	<script>
	var simple_chart_config = {
		chart: {
			container: "#$id",

			//animateOnInit: true,

			node: {
				collapsable: true,
			},

			nodeAlign: "BOTTOM",

			connectors: {
				type: "straight",
				style: {
					stroke: getComputedStyle(document.documentElement).getPropertyValue('--cm-editor-text-color')
				}
			},
			animation: {
				nodeAnimation: "easeOutBounce",
				nodeSpeed: 500,
				connectorsAnimation: "bounce",
				connectorsSpeed: 500
			},
		},

		nodeStructure: $(to_json(x))
	};
	var my_chart = new Treant(simple_chart_config);
	</script>
	"""
end

# ╔═╡ bb9bf66f-5ac8-4836-9d33-646a5c6f9015
show_tree(TTREE(EX(ex), steps[i]))

# ╔═╡ f6ce8448-d9ce-4453-9e47-dc6443d50f55
s1 = html"""
<style>
p-frame-viewer {
	display: inline-flex;
	flex-direction: column;
}
p-frames,
p-frame-controls {
	display: inline-flex;
}
p-frame-controls {
	margin-top: 20px;
}
line-like {
	font-size: 30px;
}
"""

# ╔═╡ 9a141034-17cb-4d85-a5a2-4724a38dd269
macro visual_debug(expr)
	s1
	quote
		$(esc(:(PlutoTest.@eval_step_by_step($expr)))) .|> PlutoTest.SlottedDisplay |> PlutoTest.frames |> PlutoTest.with_slotted_css
	end
end

# ╔═╡ 79f71f9d-b491-4a2c-85a4-29ae8da4f312
@visual_debug 3y + 2(x-1)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
AbstractTrees = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
LegibleLambdas = "f1f30506-32fe-5131-bd72-7c197988f9e5"
PlutoTest = "cb4044da-4d16-4ffa-a6a3-8cad7f73ebdc"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
AbstractTrees = "~0.3.4"
HypertextLiteral = "~0.9.3"
LegibleLambdas = "~0.3.0"
PlutoTest = "~0.2.2"
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

[[deps.PlutoTest]]
deps = ["HypertextLiteral", "InteractiveUtils", "Markdown", "Test"]
git-tree-sha1 = "17aa9b81106e661cffa1c4c36c17ee1c50a86eda"
uuid = "cb4044da-4d16-4ffa-a6a3-8cad7f73ebdc"
version = "0.2.2"

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
# ╟─20571e1a-9687-4d42-98b3-b3bc0b207b3b
# ╟─5e02b2c0-10cf-4746-840d-7017648f89f8
# ╠═99b6ab91-a022-449c-988c-0e5c5719c910
# ╟─885cd51d-895f-4996-a23b-780498b5b810
# ╠═13487e65-5e48-4a37-9bea-f262dd7b6d56
# ╠═b0cc4665-eb45-48ea-9a33-5acf56d2a283
# ╠═73d638bf-30c1-4694-b3a8-4b29c5e3fa65
# ╠═2141849b-675e-406c-8df4-34b2706507af
# ╠═ac097299-0a31-474c-ab26-a4fb24bb9046
# ╠═8ab0f55d-a393-4a8a-a48c-9ced26033f57
# ╠═af586f15-35c0-4c90-92c4-86049c8c0631
# ╟─4bfc2f7d-a5b0-44c7-8bb6-f1b834c1cc51
# ╠═2188a663-5a85-4ce4-bc8d-20383481e59b
# ╟─00da514b-c6be-4d95-a0de-aed486615f3a
# ╠═7429ffcb-dcee-4090-972e-ffde8393a37a
# ╟─727b2de3-1ee7-4f14-897f-46d263fa12ee
# ╠═0b5e6560-81fd-4182-bba5-aca702fb3048
# ╟─ccafd0b9-95aa-4e58-8afc-26cd3ee61cc9
# ╠═81eb8a2d-a3a9-45af-a5a5-b96aefd48712
# ╟─01eacbd4-ef37-4524-aecc-2ef9a1044cf8
# ╠═f0814e23-6f75-4db8-b277-d21d4926f876
# ╠═e52aa672-69a9-419b-a992-e7a3d1364fb6
# ╟─d5565717-239b-41ab-b311-d59b383130ed
# ╠═99a3507b-ca03-429f-acde-e2d1ebb32054
# ╠═d4e9b202-242e-4420-986b-12d2ab57af93
# ╟─7fcccb65-4a7b-4527-97be-d25f481f6eaf
# ╠═18b1c55d-a6b5-44f6-b0b3-50bdb0aa9d96
# ╠═506d408e-dc2b-4e12-b917-286e3f4079a2
# ╠═a7c8cb6a-6e17-4d8f-8958-fe3527c5b8e7
# ╟─e55dfad2-db50-459f-ab54-fa7637fc3638
# ╠═d9304d8d-9a34-46f2-908d-42d5cc5f5c5f
# ╠═27b39d7d-fc08-4ccc-aea4-b64f8a4f5726
# ╠═5585e9bb-7160-4cbf-b072-eb482edb8771
# ╠═bb9bf66f-5ac8-4836-9d33-646a5c6f9015
# ╠═a6c2d3a2-326a-41dd-864d-aa3662466222
# ╟─5696b588-21c8-41cf-a28b-0b148a13dfa4
# ╠═419842ed-fc24-420b-84eb-c9f9e575b860
# ╟─bcff2aa8-2387-44c7-a28f-39cd505a7adf
# ╠═79f71f9d-b491-4a2c-85a4-29ae8da4f312
# ╠═1f1b384a-6588-45a5-9dd3-6de3face8bfb
# ╠═d82adc20-4c8c-4f2c-9839-d03ad7e7f581
# ╠═8110f306-a7bb-43a2-bb36-6182c59b4b2e
# ╠═1a154bb7-93a3-4973-8908-788db77ac294
# ╠═6b1fb808-e993-4c2b-b81b-6710f8206de7
# ╠═437285d4-ec53-4bb7-9966-fcfb5352e205
# ╠═f6ce8448-d9ce-4453-9e47-dc6443d50f55
# ╠═9a141034-17cb-4d85-a5a2-4724a38dd269
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002

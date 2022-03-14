using MacroTools, InteractiveUtils, SpecialFunctions

struct Variable
  name::Symbol
  number::Int
end

Symbol(x::Variable) = Symbol(x.name, x.number)

Base.show(io::IO, x::Variable) = print(io, ":(", x.name, x.number, ")")

Base.print(io::IO, x::Variable) = Base.show_unquoted(io, x, 0, -1)
Base.show_unquoted(io::IO, x::Variable, ::Int, ::Int) =
  print(io, x.name, x.number)

struct Wengert
  variable::Symbol
  instructions::Vector{Any}
end

Wengert(; variable = :y) = Wengert(variable, [])

Base.keys(w::Wengert) = (Variable(w.variable, i) for i = 1:length(w.instructions))
Base.lastindex(w::Wengert) = Variable(w.variable, length(w.instructions))

Base.getindex(w::Wengert, v::Variable) = w.instructions[v.number]

function Base.show(io::IO, w::Wengert)
  println(io, "Wengert List")
  for (i, x) in enumerate(w.instructions)
    print(io, Variable(w.variable, i), " = ")
    Base.println(io, x)
  end
end

Base.push!(w::Wengert, x) = x

function Base.push!(w::Wengert, x::Expr)
  isexpr(x, :block) && return pushblock!(w, x)
  x = Expr(x.head, map(x -> x isa Expr ? push!(w, x) : x, x.args)...)
  push!(w.instructions, x)
  return lastindex(w)
end

function pushblock!(w::Wengert, x)
  bs = Dict()
  rename(ex) = Expr(ex.head, map(x -> get(bs, x, x), ex.args)...)
  for arg in MacroTools.striplines(x).args
    if @capture(arg, x_ = y_)
      bs[x] = push!(w, rename(y))
    else
      push!(w, rename(arg))
    end
  end
  return Variable(w.variable, length(w.instructions))
end

function Wengert(ex; variable = :y)
  w = Wengert(variable = variable)
  push!(w, ex)
  return w
end

function Expr(w::Wengert)
  cs = Dict()
  for x in w.instructions
    x isa Expr || continue
    for v in x.args
      v isa Variable || continue
      cs[v] = get(cs, v, 0) + 1
    end
  end
  bs = Dict()
  rename(ex::Expr) = Expr(ex.head, map(x -> get(bs, x, x), ex.args)...)
  rename(x) = x
  #ex = :(;)
  ex = Expr(:block)
  for v in keys(w)
    if get(cs, v, 0) > 1
      push!(ex.args, :($(Symbol(v)) = $(rename(w[v]))))
      bs[v] = Symbol(v)
    else
      bs[v] = rename(w[v])
    end
  end
  push!(ex.args, rename(bs[lastindex(w)]))
  return unblock(ex)
end

addm(a, b) = a == 0 ? b : b == 0 ? a : :($a + $b)
mulm(a, b) = 0 in (a, b) ? 0 : a == 1 ? b : b == 1 ? a : :($a * $b)
mulm(a, b, c...) = mulm(mulm(a, b), c...)

function derive(w::Wengert, x; out = w)
  ds = Dict()
  ds[x] = 1
  d(x) = get(ds, x, 0)
  for v in keys(w)
    ex = w[v]
    Δ = @capture(ex, a_ + b_) ? addm(d(a), d(b)) :
        @capture(ex, a_ * b_) ? addm(mulm(a, d(b)), mulm(b, d(a))) :
        @capture(ex, a_^n_Number) ? mulm(d(a),n,:($a^$(n-1))) :
        @capture(ex, a_ / b_) ? :($(mulm(b, d(a))) - $(mulm(a, d(b))) / $b^2) :
        @capture(ex, sin(a_)) ? mulm(:(cos($a)), d(a)) :
        @capture(ex, cos(a_)) ? mulm(:(-sin($a)), d(a)) :
        @capture(ex, exp(a_)) ? mulm(v, d(a)) :
        @capture(ex, log(a_)) ? mulm(:(1/$a), d(a)) :
        error("$ex is not differentiable")
    ds[v] = push!(out, Δ)
  end
  return out
end

function derive_r(w::Wengert, x)
  ds = Dict()
  d(x) = get(ds, x, 0)
  d(x, Δ) = ds[x] = haskey(ds, x) ? addm(ds[x],Δ) : Δ
  d(lastindex(w), 1)
  for v in reverse(collect(keys(w)))
    ex = w[v]
    Δ = d(v)
    if @capture(ex, a_ + b_)
      d(a, Δ)
      d(b, Δ)
    elseif @capture(ex, a_ * b_)
      d(a, push!(w, mulm(Δ, b)))
      d(b, push!(w, mulm(Δ, a)))
    elseif @capture(ex, a_^n_Number)
      d(a, mulm(Δ, n, :($a^$(n-1))))
    elseif @capture(ex, a_ / b_)
      d(a, push!(w, mulm(Δ, b)))
      d(b, push!(w, :(-$(mulm(Δ, a))/$b^2)))
    else
      error("$ex is not differentiable")
    end
  end
  push!(w, d(x))
  return w
end


1+1

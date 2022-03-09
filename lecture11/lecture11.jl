y = :(x^2 + 1)
typeof(y)
dump(y)
x = 10
eval(y)

function derive(ex, x)
    ex == x ? 1 :
    ex isa Union{Number,Symbol} ? 0 :
    error("$ex is not differentiable")
  end

using MacroTools
@capture(y, a_ + b_)
a,b

function derive(ex, x)
    ex == x ? 1 :
    ex isa Union{Number,Symbol} ? 0 :
    @capture(ex, a_ + b_) ? :($(derive(a, x)) + $(derive(b, x))) :
    error("$ex is not differentiable")
  end

  function derive(ex, x)
    ex == x ? 1 :
    ex isa Union{Number,Symbol} ? 0 :
    @capture(ex, a_ + b_) ? :($(derive(a, x)) + $(derive(b, x))) :
    @capture(ex, a_ * b_) ? :($a * $(derive(b, x)) + $b * $(derive(a, x))) :
    @capture(ex, a_^n_Number) ? :($(derive(a, x)) * ($n * $a^$(n-1))) :
    @capture(ex, a_ / b_) ? :($b * $(derive(a, x)) - $a * $(derive(b, x)) / $b^2) :
    error("$ex is not differentiable")
  end

  y = :(3x^2 + (2x + 1))
dy = derive(y, :x)

addm(a, b) = a == 0 ? b : b == 0 ? a : :($a + $b)
mulm(a, b) = 0 in (a, b) ? 0 : a == 1 ? b : b == 1 ? a : :($a * $b)
mulm(a, b, c...) = mulm(mulm(a, b), c...)

function derive(ex, x)
    ex == x ? 1 :
    ex isa Union{Number,Symbol} ? 0 :
    @capture(ex, a_ + b_) ? addm(derive(a, x), derive(b, x)) :
    @capture(ex, a_ * b_) ? addm(mulm(a, derive(b, x)), mulm(b, derive(a, x))) :
    @capture(ex, a_^n_Number) ? mulm(derive(a, x),n,:($a^$(n-1))) :
    @capture(ex, a_ / b_) ? :($(mulm(b, derive(a, x))) - $(mulm(a, derive(b, x))) / $b^2) :
    error("$ex is not differentiable")
  end

  y = :(3x^2 + (2x + 1))
dy = derive(y, :x)

printstructure(x, _, _) = x

function printstructure(ex::Expr, cache = IdDict(), n = Ref(0))
    haskey(cache, ex) && return cache[ex]
    args = map(x -> printstructure(x, cache, n), ex.args)
    cache[ex] = sym = Symbol(:y, n[] += 1)
    println(:($sym = $(Expr(ex.head, args...))))
    return sym
  end

  printstructure(y2);

:(x / (1 + x^2)) |> printstructure;

derive(:(x / (1 + x^2)), :x) |> printstructure;

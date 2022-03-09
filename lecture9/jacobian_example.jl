using Symbolics

struct MultiDual
    val
    derivs
end

import Base: +, *

function +(f::MultiDual, g::MultiDual) 
    return MultiDual(f.val + g.val, f.derivs + g.derivs)
end

function *(f::MultiDual, g::MultiDual)
    return MultiDual(f.val * g.val, f.val .* g.derivs .+ g.val .* f.derivs)
end

f(x) = [x[1]*x[1]+x[2]+x[3],
        x[2]*x[3],
        x[1] ]

@variables x₁,x₂,x₃
x = [x₁,x₂,x₃]

v =f([MultiDual(x₁,[1,0,0]),
  MultiDual(x₂,[0,1,0]),
  MultiDual(x₃,[0,0,1])]
)

display(   [x.val for x∈v ] )
display(  Matrix(hcat([x.derivs for x∈v]...)') )
@variables a,b,c
g(x) = x[2]*x[2] * x[3] + x[1]
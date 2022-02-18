using Distributed
println(workers())

if nworkers()==1
   addprocs(5)
   println(workers())
end

@everywhere function f(i)
    return rand(10)*i
end



@distributed (+) for i in r
          f(i)
    end

r = 1:10000
@distributed hcat for i in r
      f(i)
end 

for i=1:10 display(rand(105,5)) end
using QuadGK

function summ(x)
    return x^2 + 2x    
end

@time quadgk(x -> summ(x), 0, 10)

using SymPy

x = symbols("x")

y =  x^4 + 5x + 4

s = solve(y, x)

s[2]

using oneAPI 

oneAPI.devices()

oneAPI.device()

include("module test.jl")
using .test
test1
test1()

for x in 1:10, y in 1:10
    println(x, y)
end


mutable struct person
    name::String
    age::Int

    function person()
        new("John", 20)
        
    end
end

p = person()

include("module test.jl")

using .geometry 
p = Point(1, 2)
c = circle(p, 3)
area(c)

mutable struct tst 
    const x 
    y 

end

t = tst(1, 2)
t.y = 3

using BenchmarkTools

@benchmark begin
    sum(x -> x^2 + 2x, 1:1000)
end

a = Vector{Int}(undef, 1000)

a[5] = 345

function f(x)
    return x^4 + 5x^3 + 3x^2 + 2x + 1
end

@show f(2)

@benchmark begin
    f(2)
end
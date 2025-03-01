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

# Define a meshgrid function using list comprehensions
function meshgrid(x::AbstractVector, y::AbstractVector)
    X = [xi for yi in y, xi in x]
    Y = [yi for yi in y, xi in x]
    return X, Y
end

# Example usage:
x = LinRange(0, 1, 100)  # e.g., 5 points from 0 to 1
y = LinRange(0, 1, 100)  # e.g., 3 points from 0 to 1

X, Y = meshgrid(x, y)

println("X grid:")
println(X)
println("\nY grid:")
println(Y)

f = X^2 + Y^2

using Plots

plot(X, Y, f, st = :surface)

using SymPy, Unitful, Observables

@syms x y 

v = 5*x*u"m/s"

e = 5u"c"

v/e

v = Observable(5*x*u"m/s")

e = 2*v[]

v[] = 10*y*u"m/s"

e
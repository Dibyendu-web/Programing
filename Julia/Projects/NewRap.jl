using SymPy

@syms x 

function f(x)
    return x^2
end

df = diff(f(x), x)


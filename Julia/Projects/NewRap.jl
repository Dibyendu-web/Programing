using SymPy

@syms x

function f(a)
    return a^2
end

df = SymPy.diff(f(x), x)

println(df)


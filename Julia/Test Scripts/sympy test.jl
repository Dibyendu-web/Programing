using SymPy, Plots

@syms x y

g = x^2 + y^2
g1 = lambdify(g, x, y)

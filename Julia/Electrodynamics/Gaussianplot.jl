using Plots, LaTeXStrings

gr()

function gauss(x, x0=0, σ=1)  
    return exp(-((x - x0)^2) / (2 * σ^2))
    
end

@time begin
    plot(x -> gauss(x, 0.3, 0.2), -1, 1, title="Gaussian Function", xlabel=L"x", ylabel=L"f(x)",label = L"f(x) = e^{-\frac{(x - x_0)^2}{2 \sigma^2}}", legend = :topleft)
    plot!(x -> -gauss(x, -0.3, 0.3), -1, 1, title="Gaussian Function", xlabel=L"x", ylabel=L"f(x)", label = L"f(x) = -e^{-\frac{(x - x_0)^2}{2 \sigma^2}}")
end
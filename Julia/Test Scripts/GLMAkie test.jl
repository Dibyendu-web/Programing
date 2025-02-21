using GLMakie

l = Observable(zeros(10))

lis = on(l) do k 
    println(k)
end


fig = Figure(size = (3840, 2160))


ax = fig[1, 1] = Axis(fig,
     aspect = 1,

    title = "Test", titlesize = 20,
    xlabel = "X", xticksize = 5, xgridwidth = 2,
    ylabel = "Y", yticksize = 5, ygridwidth = 2,
)

xlims!(ax, -10, 10), ylims!(ax, -10, 10)
vlines!(ax, [0], color = :black)
hlines!(ax, [0], color = :black)

l[] = ones(10)
x = 1:10
lines!(ax, x, l)


fig


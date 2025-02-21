using PyCall, GLMakie, LaTeXStrings

eyes = pyimport("eyes17.eyes")

global m = eyes.open()

if !(m.connected) 
    println("Waiting for connection...")
    for i in 1:10
        sleep(1)
        println("Attempt $i")
        global m = eyes.open()
        if m.connected
            break
        end
    end
    if !(m.connected)
        error("Connection failed")
    end
end

fig = Figure(size = (3840, 2160))

ax = fig[1, 1] = Axis(fig,
    aspect = 1, backgroundcolor = :black,

    title = L"X-Y\;Oscilloscope", titlesize = 30,
    xlabel = L"X",xgridwidth = 0.5, xgridcolor = :white,
    ylabel = L"Y",ygridwidth = 0.5, ygridcolor = :white
)

xlims!(ax, -16, 16), ylims!(ax, -16, 16)
vlines!(ax, [0], color = :white, linewidth = 0.5)
hlines!(ax, [0], color = :white, linewidth = 0.5)


fig[2, 1] = buttongrid = GridLayout(tellwidth = false)

button = buttongrid[1,1] = Button(fig, label = "Stop", height= 60, width= 250)# Place button in the layout


samples = 5000
x = Observable(zeros(samples))
y = Observable(zeros(samples))
lines!(ax, x, y, label=L"x-y")


function collect()
    tx, xc, ty, yc = m.capture2(samples, 1)
    return xc, yc
end

function update()
    xn, yn = collect()
    x[] = xn; notify(x)
    y[] = yn; notify(y)
    
end

running = Observable(true)

function stop()
    running[] = false
end

on(button.clicks) do _
    stop()
    println("Oscilloscope stopped.")
end

@async while running[]
    update()
    sleep(0.001)
end


fig


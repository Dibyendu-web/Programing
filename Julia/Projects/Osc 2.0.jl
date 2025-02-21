using PyCall, GLMakie, LaTeXStrings, Base.Threads

# Import Eyes17
eyes = pyimport("eyes17.eyes")
global m = eyes.open()

# Connection Handling
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

# Create Figure
fig = Figure(size = (1200, 800))  # Adjusted size for performance
ax = fig[1, 1] = Axis(fig,
    aspect = 1, backgroundcolor = :black,
    title = L"X-Y\;Plot", titlesize = 20,
    xlabel = L"X", xgridwidth = 0.5, xgridcolor = :white,
    ylabel = L"Y", ygridwidth = 0.5, ygridcolor = :white
)

xlims!(ax, -16, 16)
ylims!(ax, -16, 16)
vlines!(ax, [0], color = :white, linewidth = 0.5)
hlines!(ax, [0], color = :white, linewidth = 0.5)

# Create Button in Layout
fig[2, 1] = buttongrid = GridLayout(tellwidth = false)
button = buttongrid[1, 1] = Button(fig, label="Stop", height=60, width=250)

# Observable Data Storage
samples = 5000
x = Observable(zeros(samples))
y = Observable(zeros(samples))
lines!(ax, x, y, label=L"x-y", color=:cyan)

# Data Queue (Prevents Data Loss)
data_queue = Channel{Tuple{Vector{Float64}, Vector{Float64}}}(10)

# Function to Collect Data
function collect()
    tx, xc, ty, yc = m.capture2(samples, 1)
    put!(data_queue, (xc, yc))  # Store new data in the queue
end

# Background Data Collection (Separate Thread)
Threads.@spawn while true
    collect()
end

# Flag to Stop the Loop
running = Observable(true)

# Function to Stop the Oscilloscope
function stop()
    running[] = false
    println("Oscilloscope stopped.")
end

# Stop Button Callback
on(button.clicks) do _
    stop()
end

# Real-time Update Loop
@async while running[] && isopen(fig.scene)  # Only run if the figure is open
    if isready(data_queue)
        xn, yn = take!(data_queue)  # Get latest data
        x[] = xn; notify(x)  # Update plot
        y[] = yn; notify(y)
    end
    sleep(0.01)  # Lower CPU usage while still updating smoothly
end

fig

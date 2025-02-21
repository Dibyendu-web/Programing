using PyCall, Plots

eyes = pyimport("eyes17.eyes")

m = eyes.open()

begin
    t, v, tt, vv = m.capture2(1000, 2)
    plot(v, vv, label="xy")
    xlims!(-10, 10)
    ylims!(-10, 10)
end

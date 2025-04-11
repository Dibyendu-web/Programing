using ACME, Plots

cir = @circuit begin
    v = voltagesource(5)
    r = resistor(1000)
    c = capacitor(100e-6)
    out = voltageprobe()
    v[+] == r[1]
    r[2] == c[1]
    c[2] == gnd
    v[-] == gnd
    out[+] == c[1]
    out[-] == gnd
end

begin
    model = DiscreteModel(cir, 1e-3)
    y = run!(model, zeros(0,500))
    plot(y')
end;



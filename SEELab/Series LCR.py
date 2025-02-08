import eyes17.eyes
import numpy as np
import matplotlib.pyplot as plt
import time as t

l = float(input("Enter the Inductor value in H: "))
c = float(input("Enter the Capacitor value in F: "))
r = float(input("Enter the Resistor value in Ohm: "))

def resfreq(l,c):
    return 1/(2*np.pi*np.sqrt(l*c))

def rescurve(l,c,r):

    f = resfreq(l,c)
    print("The resonant frequency is: %f Hz" %f)

    f1, f2 = 100, 5000

    if f<f1 or f>f2:
        return

    frange = np.linspace(f1, f2, 100)

    m = eyes17.eyes.open()

    v = []
    for i in frange:
        m.set_sine(i)
        v.append(np.max(m.capture1("A1", 10000, 0.1)[1]))
        print("Applying frequency: %i Hz" %i)

    plt.plot(frange, v)
    plt.show()

rescurve(l,c,r)


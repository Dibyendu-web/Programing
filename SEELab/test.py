import eyes17.eyes as e
import eyes17.SENSORS.MPU6050 as m
import eyes17.SENSORS.QMC5883L as q

p = e.open()

"""A = m.connect(p.I2C)

#a = p.capture_i2c(A.ADDRESS,0x43,6,1,1000)
m.MPU6050.getAccel(A)
m.MPU6050.getGyro(A)
m.MPU6050.getTemp(A)"""

B = q.connect(p.I2C)

q.QMC5883L.getRaw(B)
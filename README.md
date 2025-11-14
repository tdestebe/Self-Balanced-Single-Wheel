# Self Balanced Single Wheel Simulations
This project aims to simulate into openModelica a one axis self stabilizing device witch consist only three components:
* Arduino nano, 
* Nidec H24 brushless motor, 
* MPU6050 3-axis accelerometer and gyroscope.

In the physical model, a PID controller continuously calculates an error value as the difference between a desired set-point and a measured process variable and applies a correction based on proportional, integral, and derivative terms.
In our case, the MPU6050 sensor is replaced by an AbsoluteAngles (Measure absolute angles between frame connector and the world frame) that collects data of the position (more precisely the angle) of the device, and sends that data to the dynamical implementation which performs calculations, like in the Arduino, and sends the result to the electric motor (Modelica DC_PermanentMagnet component), which with its movement tends to hold the device in the desired position. 
As a limitation of the current implementation, this loop is not performed quickly enough so that the device would be stable in a vertical position.However, the device doesn't fall and stays around the vertical position.




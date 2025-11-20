# Self Balanced Single Wheel Simulations
This project aims to simulate into openModelica a one axis self stabilizing device witch consist only three components:
* Arduino nano, 
* Nidec H24 brushless motor, 
* MPU6050 3-axis accelerometer and gyroscope.

In the physical model, a PID controller continuously calculates an error value as the difference between a desired set-point and a measured process variable and applies a correction based on proportional, integral, and derivative terms.
In our case, the MPU6050 sensor is replaced by an AbsoluteAngles (Measure absolute angles between frame connector and the world frame) that collects data of the position (more precisely the angle) of the device, and sends that data to the dynamical implementation which performs calculations, like in the Arduino, and sends the result to the electric motor (Modelica DC_PermanentMagnet component), which with its movement tends to hold the device in the desired position. 

## Component characteristics
### PID parameters
PID controller with limited output, anti-windup compensation, setpoint weighting and optional feed-forward.
|Parameter name |Value|Description                      |
|---------------|-----|---------------------------------|
|k              |3    |Gain of controller               |
|Ti             |0.5  |Time constant of Integrator block|
|Td             |0.03 |Time constant of Derivative block|
|yMax           |12   |Upper limit of output            |
|withFeedForward|true |Use feed-forward input?          |
|kFF            |0.01 |Gain of feed-forward input       |

### Motor parameters
Permanent magnet DC machine.
|Parameter name |Value|Description                                          |
|---------------|-------|---------------------------------------------------|
|Jr             |0.00014|Rotor's moment of inertia                          |
|VaNominal      |12     |Nominal armature voltage                           |
|IaNominal      |0.08   |Nominal armature current (>0..Motor, <0..Generator)|
|wNominal       |3000   |Nominal speed                                      |

## Simulation results
CAD Model:
<img width="1936" height="1152" alt="thumbnail" src="https://github.com/user-attachments/assets/8101cd32-f389-488b-9fec-0e81bf05d595" />

### free-fall simulation

[![Watch the video](https://github.com/tdestebe/Self-Balanced-Single-Wheel/blob/c7efdbdb9b2b29d7fffca7758ad53dfc34a5959a/videos/thumbnail.png)](https://github.com/tdestebe/Self-Balanced-Single-Wheel/blob/c7efdbdb9b2b29d7fffca7758ad53dfc34a5959a/videos/singleWheelSelfFreeFall.mp4)

### self balanced simulation

[![Watch the video](https://github.com/tdestebe/Self-Balanced-Single-Wheel/blob/c7efdbdb9b2b29d7fffca7758ad53dfc34a5959a/videos/thumbnail.png)](https://github.com/tdestebe/Self-Balanced-Single-Wheel/blob/c7efdbdb9b2b29d7fffca7758ad53dfc34a5959a/videos/singleWheelSelfBalancedSimulation.mp4)


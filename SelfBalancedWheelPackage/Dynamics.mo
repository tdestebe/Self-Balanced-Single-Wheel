within SelfBalancedWheelPackage;

model Dynamics
  Modelica.Mechanics.Rotational.Interfaces.Flange_b outputSpeed annotation(
    Placement(transformation(origin = {104, -54}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {96, 20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_PermanentMagnet dcpm(TaOperational = 293.15, Jr = 0.0014, VaNominal = 24, wNominal = 617.8465552059927, IaNominal = 0.42) annotation(
    Placement(transformation(origin = {20, -12}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor1 annotation(
    Placement(transformation(origin = {14, -54}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(transformation(origin = {-38, 12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage annotation(
    Placement(transformation(origin = {2, 58}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor annotation(
    Placement(transformation(origin = {26, 34}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput inputBodyAngle annotation(
    Placement(transformation(origin = {100, -80}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {104, -46}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation(
    Placement(transformation(origin = {0, 38}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Gain gain(k = -0.5)  annotation(
    Placement(transformation(origin = {-34, -80}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Blocks.Math.Sign sign1 annotation(
    Placement(transformation(origin = {30, -80}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
equation
  connect(speedSensor1.flange, dcpm.flange) annotation(
    Line(points = {{24, -54}, {33, -54}, {33, -12}, {30, -12}}));
  connect(ground.p, dcpm.pin_an) annotation(
    Line(points = {{-28, 12}, {-28, -2}, {14, -2}}, color = {0, 0, 255}));
  connect(currentSensor.p, signalVoltage.n) annotation(
    Line(points = {{26, 44}, {26, 59}, {12, 59}, {12, 58}}, color = {0, 0, 255}));
  connect(currentSensor.n, dcpm.pin_ap) annotation(
    Line(points = {{26, 24}, {26, -2}}, color = {0, 0, 255}));
  connect(signalVoltage.p, ground.p) annotation(
    Line(points = {{-8, 58}, {-28, 58}, {-28, 12}}, color = {0, 0, 255}));
  connect(dcpm.flange, outputSpeed) annotation(
    Line(points = {{30, -12}, {72, -12}, {72, -54}, {104, -54}}));
  connect(voltageSensor.p, signalVoltage.p) annotation(
    Line(points = {{-10, 38}, {-8, 38}, {-8, 58}}, color = {0, 0, 255}));
  connect(voltageSensor.n, signalVoltage.n) annotation(
    Line(points = {{10, 38}, {12, 38}, {12, 58}}, color = {0, 0, 255}));
  connect(gain.y, signalVoltage.v) annotation(
    Line(points = {{-44, -80}, {-60, -80}, {-60, 88}, {2, 88}, {2, 70}}, color = {0, 0, 127}));
  connect(sign1.u, inputBodyAngle) annotation(
    Line(points = {{42, -80}, {100, -80}}, color = {0, 0, 127}));
  connect(sign1.y, gain.u) annotation(
    Line(points = {{19, -80}, {-22, -80}}, color = {0, 0, 127}));
end Dynamics;
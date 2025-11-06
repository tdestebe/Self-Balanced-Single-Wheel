within SelfBalancedWheelPackage;

model Dynamics
  Modelica.Mechanics.Rotational.Interfaces.Flange_b outputSpeed annotation(
    Placement(transformation(origin = {104, 20}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {96, 20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_PermanentMagnet dcpm(Jr = dcpmData.Jr, TaOperational = 293.15, phiMechanical(fixed = true), wMechanical(fixed = true), ia(fixed = true), VaNominal = dcpmData.VaNominal, IaNominal = dcpmData.IaNominal, wNominal = dcpmData.wNominal, TaNominal = dcpmData.TaNominal) annotation(
    Placement(transformation(origin = {14, -12}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J = JLoad) annotation(
    Placement(transformation(origin = {56, -12}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque loadTorque(tau_nominal = -TLoad, TorqueDirection = false, w_nominal = wLoad) annotation(
    Placement(transformation(origin = {86, -12}, extent = {{10, -10}, {-10, 10}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor1 annotation(
    Placement(transformation(origin = {14, -54}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(transformation(origin = {-44, 12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  parameter Modelica.Electrical.Machines.Utilities.ParameterRecords.DcPermanentMagnetData dcpmData(wNominal(displayUnit = "rad/s") = 10)  annotation(
    Placement(transformation(origin = {-64, -76}, extent = {{-10, -10}, {10, 10}})));
  parameter Modelica.Units.SI.Torque TLoad = ViNominal*dcpmData.IaNominal/dcpmData.wNominal "Nominal load torque";
  parameter Modelica.Units.SI.AngularVelocity wLoad = dcpmData.wNominal "Nominal load torque";
  parameter Modelica.Units.SI.Inertia JLoad = dcpmData.Jr "Load's moment of inertia";
  parameter Modelica.Units.SI.Resistance Ra = Modelica.Electrical.Machines.Thermal.convertResistance(dcpmData.Ra, dcpmData.TaRef, dcpmData.alpha20a, dcpmData.TaNominal) "Warm armature resistance";
  parameter Modelica.Units.SI.Voltage ViNominal = dcpmData.VaNominal - Ra*dcpmData.IaNominal "Nominal induced voltage";
  parameter Modelica.Units.SI.Time Ta = dcpmData.La/Ra "Armature time constant";
  parameter Modelica.Units.SI.Time Ts = 1e-3 "Dead time of inverter";
  parameter Modelica.Units.SI.Resistance k = Ra*Ta/(2*Ts) "Current controller proportional gain";
  parameter Modelica.Units.SI.Time Ti = Ta "Current controller integral time constant";
  parameter Modelica.Units.SI.MagneticFlux kPhi = ViNominal/dcpmData.wNominal "Voltage constant";
  Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage annotation(
    Placement(transformation(origin = {-4, 58}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor annotation(
    Placement(transformation(origin = {20, 34}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Continuous.LimPID PID(controllerType = Modelica.Blocks.Types.SimpleController.PI, k = k, Ti = Ti, yMax = dcpmData.VaNominal, withFeedForward = true, kFF = kPhi, initType = Modelica.Blocks.Types.Init.InitialOutput)  annotation(
    Placement(transformation(origin = {-54, 84}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T = Ts, initType = Modelica.Blocks.Types.Init.InitialOutput)  annotation(
    Placement(transformation(origin = {-24, 84}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Step step(height = dcpmData.IaNominal, offset = 0, startTime = 0.1)  annotation(
    Placement(transformation(origin = {-86, 84}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealInput inputBodyAngle annotation(
    Placement(transformation(origin = {100, -48}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {104, -46}, extent = {{-20, -20}, {20, 20}})));
equation
  connect(loadInertia.flange_a, dcpm.flange) annotation(
    Line(points = {{46, -12}, {24, -12}}));
  connect(loadTorque.flange, loadInertia.flange_b) annotation(
    Line(points = {{76, -12}, {66, -12}}));
  connect(speedSensor1.flange, dcpm.flange) annotation(
    Line(points = {{24, -54}, {33, -54}, {33, -12}, {24, -12}}));
  connect(ground.p, dcpm.pin_an) annotation(
    Line(points = {{-34, 12}, {-34, -2}, {8, -2}}, color = {0, 0, 255}));
  connect(loadInertia.flange_a, outputSpeed) annotation(
    Line(points = {{46, -12}, {46, 20}, {80, 20}, {80, 13}, {104, 13}, {104, 20}}));
  connect(currentSensor.p, signalVoltage.n) annotation(
    Line(points = {{20, 44}, {20, 57}, {6, 57}, {6, 58}}, color = {0, 0, 255}));
  connect(currentSensor.n, dcpm.pin_ap) annotation(
    Line(points = {{20, 24}, {20, -2}}, color = {0, 0, 255}));
  connect(signalVoltage.p, ground.p) annotation(
    Line(points = {{-14, 58}, {-34, 58}, {-34, 12}}, color = {0, 0, 255}));
  connect(PID.y, firstOrder.u) annotation(
    Line(points = {{-43, 84}, {-36, 84}}, color = {0, 0, 127}));
  connect(firstOrder.y, signalVoltage.v) annotation(
    Line(points = {{-13, 84}, {-4, 84}, {-4, 70}}, color = {0, 0, 127}));
  connect(step.y, PID.u_s) annotation(
    Line(points = {{-74, 84}, {-66, 84}}, color = {0, 0, 127}));
  connect(currentSensor.i, PID.u_ff) annotation(
    Line(points = {{10, 34}, {-48, 34}, {-48, 72}}, color = {0, 0, 127}));
  connect(speedSensor1.w, PID.u_m) annotation(
    Line(points = {{4, -54}, {-54, -54}, {-54, 72}}, color = {0, 0, 127}));
end Dynamics;
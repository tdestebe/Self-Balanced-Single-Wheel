within SelfBalancedWheelPackage;

model SingleWheelRobot
  Dynamics dynamics annotation(
    Placement(transformation(origin = {-36, 14}, extent = {{-10, -10}, {10, 10}})));
  Animation animation "Multibody Single Wheel Model" annotation(
    Placement(transformation(origin = {18, 16}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(dynamics.outputSpeed, animation.inputSpeed) annotation(
    Line(points = {{-26, 16}, {7, 16}}));
  connect(dynamics.inputBodyAngle, animation.outputBodyAngle) annotation(
    Line(points = {{-26, 10}, {0, 10}, {0, 14}, {8, 14}}, color = {0, 0, 127}));
end SingleWheelRobot;
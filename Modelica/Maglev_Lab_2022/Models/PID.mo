within Maglev_Lab_2022.Models;

model PID
  parameter Real kP;
  parameter Real kI;
  Modelica.Blocks.Interfaces.RealInput err annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput u annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integrator(k = kI)  annotation(
    Placement(visible = true, transformation(origin = {2, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain PGain(k = kP)  annotation(
    Placement(visible = true, transformation(origin = {2, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add sum annotation(
    Placement(visible = true, transformation(origin = {48, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(err, integrator.u) annotation(
    Line(points = {{-100, 0}, {-40, 0}, {-40, -22}, {-10, -22}}, color = {0, 0, 127}));
  connect(PGain.u, err) annotation(
    Line(points = {{-10, 20}, {-40, 20}, {-40, 0}, {-100, 0}}, color = {0, 0, 127}));
  connect(sum.y, u) annotation(
    Line(points = {{60, 0}, {100, 0}}, color = {0, 0, 127}));
  connect(PGain.y, sum.u1) annotation(
    Line(points = {{14, 20}, {24, 20}, {24, 6}, {36, 6}}, color = {0, 0, 127}));
  connect(integrator.y, sum.u2) annotation(
    Line(points = {{14, -22}, {24, -22}, {24, -6}, {36, -6}}, color = {0, 0, 127}));

annotation(
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {-50, 7}, extent = {{108, 38}, {0, -38}}, textString = "PID")}));
end PID;

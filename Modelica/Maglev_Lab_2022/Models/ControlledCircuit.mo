within Maglev_Lab_2022.Models;

model ControlledCircuit
  extends Modelica.Icons.Example;
  Maglev_Lab_2022.Models.CoilCircuit coilCircuit annotation(
    Placement(visible = true, transformation(origin = {30, -3.9968e-15}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
  Maglev_Lab_2022.Models.PID PID(kI = 740, kP = 80)  annotation(
    Placement(visible = true, transformation(origin = {-6, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add minus(k2 = -1)  annotation(
    Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Cosine Delta(amplitude = 0.5, f = 1, offset = 0.5) annotation(
    Placement(visible = true, transformation(origin = {10, -44}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  Modelica.Blocks.Interaction.Show.RealValue Iout annotation(
    Placement(visible = true, transformation(origin = {80, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp CurrentSetpoint(duration = 0, height = 1, offset = 0, startTime = 0.25)  annotation(
    Placement(visible = true, transformation(origin = {-78, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(coilCircuit.V_in, PID.u) annotation(
    Line(points = {{16, 0}, {4, 0}}, color = {0, 0, 127}));
  connect(PID.err, minus.y) annotation(
    Line(points = {{-16, 0}, {-28, 0}}, color = {0, 0, 127}));
  connect(coilCircuit.delta, Delta.y) annotation(
    Line(points = {{30, -12}, {30, -44}, {21, -44}}, color = {0, 0, 127}));
  connect(minus.u2, coilCircuit.I) annotation(
    Line(points = {{-52, -6}, {-60, -6}, {-60, -28}, {54, -28}, {54, 6}, {44, 6}}, color = {0, 0, 127}));
  connect(Iout.numberPort, coilCircuit.I) annotation(
    Line(points = {{68, 6}, {44, 6}}, color = {0, 0, 127}));
  connect(minus.u1, CurrentSetpoint.y) annotation(
    Line(points = {{-52, 6}, {-66, 6}}, color = {0, 0, 127}));
end ControlledCircuit;

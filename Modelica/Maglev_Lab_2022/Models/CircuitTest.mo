within Maglev_Lab_2022.Models;

model CircuitTest
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Ramp Voltage(duration = 0, startTime = 0.25)  annotation(
    Placement(visible = true, transformation(origin = {-44, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Maglev_Lab_2022.Models.CoilCircuit coilCircuit annotation(
    Placement(visible = true, transformation(origin = {10, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interaction.Show.RealValue Current annotation(
    Placement(visible = true, transformation(origin = {60, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Cosine Delta(amplitude = 0.5, f = 1, offset = 0.5) annotation(
    Placement(visible = true, transformation(origin = {-10, -20}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
equation
  connect(Voltage.y, coilCircuit.V_in) annotation(
    Line(points = {{-33, 20}, {-1, 20}}, color = {0, 0, 127}));
  connect(Current.numberPort, coilCircuit.I) annotation(
    Line(points = {{48.5, 20}, {20.5, 20}}, color = {0, 0, 127}));
  connect(coilCircuit.delta, Delta.y) annotation(
    Line(points = {{10, 11}, {10, -20}, {1, -20}}, color = {0, 0, 127}));
end CircuitTest;

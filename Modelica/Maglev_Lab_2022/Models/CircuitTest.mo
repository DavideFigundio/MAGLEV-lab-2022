within Maglev_Lab_2022.Models;

model CircuitTest
  extends Modelica.Icons.Example;
  Maglev_Lab_2022.Models.CoilCircuit coilCircuit annotation(
    Placement(visible = true, transformation(origin = {-2.22045e-16, 20}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
  Modelica.Blocks.Sources.Cosine Delta(amplitude = -1, f = 1, offset = 1)  annotation(
    Placement(visible = true, transformation(origin = {-18, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp Voltage(duration = 1)  annotation(
    Placement(visible = true, transformation(origin = {-46, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(coilCircuit.delta, Delta.y) annotation(
    Line(points = {{0, 6}, {0, -20}, {-6, -20}}, color = {0, 0, 127}));
  connect(coilCircuit.V, Voltage.y) annotation(
    Line(points = {{-14, 20}, {-34, 20}}, color = {0, 0, 127}));
end CircuitTest;

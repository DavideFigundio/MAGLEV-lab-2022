within Maglev_Lab_2022.Models;

model CoilCircuit
  Modelica.Blocks.Tables.CombiTable1Ds InductanceValues(fileName = "C:/Users/dfigu/Documents/Projects/MAGLEV-lab-2022/Modelica/Maglev_Lab_2022/Models/IndTable.mat", smoothness = Modelica.Blocks.Types.Smoothness.ContinuousDerivative, tableName = "table", tableOnFile = true, verboseExtrapolation = true, verboseRead = true) annotation(
    Placement(visible = true, transformation(origin = {52, -4}, extent = {{12, -12}, {-12, 12}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.VariableInductor inductance annotation(
    Placement(visible = true, transformation(origin = {12, -4}, extent = {{10, 10}, {-10, -10}}, rotation = 90)));
  Modelica.Electrical.Analog.Basic.Resistor resistance(R = 3.7)  annotation(
    Placement(visible = true, transformation(origin = {-26, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage annotation(
    Placement(visible = true, transformation(origin = {-50, 6}, extent = {{-14, 14}, {14, -14}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(origin = {-28, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput V_in annotation(
    Placement(visible = true, transformation(origin = {-88, 6}, extent = {{-6, -6}, {6, 6}}, rotation = 0), iconTransformation(origin = {-93, 1}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput delta annotation(
    Placement(visible = true, transformation(origin = {80, -4}, extent = {{-6, -6}, {6, 6}}, rotation = 180), iconTransformation(origin = {0, -90}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput I annotation(
    Placement(visible = true, transformation(origin = {44, 20}, extent = {{-4, -4}, {4, 4}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor annotation(
    Placement(visible = true, transformation(origin = {12, 20}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
equation
  connect(ground.p, inductance.n) annotation(
    Line(points = {{-28, -18}, {12, -18}, {12, -14}}, color = {0, 0, 255}));
  connect(InductanceValues.y[2], inductance.L) annotation(
    Line(points = {{39, -4}, {24, -4}}, color = {0, 0, 127}));
  connect(signalVoltage.v, V_in) annotation(
    Line(points = {{-66, 6}, {-88, 6}}, color = {0, 0, 127}));
  connect(currentSensor.n, inductance.p) annotation(
    Line(points = {{12, 10}, {12, 6}}, color = {0, 0, 255}));
  connect(resistance.n, currentSensor.p) annotation(
    Line(points = {{-16, 34}, {12, 34}, {12, 30}}, color = {0, 0, 255}));
  connect(currentSensor.i, I) annotation(
    Line(points = {{24, 20}, {44, 20}}, color = {0, 0, 127}));
  connect(InductanceValues.u, delta) annotation(
    Line(points = {{66, -4}, {80, -4}}, color = {0, 0, 127}));
  connect(signalVoltage.p, resistance.p) annotation(
    Line(points = {{-50, 20}, {-50, 34}, {-36, 34}}, color = {0, 0, 255}));
  connect(signalVoltage.n, ground.p) annotation(
    Line(points = {{-50, -8}, {-50, -18}, {-28, -18}}, color = {0, 0, 255}));  protected
  annotation(
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {0, 3}, extent = {{-62, -49}, {62, 49}}, textString = "Induction Circuit")}),
    Diagram);
end CoilCircuit;

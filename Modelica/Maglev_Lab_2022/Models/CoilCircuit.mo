within Maglev_Lab_2022.Models;

model CoilCircuit
  Maglev_Lab_2022.Components.CircuitEquation circuitEquation(R = 3.7)  annotation(
    Placement(visible = true, transformation(origin = {2, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput V annotation(
    Placement(visible = true, transformation(origin = {-62, 28}, extent = {{-8, -8}, {8, 8}}, rotation = 0), iconTransformation(origin = {-100, 2.22045e-16}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput I annotation(
    Placement(visible = true, transformation(origin = {72, 28}, extent = {{-8, -8}, {8, 8}}, rotation = 0), iconTransformation(origin = {104, 1.77636e-15}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput delta annotation(
    Placement(visible = true, transformation(origin = {-64, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -98}, extent = {{-14, -14}, {14, 14}}, rotation = 90)));
  Modelica.Blocks.Tables.CombiTable1Ds InductanceValues(fileName = "C:/Users/dfigu/Documents/Projects/MAGLEV-lab-2022/Modelica/Maglev_Lab_2022/Models/IndTable.mat", tableName = "table", tableOnFile = true, verboseRead = true)  annotation(
    Placement(visible = true, transformation(origin = {-26, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interaction.Show.RealValue RI annotation(
    Placement(visible = true, transformation(origin = {46, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interaction.Show.RealValue I_der_term annotation(
    Placement(visible = true, transformation(origin = {46, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interaction.Show.RealValue L_der_term annotation(
    Placement(visible = true, transformation(origin = {46, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interaction.Show.RealValue L(use_numberPort = true)  annotation(
    Placement(visible = true, transformation(origin = {66, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interaction.Show.RealValue L_der annotation(
    Placement(visible = true, transformation(origin = {68, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Derivative derivative annotation(
    Placement(visible = true, transformation(origin = {28, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(V, circuitEquation.V) annotation(
    Line(points = {{-62, 28}, {-8, 28}}, color = {0, 0, 127}));
  connect(circuitEquation.I, I) annotation(
    Line(points = {{12, 28}, {72, 28}}, color = {0, 0, 127}));
  connect(InductanceValues.u, delta) annotation(
    Line(points = {{-38, -28}, {-64, -28}}, color = {0, 0, 127}));
  connect(RI.numberPort, circuitEquation.RI) annotation(
    Line(points = {{34, 82}, {-2, 82}, {-2, 38}}, color = {0, 0, 127}));
  connect(I_der_term.numberPort, circuitEquation.I_der_term) annotation(
    Line(points = {{34, 70}, {2, 70}, {2, 38}}, color = {0, 0, 127}));
  connect(L_der_term.numberPort, circuitEquation.L_der_term) annotation(
    Line(points = {{34, 56}, {8, 56}, {8, 38}}, color = {0, 0, 127}));
  connect(L.numberPort, InductanceValues.y[2]) annotation(
    Line(points = {{54.5, -28}, {-14, -28}}, color = {0, 0, 127}));
  connect(L_der.numberPort, derivative.y) annotation(
    Line(points = {{56.5, -6}, {40, -6}}, color = {0, 0, 127}));
  connect(circuitEquation.L_der, derivative.y) annotation(
    Line(points = {{6, 18}, {6, 12}, {44, 12}, {44, -6}, {40, -6}}, color = {0, 0, 127}));
  connect(circuitEquation.L, InductanceValues.y[2]) annotation(
    Line(points = {{-2, 18}, {-2, -28}, {-14, -28}}, color = {0, 0, 127}));
  connect(derivative.u, InductanceValues.y[2]) annotation(
    Line(points = {{16, -6}, {-2, -6}, {-2, -28}, {-14, -28}}, color = {0, 0, 127}));
  annotation(
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {0, 3}, extent = {{-62, -49}, {62, 49}}, textString = "Induction Circuit")}),
    Diagram);
end CoilCircuit;

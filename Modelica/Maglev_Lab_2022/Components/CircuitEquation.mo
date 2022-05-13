within Maglev_Lab_2022.Components;

model CircuitEquation
  extends Modelica.Icons.Function;
  parameter Modelica.Units.SI.Resistance R;
  Modelica.Blocks.Interfaces.RealInput V annotation(
    Placement(visible = true, transformation(origin = {-98, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-98, 0}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput I annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput L annotation(
    Placement(visible = true, transformation(origin = {-6, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-40, -94}, extent = {{-12, -12}, {12, 12}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput RI annotation(
    Placement(visible = true, transformation(origin = {-46, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-50, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput I_der_term annotation(
    Placement(visible = true, transformation(origin = {0, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput L_der_term annotation(
    Placement(visible = true, transformation(origin = {64, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {50, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput L_der annotation(
    Placement(visible = true, transformation(origin = {22, -102}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {40, -94}, extent = {{-12, -12}, {12, 12}}, rotation = 90)));
equation
  V = R*I + L_der*I + der(I)*L;
  RI = R*I;
  I_der_term = der(I)*L;
  L_der_term = L_der*I;

end CircuitEquation;

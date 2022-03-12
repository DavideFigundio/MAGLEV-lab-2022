clc
clear
close all

%% VALUES S.I.%%
m = 0.83474;        %mass
R = 3.5;            %resistance
N = 860;            %spires
Lb = 0.03;          %width
Pb = 0.03;          %depth
d0 = 0.01228;       %delta0
u0 = 4*pi*10^(-7);  %magnetic permeability (vacuum)
cr = 700;           %relative magnetic permeability for iron
xD = d0/2;          %position setpoint
x0 = 0;             %initial position
Lfe = 0.2781;       %magnetic circuit length in iron

%% PARAMETERS %%
Kp_I = 3000;        %Bandwidth for electrical controller

%% CALCULATION %%
As = Lb*Pb;         %spire area
k = u0*As*(N^2);
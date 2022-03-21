% File containing all measurments for use in modeling and simulation of the
% magnetic control system.

clc
clear
close all

%% UNIVERSAL CONSTANTS %%
g = 9.81;           % Gravity acceleration
u0 = 4*pi*10^(-7);  % Magnetic permeability in th vacuum

%% MEASURED VALUES (S.I. UNITS) %%
m = 0.83474;        % Mass of the mobile element
R = 3.7;            % Resistance of the excitation circuit
N = 860;            % Number of spires of the excitation circuit
Lb = 0.03;          % Width of the cross-section of the iron
Pb = 0.03;          % Depth of the cross-section of the iron
d0 = 0.01228;       % Initial distance of the mobile element from the iron
cr = 700;           % Relative magnetic permeability for iron
xD = d0/2;          % Position setpoint
x0 = 0;             % Initial position
Lfe = 0.2781;       % Magnetic circuit length in iron

%% CALCULATION %%
As = Lb*Pb;         % Magnetic circuit section area
k = u0*As*(N^2);    % Magnetic force constant

%% INDUCTANCE MAPPING %%

% Methodology: we measure the peak current and voltage for certain values of the
% air gap between the mobile element and the rest of the magnetic circuit,
% and calcualte the inductance from these values.

V_vect = [5,5,5,5,5,5,5];
I_vect = [0.46,0.66,0.725,0.86,0.925,1.005,1.01];
delta_vect = [0,1.8,2.4,6.56,9.99,14.04,17.8];
L_vect=sqrt((V_vect./I_vect).^2 - R^2)./31.4;

%% PARAMETERS %%
Kp_I = 3000;        %Bandwidth for electrical controller
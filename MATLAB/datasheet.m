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
cr = 700;           % Relative magnetic permeability for iron
x0 = 0;             % Initial position
Lfe = 0.2781;       % Magnetic circuit length in iron

Fs = 0.2*m*g;

%% CALCULATION %%
As = Lb*Pb;         % Magnetic circuit section area
k = u0*As*(N^2);    % Magnetic force constant

%% INDUCTANCE MAPPING %%
load('inductanceResults.mat')                       % Simulation results
L_sim = inductanceArray(:, 2);

%% FORCE MAPPING %%
load('simulationResults.mat')
forceArray = -transpose(forceArray);

%% PARAMETERS %%
d0 = 14;            % Initial distance of the mobile element from the iron [mm]
% Simulated gravity compensation line
mG = 1.9412;
qG = 0.0116;

%% LQR %%
load("LQRval.mat")
k1 = K(1);
k2 = K(2);
k3 = K(3);


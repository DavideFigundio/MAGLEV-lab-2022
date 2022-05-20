% Script that performs setup for simulation of the system
clc
clear
close all

%% UNIVERSAL CONSTANTS %%
g = 9.81;           % Gravity acceleration

%% MEASURED VALUES (S.I. UNITS) %%
m = 0.83474;        % Mass of the mobile element

%% FORCE MAPPING %%
load('simulationResults.mat')
forceArray = -transpose(forceArray);

%% PARAMETERS %%
d0 = 14;            % Initial distance of the mobile element from the iron [mm]
start = d0*3/4;     % Starting position of the mobile element
% Simulated gravity compensation line
mG = 1.9412;
qG = 0.0116;
% PID Weighting
load("Kvals.mat")

%% LQR %%
load("LQRval.mat")
k1 = K(1);
k2 = K(2);
k3 = K(3);


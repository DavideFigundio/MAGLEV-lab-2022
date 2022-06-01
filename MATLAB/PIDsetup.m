% Script that performs setup for simulation of the system
clc
clear
close all

%% UNIVERSAL CONSTANTS %%
g = 9.81;           % Gravity acceleration

%% MEASURED VALUES (S.I. UNITS) AND DATA%%
m = 0.83474;        % Mass of the mobile element
eqforce = m*g;

% Data from FEMM simulations
load('simulationResults.mat')           % Loading simulation results
forceArray = -transpose(forceArray);    % Correction of results
deltas = 10*deltas;                     % cm->mm conversion
N_delta = length(deltas);
N_I = length(I);

%% GRAVITY COMPENSATION %%

% Simulated equilibrium
sim_eq = contourc(deltas, I, forceArray, [eqforce, eqforce]);
gc = polyfit(sim_eq(1, 2:N_I), sim_eq(2, 2:N_I), 1);

mG= gc(1);
qG = gc(2);

%% PARAMETERS %%
d0 = 14;            % Initial distance of the mobile element from the iron [mm]
start = d0*3/4;     % Starting position of the mobile element

% PID Weighting
load("Kvals.mat")


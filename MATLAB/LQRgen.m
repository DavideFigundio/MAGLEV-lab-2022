%% LQR Generation %%

clear
clc
close all

%% LOADING AND PREPARATION OF DATA %%
m = 0.83474;                                         % Mobile element mass
eqforce = m*9.81;                                    % Equilibrium force
eqpoint = 7;                    % linearization point

% Data from FEMM simulations
load('simulationResults.mat')                     % Loading simulation results
forceArray = -transpose(forceArray);    % Correction of results
deltas = 10*deltas;                     % cm->mm conversion
N_delta = length(deltas);
N_I = length(I);
fParam = 0.2;                          % Hypothesized friction/gravity ratio
frictionForce = eqforce*fParam;

%% SIMULATED EQUILIBRIUM VALUES %%

% Simulated take-off
sim_takeoff = contourc(deltas, I, forceArray, [eqforce+frictionForce, eqforce+frictionForce]);
sim_to = polyfit(sim_takeoff(1, 2:N_I), sim_takeoff(2, 2:N_I), 1); 

% Simulated fall-down
sim_falldown = contourc(deltas, I, forceArray, [eqforce-frictionForce, eqforce-frictionForce]);
sim_fd = polyfit(sim_falldown(1, 2:N_I), sim_falldown(2, 2:N_I), 1);

% Gradient estimation
max = polyval(sim_to, eqpoint);
min = polyval(sim_fd, eqpoint);
der = 2*frictionForce/(max-min);

A = [0, 1, 0; 0, 0, 1; 0, 0, 0];
B = [0; 0; der/m];
Q = diag([1, 10, 0.1]);
R = 1;

K = lqr(A, B, Q , R);
save('LQRval', "K")



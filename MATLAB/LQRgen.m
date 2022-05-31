%% LQR Generation %%

clear
clc
close all

%% LOADING AND PREPARATION OF DATA %%
m = 0.83474;                                         % Mobile element mass
eqforce = m*9.81;                                    % Equilibrium force
deltaeq = 7;                    % linearization point
d0 = 14;
start = d0;

% Data from FEMM simulations
load('simulationResults.mat')                     % Loading simulation results
forceArray = -transpose(forceArray);    % Correction of results
deltas = 10*deltas;                     % cm->mm conversion
N_delta = length(deltas);
N_I = length(I);
fParam = 0.2;                          % Hypothesized friction/gravity ratio
frictionForce = eqforce*fParam;

%% SIMULATED EQUILIBRIUM VALUES %%

% Simulated equilibrium
sim_eq = contourc(deltas, I, forceArray, [eqforce, eqforce]);
gc = polyfit(sim_eq(1, 2:N_I), sim_eq(2, 2:N_I), 1);

mG= gc(1);
qG = gc(2);

k1=4*eqforce/(mG^2);
k2=qG*sqrt(k1/eqforce);

ieq = mG*deltaeq + qG;

a = -4*k1*ieq^2/m/(2*deltaeq+k2)^3;
b = 2*k1*ieq/m/(2*deltaeq+k2)^2;


A = [0, -1; a, 0;];
B = [0; b];
C = [1, 0];
D = 0;
sys = ss(A, B, C, D);

Q = diag([10, 0.1, 1]);
R = 1;

K = lqi(sys, Q, R);




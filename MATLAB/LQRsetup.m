%% LQR SETUP %%
% Script for the preparation of LQR simulation and the computation of the
% LQR gain.

clear
clc
close all

%% PREPARATION OF DATA %%

% System parameters
m = 0.83474;                    % Mobile element mass
eqforce = m*9.81;               % Equilibrium force
deltaeq = 7;                    % linearization point
d0 = 14;
start = d0;

% Data from FEMM simulations
load('simulationResults.mat')           % Loading simulation results
forceArray = -transpose(forceArray);    % Correction of results
deltas = 10*deltas;                     % cm->mm conversion
N_delta = length(deltas);
N_I = length(I);

%% PARAMETER ESTIMATION %%

% Simulated gravity compensation line
sim_eq = contourc(deltas, I, forceArray, [eqforce, eqforce]);
gc = polyfit(sim_eq(1, 2:N_I), sim_eq(2, 2:N_I), 1);

%mG= gc(1);
%qG = gc(2);

% Parameter computation
k1=4*eqforce/(mG^2);
k2=qG*sqrt(k1/eqforce);

% Plotting
formulaForceArray = zeros(N_I, N_delta);
for i=1:N_delta
    for j = 1:N_I
        formulaForceArray(j, i) = k1*I(j)^2/(k2+2*deltas(i))^2;
    end
end

surf(deltas, I, formulaForceArray./forceArray)
xlabel('Air Gap [mm]')
ylabel('Current [A]')
zlabel('Ratio')



%% LINEARIZATION AND LQR %%

ieq = mG*deltaeq + qG;

a = -4*k1*ieq^2/m/(2*deltaeq+k2)^3;
b = 2*k1*ieq/m/(2*deltaeq+k2)^2;


A = [0, -1; a, 0;];
B = [0; b];
C = [1, 0];
D = 0;
sys = ss(A, B, C, D);

Q = diag([10, 0.1, 10]);
R = 1;

K = lqi(sys, Q, R);





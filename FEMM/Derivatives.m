%% DERIVATIVE ANALYSYS %%
% Script for analysing partial derivatives of the system, and linearizing
% it around specified equilibrium points.

clear
clc
close all
hold on

%% LOADING AND PREPARATION OF DATA %%

% Measured data
deltarising = [13.2, 10.65, 9.12, 7.4, 6.05, 4.6];  % Rising air gaps
Irising = [2.96, 2.46, 2.07, 1.7, 1.45, 1.15];      % Rising currents
deltafalling = [4.95, 6.3, 7.6, 10.1];              % Falling air gaps
Ifalling = [0.93, 1.16, 1.32, 1.82];                % Falling currents
m = 0.83474;                                        % Mobile element mass
eqforce = m*9.81;                                   % Equilibrium force

% Data from FEMM simulations
load('results.mat')                     % Loading simulation results
forceArray = -transpose(forceArray);    % Correction of results
deltas = 10*deltas;                     % cm->mm conversion
N_delta = length(deltas);
N_I = length(I);
fParam = 0.25;                          % Hypothesized friction/gravity ratio
frictionForce = eqforce*fParam;

%% SIMULATED EQUILIBRIUM VALUES %%

% MAXIMUM EQUILIBRIUM CURRENT
% This computes the maximum current in simulation, above which the magnetic
% force surpasses the value of the gravitational force plus the static
% friction force, thus for which the mobile element moves upwards, as a 
% function of the air gap.
sim_upperbound = contourc(deltas, I, forceArray, [eqforce+frictionForce, eqforce+frictionForce]);
sim_hi = polyfit(sim_upperbound(1, 2:N_I), sim_upperbound(2, 2:N_I), 1); 

% MINIMUM EQUILIBRIUM CURRENT
% This computes the minimum current in simulation, below which the magnetic
% force is less than the value of the gravitational force minus the static
% friction force, thus for which the mobile element moves downwards, as a
% function of the air gap.
sim_lowerbound = contourc(deltas, I, forceArray, [eqforce-frictionForce, eqforce-frictionForce]);
sim_lo = polyfit(sim_lowerbound(1, 2:N_I), sim_lowerbound(2, 2:N_I), 1);

% TRUE EQUILIBRIUM CURRENT
% This computes the value of the current for which the magnetic force is
% equal to the gravitational force, as a function of the air gap.
sim_equilibrium = contourc(deltas, I, forceArray, [eqforce, eqforce]);
sim_eq = polyfit(sim_equilibrium(1, 2:N_I), sim_equilibrium(2, 2:N_I), 1);

% SIMULATED GRADIENT
% We estimate the partial derivative dF/dI at the true equilibrium as
% 2*Fs/(Imax-Imin), and compare it to the true partial derivative obtained
% from the simulation.

% Gradient computation
hdelta = (deltas(length(deltas))-deltas(1))/length(deltas);
hI = (I(length(I))-I(1))/length(I);
[FX, FY] = gradient(forceArray, hdelta, hI);

% Extraction and plotting of partial derivatives from gradient
n = length(sim_equilibrium);
grad = zeros(1, n-1);
for i = 2:n
    grad(i-1) = interp2(deltas, I, FY, sim_equilibrium(1, i), sim_equilibrium(2, i));
end
plot(sim_equilibrium(1, 2:n), grad, 'r')

%  GRADIENT ESTIMATE
grad_est = zeros(1, n-1);
for i = 2:n
    delta = sim_equilibrium(1, i);
    max = polyval(sim_hi, delta);
    min = polyval(sim_lo, delta);
    grad_est(i-1) = 2*frictionForce/(max-min);
end
plot(sim_equilibrium(1, 2:n), grad_est, 'k')

%% MEASURED GRADIENT ESTIMATE %%

% MAXIMUM EQUILIBRIUM CURRENT (Measured)
% We compute the maximum equilibrium current via linear regression of the
% rising thresholds.
prising = polyfit(deltarising, Irising, 1);

% MINIMUM EQUILIBRIUM CURRENT (Measured)
% We compute the minimum equilibrium current via linear regression of the
% falling thresholds.
pfalling = polyfit(deltafalling, Ifalling, 1);

deltaVals = linspace (1, 20, length(deltas));    % set of air gaps
n = length(deltaVals);
Kvals = zeros(1, n);        % Set of estimated partial derivatives
for i = 1:n
    delta = deltaVals(i);
    max = polyval(prising, delta);
    min = polyval(pfalling, delta);
    Kvals(i) = 2*frictionForce/(max-min);
end
plot(deltaVals, Kvals, 'b')

xlabel('Air Gap [mm]')
ylabel('dF/dI [N/A]')
legend('True simulation gradient', 'Estimated simulation gradient', 'Estimated measured gradient')
grid on
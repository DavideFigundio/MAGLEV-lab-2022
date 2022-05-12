%% DERIVATIVE ANALYSYS %%
% Script for analysing partial derivatives of the system, and linearizing
% it around specified equilibrium points.

clear
clc
close all
hold on

%% LOADING AND PREPARATION OF DATA %%

% Measured data
deltaTakeoff = [13.2, 10.65, 9.12, 7.4, 6.05, 4.6];  % Takeoff air gaps
ITakeoff = [2.96, 2.46, 2.07, 1.7, 1.45, 1.15];      % Takeoff currents
deltaFalldown = [4.95, 6.3, 7.6, 10.1];              % Falldown air gaps
IFalldown = [0.93, 1.16, 1.32, 1.82];                % Falldown currents
m = 0.83474;                                         % Mobile element mass
eqforce = m*9.81;                                    % Equilibrium force

% Data from FEMM simulations
load('simulationResults.mat')                     % Loading simulation results
forceArray = -transpose(forceArray);    % Correction of results
deltas = 10*deltas;                     % cm->mm conversion
N_delta = length(deltas);
N_I = length(I);
fParam = 0.25;                          % Hypothesized friction/gravity ratio
frictionForce = eqforce*fParam;

%% SIMULATED EQUILIBRIUM VALUES %%

% Simulated take-off
sim_takeoff = contourc(deltas, I, forceArray, [eqforce+frictionForce, eqforce+frictionForce]);
sim_to = polyfit(sim_takeoff(1, 2:N_I), sim_takeoff(2, 2:N_I), 1); 

% Simulated fall-down
sim_falldown = contourc(deltas, I, forceArray, [eqforce-frictionForce, eqforce-frictionForce]);
sim_fd = polyfit(sim_falldown(1, 2:N_I), sim_falldown(2, 2:N_I), 1);

% Simulated equilibrium
sim_equilibrium = contourc(deltas, I, forceArray, [eqforce, eqforce]);
sim_eq = polyfit(sim_equilibrium(1, 2:N_I), sim_equilibrium(2, 2:N_I), 1);

%% SIMULATED GRADIENT %%
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

% Gradient estimation using equilbrium channel
grad_est = zeros(1, n-1);
for i = 2:n
    delta = sim_equilibrium(1, i);
    max = polyval(sim_to, delta);
    min = polyval(sim_fd, delta);
    grad_est(i-1) = 2*frictionForce/(max-min);
end
plot(sim_equilibrium(1, 2:n), grad_est, 'k')

%% MEASURED GRADIENT ESTIMATE %%

% Measured takeoff
ptakeoff = polyfit(deltaTakeoff, ITakeoff, 1);

% Measured falldown
% We compute the minimum equilibrium current via linear regression of the
% falling thresholds.
pfalldown = polyfit(deltaFalldown, IFalldown, 1);

deltaVals = linspace (1, 20, length(deltas));    % set of air gaps
n = length(deltaVals);
Kvals = zeros(1, n);        % Set of estimated partial derivatives
for i = 1:n
    delta = deltaVals(i);
    max = polyval(ptakeoff, delta);
    min = polyval(pfalldown, delta);
    Kvals(i) = 2*frictionForce/(max-min);
end
plot(deltaVals, Kvals, 'b')

xlabel('Air Gap [mm]')
ylabel('dF/dI [N/A]')
legend('True simulation gradient', 'Estimated simulation gradient', 'Estimated measured gradient')
grid on
%% EQUILIBRIUM CHANNEL ANALYSIS %%
% Script for anaysis and plotting of equilibrium positions considering friction.

clear
clc
close all
grid on
hold on
set(gca, 'Layer', 'top')

%% LOADING SIMULATION RESULTS %%

load('simulationResults.mat')
forceArray = -transpose(forceArray);
N_delta = length(deltas);
N_I = length(I);

%% MEASURED PARAMETERS %%

m = 0.83474;                 % mobile element mass
eqforce = m*9.81;            % equilibrium force
frictionForce = eqforce*0.2; % static friction force

% Take-off line measurments
deltaTO = [13.2, 10.65, 9.12, 7.4, 6.05, 4.6];  
Ito = [2.96, 2.46, 2.07, 1.7, 1.45, 1.15];

% Fall-down line measurments
deltaFD = [4.95, 6.3, 7.6, 10.1];
Ifd = [0.93, 1.16, 1.32, 1.82];

%% COMPUTATION OF SIMULATED TAKE-OFF, FALL-D0WN AND EQUILIBRIUM %%

% Simulated take-off line computation and plotting
sim_takeoff = contour(deltas, I, forceArray, [eqforce+frictionForce eqforce+frictionForce], 'c');
n = length(sim_takeoff);
sim_to_x = sim_takeoff(1, 2:n);
sim_to_y = sim_takeoff(2, 2:n);
sim_channel = area(sim_to_x, sim_to_y, 'FaceColor', 'y', 'LineStyle', 'none');

% Simulated fall-down line computation and plotting
sim_falldown = contour(deltas, I, forceArray, [eqforce-frictionForce eqforce-frictionForce], 'c');
n = length(sim_falldown);
sim_fd_x = sim_falldown(1, 2:n);
sim_fd_y = sim_falldown(2, 2:n);
area(sim_fd_x, sim_fd_y, 'FaceColor', 'w', 'LineStyle', 'none');

% Simulated equilibrium line computation and plotting
sim_equilibrium = contour(deltas, I, forceArray, [eqforce eqforce], 'LineStyle', 'none');
n = length(sim_equilibrium);
sim_x = sim_equilibrium(1, 2:n);
sim_y = sim_equilibrium(2, 2:n);
eqplot = plot(sim_x, sim_y, ':b');

%% REGRESSION AND PLOTTING OF MEASURED TAKE-OFF AND FALL-DOWN %%

xvals = linspace(3, 15);
pTO = polyfit(deltaTO, Ito, 1); % Takeoff polynomial regression
pFD = polyfit(deltaFD, Ifd, 1); % Falldown polynomial regression

points = scatter(deltaTO/10, Ito, 'r', 'filled');
scatter(deltaFD/10, Ifd, 'r', 'filled')
takeoff = plot(xvals/10, polyval(pTO, xvals), '--m');
falldown = plot(xvals/10, polyval(pFD, xvals), '--k');

%% COMPUTATION AND PLOTTING OF GRAVITY COMPENSATION LINE %%

% Regression of simulated equilibrium lines
sim_to = polyfit(sim_takeoff(1, 2:N_I), sim_takeoff(2, 2:N_I), 1);
sim_fd = polyfit(sim_falldown(1, 2:N_I), sim_falldown(2, 2:N_I), 1);
sim_eq = polyfit(sim_equilibrium(1, 2:N_I), sim_equilibrium(2, 2:N_I), 1);

ratio = (sim_eq-sim_fd)/(sim_to-sim_fd);
pGC = pFD + ratio*(pTO-pFD);

gravComp = plot(xvals/10, polyval(pGC, xvals), 'r');

legend([sim_channel, eqplot, points, takeoff, falldown, gravComp], 'Simulation Equilibrium Channel', 'Simulated Gravity Compensation Line', 'Measured Points', 'Take-Off Line', 'Fall-Down Line', 'Gravity Compensation Line')
ylabel('Current [A]')
xlabel('Air Gap [cm]')





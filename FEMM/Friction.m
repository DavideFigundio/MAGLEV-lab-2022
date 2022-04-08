%% FRICTION ANALYSIS %%
% Script for anaysis and representation of equilibrium positions considering friction.

clear
clc
close all

load('results.mat')
forceArray = -forceArray(:, :);
N_delta = length(deltas);
N_I = length(I);

m = 0.83474;
eqforce = m*9.81;
frictionForce = eqforce*0.2;

deltarising = [13.2, 10.65, 9.12, 7.4, 6.05, 4.6];
Irising = [2.96, 2.46, 2.07, 1.7, 1.45, 1.15];

prising = polyfit(deltarising, Irising, 1);

deltafalling = [4.95, 6.3, 7.6, 10.1];
Ifalling = [0.93, 1.16, 1.32, 1.82];

pfalling = polyfit(deltafalling, Ifalling, 1);

pmiddle = (prising + pfalling)/2

grid on
hold on
set(gca, 'Layer', 'top')


xvals = linspace(3, 15);

sim_upperbound = contour(deltas, I, transpose(forceArray), [eqforce+frictionForce eqforce+frictionForce], 'c');
sim_up_x = sim_upperbound(1, 2:N_I);
sim_up_y = sim_upperbound(2, 2:N_I);
sim_channel = area(sim_up_x, sim_up_y, 'FaceColor', 'c', 'LineStyle', 'none');

sim_lowerbound = contour(deltas, I, transpose(forceArray), [eqforce-frictionForce eqforce-frictionForce], 'c');
sim_lo_x = sim_lowerbound(1, 2:N_I);
sim_lo_y = sim_lowerbound(2, 2:N_I);
area(sim_lo_x, sim_lo_y, 'FaceColor', 'w', 'LineStyle', 'none');

sim_equilibrium = contour(deltas, I, transpose(forceArray), [eqforce eqforce], 'LineStyle', 'none');
sim_x = sim_equilibrium(1, 2:N_I);
sim_y = sim_equilibrium(2, 2:N_I);
eqplot = plot(sim_x, sim_y, ':b');

points = scatter(deltarising/10, Irising, 'r', 'filled');
scatter(deltafalling/10, Ifalling, 'r', 'filled')
midval = plot(xvals/10, polyval(pmiddle, xvals), 'r');
plot(xvals/10, polyval(prising, xvals), '--k');
plot(xvals/10, polyval(pfalling, xvals), '--k');

legend([sim_channel, eqplot, points, midval], 'Simulation Friction Channel', 'Simulated Equilibria', 'Measured Points', 'Assumed Equilibrium Line')
title("Simulation vs. Measured Equilibrium Channel")
ylabel('Current [A]')
xlabel('Air Gap [cm]')





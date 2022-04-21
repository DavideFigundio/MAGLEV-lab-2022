%% VALUE GENERATION %%
% This script generates values for the 1-D maps of the control scheme,
% starting from measured and simulated data.
% Outputted data is:
%   -deltaVals: set of deltas (air gaps) to which all other plots are referred
%   -Gcomp: plot of currents required to compensate gravity as a function
%   of delta
%   -FcompUp: plot of currents required to compensate static friction in an
%   upwards direction as a function of delta
%   -FcompDown: plot of currents required to compensate static friction in
%   a downwards direction as a function of delta
%   -Kvals: weighting of PID control action depending on delta

close all
clear
clc

%% IMPORTING SIMULATION AND MEASURED DATA %%

load("simulationResults.mat")   % file containing simulation output data
load("measurments.mat")         % file containing measured current/position thresholds
forceArray = -forceArray;       % correction of force sign
deltas = 10*deltas;             % conversion from cm to mm

%% GENERATION OF SIMULATED EQUILIBRIUM CHANNEL %%

m = 0.83474;                    % mass of the mobile element
eqforce = m*9.81;               % force required to maintain equilibrium
fParam = 0.25;                  % assumed ratio of static friction to gravitational force
frictionForce = eqforce*fParam; % computation of maximum static friction force
N_I = length(I);

% MAXIMUM EQUILIBRIUM CURRENT (Simulation)
% This computes the maximum current in simulation, above which the magnetic
% force surpasses the value of the gravitational force plus the static
% friction force, thus for which the mobile element moves upwards, as a 
% function of the air gap.
sim_upperbound = contourc(deltas, I, transpose(forceArray), [eqforce+frictionForce]);
sim_hi = polyfit(sim_upperbound(1, 2:N_I), sim_upperbound(2, 2:N_I), 1); 

% MINIMUM EQUILIBRIUM CURRENT (Simulation)
% This computes the minimum current in simulation, below which the magnetic
% force is less than the value of the gravitational force minus the static
% friction force, thus for which the mobile element moves downwards, as a
% function of the air gap.
sim_lowerbound = contourc(deltas, I, transpose(forceArray), [eqforce-frictionForce]);
sim_lo = polyfit(sim_lowerbound(1, 2:N_I), sim_lowerbound(2, 2:N_I), 1);

% TRUE EQUILIBRIUM CURRENT (Simulation)
% This computes the value of the current for which the magnetic force is
% equal to the gravitational force, as a function of the air gap.
sim_equilibrium = contourc(deltas, I, transpose(forceArray), [eqforce]);
sim_eq = polyfit(sim_equilibrium(1, 2:N_I), sim_equilibrium(2, 2:N_I), 1);

%% REGRESSION OF MEASURED VALUES %%

deltaVals = linspace (1, 20, length(deltas));    % set of assumed air gaps, abscissa of all 1-D lookup tables
n = length(deltaVals);

% MAXIMUM EQUILIBRIUM CURRENT (Measured)
% We compute the maximum equilibrium current via linear regression of the
% rising thresholds.
prising = polyfit(deltarising, Irising, 1);

% MINIMUM EQUILIBRIUM CURRENT (Measured)
% We compute the minimum equilibrium current via linear regression of the
% falling thresholds.
pfalling = polyfit(deltafalling, Ifalling, 1);

%% GENERATION OF OUTPUT VALUES %%

% GCOMP
% We construct Gcomp considering the ratio between maximum, minimum and
% equilibrium currents in simulation, and maintaining the same ratio
% between the measured maximum and minimum currents, and the assumed
% equilibrium current, Gcomp. Considering that Gcomp is a straight line,
% the result is a vector [m q] such that I = m*delta + q.
ratio = (sim_eq-sim_lo)/(sim_hi-sim_lo);
Gcomp = pfalling + ratio*(prising-pfalling);

% Optional plotting of assumed measured equilibrium lines
%{
hold on
plot(deltaVals, polyval(Gcomp, deltaVals))
plot(deltaVals, polyval(prising, deltaVals))
plot(deltaVals, polyval(pfalling, deltaVals))
title("Assumed Equilibrium Lines")
xlabel("Air Gap [mm]")
ylabel("Current [A]")
%}

% FCOMPUP & FCOMPDOWN
% We compute these lines as the difference between the maximum/minimum
% equilibrium currents, and the true equilibrium current Gcomp.
FcompUp = prising - Gcomp;
FcompDown = pfalling - Gcomp;

% KVALS
% The weighting of the PID control is based on the local derivative of the
% force relative to the current. We can obtain a good approximation of this
% as (2*static friction force)/(max eq current - min eq current).
Kvals = zeros(1, n);
for i = 1:n
    delta = deltaVals(i);
    max = polyval(prising, delta);
    min = polyval(pfalling, delta);
    Kvals(i) = 2*frictionForce/(max-min);
end

%% SAVING TO FILE %%

% This file can then be loaded when starting the control algorithm.
save("Execution_params.mat", "Gcomp", "FcompUp", "FcompDown", "Kvals", "deltaVals")


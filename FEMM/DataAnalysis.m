%% DATA ANALYSIS %%
% Small script for representation of the simulation's output data.

clear
clc
close all

load('results.mat')
forceArray = -forceArray(2:40, :);
deltas = deltas(2:40);
surf(I, deltas, forceArray)
xlabel('Current [A]')
ylabel('Air Gap [cm]')
zlabel("Force [N]")
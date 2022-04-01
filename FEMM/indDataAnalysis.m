%% INDUCATANCE DATA ANALYSIS %%
% Small script for representation of the force simulation's output data.

clear
clc
close all

load('ind_results.mat')
R = 3.7; 
V_vect = [5,5,5,5,5,5,5];
I_vect = [0.46,0.66,0.725,0.86,0.925,1.005,1.01];
delta_vect = [0,1.8,2.4,6.56,9.99,14.04,17.8]/10;
L_vect=sqrt((V_vect./I_vect).^2 - R^2)./31.4;
L_sim = inductanceArray(:, 2);

%{
tiledlayout(3, 1)

nexttile
surf(I, deltas, inductanceArray)
title("F.E.M.M. Inductance Simulation Results")
xlabel('Current [A]')
ylabel('Air Gap [cm]')
zlabel("Inductance")

nexttile
%}
plot(deltas, L_sim)
hold on
plot(delta_vect, L_vect)
title("Inductance Simulation vs. Measurments")
xlabel('Air Gap [cm]')
ylabel('Inductance')
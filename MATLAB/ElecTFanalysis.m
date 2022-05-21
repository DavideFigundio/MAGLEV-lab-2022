%% ELECTRICAL TRANSFER FUNCTION ANALYSIS %%
% Script for the analysis of the electrical transfer functions and 
% controllers in various situations.

close all
clear
clc

%% VARIABLES %%
    
R = 3.5;            % Measured coil resistance
Lmax = 0.35;        % Maximum coil inductance
Lmin = 0.108;       % Minimum coil inductance

K = 100;            % Desired bandwidth

%% TRANSFER FUNCTION GENERATION %%

% System TF
s = tf('s');
Gworst = 1/(R+s*Lmax);
Gbest = 1/(R+s*Lmin);

% Regulator
R = tf([K*Lmax, K*R], [1 0]);

% Loop Analysis
Best = loopsens(Gbest, R);
Worst = loopsens(Gworst, R);

%% PLOTTING %%

subplot(1,2,1)
bode(Worst.Si, 'r', Worst.Ti, 'b', Worst.Li, 'g')
grid on
legend('Sensitivity','Complementary Sensitivity','Loop Transfer')
title('Maximum Inductance')

subplot(1,2,2)
bode(Best.Si, 'r', Best.Ti, 'b', Best.Li, 'g')
grid on
legend('Sensitivity','Complementary Sensitivity','Loop Transfer')
title('Minimum Inductance')



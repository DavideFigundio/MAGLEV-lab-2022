%% INDUCATANCE DATA ANALYSIS %%
% Small script for representation of the inductance simulation's output data.

clear
clc
close all

%% MEASURED VALUES %%
load('inductanceResults.mat')                       % Simulation results
L_sim = inductanceArray(:, 2);

% Measures for computation of inductances
V_vect = [5,5,5,5,5,5,5];                           % Voltages
I_vect = [0.46,0.66,0.725,0.86,0.925,1.005,1.01];   % Currents
delta_vect = [0.3,1.8,2.4,6.56,9.99,14.04,17.8]/10; % Air gaps

R = 3.7;                                            % El. resistance
Lfe = 0.048*2 + 2*(0.093-0.028) + 2*0.028;          % Ferrite length
N = 860;                                            % No of spires
Lb = 0.028;                                         % Height and depth of
Pb = 0.028;                                         % section
cr = 1850;                                          % Relative permeability
u0 = 4*pi*10^(-7);                                  % vacuum permeability
As = Lb*Pb;                                         % section area
k = u0*As*(N^2);

%% COMPUTATION OF MEASURED INDUCTANCES %%
L_vect = sqrt((V_vect./I_vect).^2 - R^2)./31.4;

%% COMPUTATION OF THEORETICAL INDUCTANCES %%
n = length(deltas);
L_theoretical = zeros(1, n);
for i = 1:n
    L_theoretical(i) = k/(2*deltas(i)/100 + Lfe/cr);
end


%% PLOTTING %% 
tiledlayout(1, 2)

% Raw simulation output surface plot
nexttile
surf(u, deltas, inductanceArray)
xlabel('Relative Permeability')
ylabel('Air Gap [cm]')
zlabel("Inductance [H]")

% Comparison between theory, simulation and measurments
nexttile
hold on
grid on
plot(deltas, L_sim)
plot(deltas, L_theoretical)
scatter(delta_vect, L_vect, 'k')
xlabel('Air Gap [cm]')
ylabel('Inductance [H]')
legend('FEMM Simulation', 'Magnetic Circuit Model', 'Measured Values')
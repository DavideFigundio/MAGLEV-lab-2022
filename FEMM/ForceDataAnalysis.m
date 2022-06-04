%% DATA ANALYSIS %%
% Small script for representation of the force simulation's output data.

clear
clc
close all

%% MEASURED VALUES %%

% Simulation results
load('simulationResults.mat')
forceArray = -forceArray(:, :);
N_delta = length(deltas);
N_I = length(I);

% Other parameters
m = 0.83474;                                % mass
Lfe = 0.048*2 + 2*(0.093-0.028) + 2*0.028;  % ferrite length
N = 860;                                    % No of spires
Lb = 0.028;                                 % Height of section
Pb = 0.028;                                 % Depth of section
cr = 1850;                                  % ferrite rel. permeability
u0 = 4*pi*10^(-7);                          % vacuum permeability

%% THEORETICAL FORCE COMPUTATION %%

As = Lb*Pb;         % section area
k = u0*As*(N^2);
formulaForceArray = zeros(N_delta, N_I);
for i = 1:N_delta
    for j = 1:N_I
        formulaForceArray(i, j) = k*I(j)^2/(Lfe/cr + deltas(i)/100)^2;
        % 4375/13440
    end
end

%% PLOTTING %%

tiledlayout(2, 2)

nexttile
surf(I, deltas, forceArray)
title("F.E.M.M.  Force Simulation Plot")
xlabel('Current [A]')
ylabel('Air Gap [cm]')
zlabel("Force [N]")

nexttile
surf(I, deltas, formulaForceArray)
title("Magnetic Circuit Formula Plot")
xlabel('Current [A]')
ylabel('Air Gap [cm]')
zlabel("Force [N]")

nexttile
surf(I, deltas, forceArray-formulaForceArray)
title("Difference Between Models")
xlabel('Current [A]')
ylabel('Air Gap [cm]')
zlabel("Force [N]")

nexttile
surf(I, deltas, formulaForceArray./forceArray)
title("Ratio Between Models")
xlabel('Current [A]')
ylabel('Air Gap [cm]')
zlabel("Force Ratio")


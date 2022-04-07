%% DATA ANALYSIS %%
% Small script for representation of the force simulation's output data.

clear
clc
close all

load('results.mat')
forceArray = -forceArray(:, :);
N_delta = length(deltas);
N_I = length(I);

m = 0.83474;

Lfe = 0.048*2 + 2*(0.093-0.028) + 2*0.028;
N = 860;
Lb = 0.028;
Pb = 0.028;
cr = 1850;
u0 = 4*pi*10^(-7);

As = Lb*Pb;
k = u0*As*(N^2);

formulaForceArray = zeros(N_delta, N_I);
for i = 1:N_delta
    for j = 1:N_I
        formulaForceArray(i, j) = 4375/13440*k*I(j)^2/(Lfe/cr + deltas(i)/100)^2;
    end
end

eqforce = m*9.81;
equilibriumArray = zeros(N_delta, N_I);
for i = 1:N_delta
    for j = 1:N_I
        equilibriumArray(i, j) = eqforce;
    end
end

tiledlayout(3, 2)

nexttile
h=gca;
surf(I, deltas, forceArray)
title("F.E.M.M. Simulation Results")
xlabel('Current [A]')
ylabel('Air Gap [cm]')
zlabel("Force [N]")
%set(h, 'zscale', 'log')

nexttile
zdiff = forceArray-equilibriumArray;
C = contour(deltas, I, transpose(zdiff), [0 0]);
title("Simulation Equilibrium")
ylabel('Current [A]')
xlabel('Air Gap [cm]')
% Extract the x- and y-locations from the contour matrix C.

nexttile
h=gca;
surf(I, deltas, formulaForceArray)
title("Formula Results")
xlabel('Current [A]')
ylabel('Air Gap [cm]')
zlabel("Force [N]")
%set(h, 'zscale', 'log')

nexttile
zdiff2 = formulaForceArray-equilibriumArray;
C2 = contour(deltas, I, transpose(zdiff), [0 0]);
title("Formula Equilibrium")
ylabel('Current [A]')
xlabel('Air Gap [cm]')
% Extract the x- and y-locations from the contour matrix C.

nexttile
h=gca;
surf(I, deltas, forceArray-formulaForceArray)
title("Difference Between Simulation and Formula")
xlabel('Current [A]')
ylabel('Air Gap [cm]')
zlabel("Force [N]")
%set(h, 'zscale', 'log')


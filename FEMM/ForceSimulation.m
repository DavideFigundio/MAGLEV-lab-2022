%% FORCE SIMULATION %%
% This matlab script takes the F.E.M.M. model generated with the script
% FEMMsetup and computes the attractive force for different values of the
% excitation current and the air gap.

clear
clc
close all
openfemm
opendocument('Simulation.FEM')

%% SIMULATION PARAMETERS %%
BarXinitial = 9.1;
BarY = 4;

% Generation of a vector of air gap values [cm]
delta_in = 0.1; %% Do not modify this
deltaMax = 2;
N_delta = 40;
deltas = linspace(delta_in, deltaMax, N_delta);

% Generation of a vector of current values [A]
Imin = 0;
Imax = 5;
N_I = 100;
I = linspace(Imin, Imax, N_I);

%% COMPUTATION %%
forceArray = zeros(N_delta-1, N_I);

% Iteration over values of delta and I 
for i=2:N_delta
    mi_selectgroup(1)
    mi_movetranslate(deltas(i)-deltas(i-1), 0)
    BarX = BarXinitial + deltas(i);

    for j = 1:N_I
        forceArray(i-1, j) = computeForce(I(j), BarX, BarY);
    end

end

% Resetting initial position at the end of the simulation
mi_selectgroup(1)
mi_movetranslate(deltas_in-deltaMax, 0)
mi_saveas('Simulation.FEM')

function magneticForce = computeForce(I, x, y)
    mi_modifycircprop('Coil Circuit', 1, I)
    mi_saveas('Simulation.FEM')
    mi_analyze()
    mi_loadsolution
    mo_selectblock(x, y)
    magneticForce = mo_blockintegral(18);
end
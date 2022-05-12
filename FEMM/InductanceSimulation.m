%% INDUCTANCE SIMULATION %%
% This matlab script takes the F.E.M.M. model generated with the script
% FEMMsetup and computes the coil inductance for different values of the
% excitation current and the air gap.

clear
clc
close all
openfemm
opendocument('Simulation.FEM')

%% SIMULATION PARAMETERS %%

% Generation of a vector of air gap values [cm]
delta_in = 0.1; %% Do not modify this
deltaMax = 2;
N_delta = 40;
deltas = linspace(delta_in, deltaMax, N_delta);

% Generation of a vector of relative permeability values
umin = 1500;
umax = 2500;
N_u = 40;
u = linspace(umin, umax, N_u);

%% COMPUTATION %%
inductanceArray = zeros(N_delta, N_u);

% Iteration over values of delta and I
mi_modifycircprop('Coil Circuit', 1, 2) % Sets current to 2A, but works for any values !=0
for j = 1:N_u
    inductanceArray(1, j) = computeInductance(u(j));
end

for i=2:N_delta
    mi_selectgroup(1) % Group 1 corresponds to the mobile bar
    mi_movetranslate(deltas(i)-deltas(i-1), 0)

    for j = 1:N_u
        inductanceArray(i, j) = computeInductance(u(j));
    end

end


save("inductanceResults.mat","deltas", "u", "inductanceArray")

% Resetting initial conditions at the end of the simulation
mi_selectgroup(1)
mi_movetranslate(delta_in-deltaMax, 0)
mi_modifymaterial('Ferrite', 1, 1850)
mi_modifymaterial('Ferrite', 2, 1850)
mi_saveas('Simulation.FEM')

function inductance = computeInductance(u)
% Function that computes the inductance using FEMM commands
    
    % Setting permeability for the ferrite
    mi_modifymaterial('Ferrite', 1, u)  %Corresponds to mobile bar
    mi_modifymaterial('Ferrite', 2, u)  %Corresponds to fixed electromagnet
    
    % Simulates and loads results
    mi_saveas('Simulation.FEM')
    mi_analyze()
    mi_loadsolution
    mo_groupselectblock()   % Selects all blocks since no params are specified

    % Computes inductance from the magnetic field energy: L = 2*E/(I^2)
    % Giving mo_blockintegral 2 as a parameter selects the magnetic energy
    inductance = 2*mo_blockintegral(2)/4;   % considers 2A current > I^2=4
end
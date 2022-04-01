%% F.E.M.M. SETUP %%
% This Matlab script performs construction of the model in Finite Element
% Method Magnetics, starting from the specified parameters. This model can
% then be used for simulation by other scripts.

clear
clc
close all

openfemm                            % F.E.M.M. initialization
create(0)                           % Sets F.E.M.M. to "Magnetic Problem'
saveFileName = 'Simulation.FEM';    % Sets name of the file created

%% MODEL PARAMETERS %%

% Geometric parameters [cm]
depth = 3;              % Model depth
U_len = 9.3;            % Length of the U-bar
U_hig = 7.6;            % Height of the U-bar
U_thi = 2.8;            % Thickness of the U-bar
Bar_len = 9.3;          % Length of the mobile bar
Bar_thi = 2.8;          % Thickness of the mobile bar
Coil_thi = 1.55;        % Thickness of the coil windings
Coil_hig = 4.2;         % Height of the coil windings
delta_in = 0.1;         % Initial air gap value
BoundaryLimit = 15;     % Sets distance of boundary conditions for simulation

% Material parameters
mi_getmaterial('Air')
mi_addmaterial('Ferrite', 1850, 1850, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
mi_getmaterial('18 AWG') % Coil winding wire thickness (=~1mm)

% Other parameters
I0 = 0;                 % Initial excitation current [A]
N = 430;                % Number of spires per winding

%% INITIAL GENERATION %%

mi_probdef(0, 'centimeters', 'planar', 1E-8, depth, 30, 0)  % Problem Definiton
mi_addcircprop('Coil Circuit', I0, 1)
mi_makeABC(5, BoundaryLimit, U_hig/2, U_len/2, 0)

Air_node = setBlockProperties(-1, -1, 'Air', '<None>', 0, 1);

%% SHAPE GENERATION %%

% Generation of the U-bar
U_coords = [  
    0,0;
    U_hig, 0;
    U_hig, U_thi;
    U_thi, U_thi;
    U_thi, U_len-U_thi;
    U_hig, U_len-U_thi;
    U_hig, U_len;
    0, U_len];
mi_drawpolygon(U_coords)

% Generation of the mobile bar
Bar_coords = [
    U_hig+delta_in, 0;
    U_hig+Bar_thi+delta_in, 0;
    U_hig+Bar_thi+delta_in, Bar_len;
    U_hig+delta_in, Bar_len];
mi_drawpolygon(Bar_coords)

% Generation of the 4 coil blocks
Coil1_coords = [
    U_hig-Coil_hig, -Coil_thi;
    U_hig, -Coil_thi;
    U_hig, 0;
    U_hig-Coil_hig, 0];
Coil2_coords = [
    U_hig-Coil_hig, U_thi;
    U_hig, U_thi;
    U_hig, U_thi+Coil_thi;
    U_hig-Coil_hig, U_thi+Coil_thi];
Coil3_coords = [
    U_hig-Coil_hig, U_len-U_thi-Coil_thi;
    U_hig, U_len-U_thi-Coil_thi;
    U_hig, U_len-U_thi;
    U_hig-Coil_hig, U_len-U_thi];
Coil4_coords = [
    U_hig-Coil_hig, U_len;
    U_hig, U_len;
    U_hig, U_len+Coil_thi;
    U_hig-Coil_hig, U_len+Coil_thi];

mi_drawpolygon(Coil1_coords)
mi_drawpolygon(Coil2_coords)
mi_drawpolygon(Coil3_coords)
mi_drawpolygon(Coil4_coords)

%% BLOCK PROPERTIES %%

U_label_coords = setBlockProperties(U_thi/2, U_thi/2, 'Ferrite', '<None>', 0, 1);     % Sets U_bar block properties
Bar_label_coords = setBlockProperties(U_hig+Bar_thi/2+delta_in, Bar_len/2, 'Ferrite', '<None>', 1, 1);   % Sets the mobile bar block properties
Coil1_label_coords = setBlockProperties(U_hig-Coil_hig/2, -Coil_thi/2, '18 AWG', 'Coil Circuit', 0, -N);   % Sets coil properties
Coil2_label_coords = setBlockProperties(U_hig-Coil_hig/2, U_thi+Coil_thi/2, '18 AWG', 'Coil Circuit', 0, N);
Coil3_label_coords = setBlockProperties(U_hig-Coil_hig/2, U_len-U_thi-Coil_thi/2, '18 AWG', 'Coil Circuit', 0, N);
Coil4_label_coords = setBlockProperties(U_hig-Coil_hig/2, U_len+Coil_thi/2, '18 AWG', 'Coil Circuit', 0, -N);

%% GROUPING OF BAR ELEMENTS %%

for i=1:4
    coords = Bar_coords(i,:);
    mi_selectnode(coords);
    mi_setnodeprop(0, 1)
    mi_clearselected
end

mi_saveas('Simulation.FEM')


function coordinates = setBlockProperties(x, y, material, circuit, group, turns)
% Function that sets material properties at the specified coordinates.
    coords = [x, y];
    mi_addblocklabel(coords)

    mi_clearselected
    mi_selectlabel(coords);
    mi_setblockprop(material, 1, 1, circuit, 0, group, turns)
    mi_clearselected
    
    coordinates = coords;
end







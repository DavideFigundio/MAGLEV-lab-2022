clear all
close all
clc

%%
m = 0.7; % [kg]
R = 3.5; % [ohm]
N = 2*860; % [-]
Lb = 0.03; 
Pb = 0.03;
d0 = 0.0145;
u0 = 4*pi*1e-7;
cr = 700;
x0 = 0;
Lfe = 0.2791;
conversion_V2mm=17.8/(3540-260);
%%
As = Lb*Pb;
ur = cr*u0;
k = u0*As*(N^2);
I = sqrt((m*9.81*(Lfe/cr+2*(d0))^2)/(k));
parameter = [m,R,N,Lb,Pb,d0,u0,cr,x0,Lfe,ur,As];

V_vect = [5,5,5,5,5,5,5];
I_vect = fliplr([0.46,0.66,0.725,0.86,0.925,1.005,1.01]);
x_vect = fliplr([0,1.8,2.4,6.56,9.99,14.04,17.8]);
L_vect=sqrt((V_vect./I_vect).^2 - R^2)./31.4;
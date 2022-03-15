clear all
close all
clc
%%
R = 3.7;
V_vect = [5,5,5,5,5,5,5];
I_vect = [0.46,0.66,0.725,0.86,0.925,1.005,1.01];
x_vect = [0,1.8,2.4,6.56,9.99,14.04,17.8];
L_vect=sqrt((V_vect./I_vect).^2 - R^2)./31.4;
% Plot the data for the fast heating of the superconductor
clear; close all; clc;

% import data
fastR=importdata('fastHeatR.csv');
fastV=importdata('fastHeatV.csv');

% Convert voltage to temperature
Voff=0.000366;
Vo=0.460024;
a0=-0.002698;
fastT=(fastV+Voff-Vo)./a0+273;

% initialize time array
time=linspace(0,100,length(fastR));

% plot the data
%plot(time,fastV,'r-',time,fastR,'b-',fastV,fastR,'k-')
figure
plot(fastT,fastR,'b-')
title('Resistance vs Temperature')
legend('Resistance')
xlabel('T')
ylabel('R')

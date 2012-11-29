% Plot the data for the fast heating of the superconductor
clear;  clc;

% import data
slowR=importdata('slowHeatR.csv');
slowV=importdata('slowHeatV.csv');

% Convert voltage to temperature
Voff=0.000366;
Vo=0.460024;
a0=-0.002698;
slowT=(slowV+Voff-Vo)./a0+273;

% initialize time array
time2=linspace(0,1000,length(slowR));

% plot the data
%plot(time,slowV,'r-',time,slowR,'b-',slowV,slowR,'k-')
%figure
figure
plot(slowT,slowR,'r-')
title('Slow Scan: Resistance vs Temperature')
legend('Resistance')
xlabel('T')
ylabel('R')

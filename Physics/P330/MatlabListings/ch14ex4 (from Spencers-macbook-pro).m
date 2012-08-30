clear; close all;
% build a time series made up of 5 different frequencies
% then use ft.m to display the spectrum

N=2^14;
tau=6000/N;
t=0:tau:(N-1)*tau;

% Notice that the w array is different than before
dw=2*pi/(N*tau);
w = -(N/2)*dw:dw:dw*(N/2-1);

% Make a signal consisting of angular frequencies
% w=1, 3, 3.5, 4, and 6
f=cos(t)+.5*cos(3*t)+.4*cos(3.5*t)+.7*cos(4*t)+.2*cos(6*t);

% Use our new function to calculate the fourier transform
% which needs to be saved as ft.m
g = ft(f,tau);
P = abs(g).^2;

figure
plot(w,P)
xlabel('\omega')
ylabel('P(\omega)')
title('Power Spectrum with peaks at all the right frequencies')

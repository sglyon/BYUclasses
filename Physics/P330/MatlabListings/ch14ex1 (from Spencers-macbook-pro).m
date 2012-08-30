clear; close all;

% Build a time series made up of 5 different frequencies
% then use fft to display the spectrum
N=2^14;
tau=6000/N;
t=0:tau:(N-1)*tau;

% Make a signal consisting of angular frequencies
% w=1, 3, 3.5, 4, and 6
f=cos(t)+.5*cos(3*t)+.4*cos(3.5*t)+.7*cos(4*t)+.2*cos(6*t);

% the time plot is very busy and not very helpful
plot(t,f)
title('Time Series')

% now take the fft and display the power spectrum
g=fft(f);
P=abs(g).^2;
dw=2*pi/(N*tau);
w=0:dw:2*pi/tau-dw;

figure
plot(w,P)
xlabel('\omega')
ylabel('P(\omega)')
title('Power Spectrum, including aliased points')

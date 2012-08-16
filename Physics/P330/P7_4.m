clear; close all; clc;

% Build a time series made up of 5 different frequencies
% then use fft to display the spectrum
N=2^14;
tau=6000/N;
t=0:tau:(N-1)*tau;

% Make a signal consisting of angular frequencies
% w=1, 3, 3.5, 4, and 6
f=sin(t)+.5*sin(3*t)+.4*sin(3.01*t)+.7*sin(4*t)+.2*sin(6*t);

alpha1 = 1;
alpha2 = 10;
alpha3 = 0.1;
alpha4 = 25;

win1 = window(@gausswin,length(f),alpha1)';  % TODO: Define alpha
win2 = window(@gausswin,length(f),alpha2)';  % TODO: Define alpha
win3 = window(@gausswin,length(f),alpha3)';  % TODO: Define alpha
win4 = window(@gausswin,length(f),alpha4)';  % TODO: Define alpha
f1 = f .* win1;
f2 = f .* win2;
f3 = f .* win3;
f4 = f .* win4;

% the time plot is very busy and not very helpful
plot(t,f)
title('Time Series')

% now take the fft and display the power spectrum
g=fft(f);
P=abs(g).^2;
dw=2*pi/(N*tau);
w=0:dw:2*pi/tau-dw;

g4 = fft(f4);
P4 = abs(g4) .^ 2;


figure
plot(w, P/max(P))
xlabel('\omega')
ylabel('P(\omega)')
title('Power Spectrum, including aliased points')


figure
plot(w, P4/max(P4))
xlabel('\omega')
ylabel('P(\omega)')
title('STUFF Power Spectrum, including aliased points')

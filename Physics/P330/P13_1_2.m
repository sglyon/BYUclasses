%%
close all; clc; clear;

%% 13.1
F1 = @(x) -((2*tanh(3 * x / 2) ./ (3*(cosh(3.*x/2)).^2)))
U = @(x) -(2/9)*(sech(3*x ./2)).^2;
xe1 = linspace(-3,3,100);
plot(xe1,F1(xe1),'r-',xe1, U(xe1),'b-')

%% 13.2
syms x
xe2 = linspace(-.8,.8,100);
F1t = taylor(-((2*tanh(3 * x / 2) ./ (3*(cosh(3.*x/2)).^2))) ,x ,'Order', 8)
sinapprox = taylor(sin(x),x,'Order',8)
% note that the harmonic oscillator has frequency 1

% this makes our taylor series plotable
f1t = matlabFunction(F1t);
plot(xe2,f1t(xe2))

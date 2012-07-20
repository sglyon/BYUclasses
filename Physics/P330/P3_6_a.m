clear;
clc;
close all;
f = inline('exp(-abs(x-sin(y))).*(1+1/5.*cos(x./2)).*((1+4)./(3+10.*y.^2))', 'x','y');
[X, Y] = meshgrid(linspace(-5,5,40), linspace(-6,6,40));
F = f(X,Y);
surf(X,Y, F)

function [x,psi,E] = SquareWell(n,a,NPoints)
% Calculate the energy and wavefunction for an
% electron in an infinite square well
%
% Inputs: n is the energy level; must be a positive integer
%         a is the well width in nanometers
%         NPoints is the number of points in the x grid
%
% Outputs: x is the grid for the plot, measured in nanometers
%          psi is the normalized wave function
%          E is the energy of the state in electron-volts

% Make the x-grid
xmin = 0;
xmax = a;
x = linspace(xmin,xmax,NPoints);

% Wave number for this energy level
k = n * pi / a;

% Calculate the wave function
psi = sqrt(2/a) * sin(k*x);

% Constants in MKS units
hbar = 1.05e-34;
m=9.11e-31;

% Calculate energy in electron-volts
E = n^2*pi^2*hbar^2 / (2*m*(a*1e-9)^2) / 1.6e-19;

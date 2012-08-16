clear; close all;

% remember that n must be a positive integer
n=3;

% Set the width to an Angstrom
a=0.1;

% Get the values
[x,psi,Energy] = SquareWell(n,a,100);

% Make the plot and label it
plot(x,psi)
s=sprintf('\\Psi_%g(x); a=%g nm; Energy=%g eV',n,a,Energy);
title(s);
xlabel('x (nm)');
ylabel('\Psi(x)');

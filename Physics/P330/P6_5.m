clear; clc;

% Declare w0 global and set it
global w0 alpha wt;
w0 = 1;
alpha = 0.1;
wt = 1;

% Set time bounds
tstart = 0; tfinal = 2 * pi / w0 * 30;

u0 = zeros(2, 1)  % initial conditions
u0(0) = 0
u0(1) = 0

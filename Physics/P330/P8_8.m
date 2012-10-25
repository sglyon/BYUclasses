clear; close all; clc;

global L0 gamma g w0 DL wp

L0 = 2;
gamma = 0.1;
g = 9.8;
w0 = 1;
DL = 0.2;
wp = 2;


% Set time bounds
tstart = 0; tfinal = 800;
times = linspace(tstart, tfinal, 1000);

u0 = zeros(3, 1);  % initial conditions are both zero in this problem
u0(2) = 1;

% Set options and solve the system using ode45
options = odeset('RelTol', 1e-8);
[te, u] = ode45(@rhs8_8, times, u0, options);

xe = u(:, 1);
we = u(:, 2);
ae = u(:, 3);

clear; clc; close all;

global alpha w0squared wPhi gamma

% Define constants
g = 9.8;
l1 = 2;
m1 = 10;
m2 = 10;
m3 = 10;
l2 = 0.5;
l3 = 0.5;
A = 0.5;
gamma = 0.1;
M = m1 + m2 + m3;

I1 = M * l1 ^ 2;
I2 = m2 * l2 ^ 2 + m3 * l3 ^ 2;

w0squared = (M * g * l1) / (I1 + I2);
w0 = sqrt(w0squared);
wPhi = w0;
wp = w0;
alpha = (I2 * A * wPhi ^ 2) / (I1 + I2);

% Set time bounds
tstart = 0; tfinal = 800;
times = linspace(tstart, tfinal, 1000);

u0 = zeros(2, 1);  % initial conditions are both zero in this problem

% Set options and solve the system using ode45
options = odeset('RelTol', 1e-8);
[te, u] = ode45(@rhs8_2, times, u0, options);

xe = u(:, 1);
omega = u(:, 2);

plot(te, xe);
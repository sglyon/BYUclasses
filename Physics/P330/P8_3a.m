clear; clc; close all;

global w0 gamma epsilon wp

% Define constants
% w0 = 1;
% gamma = 0;
% epsilon = 0.1;
% wp = 1.1;

w0 = 1;
gamma = 0;
epsilon = 0.1;
wp = 1;

% Set time bounds
tstart = 0; tfinal = 800;
times = linspace(tstart, tfinal, 1000);

u0 = zeros(2, 1);  % initial conditions are both zero in this problem
u0(2) = 1;

% Set options and solve the system using ode45
options = odeset('RelTol', 1e-8);
[te, u] = ode45(@rhs8_3, times, u0, options);

xe = u(:, 1);
ve = u(:, 2);

plot(te, xe);
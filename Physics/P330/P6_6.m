clear; clc;

% Declare w0 global and set it
global w0 alpha wt gamma;
w0 = 1;
alpha = 0.1;
wt = 1;
gamma = - 0.1;

% Set time bounds
tstart = 0; tfinal = 500;
times = linspace(tstart, tfinal, 1000);

u0 = zeros(2, 1);  % initial conditions are both zero in this problem

% Set options and solve the system using ode45
options = odeset('RelTol', 1e-8);
[t, u] = ode45(@rhs6_6, times, u0, options);

theta = u(:, 1);
omega = u(:, 2); 

plot(times, theta);
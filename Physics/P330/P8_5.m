clear; clc; close all;

global w0 gamma epsilon wp

% Define constants
% w0 = 1;
% gamma = 0;
% epsilon = 0.1;
% wp = 1.1;

w0 = 1;
gamma = 0;
epsilon = 0.3;
wp = 1.3;

% Set time bounds
tmin = 0; tmax = 500;
N = 2 ^ 14;
t0 = tmax / 2;
tau = tmax / N;
times = tmin: tau: tmax - tau ;

dw = 2 * pi / (N * tau);
w = -(N / 2) * dw : dw : dw * (N / 2 - 1); % (angular frequency, radians/sec)

u0 = zeros(2, 1);  % initial conditions are both zero in this problem
u0(2) = 1;

% Set options and solve the system using ode45
options = odeset('RelTol', 1e-8);
[te, u] = ode45(@rhs8_3, times, u0, options);

xe = u(:, 1);
ve = u(:, 2);

g = ft(xe, tau);
P = abs(g) .^ 2;
semilogy(w, P);
xlim([-10, 10]);
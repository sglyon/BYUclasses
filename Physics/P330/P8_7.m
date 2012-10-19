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

peak0 = ones(1, 2^14) * w0;
peak01 = ones(1, 2^14) * -w0;

peak1 = ones(1, 2^14) * (w0 - wp);
peak2 = ones(1, 2^14) * (w0 + wp);

peak3 = ones(1, 2^14) * (-wp - w0);
peak4 = ones(1, 2^14) * (wp - w0);


peak5 = ones(1, 2^14) * (wp - 3 * w0);
peak6 = ones(1, 2^14) * (3 * w0 - wp);

vline = linspace(10e-4, 10e4, 2^14);
semilogy(w, P, peak0, vline, 'r', peak01, vline, 'r', peak1, vline, 'g', peak2, vline, 'g', peak3, vline, 'k', peak4, vline, 'k', peak5, vline, 'm', peak6, vline, 'm');
xlim([-10, 10]);
clear; close all; clc;

global w0 gamma
w0 = 1;
gamma = .3;

tstart = 0; tfinal = 2^4;
N = 2 ^ 12;
time = linspace(tstart, tfinal, N);

init = [10000; 0];

options = odeset('RelTol', 1e-8);
[t, u] = ode45(@rhs7_5, time, init, options);

y = u(:, 1);
v = u(:, 2);

wd = w0 * sqrt(1 - gamma^2 / w0^2);

omega = fft(y);
P = abs(omega) .^ 2;

tau = time(2) - time(1);
dw = 2 * pi / (N * tau);
w = 0: dw : 2 * pi / tau - dw;

plot(w, P);
xlim([0 2]);
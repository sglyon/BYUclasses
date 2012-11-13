%% Setup
clear; close all; clc;

global A gamma

gamma = 0.4;

N = 2^15;
tstart = 0; tfinal = 1000;
times = linspace(tstart, tfinal, N);

u0 = zeros(2, 1);
u0(1) = 1;

A = 1.3;
options = odeset('RelTol', 1e-6);
[te, u1] = ode45(@rhs9_3c, times, u0, options);

x1 = u1(:,1);
v1 = u1(:,2);

n1 = ceil(.6 * N);
plot(x1(n1:end), v1(n1:end));
xlabel('x'); ylabel('v');
title('Phase diagram with A = 1.3');

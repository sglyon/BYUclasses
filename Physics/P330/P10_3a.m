%% Setup
clear; close all; clc;

N = 2^10;
tstart = 0; tfinal = 500;
times = linspace(tstart, tfinal, N);
tau = times(2) - times(1);
dw=2*pi/(N*tau);
w=0:dw:2*pi/tau-dw;


%% part a
global wc w0

w0 = 1.3;
wc = 0.3;

u0 = zeros(4, 1);  % initial conditions are all zero except theta1
u0(1) = 1.;

options = odeset('RelTol', 1e-5);
[te, u] = ode45(@rhs10_3a, times, u0, options);

th1e = u(:, 1);
th2e = u(:, 2);
w1e = u(:, 3);
w2e = u(:, 4);

figure
subplot(2,1,1);
plot(te,th1e);
title('\theta_1')
ylim([-.4 .4]);
subplot(2,1,2);
plot(te,th2e);
ylim([-.4 .4]);
title('\theta_2')

figure
hold on
plot(te, th1e);
plot(te, th2e, 'r');
title('Synchronizing clocks')
hold off

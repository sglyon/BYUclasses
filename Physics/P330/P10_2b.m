%% Setup
clear; close all; clc;

global wc w0

w0 = 1.3;
wc = 0.3;

%% part b
N = 2^8;
tstart = 0; tfinal = 250;
times = linspace(tstart, tfinal, N);
tau = times(2) - times(1);
dw=2*pi/(N*tau);
w=0:dw:2*pi/tau-dw;

u0 = zeros(4, 1);  % initial conditions are all zero except theta1
u0(1) = 0.3;

options = odeset('RelTol', 1e-5);
[te, u] = ode45(@rhs10_2, times, u0, options);

th1e = u(:, 1);
th2e = u(:, 2);
w1e = u(:, 3);
w2e = u(:, 4);

figure
subplot(2,1,1);
plot(te,th1e);
title('\theta_1')
subplot(2,1,2);
plot(te,th2e);
title('\theta_2')

%% part c
gth1 = fft(th1e);
Pth1 = abs(gth1) .^2;

figure
semilogy(w, Pth1)
title('FT of \theta_1')
% It looks like Tb is btwn. 90-100. That makes wb aobut .069.
% We verified that the peaks were about that far apart.
% From mathematica we expected peaks at w0 and sqrt(-w0^2-2wc^2) We see them!

%% part d
global gam

gam = 0.07;

[~, u2] = ode45(@rhs10_2d, times, u0, options);

th1e2 = u2(:, 1);
th2e2 = u2(:, 2);
w1e2 = u2(:, 3);
w2e2 = u2(:, 4);

figure
subplot(2,1,1);
plot(te,th1e2);
title('\theta_1 for part d')
subplot(2,1,2);
plot(te,th2e2);
title('\theta_2 for part d')

%% part e
global N1

N1 = -0.03;

[~, u3] = ode45(@rhs10_2e, times, u0, options);

th1e3 = u3(:, 1);
th2e3 = u3(:, 2);
w1e3 = u3(:, 3);
w2e3 = u3(:, 4);

figure
subplot(2,1,1);
plot(te,th1e3);
title('\theta_1 for part e')
subplot(2,1,2);
plot(te,th2e3);
title('\theta_2 for part e')


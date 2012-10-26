%% Setup
clear; close all; clc;

global l epsi w0 omega A

l = 1;
epsi = 2;
w0 = 1.3;
omega = 1.4;

N = 2^8;
tstart = 0; tfinal = 500;
times = linspace(tstart, tfinal, N);
tau = times(2) - times(1);
dw=2*pi/(N*tau);
w=0:dw:2*pi/tau-dw;

u0 = zeros(2, 1);  % initial conditions are both zero in this problem

% Set options and solve the system using ode45
options = odeset('RelTol', 1e-5);

A = 0;
[te, u2] = ode45(@rhs9_2, times, u0, options);

x2 = u2(:, 1);
v2 = u2(:, 2);

figure
subplot(2,1,1)
plot(te, x2);
title('x(t) when A = 0');

g2 = fft(x2);
P2 = abs(g2) .^2;

subplot(2,1,2)
semilogy(w, P2 / max(P2));
title('power spectrum when A = 0');

A = 1.22;
[te, u3] = ode45(@rhs9_2, times, u0, options);

x3 = u3(:, 1);
v3 = u3(:, 2);

figure
subplot(2,1,1)
plot(te, x3);
title('x(t) when A = 1.22');

g3 = fft(x3);
P3 = abs(g3) .^2;

subplot(2,1,2)
semilogy(w, P3 / max(P3));
title('power spectrum when A = 1.22');

A = 1.25;
[te, u4] = ode45(@rhs9_2, times, u0, options);

x4 = u4(:, 1);
v4 = u4(:, 2);

figure
subplot(2,1,1)
plot(te, x4);
title('x(t) when A = 1.25');

g4 = fft(x4);
P4 = abs(g4) .^2;

subplot(2,1,2)
semilogy(w, P4 / max(P4));
title('power spectrum when A = 1.25');

A = 1.27;
[te, u5] = ode45(@rhs9_2, times, u0, options);

x5 = u5(:, 1);
v5 = u5(:, 2);

figure
subplot(2,1,1)
plot(te, x5);
title('x(t) when A = 1.27');

g5 = fft(x5);
P5 = abs(g5) .^2;

subplot(2,1,2)
semilogy(w, P5 / max(P5));
title('power spectrum when A = 1.27');

A = 1.28;
[te, u7] = ode45(@rhs9_2, times, u0, options);

x7 = u7(:, 1);
v7 = u7(:, 2);

figure
subplot(2,1,1)
plot(te, x7);
title('x(t) when A = 1.28');

g7 = fft(x7);
P7 = abs(g7) .^2;

subplot(2,1,2)
semilogy(w, P7 ./ max(P7));
title('power spectrum when A = 1.28');

A = 1.4;
[te, u6] = ode45(@rhs9_2, times, u0, options);

x6 = u6(:, 1);
v6 = u6(:, 2);

figure
subplot(2,1,1)
plot(te, x6);
title('x(t) when A = 1.4');

g6 = fft(x6);
P6 = abs(g6) .^2;

subplot(2,1,2)
semilogy(w, P6 / max(P6));
title('power spectrum when A = 1.4');
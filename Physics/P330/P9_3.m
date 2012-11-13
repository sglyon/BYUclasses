%% Setup
clear; close all; clc;

%% Part a
U = @(x) - (x.^2) / 2 + (x .^ 4) / 4;

xx = linspace(-2, 2, 1000);
plot(xx, U(xx));  % Minima at +- 1

%% Part b
N = 2^10;
tstart = 0; tfinal = 40;
times = linspace(tstart, tfinal, N);

% First set of initial conditions
u0 = zeros(2, 1);
u0(1) = -1.2;
u0(2) = .2;

options = odeset('RelTol', 1e-6);
[te, u1] = ode45(@rhs9_3a, times, u0, options);

x1 = u1(:,1);
v1 = u1(:,2);

figure
subplot(2,2,1);
plot(te, x1);
title('position with initial x,v = (-1.2, .2)');

% First set of initial conditions
u0 = zeros(2, 1);
u0(1) = -1.2;
u0(2) = 2;

[~, u2] = ode45(@rhs9_3a, times, u0, options);

x2 = u2(:,1);
v2 = u2(:,2);

subplot(2,2,2);
plot(te, x2);
title('position with initial x,v = (-1.2, 2)');

% Third set of initial conditions
u0 = zeros(2, 1);
u0(1) = 0;
u0(2) = 0;

[~, u3] = ode45(@rhs9_3a, times, u0, options);

x3 = u3(:,1);
v3 = u3(:,2);

subplot(2,2,3);
plot(te, x3);
title('position with initial x,v = (0, 0)');

% Fourth set of initial conditions
u0 = zeros(2, 1);
u0(1) = 0;
u0(2) = 1e-5;

[~, u4] = ode45(@rhs9_3a, times, u0, options);

x4 = u4(:,1);
v4 = u4(:,2);

subplot(2,2,4);
plot(te, x4);
title('position with initial x,v = (0, 0.00001)');

%% Part c
global A gamma

gamma = 0.4;

N = 2^10;
tstart = 0; tfinal = 1000;
times = linspace(tstart, tfinal, N);
tau = times(2) - times(1);
dw = 2 * pi / (N * tau);
w = 0: dw: 2 * pi / tau - dw;

u0 = zeros(2, 1);
u0(1) = 1;

A = .2;
[te, u5] = ode45(@rhs9_3c, times, u0, options);

x5 = u5(:,1);
v5 = u5(:,2);

g5 = fft(x5);
P5 = abs(g5).^2;

figure
subplot(2,2,1)
plot(te, x5);
title('A = .2');

A = .72;
[~, u6] = ode45(@rhs9_3c, times, u0, options);

x6 = u6(:,1);
v6 = u6(:,2);

g6 = fft(x6);
P6 = abs(g6).^2;

subplot(2,2,2)
plot(te, x6);
title('A = .72');

A = .8;
[~, u7] = ode45(@rhs9_3c, times, u0, options);

x7 = u7(:,1);
v7 = u7(:,2);

g7 = fft(x7);
P7 = abs(g7).^2;

subplot(2,2,3)
plot(te, x7);
title('A = .8');


A = .999;
[~, u8] = ode45(@rhs9_3c, times, u0, options);

x8 = u8(:,1);
v8 = u8(:,2);

g8 = fft(x8);
P8 = abs(g8).^2;

subplot(2,2,4)
plot(te, x8);
title('A = .999');

figure
subplot(2,2,1)
semilogy(w, P5 / max(P5));
title('Power spectrum when A = 0.2');

subplot(2,2,2)
semilogy(w, P6 / max(P6));
title('Power spectrum when A = 0.72')

subplot(2,2,3)
semilogy(w, P7 / max(P7));
title('Power spectrum when A = 0.8')

subplot(2,2,4)
semilogy(w, P8 / max(P8));
title('Power spectrum when A = 0.999')

%% Part d
A = 0.9;

u0 = zeros(2, 1);
u0(1) = 1;
[~, u9] = ode45(@rhs9_3c, times, u0, options);

x9 = u9(:,1);
v9 = u9(:,2);

u0 = zeros(2, 1);
u0(1) = 1.000001;
[~, u10] = ode45(@rhs9_3c, times, u0, options);

x10 = u10(:,1);
v10 = u10(:,2);

figure
subplot(3,1,1);
plot(te, x9);
title('When x(0) = 1')

subplot(3,1,2);
plot(te, x10);
title('when x(0) = 1.000001');

subplot(3,1,3)
plot(te, x10 - x9, 'r');
title('Difference between xs at diff initial conditions');
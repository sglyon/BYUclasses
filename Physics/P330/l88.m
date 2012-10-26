clear; close all; clc;

global L0 gamma g w0 DL wp

L0 = 2;
gamma = 0.1;
g = 9.8;
w0 = 1;
DL = .0;
wp = 2;


% Set time bounds
tstart = 0; tfinal = 800;
times = linspace(tstart, tfinal, 1000);

u0 = zeros(3, 1);  % initial conditions are both zero in this problem
u0(2) = 1;

% Set options and solve the system using ode45
%options = odeset('RelTol', 1e-8);
%[te, u] = ode45(@rhs8_8, times, u0, options);

options = odeset('RelTol', 1e-8);
[te1, u1] = ode45(@rhs8_8, times, u0, options);

xe1 = u1(:, 1);
we1 = u1(:, 2);
ae1 = u1(:, 3);

DL = .1;
[te2, u2] = ode45(@rhs8_8, times, u0, options);
xe2 = u2(:, 1);
we2 = u2(:, 2);
ae2 = u2(:, 3);


DL = .2;
[te3, u3] = ode45(@rhs8_8, times, u0, options);
xe3 = u3(:, 1);
we3 = u3(:, 2);
ae3 = u3(:, 3);

DL = .3;
[te4, u4] = ode45(@rhs8_8, times, u0, options);
xe4 = u4(:, 1);
we4 = u4(:, 2);
ae4 = u4(:, 3);

figure;
hold on
subplot(2,2,1)
plot(te1, xe1)
title('DL = 0')

subplot(2,2,2)
plot(te2, xe2)
title('DL = 0.1')

subplot(2,2,3)
plot(te3, xe3)
title('DL = 0.2')

subplot(2,2,4)
plot(te4, xe4)
title('DL = 0.3')

hold off
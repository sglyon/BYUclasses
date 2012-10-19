clear; clc; close all;

global w0 gamma epsilon wp

% Define constants
% w0 = 1;
% gamma = 0;
% epsilon = 0.1;
% wp = 1.1;

w0 = 1;
gamma = 0;
epsilon = 0.1;
wp = 2;

% Set time bounds
tstart = 0; tfinal = 300;
times = linspace(tstart, tfinal, 1000);

u0 = zeros(2, 1);  % initial conditions are both zero in this problem
u0(2) = 1;

% Set options and solve the system using ode45
options = odeset('RelTol', 1e-8);
[te1, u1] = ode45(@rhs8_3, times, u0, options);

xe1 = u1(:, 1);
ve1 = u1(:, 2);

epsilon = 0.15;
[te2, u2] = ode45(@rhs8_3, times, u0, options);
xe2 = u2(:, 1);
ve2 = u2(:, 2);

epsilon = 0.25;
[te3, u3] = ode45(@rhs8_3, times, u0, options);
xe3 = u3(:, 1);
ve3 = u3(:, 2);


epsilon = .5;
[te4, u4] = ode45(@rhs8_3, times, u0, options);
xe4 = u4(:, 1);
ve4 = u4(:, 2);



figure;
hold on
subplot(2,2,1)
plot(te1, xe1)
axis([te1(1) te1(end) -1e5 1e5])
title('epsilon = 0.1')

subplot(2,2,2)
plot(te2, xe2)
axis([te1(1) te1(end) -1e5 1e5])
title('epsilon = 0.15')

subplot(2,2,3)
plot(te3, xe3)
axis([te1(1) te1(end) -1e5 1e5])
title('epsilon = 0.25')

subplot(2,2,4)
plot(te4, xe4)
axis([te1(1) te1(end) -1e5 1e5])
title('epsilon = 0.5')

hold off
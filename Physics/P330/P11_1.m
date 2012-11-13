%% Setup
clear; clc; close all;

global w0 w L b

w0 = 1;
L = 1;
b = 0.02;
w = 30;

% Set time bounds
tstart = 0; tfinal = 30;
times = linspace(tstart, tfinal, 1000);

%% Part a
u0 = zeros(4, 1);  % initial conditions are both zero in this problem
u0(1) = 1;
u0(3) = 1;

% Set options and solve the system using ode45
options = odeset('RelTol', 1e-8);
[te, u] = ode45(@rhs11_1, times, u0, options);

the = u(:, 1);
we = u(:, 2);
THe = u(:, 3);
We = u(:, 4);

figure
hold on
% plot(the, we, 'b', THe, We, 'g');
plot(te, the, te, THe);
legend('exact solution', 'Approximate')
title('Part a: th(0) = 1, thp(0)=0')

%% Part b
b = 0.05;
u0(1) = 3.1;
u0(3) = 3.1;

[~, u2] = ode45(@rhs11_1, times, u0, options);

the2 = u2(:, 1);
we2 = u2(:, 2);
THe2 = u2(:, 3);
We2 = u2(:, 4);

figure
hold on
% plot(the, we, 'b', THe, We, 'g');
plot(te, the2, te, THe2);
legend('exact solution', 'Approximate')
title('Part b: th(0) = 3.1, thp(0)=0')

%% Part c
Tmin = 0; Tmax = 2 * pi; nT = 2 ^8;
Trange = linspace(Tmin, Tmax, nT);

b = 0.01;
V = @(T) - w0^2 .* cos(T) - (b^2 .* w^2 .* cos(T).^2) ./ (4* L^2);

figure

subplot(2,2,1);
plot(Trange, V(Trange));
title('b = 0.01');

b = 0.03;
V = @(T) - w0^2 .* cos(T) - (b^2 .* w^2 .* cos(T).^2) ./ (4* L^2);

subplot(2,2,2);
plot(Trange, V(Trange));
title('b = 0.03');

b = 0.05;
V = @(T) - w0^2 .* cos(T) - (b^2 .* w^2 .* cos(T).^2) ./ (4* L^2);

subplot(2,2,3);
plot(Trange, V(Trange));
title('b = 0.05');

b = 0.07;
V = @(T) - w0^2 .* cos(T) - (b^2 .* w^2 .* cos(T).^2) ./ (4* L^2);

subplot(2,2,4);
plot(Trange, V(Trange));
title('b = 0.07');





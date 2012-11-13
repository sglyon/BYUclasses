clear; close all; clc;

global sigma rho cbeta

cbeta = 8 / 3;
rho = input('enter a value for rho (rho=24 is the answer to this question): ');
sigma = 10;

tstart = 0; tfinal = 50; tpoints = 2^15;
times = linspace(tstart, tfinal, tpoints);

t2start = 0; t2final = 50;
times2 = linspace(t2start, t2final, tpoints);

u0 = zeros(3, 1);  % initial conditions are both zero in this problem
u0(1) = 0.1;
u0(2) = 0.;
u0(3) = 0.1;

% Set options and solve the system using ode45
options = odeset('RelTol', 1e-8);
[te, u] = ode45(@exam2_2_rhs, times, u0, options);

x = u(:, 1);
y = u(:, 2);
z = u(:, 3);
xp = sigma .* (y - x);
yp = x .* (rho - z) - y;
zp = x .* y - cbeta .* z;


figure
plot3(x, y, z)
xlabel('x');
ylabel('y');
zlabel('z');
title('Trajectory of particle')
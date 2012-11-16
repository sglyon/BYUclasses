clear; clc; close all;

global G m1 m2 power

G = 1;
m1 = 1;
m2 = 2;
power = 3;

% Set time bounds
tstart = 0; tfinal = 400; N = 5000;
times = linspace(tstart, tfinal, N);

u0 = zeros(12, 1);  % initial conditions are both zero in this problem
u0(1) = 1;
u0(2) = 0.65;
u0(3) = .5;
u0(4) = .2;
% u0(5) = -0.3;
% u0(6) = 0.1;
u0(7) = -1;
u0(8) = -.45;
u0(9) = -.3;
u0(10) = .3;
% u0(11) = .6;
% u0(12) = -.3;

r0 = [1 + 1, (.5 +.3), 0];
v0 = [(0.65 + 0.45), (0.2 - 0.3), 0];

% Set options and solve the system using ode45
options = odeset('RelTol', 1e-8);
[te, u] = ode45(@rhs12_3, times, u0, options);

x1e = u(:, 1);
vx1e = u(:, 2);
y1e = u(:, 3);
vy1e = u(:, 4);
z1e = u(:, 5);
vz1e = u(:, 6);
x2e = u(:, 7);
vx2e = u(:, 8);
y2e = u(:, 9);
vy2e = u(:, 10);
z2e = u(:, 11);
vz2e = u(:, 12);

r1e = [x1e, y1e, z1e];
r2e = [x2e, y2e, z2e];
v1e = [vx1e, vy1e, vz1e];
v2e = [vx2e, vy2e, vz2e];

Re = (m1 * r1e + m2 * r2e) / (m1 + m2);
Ve = (m1 * v1e + m2 * v2e) / (m1 + m2);
re = r1e - r2e;

s = linspace(0, 2 * pi, 100);
a = 1.91;
b = 0.86;
plot(re(:, 1), re(:, 2), 'b-');
hold on
plot(a * cos(s) + 1.725, b * sin(s) - 0.04  , 'r-')
title('Part a: elipses')

power = 3.1;
[~, u2] = ode45(@rhs12_3, times, u0, options);

x1e2 = u2(:, 1);
vx1e2 = u2(:, 2);
y1e2 = u2(:, 3);
vy1e2 = u2(:, 4);
z1e2 = u2(:, 5);
vz1e2 = u2(:, 6);
x2e2 = u2(:, 7);
vx2e2 = u2(:, 8);
y2e2 = u2(:, 9);
vy2e2 = u2(:, 10);
z2e2 = u2(:, 11);
vz2e2 = u2(:, 12);

r1e2 = [x1e2, y1e2, z1e2];
r2e2 = [x2e2, y2e2, z2e2];
v1e2 = [vx1e2, vy1e2, vz1e2];
v2e2 = [vx2e2, vy2e2, vz2e2];

Re2 = (m1 * r1e2 + m2 * r2e2) / (m1 + m2);
Ve2 = (m1 * v1e2 + m2 * v2e2) / (m1 + m2);
re2 = r1e2 - r2e2;

figure
plot(re2(:, 1), re2(:, 2), 'b-');
title('Part a: precession')

%% Part b
format compact
format long
area1 = sum(re(1001:2000, :), 1)
area2 = sum(re(2001:3000, :), 1)

%% Part c
% period is 9.75. WE got this from the plot
mu = m1 * m2 / (m1 + m2);
E = mu  /2 * norm(v0, 2)^2 - G *m1 * m2 / (norm(r0, 2));

period = pi / sqrt(2) * (sqrt(mu) * G * m1 * m2) / ((-E) ^(3/2))
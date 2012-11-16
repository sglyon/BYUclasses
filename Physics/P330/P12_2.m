clear; clc; close all;

global G m1 m2

G = 1;
m1 = 1;
m2 = 2;

% Set time bounds
tstart = 0; tfinal = 50; N = 5000;
times = linspace(tstart, tfinal, N);

u0 = zeros(12, 1);  % initial conditions are both zero in this problem
u0(1) = 1;
u0(2) = 0.65;
u0(3) = .5;
u0(4) = .2;
u0(5) = -0.3;
u0(6) = 0.1;
u0(7) = -1;
u0(8) = -.45;
u0(9) = -.3;
u0(10) = .3;
u0(11) = .6;
u0(12) = -.3;

% Set options and solve the system using ode45
options = odeset('RelTol', 1e-8);
[te, u] = ode45(@rhs12_1, times, u0, options);

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

%% Part a
r1e = [x1e, y1e, z1e];
r2e = [x2e, y2e, z2e];
v1e = [vx1e, vy1e, vz1e];
v2e = [vx2e, vy2e, vz2e];

Re = (m1 * r1e + m2 * r2e) / (m1 + m2);
Ve = (m1 * v1e + m2 * v2e) / (m1 + m2);
re = r1e - r2e;

figure
plot3(Re(:, 1), Re(:, 2), Re(:, 3));
title('Part a: Re')

figure
plot3(Ve(:, 1), Ve(:, 2), Ve(:, 3));
title('Part a: Ve')

figure
plot3(re(:, 1), re(:, 2), re(:, 3));
title('Part b: re')

L = m1 * cross(r1e - Re, v1e - Ve) + m2 * cross(r2e - Re, v2e - Ve);

figure
plot3(L(:, 1), L(:, 2), L(:, 3));
title('Part c: L')

dot1 = dot(r1e - Re, L, 2);
dot2 = dot(r2e - Re, L, 2);

plot(te, dot1, te, dot2);
title('Part d: dot products')
legend('L dot r1 - R', 'L dot r2 - R')

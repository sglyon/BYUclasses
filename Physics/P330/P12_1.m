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

for n=5:4:N
    plot3(x1e(n-4:n),y1e(n-4:n),z1e(n-4:n), 'b-')
    hold on
    plot3(x2e(n-4:n),y2e(n-4:n),z2e(n-4:n), 'r-')
    axis equal
    pause(0.01)
end
hold off

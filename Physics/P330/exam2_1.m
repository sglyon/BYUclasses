clear; close all; clc;

tstart = 0; tfinal = 10;
times = linspace(tstart, tfinal, 100);

u0 = zeros(3, 1);  % initial conditions are both zero in this problem
u0(2) = -5;
u0  (3) = 8;

% Set options and solve the system using ode45
options = odeset('RelTol', 1e-8);
[te, u] = ode45(@exam2_1_rhs, times, u0, options);

x = u(:, 1);
a = u(:, 2);
b = u(:, 3);

hold on
plot(te, x, 'r*');
plot(te, x, 'k-', 'LineWidth', 1.2);
title('Exam 2 problem 1 solution');
xlabel('t');
ylabel('x');
legend('~', 'x');
hold off

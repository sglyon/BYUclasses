% Spencer Lyon
% Physics 330 Exam 1

% Problem 2
clear; clc; close all;
f = @(x) exp(3 * sin(x)) ;

x = linspace(0, 4 * pi, 200);

f_vals = f(x);
A = max(max(f_vals));

g = @(x) A * sin(x) ;

g_vals = g(x);



figure
axes()
plot(x, f_vals, 'g')
hold on
plot(x, g_vals, 'b--')
legend('f(x)', 'g(x)')
xlabel('x')
ylabel('f(x) or g(x)')
title('Exam Problem 2')
axis([0, 4 * pi + .5, -A - 1, A + 1])
hold off
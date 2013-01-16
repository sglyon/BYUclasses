%----------------------------------------------------------------------------%
% Opening Commands
%----------------------------------------------------------------------------%
close all; clear; clc

%----------------------------------------------------------------------------%
% Part a
%
% For a cell-edge grid, there will be 1 more point than cell. This happens
% because there is a point at the start of each cell and the endpoints are
% included.
%----------------------------------------------------------------------------%
N = 100;  % the number of grid points
a = 0;b = pi;  % the left and right bounds
h = (b - a) / (N - 1);  % calculate the step size
x_edge = a:h:b;  % build the cell-edge spatial grid

f = @(x) sin(x) .* sinh(x);  % Defin

figure  % create new figure
plot(x_edge, f(x_edge));  % plot the function on my grid
title('Part a')

whos('x_edge');

%----------------------------------------------------------------------------%
% Part b
%
% For a cell-center grid, there will be the same number of points and cells.
% This happens because there is a point in the center of each cell
%----------------------------------------------------------------------------%
n2 = 5000;  % Number of points
a2 = 0;  % lower bound
b2 = 2;  % upper bound
h2 = (b2 - a2) /  n2;  % Step size
x_center = a2 + h2 / 2:h2:b2 - h2 / 2;  % centered grid

whos('x_center');

f2 = @(x) cos(x);

figure  % Create new figure
plot(x_center, f2(x_center));
title('Part b');

int_estimate = sum(f2(x_center)) * h2;  % Estimate integral
int_real = quadgk(f2, 0, 2);  % Real integral

abs_int_err = abs(int_real - int_estimate);  % Absolute error in integral
disp('Error in the integral: '); % display the error
disp(abs_int_err);

%----------------------------------------------------------------------------%
% Part c
%
% In order to calculate the derivative at a points x, you need points on
% either side of x. The ghost points give you that.
%----------------------------------------------------------------------------%
n3 = 500;
a3 = 0;
b3 = pi / 2;
h3 = (b3 - a3) / n3;
x_c_ghost = a3 - h3 / 2:h3: b3 + h3 / 2;

whos('x_c_ghost');

f3 = @(x) sin(x);

y3 = f3(x_c_ghost);

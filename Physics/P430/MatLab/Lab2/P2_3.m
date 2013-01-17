%----------------------------------------------------------------------------%
% Opening Commands
%----------------------------------------------------------------------------%
clear; close all; clc;

%----------------------------------------------------------------------------%
% Part a
%
% Solve equation 2.8 with forward difference for derivative B.C.
%----------------------------------------------------------------------------%
n = 30;
xmin = 0; xmax = 2;
h = (xmax - xmin) / (n - 1);
x = xmin: h: xmax;
x = x';

A = zeros(n, n);  % Preallocate memory for A
A(1, 1) = 1;  % Set first row of A
A(n, n - 1: n) = [-1 / h, 1 / h];  % Set last row of A

for jrow = 2: n - 1  % fill in all other rows of A
    A(jrow, jrow - 1: jrow + 1) = [1 / (h ^ 2),  - 2 / (h ^ 2) + 9, 1 / (h ^ 2)];
end

% Create the vector representing x in the matrix equation 2.5
x_approx = zeros(n, 1);  % Preallocate memory for A
x_approx(1) = 0; % Set first row of x_approx
x_approx(n) = 0; % Set last row of x_approx
x_approx(2: n - 1) = x(2: n - 1);  % Fill in all other rows of x_approx

% Solve for y_approx
y_approx = A \ x_approx;

% Get exact solution
y = x / 9 - sin(3 * x ) ./ (27 * cos(6));

figure
plot(x, y_approx, 'r.',  x, y, 'b-')
title('Problem 2.3 part a')
rms_err_a = sqrt(mean(power(y - y_approx, 2)));


%----------------------------------------------------------------------------%
% Part b
%
% Solve equation 2.8 with quadratic extrapolation for derivative B.C.
%----------------------------------------------------------------------------%
A2 = zeros(n, n);  % Preallocate memory for A2
A2(1, 1) = 1;  % Set first row of A2
A2(n, n - 2: n) = [1 / (2 * h), -2 / h, 3 / (2 * h)];  % Set last row of A2

for jrow = 2: n - 1  % fill in all other rows of A2
    A2(jrow, jrow - 1: jrow + 1) = [1 / (h ^ 2),  - 2 / (h ^ 2) + 9, 1 / (h ^ 2)];
end

% Create the vector representing x in the matrix equation 2.5
x_approx2 = zeros(n, 1);  % Preallocate memory for A2
x_approx2(1) = 0; % Set first row of x_approx2
x_approx2(n) = 0; % Set last row of x_approx2
x_approx2(2: n - 1) = x(2: n - 1);  % Fill in all other rows of x_approx2

% Solve for y_approx2
y_approx2 = A2 \ x_approx2;

figure
plot(x, y_approx2, 'r.',  x, y, 'b-')
title('Problem 2.3 part b')
rms_err_a2 = sqrt(mean(power(y - y_approx2, 2)));

printmat([rms_err_a; rms_err_a2], 'RMS with n = 30 for parts a and b', ...
                        'Forward_difference Quadratic_extrapolation', ' ')

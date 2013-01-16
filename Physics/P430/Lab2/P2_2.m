%----------------------------------------------------------------------------%
% Opening Commands
%----------------------------------------------------------------------------%
clear; close all; clc;

%----------------------------------------------------------------------------%
% Part a
%
% Solve equation 2.6 using the linear algebra approach
%----------------------------------------------------------------------------%

% Create cell-edge grid with 100 points.
n = 30;
xmin = 0; xmax = 5;
h = (xmax - xmin) / (n - 1);
x = xmin: h: xmax;
x = x';

% Create matrix A
A = zeros(n, n);  % Preallocate memory for A
A(1, 1) = 1;  % Set first row of A
A(n, n) = 1;  % Set last row of A

for jrow = 2: n - 1  % fill in all other rows of A
    % For readability I compute each element on a separate line and combine
    jx = x(jrow, 1);
    el1 = 1 / (h ^ 2) - 1  / (2 * jx * h);  % for y_{j - 1}
    el2 = - 2 / (h ^ 2) + 1 - 1 / (jx ^ 2);  % for y_{j}
    el3 = 1 / (h ^ 2) + 1  / (2 * jx * h);  % for y_{j + 1}
    A(jrow, jrow - 1: jrow + 1) = [el1, el2, el3];
end

% Create vector to represent x in the matrix equation
x_approx = zeros(n, 1);  % Preallocate memory for A
x_approx(1) = 0; % Set first row of x_approx
x_approx(n) = 1; % Set last row of x_approx
x_approx(2: n - 1) = x(2: n - 1);  % Fill in all other rows of x_approx

% Solve the matrix equation
y_approx = A \ x_approx;

% Compute the exact solution
y = - 4 / besselj(1, 5) .* besselj(1, x) + x;

% plot the solution
figure
plot(x, y_approx, 'r.', x, y, 'b');
title('Plot for part a')


%----------------------------------------------------------------------------%
% Part b
%
% Solve equation 2.7 using the linear algebra approach
%----------------------------------------------------------------------------%
% Create cell-edge grid with 100 points.
n2 = 200;
xmin2 = 0; xmax2 = 5;
h2 = (xmax2 - xmin2) / (n2 - 1);
x2 = xmin2: h2: xmax2;
x2 = x2';

% Create matrix A
A2 = zeros(n2, n2);  % Preallocate memory for A2
A2(1, 1) = 1;  % Set first row of A2
A2(n2, n2) = 1;  % Set last row of A2

for jrow = 2: n2 - 1  % fill in all other rows of A2
    % For readability I compute each element on a2 separate line and combine
    jx = x2(jrow, 1);
    el1 = 1 / (h2 ^ 2) - sin(jx) / (2 * h2);  % for y_{j-1}
    el2 = - 2 / (h2 ^ 2) + exp(jx);  % for y_{j}
    el3 = 1 / (h2 ^ 2) + sin(jx) / (2 * h2);  % for y_{j + 1}
    A2(jrow, jrow - 1: jrow + 1) = [el1, el2, el3];
end

% Create vector to represent x2 in the matrix equation
x_approx2 = zeros(n2, 1);  % Preallocate memory for A2
x_approx2(1) = 0; % Set first row of x_approx2
x_approx2(n2) = 3; % Set last row of x_approx2
x_approx2(2: n2 - 1) = x2(2: n2 - 1);  % Fill in all other rows of x_approx2

% Solve the matrix equation
y_approx2 = A2 \ x_approx2;

figure
plot(x2, y_approx2);
title('Plot for part b')

inds = find(x2 > 4.5);
close_to_4half = y_approx2(inds(1:2) - 1);
disp('From Mathematica y(4.5) = 8.72062');
disp('From MatLab the (x,y) data around 4.5 is: ')
printmat([x2(inds(1:2) - 1) y_approx2(inds(1:2) - 1)], 'MatLab data', '  ', 'x y');

%----------------------------------------------------------------------------%
% Opening Commands
%----------------------------------------------------------------------------%
clear; close all; clc;

%----------------------------------------------------------------------------%
% Part a
%
% We can't turn this into a linear algebra problem because of the fact that
% y(x) is embedded inside the sin() function.
%----------------------------------------------------------------------------%

%----------------------------------------------------------------------------%
% Part b
%
% Solve equation 2.13 with linear algebra methods inside an iterative loop.
%----------------------------------------------------------------------------%

% Make edge centered grid
n = 50;
xmin = 0; xmax = 3;
h = (xmax - xmin) / (n - 1);
x = xmin: h: xmax;
x = x';

% Create A matrix
A = zeros(n, n);  % Preallocate memory for A
A(1, 1) = 1;  % Set first row of A
A(n, n) = 1;  % Set last row of A

for jrow = 2: n - 1  % fill in all other rows of A
    A(jrow, jrow - 1: jrow + 1) = [1 / (h ^ 2), - 2 / (h ^ 2), 1 / (h ^ 2)];
end

% Setup iteration variables
toler = 1e-8;  % convergence criterion
max_iter = 500;  % Max number of iterations
iter = 0;  % iteration number counter
dist = 500;  % starting norm

% define initial y(x)
y_old = zeros(n, 1);

while iter < max_iter && dist > toler
    b = 1 - sin(y_old);  % Create b using y_old
    b(1) = 0;
    b(end) = 0;
    y = A \ b;  % Solve linear problem for y

    % Create y'' and check the norm
    dist = norm(A * y - 1 + sin(y), 2);

    % Set y_old equal to the y created on this iteration and update iter
    y_old = y;
    iter = iter + 1;
end

% Plot results
figure
plot(x, y)
title('Solution to 2.4 part b')

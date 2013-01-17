%----------------------------------------------------------------------------%
% Opening Commands
%----------------------------------------------------------------------------%
clear; close all; clc;

%----------------------------------------------------------------------------%
% Part a
%
% Create a cell edge grid witn n = 30 points from x = 0 to x = 2.
%----------------------------------------------------------------------------%
n = 30;
xmin = 0; xmax = 2;
h = (xmax - xmin) / (n - 1);
x = xmin: h: xmax;
x = x';


%----------------------------------------------------------------------------%
% Part b
%
% Solve boundary value problem in mathematica, use ToMatlab to get the
% solution in MatLab, then plot the solution using a blue curve.
%----------------------------------------------------------------------------%
y = (1/24).*((-2).*cos(3.*x).*sin(2.*x)+(-4).*cos(2).^2.*sin(3.*x)+ ...
cos(8).*sin(3.*x)+4.*cos(x).^2.*sin(3.*x)+(-1).*cos(4.*x).*sin(3.* ...
  x)+24.*csc(6).*sin(3.*x)+2.*cot(6).*sin(4).*sin(3.*x)+(-1).*cot(6) ...
  .*sin(8).*sin(3.*x)+cos(3.*x).*sin(4.*x));

figure
hold on
plot(x, y, 'b');

%----------------------------------------------------------------------------%
% Part c
%
% Solve the boundary value problem using the linear algebra technique
% summarized in equation 2.5 then plot the solution using red dots.
% Then repeat the process with N = 100 instead of N = 30
%----------------------------------------------------------------------------%

% Create the vector representing x in the matrix equation 2.5
A = zeros(n, n);  % Preallocate memory for A
A(1, 1) = 1;  % Set first row of A
A(n, n) = 1;  % Set last row of A

for jrow = 2: n - 1  % fill in all other rows of A
    A(jrow, jrow - 1: jrow + 1) = [1 / (h ^ 2),  - 2 / (h ^ 2) + 9, 1 / (h ^ 2)];
end

% Create the vector representing x in the matrix equation 2.5
x_approx = zeros(n, 1);  % Preallocate memory for A
x_approx(1) = 0; % Set first row of x_approx
x_approx(n) = 1; % Set last row of x_approx
x_approx(2: n - 1) = sin(x(2: n - 1));  % Fill in all other rows of x_approx

% Solve for y_approx
y_approx = A \ x_approx;

% Plot the solution
plot(x, y_approx, 'r.');
title('Exact and approximate with n = 30')
hold off

% Do it again with N = 100
n2 = 100;
xmin = 0; xmax = 2;
h2 = (xmax - xmin) / (n2 - 1);
x2 = xmin: h2: xmax;
x2 = x2';

y = (1/24).*((-2).*cos(3.*x2).*sin(2.*x2)+(-4).*cos(2).^2.*sin(3.*x2)+ ...
cos(8).*sin(3.*x2)+4.*cos(x2).^2.*sin(3.*x2)+(-1).*cos(4.*x2).*sin(3.* ...
  x2)+24.*csc(6).*sin(3.*x2)+2.*cot(6).*sin(4).*sin(3.*x2)+(-1).*cot(6) ...
  .*sin(8).*sin(3.*x2)+cos(3.*x2).*sin(4.*x2));

figure
hold on
plot(x2, y, 'b');

A2 = zeros(n2, n2);
A2(1, 1) = 1;
A2(n2, n2) = 1;

for jrow = 2: n2 - 1
    A2(jrow, jrow - 1: jrow + 1) = [1 / (h2 ^ 2),  - 2 / (h2 ^ 2) + 9, 1 / (h2 ^ 2)];
end

x_approx2 = zeros(n2, 1);
x_approx2(1) = 0;
x_approx2(n2) = 1;
x_approx2(2: n2 - 1) = sin(x2(2: n2 - 1));

y_approx2 = A2 \ x_approx2;

plot(x2, y_approx2, 'r.');
title('Exact and approximate with n = 100')
hold off

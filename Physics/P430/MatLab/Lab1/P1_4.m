%----------------------------------------------------------------------------%
% Opening Commands
%----------------------------------------------------------------------------%
close all; clear; clc

n = 100;  % number of points
lb = 0;  % lower bound
ub = 5;  % upper bound
h = (ub - lb) / (n - 1);  % step size
x = lb:h:ub;  % cell-edge data

f = @(x) besselj(0, x);  % define function

y = f(x);  % Evaluate function on grid

yp = zeros(size(y));  % Pre-allocate memory for yp and ypp
ypp = zeros(size(y));

% get centered estimate for yp(p)
yp(2:n - 1) = (y(3:n) - y(1:n - 2)) / (2 * h);  % 1st der.
ypp(2:n - 1) = (y(3:n) - 2 * y(2:n - 1) + y(1:n - 2)) / h ^ 2;  % 2nd der.

% Copy yp and ypp for linear and quadratic extrapolation
yplin = yp;
ypquad = yp;
ypplin = ypp;
yppquad = ypp;

% Use linear extrapolation to get endpoints for derivatives
yplin(1) = 2 * yplin(2) - yplin(3);
yplin(n) = 2 * yplin(n - 1) - yplin(n - 2);
ypplin(1) = 2 * ypplin(2) - ypplin(3);
ypplin(n) = 2 * ypplin(n - 1) - ypplin(n - 2);

% Use quadratic extrapolation to get endpoints for derivatives
ypquad(1) = 3 * ypquad(2)-  3 * ypquad(3) + ypquad(4);
ypquad(n) = 3 * ypquad(n - 1) - 3 * ypquad(n - 2) + ypquad(n - 3);
yppquad(1) = 3 * yppquad(2) - 3 * yppquad(3) + yppquad(4);
yppquad(n) = 3 * yppquad(n - 1) - 3 * yppquad(n - 2) +yppquad(n - 3);

% Calculate real derivatives
fp = - besselj(1, x);
fpp = 1 / 2 * (- besselj(0, x) + besselj(2, x));

% Find mean absolute errors for linear and quadratic extrapolation
abs_err_linp = mean(abs(yplin - fp));  % linear 1st der. error
abs_err_linpp = mean(abs(ypplin - fpp));  % linear 2nd der. error

abs_err_quadp = mean(abs(ypquad - fp));  % quad 1st der. error
abs_err_quadpp = mean(abs(yppquad - fpp));  % quad 2nd der. error

% Display the errors
disp(sprintf('Linear first derivative error: %.8e ', abs_err_linp));
disp(sprintf('Linear second derivative error: %.8e ', abs_err_linpp));
disp(sprintf('Quadratic first derivative error: %.8e ', abs_err_quadp));
disp(sprintf('Quadratic second derivative error: %.8e ', abs_err_quadpp));


% Plot the derivatives
figure;
hold on
subplot(2,1,1);
plot(x, fp, x, yplin, x, ypquad);
title('First derivatives');
legend('Real Derivative', 'Linear Extrapolation', 'quadratic Extrapolation');

subplot(2,1,2);
plot(x, fpp, x, ypplin, x, yppquad);
title('Second derivatives');
legend('Real Derivative', 'Linear Extrapolation', 'quadratic Extrapolation');

hold off

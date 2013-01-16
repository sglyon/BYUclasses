%----------------------------------------------------------------------------%
% Opening Commands
%----------------------------------------------------------------------------%
close all; clear; clc

n = 1000;  % number of points
lb = 0;  % lower bound
ub = 5;  % upper bound
h = (ub - lb) / (n - 1);  % step size
x = lb:h:ub;  % cell-edge data

f = cos(x);
y = cos(x) + .001 * rand(1, length(x));

% Pre-allocate memory for yp and ypp
yp = zeros(size(y));
ypp = zeros(size(y));

% get centered estimate for yp(p)
yp(2:n - 1) = (y(3:n) - y(1:n - 2)) / (2 * h);  % 1st der.
ypp(2:n - 1) = (y(3:n) - 2 * y(2:n - 1) + y(1:n - 2)) / h ^ 2;  % 2nd der.

% Get real derivative data
fp = - sin(x);
fpp = - cos(x);

% Plot f, y, fp, yp
figure
hold on
subplot(2, 1, 1)
plot(x, f, 'b', x, y, 'g')
legend('Real', 'Noisy')
title('f(x)')

subplot(2, 1, 2)
plot(x, fp, 'k', x, yp, 'r')
legend('Real', 'Estimated')
title('fp(x)')
hold off

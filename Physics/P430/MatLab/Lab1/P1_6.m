%----------------------------------------------------------------------------%
% Opening Commands
%----------------------------------------------------------------------------%
close all; clear; clc

% Define h values
h1 = 0.1; h2 = 0.01; h3 = 0.001;
h = [h1 h2 h3];

x = 0;  % Define x

% find errors Note: f = exp(x), f' = f'' = exp(x), f''(0) = f'(0) = f(0) = 1
% Also note that I calculate the errors for all three h values simultaneously
forward_first = 1 - ((exp(x + h) - exp(x)) ./ h);
center_first = 1 - ((exp(x + h) - exp(x - h)) ./ (2 * h));
center_second = 1 - ((exp(x + h) - 2 * exp(x) + exp(x - h)) ./ (h.^2));

disp('Forward first derivative error:');
disp(forward_first);
disp('Centered first derivative error:');
disp(center_first);
disp('Centered second derivative error:');
disp(center_second);

clear; clc; close all;

% Set initial frequency
w0 = 1;

% Set final time to be 30 periods out and get step size
tfinal=2 * pi / w0 * 30;

N = input('Input the number of steps to be taken: ')
tao = tfinal / N ;
t = linspace(0, tfinal, N + 1)
theta = zeros(1, N + 1);
omega = zeros(1, N + 1);

theta(1) = pi / 2;
omega(1) = 0;

for n=1:N
	theta(n + 1) = theta(n) + omega(n) * tao; 
	omega(n + 1) = omega(n) +  (- w0.^2 .* sin(theta(n))) * tao;  % TODO: This is wrong
end

plot(t, theta, 'r-', t, cos(w0 .* t), 'b-');  % TODO: This is wrong
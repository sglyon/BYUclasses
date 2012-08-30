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
	% Compute 1/2 steps (predictor step)
	theta_half = theta(n) + omega(n) * tao * .5;
	omega_half = omega(n) - w0.^2 .* sin(theta(n)) * tao * .5 ;
	
	% Compute full steps (corrector step)
	theta(n + 1) = theta(n) + omega_half * tao;  % TODO: This is wrong
	omega(n + 1) = omega(n) - w0.^2 .* sin(theta_half) * tao;  % TODO: This is wrong
end

real_ans = pi * w0 ./ (2 * ellipke(sin(theta / 2) .^2));

plot(t, theta, 'r-', t, max(theta) * cos(t .* real_ans), 'b-');  % TODO: This looks funny

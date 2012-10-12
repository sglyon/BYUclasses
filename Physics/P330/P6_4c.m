clear; clc;

% Declare w0 global and set it
global w0;

w0 = 1;

% Set time bounds
tstart = 0; tfinal = 2 * pi / w0 * 30;

% Initialize state
theta0_choices = [0.1, 0.5, 1, pi / 2, .9 * pi, 0.98 * pi];

% TODO: Clean this up. Figure out how to store heterogenous data for different theta0's so we can just use a for loop.
u0 = zeros(2, 1);
u0(1) = theta0_choices(1) ;
u0(2) = 0;
times = linspace(tstart, tfinal, 1000);

% Set options and solve the system using ode45
options = odeset('RelTol', 1e-8);
[~, u] = ode45(@rhs6_4c, times, u0, options);

% Extract our data
theta1 = u(:, 1);
omega1 = u(:, 2);

figure
real_ans = pi * w0 ./ (2 * ellipke(sin(theta0_choices(1) / 4) .^2));
plot(times, theta1, 'r-', times, max(theta1) * cos(times .* real_ans), 'b-');  % TODO: This looks funny
title('With theta0 = 0.1')
%% Do this for 2nd choice of th0
u0 = zeros(2, 1);
u0(1) = theta0_choices(2) ;
u0(2) = 0;
times = linspace(tstart, tfinal, 1000);

% Set options and solve the system using ode45
options = odeset('RelTol', 1e-8);
[~, u] = ode45(@rhs6_4c, times, u0, options);

% Extract our data
theta2 = u(:, 1);
omega2 = u(:, 2);

figure
real_ans = pi * w0 ./ (2 * ellipke(sin(theta0_choices(2) / 4) .^2));
plot(times, theta2, 'r-', times, max(theta2) * cos(times .* real_ans), 'b-');
title('With theta0 = 0.5')


%% Do this for 3rd choice of th0
u0 = zeros(2, 1);
u0(1) = theta0_choices(3) ;
u0(2) = 0;
times = linspace(tstart, tfinal, 1000);

% Set options and solve the system using ode45
options = odeset('RelTol', 1e-8);
[~, u] = ode45(@rhs6_4c, times, u0, options);

% Extract our data
theta3 = u(:, 1);
omega3 = u(:, 2);

figure
real_ans = pi * w0 ./ (2 * ellipke(sin(theta0_choices(3) / 4) .^2));
plot(times, theta3, 'r-', times, max(theta3) * cos(times .* real_ans), 'b-');
title('With theta0 = 1.0')


%% Do this for 4th choice of th0
u0 = zeros(2, 1);
u0(1) = theta0_choices(4) ;
u0(2) = 0;
times = linspace(tstart, tfinal, 1000);

% Set options and solve the system using ode45
options = odeset('RelTol', 1e-8);
[~, u] = ode45(@rhs6_4c, times, u0, options);

% Extract our data
theta4 = u(:, 1);
omega4 = u(:, 2);

figure
real_ans = pi * w0 ./ (2 * ellipke(sin(theta0_choices(4) / 4) .^2));
plot(times, theta4, 'r-', times, max(theta4) * cos(times .* real_ans), 'b-');
title('With theta0 = pi/2')


%% Do this for 5th choice of th0
u0 = zeros(2, 1);
u0(1) = theta0_choices(5) ;
u0(2) = 0;
times = linspace(tstart, tfinal, 1000);

% Set options and solve the system using ode45
options = odeset('RelTol', 1e-8);
[~, u] = ode45(@rhs6_4c, times, u0, options);

% Extract our data
theta5 = u(:, 1);
omega5 = u(:, 2);

figure
real_ans = pi * w0 ./ (2 * ellipke(sin(theta0_choices(5) / 4) .^2));
plot(times, theta5, 'r-', times, max(theta5) * cos(times .* real_ans), 'b-');y
title('With theta0 = 0.9 pi')


%% Do this for 6th choice of th0
u0 = zeros(2, 1);
u0(1) = theta0_choices(6) ;
u0(2) = 0;
times = linspace(tstart, tfinal, 1000);

% Set options and solve the system using ode45
options = odeset('RelTol', 1e-8);
[~, u] = ode45(@rhs6_4c, times, u0, options);

% Extract our data
theta6 = u(:, 1);
omega6 = u(:, 2);

figure
real_ans = pi * w0 ./ (2 * ellipke(sin(theta0_choices(6) / 4) .^2));
plot(times, theta6, 'r-', times, max(theta6) * cos(times .* real_ans), 'b-');
title('With theta0 = 0.98 pi')
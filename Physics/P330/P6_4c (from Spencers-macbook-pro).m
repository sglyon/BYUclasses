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

% Set options and solve the system using ode45
options = odeset('RelTol', 1e-8);
[t, u] = ode45(@rhs6_4c, [tstart, tfinal], u0, options);

% Extract our data
theta1 = u(:, 1);
omega1 = u(:, 2);


% Get evenly spaced points
N=length(t);
taue=(tfinal - tstart) / (N - 1);
te=tstart + (0:taue:(N - 1) * taue) ;
te=te';  % convert te to a column vector, to match t
theta_e1=interp1(t, theta1, te, 'spline');
omega_e1=interp1(t, omega1, te, 'spline');

figure
real_ans = pi * w0 ./ (2 * ellipke(sin(theta_e1 / 2) .^2));
plot(te, theta_e1, 'r-', te, max(theta_e1) * cos(te .* real_ans), 'b-');  % TODO: This looks funny
title('With theta0 = 0.1')


%if i == 1
%	theta_ans = theta_e;
%	omega_ans = omega_e;
%else
%	theta_ans = [theta_ans theta_e];
%	omega_ans = [omega_ans omega_e];
%end

%%% Do this for 2nd choice of th0
u0 = zeros(2, 1);
u0(1) = theta0_choices(2) ;
u0(2) = 0;

% Set options and solve the system using ode45
options = odeset('RelTol', 1e-8);
[t, u] = ode45(@rhs6_4c, [tstart, tfinal], u0, options);

% Extract our data
theta2 = u(:, 1);
omega2 = u(:, 2);


% Get evenly spaced points
N=length(t);
taue=(tfinal - tstart) / (N - 1);
te=tstart + (0:taue:(N - 1) * taue) ;
te=te';  % convert te to a column vector, to match t
theta_e2 = interp1(t, theta2, te, 'spline');
omega_e2 = interp1(t, omega2, te, 'spline');

figure
real_ans = pi * w0 ./ (2 * ellipke(sin(theta_e2 / 2) .^2));
plot(te, theta_e2, 'r-', te, max(theta_e2) * cos(te .* real_ans), 'b-');  % TODO: This looks funny
title('With theta0 = 0.5')


%%% Do this for 3rd choice of th0
u0 = zeros(2, 1);
u0(1) = theta0_choices(3) ;
u0(2) = 0;

% Set options and solve the system using ode45
options = odeset('RelTol', 1e-8);
[t, u] = ode45(@rhs6_4c, [tstart, tfinal], u0, options);

% Extract our data
theta3 = u(:, 1);
omega3 = u(:, 2);


% Get evenly spaced points
N=length(t);
taue=(tfinal - tstart) / (N - 1);
te=tstart + (0:taue:(N - 1) * taue) ;
te=te';  % convert te to a column vector, to match t
theta_e3=interp1(t, theta3, te, 'spline');
omega_e3=interp1(t, omega3, te, 'spline');

figure
real_ans = pi * w0 ./ (2 * ellipke(sin(theta_e3 / 2) .^2));
plot(te, theta_e3, 'r-', te, max(theta_e3) * cos(te .* real_ans), 'b-');  % TODO: This looks funny
title('With theta0 = 1.0')


%%% Do this for 4th choice of th0
u0 = zeros(2, 1);
u0(1) = theta0_choices(4) ;
u0(2) = 0;

% Set options and solve the system using ode45
options = odeset('RelTol', 1e-8);
[t, u] = ode45(@rhs6_4c, [tstart, tfinal], u0, options);

% Extract our data
theta4 = u(:, 1);
omega4 = u(:, 2);


% Get evenly spaced points
N=length(t);
taue=(tfinal - tstart) / (N - 1);
te=tstart + (0:taue:(N - 1) * taue) ;
te=te';  % convert te to a column vector, to match t
theta_e4=interp1(t, theta4, te, 'spline');
omega_e4=interp1(t, omega4, te, 'spline');

figure
real_ans = pi * w0 ./ (2 * ellipke(sin(theta_e4 / 2) .^2));
plot(te, theta_e4, 'r-', te, max(theta_e4) * cos(te .* real_ans), 'b-');  % TODO: This looks funny
title('With theta0 = pi/2')


%%% Do this for 5th choice of th0
u0 = zeros(2, 1);
u0(1) = theta0_choices(5) ;
u0(2) = 0;

% Set options and solve the system using ode45
options = odeset('RelTol', 1e-8);
[t, u] = ode45(@rhs6_4c, [tstart, tfinal], u0, options);

% Extract our data
theta5 = u(:, 1);
omega5 = u(:, 2);


% Get evenly spaced points
N=length(t);
taue=(tfinal - tstart) / (N - 1);
te=tstart + (0:taue:(N - 1) * taue) ;
te=te';  % convert te to a column vector, to match t
theta_e5=interp1(t, theta5, te, 'spline');
omega_e5=interp1(t, omega5, te, 'spline');

figure
real_ans = pi * w0 ./ (2 * ellipke(sin(theta_e5 / 2) .^2));
plot(te, theta_e5, 'r-', te, max(theta_e5) * cos(te .* real_ans), 'b-');  % TODO: This looks funny
title('With theta0 = 0.9 pi')


%%% Do this for 6th choice of th0
u0 = zeros(2, 1);
u0(1) = theta0_choices(6) ;
u0(2) = 0;

% Set options and solve the system using ode45
options = odeset('RelTol', 1e-8);
[t, u] = ode45(@rhs6_4c, [tstart, tfinal], u0, options);

% Extract our data
theta6 = u(:, 1);
omega6 = u(:, 2);


% Get evenly spaced points
N=length(t);
taue=(tfinal - tstart) / (N - 1);
te=tstart + (0:taue:(N - 1) * taue) ;
te=te';  % convert te to a column vector, to match t
theta_e6=interp1(t, theta6, te, 'spline');
omega_e6=interp1(t, omega6, te, 'spline');

figure
real_ans = pi * w0 ./ (2 * ellipke(sin(theta_e6 / 2) .^2));
plot(te, theta_e6, 'r-', te, max(theta_e6) * cos(te .* real_ans), 'b-');  % TODO: This looks funny
title('With theta0 = 0.98 pi')
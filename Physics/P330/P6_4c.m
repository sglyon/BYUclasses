clear; clc;

% Declare w0 global and set it
global w0;
w0 = 1;

% Set time bounds
tstart = 0; tfinal = 2 * pi / w0 * 30;

% Initialize state
theta0_choices = [0.1, 0.5, 1, pi / 2, .9 * pi];

for i=1:5  % TODO: Clean this up. Figure out how to store heterogenous data for different theta0's
    u0 = zeros(2, 1);
    u0(1) = theta0_choices(i) ;
    u0(2) = 0;

    % Set options and solve the system using ode45
    options = odeset('RelTol', 1e-8);
    [t, u] = ode45(@rhs6_4c, [tstart, tfinal], u0, options);

    % Extract our data
    theta = u(:, 1);
    omega = u(:, 2);
    

    % Get evenly spaced points
    N=length(t);
    taue=(tfinal - tstart) / (N - 1);
    te=tstart + (0:taue:(N - 1) * taue) ;
    te=te';  % convert te to a column vector, to match t
    theta_e=interp1(t, theta, te, 'spline');
    omega_e=interp1(t, omega, te, 'spline');
    
    if i == 1
        theta_ans = theta_e;
        omega_ans = omega_e;
    else
        theta_ans = [theta_ans theta_e];
        omega_ans = [omega_ans omega_e];
    end
end


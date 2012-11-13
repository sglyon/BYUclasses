%% Setup
clear; close all; clc;

global l epsi w0

%% Part a
l = 1;
epsi = 0.3;
w0 = 1.3;

N = 2^13;
tstart = 0; tfinal = 50;
times = linspace(tstart, tfinal, N);
tau = times(2) - times(1);
dw=2*pi/(N*tau);
w=0:dw:2*pi/tau-dw;

u0 = zeros(2, 1);  % initial conditions are both zero in this problem
u0(1) = 1e-4;

% Set options and solve the system using ode45
options = odeset('RelTol', 1e-5);
[te, u] = ode45(@rhs9_1, times, u0, options);

xe = u(:, 1);
ve = u(:, 2);

figure
plot(te, xe);
title('x(t) when espilon=0.3');

% TODO: This doesn't work
figure
[x1, x2] = meshgrid(linspace(-3.5, 3.5, 40), linspace(-4, 4, 40));
xdot = x2;
vdot = epsi .* (l.^2 - x1.^2) .* x2- w0.^2 .* x1;
quiver(x1, x2, xdot, vdot);
title('Phase plot when epsilon=0.3');

figure
plot(xe, ve);
title('Part a phase plot');

%% Part b
epsi = 1;
[te2, u2] = ode45(@rhs9_1, times, u0, options);

xe2 = u2(:, 1);
ve2 = u2(:, 2);

g2 = fft(xe2);
P2 = abs(g2) .^2;

figure
semilogy(w, P2);
title('Power spectrum espilon=1');
xlim([0 20]);

figure
plot(te2, xe2);
title('x(t) when espilon=1');

% TODO: This doesn't work
figure
[x1, x2] = meshgrid(linspace(-3.5, 3.5, 40), linspace(-4, 4, 40));
xdot = x2;
vdot = epsi .* (l.^2 - x1.^2) .* x2- w0.^2 .* x1;
quiver(x1, x2, xdot, vdot);

figure
plot(xe2, ve2);
title('Part b phase plot');

% Now do epsilon=20
epsi = 20;
[te3, u3] = ode45(@rhs9_1, times, u0, options);

xe3 = u3(:, 1);
ve3 = u3(:, 2);

g3 = fft(xe3);
P3 = abs(g3) .^2;

figure
semilogy(w, P3);
title('Power spectrum espilon=20');
xlim([0 20]);

figure
plot(te3, xe3);
title('x(t) when espilon=20');

% TODO: This doesn't work
figure
[x1, x2] = meshgrid(linspace(-3.5, 3.5, 40), linspace(-4, 4, 40));
xdot = x2;
vdot = epsi .* (l.^2 - x1.^2) .* x2- w0.^2 .* x1;
quiver(x1, x2, xdot, vdot);
title('phase plot espilon=20');

figure
plot(xe3, ve3);
title('Part c phase plot')

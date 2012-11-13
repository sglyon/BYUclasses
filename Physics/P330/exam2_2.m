clear; close all; clc;

global sigma rho cbeta

cbeta = 8 / 3;
rho = 26;
sigma = 10;

tstart = 0; tfinal = 10; tpoints = 2^15;
times = linspace(tstart, tfinal, tpoints);

t2start = 0; t2final = 50;
times2 = linspace(t2start, t2final, tpoints);

u0 = zeros(3, 1);  % initial conditions are both zero in this problem
u0(1) = 0.1;
u0(2) = 0.;
u0(3) = 0.1;

% Set options and solve the system using ode45
options = odeset('RelTol', 1e-8);
[te, u] = ode45(@exam2_2_rhs, times, u0, options);

x = u(:, 1);
y = u(:, 2);
z = u(:, 3);
xp = sigma .* (y - x);
yp = x .* (rho - z) - y;
zp = x .* y - cbeta .* z;

[te2, u2] = ode45(@exam2_2_rhs, times2, u0, options);

x2 = u2(:, 1);
y2 = u2(:, 2);
z2 = u2(:, 3);
xp2 = sigma .* (y2 - x2);
yp2 = x2 .* (rho - z) - y2;
zp2 = x2 .* y2 - cbeta .* z2;

%% Part a
figure
plot(te, x, te, y, te, z);
legend('x', 'y', 'z');

%% Part b
figure
plot(x, xp, 'b')
title('Phase space: xp vs x')

figure
plot(y, yp, 'g')
title('Phase space: yp vs y')

figure
plot(z, zp, 'r')
title('Phase space: zp vs z')

%% Part c
figure
plot(x, y);
title('Projection in x-y plane')

%% Part d
figure
plot3(x2, y2, z2)
xlabel('x');
ylabel('y');
zlabel('z');
title('Trajectory of particle')

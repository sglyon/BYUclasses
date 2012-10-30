%% Setup
clear; close all; clc;

N = 2^10;
tstart = 0; tfinal = 1000;
times = linspace(tstart, tfinal, N);
tau = times(2) - times(1);
dw=2*pi/(N*tau);
w=0:dw:2*pi/tau-dw;

global w0 wc gam N1 w02

w0 = 1.3;
wc = 0.3;
gam = 0.07
N1 = -0.3;

u0 = zeros(4, 1);  % initial conditions are all zero except theta1
u0(1) = 1.;

options = odeset('RelTol', 1e-5);

%% case 1
w02 = sqrt(1.03) * w0
[te, u] = ode45(@rhs10_3c, times, u0, options);

th1e = u(:, 1);
th2e = u(:, 2);
w1e = u(:, 3);
w2e = u(:, 4);

%% case 2
w02 = sqrt(1.1) * w0
[~, u2] = ode45(@rhs10_3c, times, u0, options);

th1e2 = u2(:, 1);
th2e2 = u2(:, 2);
w1e2 = u2(:, 3);
w2e2 = u2(:, 4);


%% case 3
w02 = sqrt(1.25) * w0
[~, u3] = ode45(@rhs10_3c, times, u0, options);

th1e3 = u3(:, 1);
th2e3 = u3(:, 2);
w1e3 = u3(:, 3);
w2e3 = u3(:, 4);

% Plot case 1
figure
subplot(2,1,1);
plot(te,th1e);
title('\theta_1')
ylim([min(th1e) max(th1e)]);
subplot(2,1,2);
plot(te,th2e);
ylim([min(th1e) max(th1e)]);
title('\theta_2')

figure
hold on
plot(te, th1e);
plot(te, th2e, 'r');
title('Synchronizing clocks part 1')
hold off

% Plot case 2
figure
subplot(2,1,1);
plot(te,th1e2);
title('\theta_1')
ylim([min(th1e2) max(th1e2)]);
subplot(2,1,2);
plot(te,th2e2);
ylim([min(th1e2) max(th1e2)]);
title('\theta_2')

figure
hold on
plot(te, th1e2);
plot(te, th2e2, 'r');
title('Synchronizing clocks part 2')
hold off

% Plot case 3
figure
subplot(2,1,1);
plot(te,th1e3);
title('\theta_1')
ylim([min(th1e3) max(th1e3)]);
subplot(2,1,2);
plot(te,th2e3);
ylim([min(th1e3) max(th1e3)]);
title('\theta_2')

figure
hold on
plot(te, th1e3);
plot(te, th2e3, 'r');
title('Synchronizing clocks part 3')
hold off

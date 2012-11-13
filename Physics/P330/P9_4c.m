%% Setup
clear; close all; clc;

global A gamma

gamma = 0.4;

N = 2^15;
n1 = ceil(.6 * N);
tstart = 0; tfinal = 1000;
times = linspace(tstart, tfinal, N);
options = odeset('RelTol', 1e-6);

u0 = zeros(2, 1);
u0(1) = 1;

A = 1.36;
[te, u1] = ode45(@rhs9_3c, times, u0, options);

A = 1.371;
[~, u2] = ode45(@rhs9_3c, times, u0, options);

A = 1.97;
[~, u3] = ode45(@rhs9_3c, times, u0, options);

A = 1.99;
[~, u4] = ode45(@rhs9_3c, times, u0, options);

A = 2.;
[~, u5] = ode45(@rhs9_3c, times, u0, options);

A = 3.;
[~, u6] = ode45(@rhs9_3c, times, u0, options);

A = 50;
[~, u7] = ode45(@rhs9_3c, times, u0, options);

x1 = u1(:,1);
v1 = u1(:,2);

x2 = u2(:,1);
v2 = u2(:,2);

x3 = u3(:,1);
v3 = u3(:,2);

x4 = u4(:,1);
v4 = u4(:,2);

x5 = u5(:,1);
v5 = u5(:,2);

x6 = u6(:,1);
v6 = u6(:,2);

x7 = u7(:,1);
v7 = u7(:,2);


figure
subplot(2,1,1)
plot(x1(n1:end), v1(n1:end));
xlabel('x'); ylabel('v');
title('Phase diagram with A = 1.36');

subplot(2,1,2)
plot(x2(n1:end), v2(n1:end));
xlabel('x'); ylabel('v');
title('Phase diagram with A = 1.371');




figure
subplot(2,2,1)
plot(x3(n1:end), v3(n1:end));
xlabel('x'); ylabel('v');
title('Phase diagram with A = 1.97');

subplot(2,2,2)
plot(x4(n1:end), v4(n1:end));
xlabel('x'); ylabel('v');
title('Phase diagram with A = 1.99');

subplot(2,2,3)
plot(x5(n1:end), v5(n1:end));
xlabel('x'); ylabel('v');
title('Phase diagram with A = 2');



figure
subplot(2,1,1)
plot(x6(n1:end), v6(n1:end));
xlabel('x'); ylabel('v');
title('Phase diagram with A = 3');

subplot(2,1,2)
plot(x7(n1:end), v7(n1:end));
xlabel('x'); ylabel('v');
title('Phase diagram with A = 50');

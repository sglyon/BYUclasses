clear; close all; clc;


N = 2^16;
tmax = 200;
tau = tmax/(N-1);
t=0:tau:(N-1)*tau;
dw = 2*pi/tmax;
w = -(N/2)*dw:dw:dw*(N/2-1);

f = @(t, x) exp (-(t - 20 ).^2 ./ (0.5 ^ 2));
pulse_0 = f(t, 0);

g_0 = ft(pulse_0, tau);
P_0 = abs(g_0) .^ 2;

gravity = 9.8;
depth = 50;

kk = waterk(w, 9.8, 50);

g_30 = g_0 .* exp(i * kk * 30);
P_30 = abs(g_30) .^ 2;

f_30 = ift(g_30, dw);

plot(t, pulse_0, t, f_30);
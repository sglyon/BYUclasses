clear; clc;
th_start = 0;
th_end = pi;

th = linspace(th_start, th_end, 1000);

omega_0 = 1;

m = sin(th / 2) .^2
K = ellipke(m);

om = pi .* omega_0 ./ (2 .* K);

plot(th, om);
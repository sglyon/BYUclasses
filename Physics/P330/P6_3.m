clear; clc;
th_start = 0;
th_end = pi;

th = linspace(th_start, th_end, 1000);

omega_0 = 1;

m = linspace(0, 1, 1000);
K = ellipke(m);  % TODO: Check this integral. Answer doesn't look right

om = pi .* omega_0 ./ (2 .* K .* (sin(th / 2) .^2));

plot(th, om);
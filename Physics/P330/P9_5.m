%% Setup
clear; close all; clc;

%% Part a
n = 100;
f = zeros(n, 1);
f(1) = 1;
f(2) = 1;

for i=3:n
    f(i) = f(i-1) + f(i-2);
end

%% Part b
x = linspace(-2 * pi, 2* pi, 50001);

G = @(x) sum(cos(f .* x) ./ f);

for i=1:50001
    gx(i) = G(x(i));
end

plot(x, gx);
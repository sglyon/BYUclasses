my_func = @(x) x.^2 .* exp(-x) .* cos(x);

N = 80;

[est, act, err] = midpoint(my_func, N, 0, 2);
disp(err);

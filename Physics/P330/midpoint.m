function [approx, exact, err] = midpoint(func, N, a, b)

% Function to do basic numerical integration of f from a to b
%	using the midpoint rule and N sampling points.
% 
% func must be a function of only x
% approx is the numerical approxiamtion
% exact is the answer using matlab's quadl function
% error is the difference between the two

dx = (b - 1)  / N;
x = a + 0.5 * dx:dx: b - 0.5 * dx;
y = func(x);

approx = sum(y) * dx;

exact = quadl(func, a, b);

err = approx - exact;
function SSE = lstsq(a, x, y)

%-------------------------------------------------------------------------%
% This function returns the standard sum of squared errors for a least 
% 	squares fit. We call the function funcfit to get the function value
%   that those parameters yield and use fminsearch to find optimal parameter
%   values.
% a = vector of coefficients to be passed to funcfit.m
% x = vector of data points for the independent variable(s)
% y = vector of data points for the dependent variable(s)
%-------------------------------------------------------------------------%
SSE = sum((y-funcfit(a,x)).^2);
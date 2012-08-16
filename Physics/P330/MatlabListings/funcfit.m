function f=funcfit(a,x)
% this function evaluates the fitting
% function f(x,a1,a2,a3,...) to be fit to
% data.  It is called by leastsq.

% a is a vector of variable fitting parameters a1, a2, ...
% that are used in the function and x is a
% vector of x-values

% the function returns a vector f=f(x,a1,a2,...)

% sample exponential function with 2 variable
% parameters
f = a(1)*exp(a(2)*x);

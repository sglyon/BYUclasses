function f=funcfit(a,x)

% this function evaluates the fitting
% function f(x,a1,a2,a3,...) to be fit to
% data.  It is called by leastsq.

% a is a vector of parameters. 
% x is a function of 'x' coordinates.
% The return value (f) is the function evaluated at the values in x.


f = a(1)*sech(a(2)*x) + a(3);
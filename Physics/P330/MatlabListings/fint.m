% define the function to be integrated in fint.m
function f=fint(x)

% Warning: Matlab will do this integral with arrays of x,
% so use .*, ./, .^, etc. in this function.  If you forget
% to use the .-form you will encounter the error:
%
%       Inner matrix dimensions must agree.
%

f=cos(x).*exp(-x);

function [yp,ypp]=derivs(y,dx)

% This function numerically differentiates the array y which
% represents the function y(x) for x-data points equally spaced
% dx apart.  The first and second derivatives are returned as
% the arrays yp and ypp which are the same length as the input
% array y.  Either linear or quadratic extrapolation is used
% to load the derivatives at the endpoints.  The user decides
% which to use by commenting out the undesired formula below.

% load the first and second derivative arrays
% at the interior points
N=length(y);
yp(2:N-1)=(y(3:N)-y(1:N-2))/(2*dx);
ypp(2:N-1)=(y(3:N)-2*y(2:N-1)+y(1:N-2))/(dx^2);

% now use either linear or quadratic extrapolation to load the
% derivatives at the endpoints

% linear
%yp(1)=2*yp(2)-yp(3);yp(N)=2*yp(N-1)-yp(N-2);
%ypp(1)=2*ypp(2)-ypp(3);ypp(N)=2*ypp(N-1)-ypp(N-2);

% quadratic
yp(1)=3*yp(2)-3*yp(3)+yp(4);
yp(N)=3*yp(N-1)-3*yp(N-2)+yp(N-3);
ypp(1)=3*ypp(2)-3*ypp(3)+ypp(4);
ypp(N)=3*ypp(N-1)-3*ypp(N-2)+ypp(N-3);

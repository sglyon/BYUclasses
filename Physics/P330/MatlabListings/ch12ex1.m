clear; close all;

dx=1/1000;
x=0:dx:4;
N=length(x);
f=sin(x);

% Do the derivative at the interior points all at once using
% the colon command

dfdx(2:N-1)=(f(3:N)-f(1:N-2))/(2*dx);

% linearly extrapolate to the end points
dfdx(1)=2*dfdx(2)-dfdx(3);
dfdx(N)=2*dfdx(N-1)-dfdx(N-2);

% now plot both the approximate derivative and the exact
% derivative cos(x) to see how well we did
plot(x,dfdx,'r-',x,cos(x),'b-')

% also plot the difference between the approximate and exact
figure
plot(x,dfdx-cos(x),'b-')
title('Difference between approximate and exact derivatives')

clear; close all;

% make the crude data set with dx too big for good accuracy
dx=pi/5;

x=0:dx:2*pi;

y=sin(x);

% make a 5th order polynomial fit to this data
p=polyfit(x,y,5);

% make a fine x-grid
xi=0:dx/20:2*pi;

% evaluate the fitting polynomial on the fine grid
yi=polyval(p,xi);

% display the fit, the data, and the exact sine function
plot(x,y,'b*',xi,yi,'r-',xi,sin(xi),'c-')
legend('Data','Fit','Exact sine function')

% display the difference between the polynomial fit and
% the exact sine function
figure
plot(xi,yi-sin(xi),'b-')
title('Error in fit')

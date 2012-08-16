clear; close all;

% make the crude data set with dx too big for
% good accuracy
dx=pi/5;
x=0:dx:2*pi;
y=sin(x);

% make a fine x-grid
xi=0:dx/20:2*pi;

% interpolate on the coarse grid to
% obtain the fine yi values

% linear interpolation
yi=interp1(x,y,xi,'linear');

% plot the data and the interpolation
plot(x,y,'b*',xi,yi,'r-')
title('Linear Interpolation')

% cubic (quadratic) interpolation
yi=interp1(x,y,xi,'cubic');

% plot the data and the interpolation
figure
plot(x,y,'b*',xi,yi,'r-')
title('Cubic Interpolation')

% spline interpolation
yi=interp1(x,y,xi,'spline');

% plot the data and the interpolation
figure
plot(x,y,'b*',xi,yi,'r-')
title('Spline Interpolation')

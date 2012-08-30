clear; close all;

% Build an array of function values
x=0:.01:10; y=cos(x);

% Then, since the function returns two arrays in the form
% [yp,ypp], you would use it this way:
[fp,fpp]=derivs(y,.01);

% plot the approximate derivatives
plot(x,fp,'r-',x,fpp,'b-')
title('Approximate first and second derivatives')

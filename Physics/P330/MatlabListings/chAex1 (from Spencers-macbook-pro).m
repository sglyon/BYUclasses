clear;close all;

% Creates some fake data so we have something to plot.
x=0:0.05:2*pi;
f=sin(x);
data = f + rand(1,length(x))-0.5;
err_hi = f + 0.5;
err_low = f - 0.5;

% Plot the data
plot(x,f,'b',x,data,'b.',x,err_hi,'r-.',x,err_low,'g--');

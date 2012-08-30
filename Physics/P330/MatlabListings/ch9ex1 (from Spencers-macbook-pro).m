clear; close all;

x=linspace(0,pi,50);

% make a sine function with 1% random error on it
f=sin(x)+.01*rand(1,length(x));

% fit to the data
p=polyfit(x,f,4);

% evaluate the fit
g=polyval(p,x);

% plot fit and data together
plot(x,f,'r*',x,g,'b-')

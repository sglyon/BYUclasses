clear;close all;
f=inline('sin(x.*y)./(x.^2+y.^2)','x','y');

x=-8:.1:8;
y=x;

plot(x,f(x,2))

[X,Y]=ndgrid(x,y);
figure
surf(X,Y,f(X,Y))

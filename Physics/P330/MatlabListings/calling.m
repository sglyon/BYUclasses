clear;close all;

h=0.1;
x=-8:h:8;
y=x;

plot(x,trig(x,2))

[X,Y]=ndgrid(x,y);
figure
surf(X,Y,trig(X,Y))

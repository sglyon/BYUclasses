clear; close all;

x=-1:.1:1;
y=0:.1:1.5;
[X,Y]=ndgrid(x,y);
F=(2-cos(pi*X)).*exp(Y);

surf(X,Y,F);
title('Surface Plot')
xlabel('x')
ylabel('y')
EL=45;
for m=1:100
   AZ=30+m/100*360;
   view(AZ,EL);
   pause(.1);  % pause units are in seconds
end

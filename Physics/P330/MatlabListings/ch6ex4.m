clear; close all;

x=-1:.1:1;
y=0:.1:1.5;
[X,Y]=ndgrid(x,y);
F=(2-cos(pi*X)).*exp(Y);

dt=.1;

for m=1:100
   t=m*dt;
   g=F*cos(t);

   surf(X,Y,g);
   AZ=30;EL=45;
   view(AZ,EL);
   title('Surface Plot')
   xlabel('x')
   ylabel('y')
   axis([-1 1 -1 1 min(min(F)) max(max(F))])
   pause(.1)
end

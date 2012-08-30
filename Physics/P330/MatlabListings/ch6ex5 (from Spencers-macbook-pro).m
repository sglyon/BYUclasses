clear;close all;

a=2;b=1;Vo=1;  % set some constants

% build the x and y grids
Nx=80;Ny=40;
dx=2*b/Nx;dy=a/Ny;
x=-b:dx:b;y=0:dy:a;

[X,Y]=ndgrid(x,y); % build the 2-d grids for plotting

Nterms=20; % set the number of terms to include

V=zeros(Ny+1,Nx+1); % zero V out so we can add into it

% add the terms of the sum into V
for m=0:Nterms
   V=V+cosh((2*m+1)*pi*X/a)/cosh((2*m+1)*pi*b/a)...
            .*sin((2*m+1)*pi*Y/a)/(2*m+1);
end

V=4*Vo/pi*V; % put on the multiplicative constant

surf(X,Y,V) % surface plot the result
xlabel('x');
ylabel('y');
zlabel('V(x,y)')

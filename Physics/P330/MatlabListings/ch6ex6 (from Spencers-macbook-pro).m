clear;close

x=-5.25:.5:5.25;y=x; % define the x and y grids (avoid (0,0))
[X,Y]=ndgrid(x,y);

% Electric field of a long charged wire
Ex=X./(X.^2+Y.^2);
Ey=Y./(X.^2+Y.^2);

% make the field arrow plot
quiver(X,Y,Ex,Ey)
title('E of a long charged wire')

axis equal  % make the x and y axes be equally scaled

% Magnetic field of a long current-carrying wire
Bx=-Y./(  X.^2+Y.^2);
By=X./(X.^2+Y.^2);

% make the field arrow plot
figure
quiver(X,Y,Bx,By)
axis equal
title('B of a long current-carrying wire')

% The big magnitude difference across the region makes most arrows too small
% to see.  This can be fixed by plotting unit vectors instead
% (losing all magnitude information, but keeping direction)

B=sqrt(Bx.^2+By.^2);
Ux=Bx./B;
Uy=By./B;

figure
quiver(X,Y,Ux,Uy);
axis equal
title('B(wire): unit vectors')

% Or, you can still see qualitative size information without such a big
% variation in arrow size by having the arrow length be logarithmic.
% If s is the desired ratio between the longest arrow and the shortest one,
% this code will make the  appropriate field plot.
Bmin=min(min(B));
Bmax=max(max(B));
s=2;  % choose an arrow length ratio
k=(Bmax/Bmin)^(1/(s-1));

logsize=log(k*B/Bmin);
Lx=Ux.*logsize;
Ly=Uy.*logsize;

figure
quiver(X,Y,Lx,Ly);
axis equal
title('B(wire): logarithmic arrows')

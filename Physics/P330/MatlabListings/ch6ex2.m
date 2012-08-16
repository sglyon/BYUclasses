clear; close all;

% make a contour plot by asking Matlab to evenly space N
% contours between the minimum of F(x,y) and the maximum F(x,y)

x=-1:.1:1;y=0:.1:1.5;
[X,Y]=ndgrid(x,y);
F=(2-cos(pi*X)).*exp(Y);

N=40;
contour(X,Y,F,N);
title('Simple Contour Plot')
xlabel('x')
ylabel('y')

% You can also tell Matlab which contour levels to plot.  To do
% so load an array (V in this case) with the values of the
% levels you want to see.  In this example they will start at
% the minimum of F, end at the maximum of F, and there will be
% 21 contours.
% You can even print contour labels on the plot, which is
% a big help, by assigning the plot to a variable name
% and using the clabel command, as shown below.  Only
% every other contour is labeled in this example

top=max(max(F));  % find the max and min of F
bottom=min(min(F));
dv=(top-bottom)/20; % interval for 21 equally spaced contours
V=bottom:dv:top;
figure
cs=contour(X,Y,F,V);
clabel(cs,V(1:2:21)) % give clabel the name of the plot and
                     % an array of the contours to label
title('Fancy Contour Plot')
xlabel('x')
ylabel('y')

% Now make a surface plot of the function with the viewing
% point rotated by AZ degrees from the x-axis and
% elevated by EL degrees above the xy plane
figure
surf(X,Y,F); % or you can use mesh(X,Y,F) to make a wire plot
AZ=30;EL=45;
view(AZ,EL);
title('Surface Plot')
xlabel('x')
ylabel('y')

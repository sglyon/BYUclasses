clear;close all;

% Define the arrays x and y
% Don't make the step size too small or you will kill the
% system (you have a large, but finite amount of memory)
x=-1:.1:1;
y=0:.1:1.5;

% Use meshgrid to convert these 1-d arrays into 2-d matrices
% of x and y values over the plane
[X,Y]=meshgrid(x,y);

% Get F(x,y) by using F(X,Y). Note the use of .* with X and Y
% rather than with x and y
F=(2-cos(pi*X)).*exp(Y);

% Plot the function
surf(X,Y,F);
xlabel('x');
ylabel('y');

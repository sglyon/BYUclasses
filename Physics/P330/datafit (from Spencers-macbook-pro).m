clear;close
% Uses fminsearch to least squares fit a function defined
% in funcfit.m to data read in from data.fil

% read the data file and load x and y
load('data.mat');

% set up for the plot of the fitting function
xmin=min(x);
xmax=max(x);
npts=1001;
dx=(xmax-xmin)/(npts-1);
xplot=xmin:dx:xmax;


% set ifit to 0 and don't continue on to the fit until the user sets it to 1

ifit=0;
while (ifit==0)
    disp(' Enter an initial guess for the function ')
    a=input('parameters [a1,a2,...] in vector form [...]: ')
    % plot the data and the initial function guess
    yplot=funcfit(a,xplot);
    plot(x,y,'b*',xplot,yplot,'r-')
    xlabel('x')
    ylabel('y')
    title('Initial Guess and Data')
    ifit=input('0:guess again; 1:fit with this guess: ')
end

% Do the fit with the option TolX set; fminsearch will adjust
% a until each of its elements is determined to within TolX.
% If you think fminsearch could do better, reduce TolX.
option=optimset('TolX',1e-5);


% Have fminsearh look for the best parameters to minimize the
% leastsq.m function. The @ character in front of the function
% name tells Matlab it is a reference to an m-file function
a=fminsearch(@lstsq,a,option,x,y)


% Evaluate the function with the final fit parameters
yplot=funcfit(a,xplot);


% Plot the final fit and the data
plot(x,y,'b*',xplot,yplot,'r-')
xlabel('x')
ylabel('y')
title('Final Fit and Data')
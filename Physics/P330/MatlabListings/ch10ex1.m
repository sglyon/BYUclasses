% Secant method to solve the equation exp(-x)-x = 0
clear; close all;

% Define the function as an in line function
func=inline('exp(-x)-x','x');

% First plot the function (Note that the second plot is just
% a blue x-axis (y=0) 0*x is just a quick way to load an array
% of zeros the same size as x)
x=0:.01:2;
f=func(x);
plot(x,f,'r-',x,0*x,'b-')

% From the plot it looks like the solution is near x=0.6,
% so use an initial guess of x1=0.6
x1=0.6;

% find f(x1)
f1=func(x1);

% find a nearby second guess
x2=0.99*x1;

% set chk, the error, to 1 so it won't trigger the while
% before the loop gets started
chk=1;

while chk>1e-8  % start the loop

   f2=func(x2); % find f(x2)

% find the new x from the straight line approximation
   xnew = x2 - f2*(x2-x1)/(f2-f1)

% find the error by seeing how closely f(x)=0 is approximated
   chk=abs(f2);

% load the old x2 and f2 into x1 and f1
   x1=x2;
   f1=f2;
% put the new x into x2
   x2=xnew;

end % end of while loop

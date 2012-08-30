clear; close all;

% Make a starting guess at the solution
x0 = [1; 2; 2];

options=optimset('Display','iter');   % Option to display output

[x,fval] = fsolve(@P4_4_b,x0,options)  % Call solver

fprintf(' The solution is x=%g, y=%g, z=%g\n',x(1),x(2),x(3));
fprintf(' Final values of the function file = %g \n',fval)
disp(' (Make sure they are close to zero)')
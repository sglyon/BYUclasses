% Solve Poisson's equation by Successive-Over-relaxation
% on a rectangular Cartesian grid
clear; close all;
eps0=8.854e-12;  % set the permittivity of free space

Nx=input('Enter number of x-grid points - ');
Ny=input('Enter number of y-grid points - ');

Lx=4; % Length in x of the computation region
Ly=2; % Length in y of the computation region

% define the grids
hx=Lx/(Nx-1);         % Grid spacing in x
hy=Ly/(Ny-1);         % Grid spacing in y
x = (0:hx:Lx)-.5*Lx;  %x-grid, x=0 in the middle
y = 0:hy:Ly;          %y-grid

% estimate the best omega to use
R = (hy^2 * cos(pi/Nx)+hx^2*cos(pi/Ny))/(hx^2+hy^2);
omega=2/(1+sqrt(1-R^2));
fprintf('May I suggest using omega = %g ? \n',omega);
omega=input('Enter omega for SOR - ');

% define the voltages
V0=1;        % Potential at x=-Lx/2 and x=+Lx/2
Vscale=V0;   % set Vscale to the potential in the problem

% set the error criterion
errortest=input(' Enter error criterion - say 1e-6 - ') ;

% Initial guess is zeroes
V = zeros(Nx,Ny);

% set the charge density on the grid
rho=zeros(Nx,Ny);

% set the boundary conditions
% recall that in V(j,k), j is the x-index and k is the y-index
. . .

% MAIN LOOP

Niter = Nx*Ny*Nx;  %Set a maximum iteration count

%  set  factors used repeatedly in the algorithm
fac1 = 1/(2/hx^2+2/hy^2);
facx = 1/hx^2;
facy = 1/hy^2;

for n=1:Niter

   err(n)=0; % initialize the error at iteration n to zero

   for j=2:(Nx-1)   % Loop over interior points only
      for k=2:(Ny-1)

        % load rhs with the right-hand side of the Vjk equation,
        % Eq. (10.3)
        rhs =  . . .

        % calculate the relative error for this point, Eq. (10.18)
        currerr = . . .

        % Add some logic to compare err(n) and currerr and store
        % the bigger one in err(n). err(n) should hold
        % the biggest error on the grid for this n step after
        % finishing the j and k loops
        err(n)= . . .

         % SOR algorithm Eq. (10.14), to
         % update V(j,k) (use rhs from above)
         V(j,k) = . . .

      end
   end

   % if err < errortest break out of the loop

   fprintf('After %g iterations, error= %g\n',n,err(n));

   if(err(n) < errortest)
      disp('Desired accuracy achieved; breaking out of loop');
      break;
   end

end

% make a contour plot
figure
cnt=[0,.1,.2,.3,.4,.5,.6,.7,.8,.9,1]; % specify contours
cs = contour(x,y,V',cnt);  % Contour plot with labels
xlabel('x'); ylabel('y'); clabel(cs,[.2,.4,.6,.8])

% make a surface plot
figure
surf(x,y,V');  % Surface plot of the potential
xlabel('x'); ylabel('y');

% make a plot of error vs. iteration number
figure
semilogy(err,'b*')
xlabel('Iteration');
ylabel('Relative Error')

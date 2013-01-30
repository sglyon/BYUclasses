clear;close all;

% Set the number of grid points and build a cell-center grid
N=input(' Enter N, cell number - ')
L=10;
h=L/N;
x=-.5*h:h:L+.5*h;
x=x';  % Turn x into a column vector.

%  Load the diffusion coefficient array (make it a column vector)
D=ones(N+2,1); % (just 1 for now--we'll change it later)

% Load Dm with average values D(j-1/2) and Dp with D(j+1/2)
Dm=zeros(N+2,1);Dp=zeros(N+2,1);  % Make the column vectors
Dm(2:N+1)=.5*(D(2:N+1)+D(1:N));   % average j and j-1
Dp(2:N+1)=.5*(D(2:N+1)+D(3:N+2)); % average j and j+1

% Set the initial temperature distribution
T=sin(pi*x/L);

% Find the maximum of T for setting plot limits
Tmax=max(T);Tmin=min(T);

% Choose the time step tau.
% The max tau for explicit stability is a reasonable choice
fprintf(' Maximum explicit time step: %g \n',h^2/max(D))
tau = input(' Enter the time step - ')

% Create the matrices A and B by loading them with zeros
A=zeros(N+2);
B=zeros(N+2);

% load A and B at interior points
const = 2*h^2 / tau;
for j=2:N+1
   A(j,j-1)= -Dm(j);
   A(j,j)  = const + (Dm(j)+Dp(j));
   A(j,j+1)= -Dp(j);

   B(j,j-1)=  Dm(j);
   B(j,j)  = const-(Dm(j)+Dp(j));
   B(j,j+1)=  Dp(j);
end

% load the boundary conditions into A and B
A(1,1)=0.5; A(1,2)=0.5; B(1,1)=0.;            % T(0)=0
A(N+2,N+1)=0.5; A(N+2,N+2)=0.5; B(N+2,N+2)=0; % T(L)=0

% Set the number of time steps to take.
tfinal=input(' Enter the total run time - ')
nsteps=tfinal/tau;

% Choose how many iterations to skip between plots
skip = input(' Number of iterations to skip between plots - ')

% This is the time advance loop.
for mtime=1:nsteps

    % define the time
    t=mtime*tau;

    % find the right-hand side for the solve at interior points
    r=B*T;

    % apply the boundary conditions
    r(1)=0;   % T(0)=0
    r(N+2)=0; % T(L)=0

    % do the linear solve to update T
    T=A\r;

    % Make a plot of T every once in a while.
    if(rem(mtime,skip) == 0)
        plot(x,T)
        axis([0 L Tmin Tmax])
        pause(.1)
    end

end

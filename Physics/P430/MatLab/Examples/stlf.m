% Staggered Leapfrog Script Template
clear;close all;

% Set the values for parameters
c=2; % wave speed

% build a cell-centered grid with N=200 cells
% on the interval x=0 to x=L, with L=1
. . .

% define the initial displacement and velocity vs. x
y = exp(-(x-L/2).^2*160/L^2)-exp(-(0-L/2).^2*160/L^2);
vy = zeros(1,length(x));

% Choose a time step (Suggest that it is no larger than taulim)
taulim=h/c;
fprintf(' Courant time step limit %g \n',taulim)
tau=input(' Enter the time step - ')

% Get the initial value of yold from the initial y and vy
. . .

% Apply the boundary conditions for yold(1) and yold(N+2)
. . .

% plot the initial conditions and pause to look at them
subplot(2,1,1)
plot(x,y)
xlabel('x');ylabel('y(x,0)');title('Initial Displacement')
subplot(2,1,2)
plot(x,vy)
xlabel('x');ylabel('v_y(x,0)');title('Initial Velocity')
pause;

% Choose how long to run and when to plot
tfinal=input(' Enter tfinal - ')
skip=input(' Enter # of steps to skip between plots (faster) - ')
nsteps=tfinal/tau;

% here is the loop that steps the solution along

figure  % open a new frame for the animation
for n=1:nsteps
   time=n*tau;  % compute the time

   % Use leapfrog and the boundary conditions to load ynew with y
   % at the next time step using y and yold, i.e., ynew(2:N+1)=...
   % Be sure to use colon commands so it will run fast.
. . .

   %update yold and y
   yold=y;y=ynew;

% make plots every skip time steps
   if mod(n,skip)==0
      plot(x,y,'b-')
      xlabel('x');ylabel('y');
      title(['Staggered Leapfrog Wave: time=' num2str(time)])
      axis([min(x) max(x) -2 2]);
      pause(.1)
   end
end

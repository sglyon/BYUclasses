clear; close all;
% Use Euler's method to solve the harmonic oscillator equation

% set the angular frequency
w=1;

% decide how long to follow the motion, 10 periods in this case
tfinal=2*pi/w*10;

% choose the number of time steps to take
N=input(' Enter the number of time steps to take - ')

% Pre-allocate the arrays to make the code faster
t=zeros(1,N+1);
x=zeros(1,N+1);
v=zeros(1,N+1);

% calculate the time step
tau=tfinal/N;

% initialize the time array
t(1)=0;

% set the initial values of position and velocity
x(1)=1;v(1)=0;

% Do Euler's method for N time steps
for n=1:N
  t(n+1)=n*tau;
  x(n+1)=x(n) + v(n)*tau;
  v(n+1)=v(n) - w^2*x(n)*tau;
end

% plot the result and compare it with the exact solution
% which is x(t)=cos(w*t)
plot(t,x,'r-',t,cos(w*t),'b-')

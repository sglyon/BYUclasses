clear;close all;
% Runge-Kutta second order approximate solution
% to the harmonic oscillator

% set the angular frequency
w=1;

% decide how long to follow the motion, 10 periods in this case
tfinal=2*pi/w*10;

% choose the number of time steps to take
N=input(' Enter the number of time steps to take - ')

% calculate the time step
tau=tfinal/N;

% initialize the time array
t(1)=0;

% set the initial values of position and velocity
x(1)=1;v(1)=0;

% Do Runge-Kutta for N time steps
for n=1:N
   t(n+1)=n*tau;

   % Predictor step .5*tau into the future
   xhalf=x(n) + v(n)*tau*.5;
   vhalf=v(n) - w^2*x(n)*tau*.5;

   % Corrector step
   x(n+1)=x(n) + vhalf*tau;
   v(n+1)=v(n) - w^2*xhalf*tau;

end

% plot the result and compare it with the exact solution
% x(t)=cos(w*t) and v(t)=-w*sin(w*t)

plot(t,x,'r-',t,cos(w*t),'b-')

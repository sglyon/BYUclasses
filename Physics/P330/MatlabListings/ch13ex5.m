% example of event finding in Matlab's ode solvers
clear;close;

dt=.01;  % set the time step
u0=[0;1];  % put initial conditions in the [x;vx] column vector

% turn the eventfinder on by specifying the name of the M-file
% where the event information will be processed (events.m)
options=odeset('Events',@events,'RelTol',1e-6);

% call ode45 with event finding on
% and a parameter omega passed in
omega=1;
[t,u,te,ue,ie]=ode45(@eventrhs,[0,20],u0,options,omega);

% Here's what the output from the ode solver means:
% t: array of solution times
% u: solution vector, u(:,1) is x(t), y(:,2) is vx(t)
% te: array of event times
% ue: solution vector at the event times in te
% ie: index for the event which occurred, useful when you
%     have an array of events you are watching instead of
%     just a single type of event.  In this example ie=1
%     for the x=0 crossings, with x increasing, and ie=2
%     for the vx=0 crossings, with vx decreasing.

% separate the x=0 events from the vx=0 events
% by loading x1 and v1 with the x-positions and
% v-velocities when x=0 and by loading x2 and v2
% with the positions and velocities when v=0

n1=0;n2=0;
for m=1:length(ie)

   if ie(m)==1
      n1=n1+1;
%  load event 1: x,v,t
      x1(n1)=ue(m,1);v1(n1)=ue(m,2);t1(n1)=te(m);
   end

% load event 2: x,v,t
   if ie(m)==2
      n2=n2+1;
      x2(n2)=ue(m,1);v2(n2)=ue(m,2);t2(n2)=te(m);
   end
end

% plot the harmonic oscillator position vs time
plot(t,u(:,1),'g-')
hold on

% plot the x=0 crossings with red asterisks and the v=0
% crossings with blue asterisks
plot(t1,x1,'r*')
plot(t2,x2,'b*')

hold off

function rhs=eventrhs(t,u,omega)
%  eventrhs.m, Matlab function to compute [du(1)/dt;du(2)/dt]

% right-hand side for the simple harmonic oscillator
% make sure rhs is a column vector

rhs(1,1)=u(2);
rhs(2,1)=-omega^2*u(1);

function F=rhs(t,u)
% right-hand side function for Matlab's ordinary
% differential equation solvers: simple harmonic
% oscillator example:
%
% It is a good idea to write a comment to remind yourself
% how the variables are arranged in the vector u.
%
% In our case we will use:
%     u(1) -> x
%     u(2) -> v


% declare the frequency to be global so its value
% set in the main script can be used here
global w0;

% make the column vector F filled
% with zeros
F=zeros(length(u),1);

% Now build the elements of F

% Recall that in our ordering of the vector u we have:
%
%     du(1)                 dx
%     ----  = F(1)   ->     -- = v
%      dt                   dt
%
% so the equation dx/dt=v means that F(1)=u(2)
F(1)=u(2);

% Again, in our ordering we have:
%
%     du(2)                 dv
%     ----  = F(2)   ->     -- = -w0^2*x
%      dt                   dt
%
% so the equation dv/dt=-w0^2*x means that F(2)=-w0^2*u(1)
F(2)=-w0^2*u(1);

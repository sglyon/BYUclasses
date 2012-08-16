function [value,isterminal,direction] = events(t,u,omega)
%   function to control event finding by Matlab's ode solvers


% Locate the time and velocity when x=0 and x is increasing

% value array: same dimension as the solution u.  An event is
%              defined by having some combination of the
%              variables be zero. Since value has the same size
%              as u (2 in this case) we can event find on two
%              conditions.  Should be a column vector

% load value(1) with the expression which,
% when it is zero, defines the event, u(1)=0 in this case.
value(1,1) = u(1);

% load value(2) with a second event condition, vx=0
% (u(2)=0) in this case.  If you don't want a second
% event just set value(2)=1 so it is never 0.
value(2,1)=u(2);


% this vector tells the integrator whether
% to stop or not when the event occurs.
% 1 means stop, 0 means keep going.  isterminal
% must have the same length as y (2 in this case).
% Should be a column vector
isterminal = [0 ; 0];


% direction modifier on the event:
% 1 means value=0 and is increasing;
% -1 means value=0 and is decreasing;
% 0 means value is zero and you don't care
% whether it is increasing or decreasing.
% direction must have the same length as y.
% should be a column vector
direction = [1 ; -1];

˜function F = rsh6_4c(t, u)
% right-hand side function for Matlab's ordinary
% differential equation solvers: Driven Pendulum problem
% ..        2
% th =  - w0 * sin(th) + alpha * sin(wt) * t
%
% th' = omega
% omega' = - w0^2 * sin(th)
%
% u(1) -> theta
% u(2) -> omega

global w0, alpha, wt;
global t;  % How to deal with t on rhs?

F = zeros(length(u), 1) ; 

F(1) = u(2);
F(2) =  - w0 ^2 * sin(u(1)) + alpha * sin(wt) * t;
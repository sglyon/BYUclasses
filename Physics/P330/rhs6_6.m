function F = rhs6_6(t, u)
% right-hand side function for Matlab's ordinary
% differential equation solvers: Driven Pendulum problem with damping
% ..                      2
% th = gamma * omega  - w0 * sin(th) + alpha * sin(wt) * t
%
% th' = omega
% omega' = gamma * omega - w0^2 * sin(th) + alpha * sin(wt) * t
%
% u(1) -> theta
% u(2) -> omega

global w0 alpha wt gamma;

F = zeros(length(u), 1) ; 

F(1) = u(2);
F(2) =  gamma * u(2) - w0 ^2 * sin(u(1)) + alpha * sin(wt * t);
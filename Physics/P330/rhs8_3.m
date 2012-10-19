function F = rhs8_3(t, u)
% right-hand side function for Matlab's ordinary
% differential equation solvers: Driven Pendulum problem with damping
%
% x'' + gamma * x' + w0 ^ 2 (1 + epsilon * cos(wp * t)) * x = 0
%
% x' = v
% v' = - gamma * v - w0^2 * (1 + epsilon * cos(wp * t)) * x
%
% u(1) -> x
% u(2) -> v

global w0 gamma epsilon wp

F = zeros(length(u), 1) ;

F(1) = u(2);
F(2) = - gamma * u(2) - w0^2 * (1 + epsilon * cos(wp * t)) * u(1);
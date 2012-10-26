function F = rhs9_1(t, u)
% right-hand side function for Matlab's ordinary
% differential equation solvers: Driven Pendulum problem with damping
%
% x'' - eps*(l^2 - x^2)*x' + w0^2*x = 0
%
%
% x' = v
% a = v' = x'' = eps * (l^2 - x^2) *v - w0^2 * x
%
%
% u(1) -> x
% u(2) -> v

global l epsi w0

F = zeros(length(u), 1);

F(1) = u(2);
F(2) = epsi .* (l^2 - u(1) .^ 2) .* u(2) - w0^2 .* u(1);
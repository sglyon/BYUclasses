function F = rhs9_1(t, u)
% right-hand side function for Matlab's ordinary
% differential equation solvers: Driven van der pol oscillator
%
% x'' - eps*(l^2 - x^2)*x' + w0^2*x = A * cos( w * t)
%
%
% x' = v
% a = v' = x'' = eps * (l^2 - x^2) *v - w0^2 * x + A * cos(w * t)
%
%
% u(1) -> x
% u(2) -> v

global l epsi w0 omega A

F = zeros(length(u), 1);

F(1) = u(2);
F(2) = epsi .* (l^2 - u(1) .^ 2) .* u(2) - w0^2 .* u(1) + A * cos(omega * t);
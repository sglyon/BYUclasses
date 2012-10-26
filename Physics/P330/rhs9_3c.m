function F = rhs9_3c(t, u)
% right-hand side function for Matlab's ordinary
% differential equation solvers: Chaotic potential well with driven force
%
% dF/dx = - dU/dx = - d/dx( -x^2 / 2 + x^4 / x)
% dF/dx = x - x^3
% F = x^2 / 2 - x^4 / 4 + C (C goes away because we assume no init accel.)
% m x'' = F = x^2 / 2 - x^4 / 4
%
%
%
% u(1) -> x
% u(2) -> v
global A gamma

F = zeros(length(u), 1);

F(1) = u(2);
F(2) = u(1) - u(1)^3 + A * cos(2 * t) - gamma * u(2);

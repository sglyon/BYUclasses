function F = rhs9_3a(t, u)
% right-hand side function for Matlab's ordinary
% differential equation solvers: Chaotic potential well
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

F = zeros(length(u), 1);

F(1) = u(2);
F(2) = u(1) - u(1)^3;

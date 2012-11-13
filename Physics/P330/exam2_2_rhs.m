function F = exam2_2_rhs(t, u)
% right-hand side function for Matlab's ordinary
% differential equation solvers: Exam 2 problem 2
%
% x' = sigma * (y - x)
% y' = x * (rho - z) - y
% z' = x * y - beta * z
%
%
%
%
% u(1) -> x
% u(2) -> y
% u(3) -> z

global sigma rho cbeta

F = zeros(length(u), 1) ;

F(1) = sigma * (u(2) - u(1));
F(2) = u(1) * (rho - u(3)) - u(2);
F(3) = u(1) .* u(2) - cbeta * u(3);

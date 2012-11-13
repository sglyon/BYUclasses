function F = exam2_1_rhs(t, u)
% right-hand side function for Matlab's ordinary
% differential equation solvers: Exam 2 problem 1
%
% 5 * x'''  + 3 * x ^ 2 x'' + 2 * x * x' = 0
%
% x' = a
% b = a' = x''
% c = b' = a'' = x''' = -3 / 5 * x ^ 2 * b - 2 / 5 * x * a
%
%
% u(1) -> x
% u(2) -> a
% u(3) -> b


F = zeros(length(u), 1) ;

F(1) = u(2);
F(2) = u(3);
F(3) = - 3 / 5 * u(1) .^ 2 .* u(3) - 2 / 5 * u(1) * u(2);

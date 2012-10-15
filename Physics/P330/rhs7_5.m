function F = rhs7_5(t, u)
% right-hand side function for Matlab's ordinary
% differential equation solvers: Damped harmonic oscillator
%  ..                                        .
% y(t) =  - omega_0 ^ 2 * y(t) - 2 * gamma * y(y)
%
% y' = v
% v' = - omega_0 ^ 2 * y - 2 * gamma * v
%
% u(1) -> y
% u(2) -> v

global w0  gamma;

F = zeros(length(u), 1) ;

F(1) = u(2);
F(2) =  - w0 ^ 2 * u(1) - 2 * gamma * u(2);
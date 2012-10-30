function F = rhs10_2d(t, u)
% right-hand side function for Matlab's ordinary
% differential equation solvers: Driven Pendulum problem with damping
%
% th1' = w1
% th2' = w2
% w1' = -w0^2 * th1 - wc^2 * (th1 - th2)
% w2' = -w0^2 * th2 - wc^2 * (th2 - th1) -gamma*w2
%
%
%
% u(1) -> th1
% u(2) -> th2
% u(3) -> w1
% u(4) -> w2

global w0 wc gam

F = zeros(length(u), 1);

F(1) = u(3);
F(2) = u(4);
F(3) = -w0^2 * u(1) - wc^2 * (u(1) - u(2));
F(4) = -w0^2 * u(2) - wc^2 * (u(2) - u(1)) - gam*u(4);

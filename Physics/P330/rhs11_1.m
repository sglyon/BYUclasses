function F = rhs11_1(t, u)
% right-hand side function for Matlab's ordinary
% differential equation solvers: Driven Pendulum problem with damping
%
% th'' =  - w0 ^ 2 * sin(th) - b * w ^ 2 / L * sin(th) * sin(w * t)
% TH'' =  - w0 ^ 2 * sin(TH) - (b * w) ^ 2 / (2 * L) * sin(TH) * cos(TH)
% w1' = -w0^2 * th1 - wc^2 * (th1 - th2)
% w2' = -w0^2 * th2 - wc^2 * (th2 - th1)
%
%
%
% u(1) -> th
% u(2) -> w1
% u(3) -> TH
% u(4) -> W1

global w0 w L b

F = zeros(length(u), 1);

F(1) = u(2);
F(2) =  - w0 ^ 2 * sin(u(1)) - b * w ^ 2 / L * sin(u(1)) * sin(w * t);
F(3) = u(4);
F(4) = - w0 ^ 2 * sin(u(3)) - (b * w) ^ 2 / (2 * L) * sin(u(3)) * cos(u(3));

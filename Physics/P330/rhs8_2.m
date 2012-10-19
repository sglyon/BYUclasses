function F = rhs8_2(t, u)
% right-hand side function for Matlab's ordinary
% differential equation solvers: Driven Pendulum problem with damping
%
% th'' + gamma * th' + w0^2 * sin(th) = alpha * cos(wPhi * t)
%
% th' = omega
% w' = -gamma * w - w0^2 sin(th) + alpha * cos(wPhi * t)
%
% u(1) -> theta
% u(2) -> omega

global alpha w0squared wPhi gamma

F = zeros(length(u), 1) ;

F(1) = u(2);
F(2) = -gamma * u(2) - w0squared * sin(u(1)) + alpha * cos(wPhi * t);
function F = rhs8_8(t, u)
% right-hand side function for Matlab's ordinary
% differential equation solvers: Driven Pendulum problem with damping
%
% th'' + 2 (l'/ l) th' + gamma th' + (g/l) sin(th) = 0
%
% l = L0 + DL * cos(wp * t)
% l' = - wp * DL * sin(w  *t)
%
% th' = w
% alpha = w' = th'' = (2*DL*wp*sin(wp*t)) / (L0 + DL*cos(wp*t)) * th'
%                    - gamma * th' - (g * sin(th) / (Lo + DL*cos(wp*t)))
%
% u(1) -> th
% u(2) -> w
% u(3) -> alpha

global L0 gamma g w0 DL wp

F = zeros(length(u), 1);

F(1) = u(2);
F(2) = (2*DL*sin(wp*t)) / (L0 + DL*cos(wp*t)) * u(2) - gamma * u(2) ...
         - (g / (L0 + DL*cos(wp*t))) * sin(u(1));

function F = rhs12_3(t, u)
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
% u(1) -> x1
% u(2) -> vx1
% u(3) -> y1
% u(4) -> vy1
% u(5) -> z1
% u(6) -> vz1
% u(7) -> x2
% u(8) -> vx2
% u(9) -> y2
% u(10) -> vy2
% u(11) -> z2
% u(12) -> vz2

global G m1 m2 power

r1_r2 = [u(1)-u(7), u(3) - u(9), u(5) - u(11)];
the_norm = (r1_r2(1) ^ 2 + r1_r2(2) ^ 2 + r1_r2(3) ^ 2) ^ (power/2);

F = zeros(length(u), 1);

F(1) = u(2);
F(2) = - G * m2 * (u(1) - u(7)) / the_norm;
F(3) = u(4);
F(4) = - G * m2 * (u(3) - u(9)) / the_norm;
F(5) = u(6);
F(6) = - G * m2 * (u(5) - u(11)) / the_norm;
F(7) = u(8);
F(8) = - G * m1 * (u(7) - u(1)) / the_norm;
F(9) = u(10);
F(10) = - G * m1 * (u(9) - u(3)) / the_norm;
F(11) = u(12);
F(12) = - G * m1 * (u(11) - u(5)) / the_norm;

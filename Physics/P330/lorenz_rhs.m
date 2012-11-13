function F = lorenz_rhs(t,u)
global P r b
F = zeros(3,1);

F(1) = P * (u(2) - u(1));
F(2) =  - u(1) * u(3) + r * u(1) - u(2);
F(3) = u(1) * u(2) - b * u(3);
function T = ST(T,v,vp,rho,rhop)

global gamma F A B h tau N;

% Clear A and B (pre-allocated in main program)
A=A*0;
B=A;

% Load interior points
for j=2:N+1
    D1 = (v(j) + vp(j))/(4*h) + 2*F/(rho(j)+rhop(j))/h^2;
    D2 = -(gamma-1) * (v(j+1) + vp(j+1) - v(j-1) - vp(j-1) )/(4*h) ...
         - 4*F/(rho(j) + rhop(j))/h^2;
    D3 = -(v(j) + vp(j))/(4*h) + 2*F/(rho(j)+rhop(j))/h^2;
    A(j,j-1)=-0.5*D1;
    A(j,j)=1/tau - 0.5*D2;
    A(j,j+1)=-0.5*D3;
    B(j,j-1)=0.5*D1;
    B(j,j)=1/tau + 0.5*D2;
    B(j,j+1)=0.5*D3;
end

% Apply boundary condition
% Insulating: dt/dx = 0
.
.
.

% Crank Nicolson solve to step rho in time
r = B*T;
T = A\r;

end

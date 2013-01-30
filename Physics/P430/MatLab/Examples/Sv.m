function v = Sv(v,vbar,vbarp,rho,rhop,T,Tp)

global kB mu M A B h tau N;

% Clear A and B (pre-allocated in main program)
A=A*0;
B=A;

E0 = v * 0; % create the constant term the right size

% Load interior points
for j=2:N+1
    E0(j) = -kB/4/h/M/(rho(j)+rhop(j)) * ...
        ( (rho(j+1) + rhop(j+1)) * (T(j+1) + Tp(j+1)) ...
        - (rho(j-1) + rhop(j-1)) * (T(j-1) + Tp(j-1)));
    E1 = (vbar(j) + vbarp(j))/(4*h) ...
        +8*mu/3/h^2/(rho(j)+rhop(j));
    E2 =-16*mu/3/h^2/(rho(j)+rhop(j));
    E3 =-(vbar(j) + vbarp(j))/(4*h) ...
        +8*mu/3/h^2/(rho(j)+rhop(j));
    A(j,j-1)=-0.5*E1;
    A(j,j)=1/tau - 0.5*E2;
    A(j,j+1)=-0.5*E3;
    B(j,j-1)=0.5*E1;
    B(j,j)=1/tau + 0.5*E2;
    B(j,j+1)=0.5*E3;
end

% Apply boundary condition
% Fixed: v = 0
.
.
.

% Crank Nicolson solve to step rho in time
r = B*v + E0;
v = A\r;

end

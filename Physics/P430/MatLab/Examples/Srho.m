function rho = Srho(rho,v,vp)
% Step rho forward in time by using Crank-Nicolson
% on the continuity equation

global A B h tau N;

% Clear A and B (pre-allocated in main program)
A=A*0;
B=A;

% Load interior points
for j=2:N+1
    C1 = -tau * (v(j+1) + vp(j+1)) / (8*h);
    C2 = -tau * (v(j-1) + vp(j-1)) / (8*h);
    A(j,j-1)=C2;
    A(j,j)=1;
    A(j,j+1)=-C1;
    B(j,j-1)=-C2;
    B(j,j)=1;
    B(j,j+1)=C1;
end

% Apply boundary condition
.
.
.

% Crank Nicolson solve to step rho in time
r = B*rho;
rho = A\r;

end

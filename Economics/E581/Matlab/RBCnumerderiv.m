function [AA, BB, CC, DD, FF, GG, HH, JJ, KK, LL, MM, TT] = RBCnumerderiv(funcname,theta0,nx,ny,nz)

%This function takes the following inputs:
%  funcname - is the name of the function which generates a column vector from ny+nx dynamic equations
%    with the ny eqyations to be linearized into AX(t)+BX(t-1)+CY(t)+DZ(t)=0 in the first ny rows
%    the function must be written so as to evaluate to zero for all rows in the steady state
%  xyzbar - is a matrix of nx+ny steady state values
%    with the values of xbar in the first nx rows, the values of ybar in
%    the middle ny rows, and the values of zbar in the last nz rows
%  nx - is the number of elements in X
%  ny - is the number of elements in Y
%  nz - is the number of elements in Z
%The function generates matrices AA thru MM from the log-lineaization of the equations in the function "funcname"

incr = .00000001;    %increment to use in calculating numerical derivatives
T0 = funcname(theta0);  %this should be zero or very close to it when evaluating at the SS

% create matrix of deviations for input, dev
% deviate columns by adding incr
leng = 3*nx+2*(ny+nz);
dev=repmat(theta0',leng,1);
for i=1:leng
  dev(i,i)=dev(i,i)+incr;
end

% calculate a matrix of deviations for dynamic equations, big
% rows correspond to equations
% colums correspond to variables from "theta0" vector being changed
% note output of RBC2dyn is a column vector
big = zeros(nx+ny,leng);
%note we add a 1 to TO since the functions evaluate to 0 in the SS, not 1.
for i = 1:leng
    if i<3*nx+2*ny+1
        big(:,i) = theta0(i)*(funcname(dev(i,:)')-T0)./(1+T0);
    else
        big(:,i) = (funcname(dev(i,:)')-T0)./(1+T0);
    end
end
big = big/incr;

% pull out appropriate parts of "big" into Uhlig's matrices
AA = big(1:ny,nx+1:2*nx);
BB = big(1:ny,2*nx+1:3*nx);
CC = big(1:ny,3*nx+ny+1:3*nx+2*ny);
DD = big(1:ny,3*nx+2*ny+nz+1:leng);
FF = big(ny+1:ny+nx,1:nx);
GG = big(ny+1:ny+nx,nx+1:2*nx);
HH = big(ny+1:ny+nx,2*nx+1:3*nx);
JJ = big(ny+1:ny+nx,3*nx+1:3*nx+ny);
KK = big(ny+1:ny+nx,3*nx+ny+1:3*nx+2*ny);
LL = big(ny+1:ny+nx,3*nx+2*ny+1:3*nx+2*ny+nz);
MM = big(ny+1:ny+nx,3*nx+2*ny+nz+1:leng);
TT = log(1+T0);

end

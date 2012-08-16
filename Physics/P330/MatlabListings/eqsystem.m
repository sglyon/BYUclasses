% nonlinear system of equations routine for
% use with fsolve
function s=eqsystem(xn)

% Unpack the inputs into friendly names
x=xn(1);
y=xn(2);
z=xn(3);

Eq1 = sin(x*y)+exp(-x*z)-0.95908;
Eq2 = z*sqrt(x^2+y^2) -6.70820;
Eq3 = tan(y/x)+cos(z)+3.17503;

s=[ Eq1; Eq2; Eq3 ];

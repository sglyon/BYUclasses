function [residual, g1, g2] = hw8_4_static(y, x, params)
%
% Status : Computes static model for Dynare
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

residual = zeros( 10, 1);

%
% Model equations
%

T20 = (exp(y(9))*y(10))^params(10);
T22 = params(6)*y(8)^params(10)+(1-params(6))*T20;
T45 = params(7)*params(6)*y(8)^(params(10)-1);
T46 = 1/params(10)-1;
T47 = T22^T46;
T56 = (params(6)*y(8)^params(10)-T20*(params(6)-1))^T46;
T84 = (1-y(10))^params(2);
T96 = params(6)*getPowerDeriv(y(8),params(10),1);
T97 = getPowerDeriv(T22,1/params(10),1);
T103 = getPowerDeriv(T22,T46,1);
T109 = getPowerDeriv(params(6)*y(8)^params(10)-T20*(params(6)-1),T46,1);
T117 = exp(y(9))*y(10)*getPowerDeriv(exp(y(9))*y(10),params(10),1);
T118 = (1-params(6))*T117;
T136 = exp(y(9))*getPowerDeriv(exp(y(9))*y(10),params(10),1);
T137 = (1-params(6))*T136;
lhs =y(2);
rhs =params(7)*T22^(1/params(10));
residual(1)= lhs-rhs;
lhs =y(6);
rhs =1/(1-params(3))*(y(1)^(1-params(3))-1)+params(1)*log(1-y(10));
residual(2)= lhs-rhs;
lhs =y(4);
rhs =T45*T47;
residual(3)= lhs-rhs;
lhs =y(5);
rhs =T20*params(7)*(1-params(6))*T56/y(10);
residual(4)= lhs-rhs;
lhs =y(3);
rhs =y(8)-y(8)*(1-params(5));
residual(5)= lhs-rhs;
lhs =y(1);
rhs =y(2)-y(3);
residual(6)= lhs-rhs;
lhs =y(7);
rhs =exp(y(9));
residual(7)= lhs-rhs;
lhs =1;
rhs =params(4)*(1+y(4)-params(5));
residual(8)= lhs-rhs;
lhs =y(9);
rhs =y(9)*params(8)+x(1);
residual(9)= lhs-rhs;
lhs =y(5)*y(1)^(-params(3))*T84;
rhs =params(1);
residual(10)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(10, 10);

  %
  % Jacobian matrix
  %

  g1(1,2)=1;
  g1(1,8)=(-(params(7)*T96*T97));
  g1(1,9)=(-(params(7)*T97*T118));
  g1(1,10)=(-(params(7)*T97*T137));
  g1(2,1)=(-(1/(1-params(3))*getPowerDeriv(y(1),1-params(3),1)));
  g1(2,6)=1;
  g1(2,10)=(-(params(1)*(-1)/(1-y(10))));
  g1(3,4)=1;
  g1(3,8)=(-(T47*params(7)*params(6)*getPowerDeriv(y(8),params(10)-1,1)+T45*T96*T103));
  g1(3,9)=(-(T45*T103*T118));
  g1(3,10)=(-(T45*T103*T137));
  g1(4,5)=1;
  g1(4,8)=(-(T20*params(7)*(1-params(6))*T96*T109/y(10)));
  g1(4,9)=(-((T56*params(7)*(1-params(6))*T117+T20*params(7)*(1-params(6))*T109*(-((params(6)-1)*T117)))/y(10)));
  g1(4,10)=(-((y(10)*(T56*params(7)*(1-params(6))*T136+T20*params(7)*(1-params(6))*T109*(-((params(6)-1)*T136)))-T20*params(7)*(1-params(6))*T56)/(y(10)*y(10))));
  g1(5,3)=1;
  g1(5,8)=(-(1-(1-params(5))));
  g1(6,1)=1;
  g1(6,2)=(-1);
  g1(6,3)=1;
  g1(7,7)=1;
  g1(7,9)=(-exp(y(9)));
  g1(8,4)=(-params(4));
  g1(9,9)=1-params(8);
  g1(10,1)=T84*y(5)*getPowerDeriv(y(1),(-params(3)),1);
  g1(10,5)=y(1)^(-params(3))*T84;
  g1(10,10)=y(5)*y(1)^(-params(3))*(-(getPowerDeriv(1-y(10),params(2),1)));
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],10,100);
end
end

function [residual, g1, g2] = hw8_3_static(y, x, params)
%
% Status : Computes static model for Dynare
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

residual = zeros( 9, 1);

%
% Model equations
%

T20 = (exp(y(9))*params(7))^params(11);
T22 = params(6)*y(8)^params(11)+(1-params(6))*T20;
T45 = params(8)*params(6)*y(8)^(params(11)-1);
T46 = 1/params(11)-1;
T47 = T22^T46;
T56 = (params(6)*y(8)^params(11)-T20*(params(6)-1))^T46;
T85 = params(6)*getPowerDeriv(y(8),params(11),1);
T86 = getPowerDeriv(T22,1/params(11),1);
T92 = getPowerDeriv(T22,T46,1);
T98 = getPowerDeriv(params(6)*y(8)^params(11)-T20*(params(6)-1),T46,1);
T106 = exp(y(9))*params(7)*getPowerDeriv(exp(y(9))*params(7),params(11),1);
T107 = (1-params(6))*T106;
lhs =y(2);
rhs =params(8)*T22^(1/params(11));
residual(1)= lhs-rhs;
lhs =y(6);
rhs =1/(1-params(3))*(y(1)^(1-params(3))-1)+params(1)*log(1-params(7));
residual(2)= lhs-rhs;
lhs =y(4);
rhs =T45*T47;
residual(3)= lhs-rhs;
lhs =y(5);
rhs =T20*params(8)*(1-params(6))*T56/params(7);
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
rhs =y(9)*params(9)+x(1);
residual(9)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(9, 9);

  %
  % Jacobian matrix
  %

  g1(1,2)=1;
  g1(1,8)=(-(params(8)*T85*T86));
  g1(1,9)=(-(params(8)*T86*T107));
  g1(2,1)=(-(1/(1-params(3))*getPowerDeriv(y(1),1-params(3),1)));
  g1(2,6)=1;
  g1(3,4)=1;
  g1(3,8)=(-(T47*params(8)*params(6)*getPowerDeriv(y(8),params(11)-1,1)+T45*T85*T92));
  g1(3,9)=(-(T45*T92*T107));
  g1(4,5)=1;
  g1(4,8)=(-(T20*params(8)*(1-params(6))*T85*T98/params(7)));
  g1(4,9)=(-((T56*params(8)*(1-params(6))*T106+T20*params(8)*(1-params(6))*T98*(-((params(6)-1)*T106)))/params(7)));
  g1(5,3)=1;
  g1(5,8)=(-(1-(1-params(5))));
  g1(6,1)=1;
  g1(6,2)=(-1);
  g1(6,3)=1;
  g1(7,7)=1;
  g1(7,9)=(-exp(y(9)));
  g1(8,4)=(-params(4));
  g1(9,9)=1-params(9);
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],9,81);
end
end

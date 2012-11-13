function [residual, g1, g2] = cash_in_advance_static(y, x, params)
%
% Status : Computes static model for Dynare
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

residual = zeros( 12, 1);

%
% Model equations
%

T39 = y(5)/(y(5)*exp(params(5)));
T56 = params(3)*y(2)^(params(4)-1);
T64 = params(3)*y(2)^params(4)+(1-params(3))*(y(3)*y(10))^params(4);
T67 = T64^(1/params(4)-1);
T72 = (1-params(3))*y(10)*(y(3)*y(10))^(params(4)-1);
T117 = getPowerDeriv(T64,1/params(4)-1,1);
T127 = getPowerDeriv(T64,1/params(4),1);
lhs =y(1);
rhs =(1+params(9)+y(11))/y(7);
residual(1)= lhs-rhs;
lhs =y(3)*y(5);
rhs =(1+params(9)+y(11))/y(7)+y(2)*(1+params(5)+params(8))-y(2)*(1+y(6)-params(2));
residual(2)= lhs-rhs;
lhs =1;
rhs =params(1)*(1+y(6)-params(2))*(1-y(3))/(1-y(3))*T39;
residual(3)= lhs-rhs;
lhs =1;
rhs =params(1)*(1-y(3))*y(7)*y(5)/(y(1)*y(7)*exp(y(11)-params(8)));
residual(4)= lhs-rhs;
lhs =y(6);
rhs =T56*T67;
residual(5)= lhs-rhs;
lhs =y(5);
rhs =T67*T72;
residual(6)= lhs-rhs;
lhs =y(11);
rhs =y(11)*params(12)+x(2);
residual(7)= lhs-rhs;
lhs =y(12);
rhs =y(12)*params(10)+x(1);
residual(8)= lhs-rhs;
lhs =y(10);
rhs =exp(y(12));
residual(9)= lhs-rhs;
lhs =y(8);
rhs =y(2)*(1+params(5)+params(8))-y(2)*(1-params(2));
residual(10)= lhs-rhs;
lhs =y(4);
rhs =T64^(1/params(4));
residual(11)= lhs-rhs;
lhs =y(9);
rhs =log(y(1))+params(6)*log(1-y(3));
residual(12)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(12, 12);

  %
  % Jacobian matrix
  %

  g1(1,1)=1;
  g1(1,7)=(-((-(1+params(9)+y(11)))/(y(7)*y(7))));
  g1(1,11)=(-(1/y(7)));
  g1(2,2)=(-(1+params(5)+params(8)-(1+y(6)-params(2))));
  g1(2,3)=y(5);
  g1(2,5)=y(3);
  g1(2,6)=y(2);
  g1(2,7)=(-((-(1+params(9)+y(11)))/(y(7)*y(7))));
  g1(2,11)=(-(1/y(7)));
  g1(3,3)=(-(params(1)*T39*((1-y(3))*(-(1+y(6)-params(2)))-(-((1+y(6)-params(2))*(1-y(3)))))/((1-y(3))*(1-y(3)))));
  g1(3,6)=(-(params(1)*T39));
  g1(4,1)=(-((-(params(1)*(1-y(3))*y(7)*y(5)*y(7)*exp(y(11)-params(8))))/(y(1)*y(7)*exp(y(11)-params(8))*y(1)*y(7)*exp(y(11)-params(8)))));
  g1(4,3)=(-(params(1)*(-(y(7)*y(5)))/(y(1)*y(7)*exp(y(11)-params(8)))));
  g1(4,5)=(-(params(1)*y(7)*(1-y(3))/(y(1)*y(7)*exp(y(11)-params(8)))));
  g1(4,7)=(-((y(1)*y(7)*exp(y(11)-params(8))*params(1)*y(5)*(1-y(3))-params(1)*(1-y(3))*y(7)*y(5)*y(1)*exp(y(11)-params(8)))/(y(1)*y(7)*exp(y(11)-params(8))*y(1)*y(7)*exp(y(11)-params(8)))));
  g1(4,11)=(-((-(params(1)*(1-y(3))*y(7)*y(5)*y(1)*y(7)*exp(y(11)-params(8))))/(y(1)*y(7)*exp(y(11)-params(8))*y(1)*y(7)*exp(y(11)-params(8)))));
  g1(5,2)=(-(T67*params(3)*getPowerDeriv(y(2),params(4)-1,1)+T56*params(3)*getPowerDeriv(y(2),params(4),1)*T117));
  g1(5,3)=(-(T56*T117*(1-params(3))*y(10)*getPowerDeriv(y(3)*y(10),params(4),1)));
  g1(5,6)=1;
  g1(5,10)=(-(T56*T117*(1-params(3))*y(3)*getPowerDeriv(y(3)*y(10),params(4),1)));
  g1(6,2)=(-(T72*params(3)*getPowerDeriv(y(2),params(4),1)*T117));
  g1(6,3)=(-(T72*T117*(1-params(3))*y(10)*getPowerDeriv(y(3)*y(10),params(4),1)+T67*(1-params(3))*y(10)*y(10)*getPowerDeriv(y(3)*y(10),params(4)-1,1)));
  g1(6,5)=1;
  g1(6,10)=(-(T72*T117*(1-params(3))*y(3)*getPowerDeriv(y(3)*y(10),params(4),1)+T67*((1-params(3))*(y(3)*y(10))^(params(4)-1)+(1-params(3))*y(10)*y(3)*getPowerDeriv(y(3)*y(10),params(4)-1,1))));
  g1(7,11)=1-params(12);
  g1(8,12)=1-params(10);
  g1(9,10)=1;
  g1(9,12)=(-exp(y(12)));
  g1(10,2)=(-(1+params(5)+params(8)-(1-params(2))));
  g1(10,8)=1;
  g1(11,2)=(-(params(3)*getPowerDeriv(y(2),params(4),1)*T127));
  g1(11,3)=(-(T127*(1-params(3))*y(10)*getPowerDeriv(y(3)*y(10),params(4),1)));
  g1(11,4)=1;
  g1(11,10)=(-(T127*(1-params(3))*y(3)*getPowerDeriv(y(3)*y(10),params(4),1)));
  g1(12,1)=(-(1/y(1)));
  g1(12,3)=(-(params(6)*(-1)/(1-y(3))));
  g1(12,9)=1;
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],12,144);
end
end

function [residual, g1, g2, g3] = hw8_3_dynamic(y, x, params, steady_state, it_)
%
% Status : Computes dynamic model for Dynare
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

%
% Model equations
%

residual = zeros(9, 1);
T20 = (exp(y(12))*params(7))^params(11);
T22 = params(6)*y(11)^params(11)+(1-params(6))*T20;
T23 = 1/params(11);
T45 = params(8)*params(6)*y(11)^(params(11)-1);
T46 = T23-1;
T47 = T22^T46;
T55 = params(6)*y(11)^params(11)-T20*(params(6)-1);
T56 = T55^T46;
T76 = params(4)*(y(4)/y(13))^params(3);
T92 = getPowerDeriv(y(4)/y(13),params(3),1);
T99 = (-y(4))/(y(13)*y(13));
T107 = params(6)*getPowerDeriv(y(11),params(11),1);
T108 = getPowerDeriv(T22,T23,1);
T113 = params(8)*params(6)*getPowerDeriv(y(11),params(11)-1,1);
T114 = getPowerDeriv(T22,T46,1);
T120 = getPowerDeriv(T55,T46,1);
T127 = exp(y(12))*params(7)*getPowerDeriv(exp(y(12))*params(7),params(11),1);
T128 = (1-params(6))*T127;
T146 = params(6)*getPowerDeriv(y(11),params(11),2);
T161 = T127+exp(y(12))*params(7)*exp(y(12))*params(7)*getPowerDeriv(exp(y(12))*params(7),params(11),2);
T162 = (1-params(6))*T161;
T225 = getPowerDeriv(y(4)/y(13),params(3),2);
T226 = 1/y(13)*T225;
lhs =y(5);
rhs =params(8)*T22^T23;
residual(1)= lhs-rhs;
lhs =y(9);
rhs =1/(1-params(3))*(y(4)^(1-params(3))-1)+params(1)*log(1-params(7));
residual(2)= lhs-rhs;
lhs =y(7);
rhs =T45*T47;
residual(3)= lhs-rhs;
lhs =y(8);
rhs =T20*params(8)*(1-params(6))*T56/params(7);
residual(4)= lhs-rhs;
lhs =y(1);
rhs =y(11)-(1-params(5))*y(2);
residual(5)= lhs-rhs;
lhs =y(4);
rhs =y(5)-y(6);
residual(6)= lhs-rhs;
lhs =y(10);
rhs =exp(y(12));
residual(7)= lhs-rhs;
lhs =1;
rhs =T76*(1+y(14)-params(5));
residual(8)= lhs-rhs;
lhs =y(12);
rhs =params(9)*y(3)+x(it_, 1);
residual(9)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(9, 15);

  %
  % Jacobian matrix
  %

  g1(1,5)=1;
  g1(1,11)=(-(params(8)*T107*T108));
  g1(1,12)=(-(params(8)*T108*T128));
  g1(2,4)=(-(1/(1-params(3))*getPowerDeriv(y(4),1-params(3),1)));
  g1(2,9)=1;
  g1(3,7)=1;
  g1(3,11)=(-(T47*T113+T45*T107*T114));
  g1(3,12)=(-(T45*T114*T128));
  g1(4,8)=1;
  g1(4,11)=(-(T20*params(8)*(1-params(6))*T107*T120/params(7)));
  g1(4,12)=(-((T56*params(8)*(1-params(6))*T127+T20*params(8)*(1-params(6))*T120*(-((params(6)-1)*T127)))/params(7)));
  g1(5,1)=1;
  g1(5,2)=1-params(5);
  g1(5,11)=(-1);
  g1(6,4)=1;
  g1(6,5)=(-1);
  g1(6,6)=1;
  g1(7,10)=1;
  g1(7,12)=(-exp(y(12)));
  g1(8,4)=(-((1+y(14)-params(5))*params(4)*1/y(13)*T92));
  g1(8,13)=(-((1+y(14)-params(5))*params(4)*T92*T99));
  g1(8,14)=(-T76);
  g1(9,3)=(-params(9));
  g1(9,12)=1;
  g1(9,15)=(-1);
end
if nargout >= 3,
  %
  % Hessian matrix
  %

  v2 = zeros(22,3);
  v2(1,1)=1;
  v2(1,2)=161;
  v2(1,3)=(-(params(8)*(T108*T146+T107*T107*getPowerDeriv(T22,T23,2))));
  v2(2,1)=1;
  v2(2,2)=176;
  v2(2,3)=(-(params(8)*T128*T107*getPowerDeriv(T22,T23,2)));
  v2(3,1)=1;
  v2(3,2)=162;
  v2(3,3)=  v2(2,3);
  v2(4,1)=1;
  v2(4,2)=177;
  v2(4,3)=(-(params(8)*(T128*T128*getPowerDeriv(T22,T23,2)+T108*T162)));
  v2(5,1)=2;
  v2(5,2)=49;
  v2(5,3)=(-(1/(1-params(3))*getPowerDeriv(y(4),1-params(3),2)));
  v2(6,1)=3;
  v2(6,2)=161;
  v2(6,3)=(-(T113*T107*T114+T47*params(8)*params(6)*getPowerDeriv(y(11),params(11)-1,2)+T113*T107*T114+T45*(T114*T146+T107*T107*getPowerDeriv(T22,T46,2))));
  v2(7,1)=3;
  v2(7,2)=176;
  v2(7,3)=(-(T113*T114*T128+T45*T128*T107*getPowerDeriv(T22,T46,2)));
  v2(8,1)=3;
  v2(8,2)=162;
  v2(8,3)=  v2(7,3);
  v2(9,1)=3;
  v2(9,2)=177;
  v2(9,3)=(-(T45*(T128*T128*getPowerDeriv(T22,T46,2)+T114*T162)));
  v2(10,1)=4;
  v2(10,2)=161;
  v2(10,3)=(-(T20*params(8)*(1-params(6))*(T120*T146+T107*T107*getPowerDeriv(T55,T46,2))/params(7)));
  v2(11,1)=4;
  v2(11,2)=176;
  v2(11,3)=(-((T107*T120*params(8)*(1-params(6))*T127+T20*params(8)*(1-params(6))*(-((params(6)-1)*T127))*T107*getPowerDeriv(T55,T46,2))/params(7)));
  v2(12,1)=4;
  v2(12,2)=162;
  v2(12,3)=  v2(11,3);
  v2(13,1)=4;
  v2(13,2)=177;
  v2(13,3)=(-((params(8)*(1-params(6))*T127*T120*(-((params(6)-1)*T127))+T56*params(8)*(1-params(6))*T161+params(8)*(1-params(6))*T127*T120*(-((params(6)-1)*T127))+T20*params(8)*(1-params(6))*((-((params(6)-1)*T127))*(-((params(6)-1)*T127))*getPowerDeriv(T55,T46,2)+T120*(-((params(6)-1)*T161))))/params(7)));
  v2(14,1)=7;
  v2(14,2)=177;
  v2(14,3)=(-exp(y(12)));
  v2(15,1)=8;
  v2(15,2)=49;
  v2(15,3)=(-((1+y(14)-params(5))*params(4)*1/y(13)*T226));
  v2(16,1)=8;
  v2(16,2)=184;
  v2(16,3)=(-((1+y(14)-params(5))*params(4)*(T99*T226+T92*(-1)/(y(13)*y(13)))));
  v2(17,1)=8;
  v2(17,2)=58;
  v2(17,3)=  v2(16,3);
  v2(18,1)=8;
  v2(18,2)=193;
  v2(18,3)=(-((1+y(14)-params(5))*params(4)*(T99*T99*T225+T92*(-((-y(4))*(y(13)+y(13))))/(y(13)*y(13)*y(13)*y(13)))));
  v2(19,1)=8;
  v2(19,2)=199;
  v2(19,3)=(-(params(4)*1/y(13)*T92));
  v2(20,1)=8;
  v2(20,2)=59;
  v2(20,3)=  v2(19,3);
  v2(21,1)=8;
  v2(21,2)=208;
  v2(21,3)=(-(params(4)*T92*T99));
  v2(22,1)=8;
  v2(22,2)=194;
  v2(22,3)=  v2(21,3);
  g2 = sparse(v2(:,1),v2(:,2),v2(:,3),9,225);
end
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],9,3375);
end
end

function [residual, g1, g2, g3] = hw8_2_dynamic(y, x, params, steady_state, it_)
%
% Status : Computes dynamic model for Dynare
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

%
% Model equations
%

residual = zeros(10, 1);
T13 = params(7)*y(11)^params(6);
T19 = (exp(y(12))*y(13))^(1-params(6));
T38 = exp(y(12))*y(13)/y(11);
T45 = params(7)*(1-params(6))*exp(y(12))^(1-params(6));
T47 = (y(11)/y(13))^params(6);
T66 = params(4)*(y(4)/y(14))^params(3);
T79 = y(4)^(-params(3));
T82 = (1-y(13))^params(2);
T89 = getPowerDeriv(y(4)/y(14),params(3),1);
T99 = (-y(4))/(y(14)*y(14));
T108 = params(7)*getPowerDeriv(y(11),params(6),1);
T113 = (-(exp(y(12))*y(13)))/(y(11)*y(11));
T114 = getPowerDeriv(T38,1-params(6),1);
T119 = getPowerDeriv(y(11)/y(13),params(6),1);
T125 = exp(y(12))*y(13)*getPowerDeriv(exp(y(12))*y(13),1-params(6),1);
T133 = params(7)*(1-params(6))*exp(y(12))*getPowerDeriv(exp(y(12)),1-params(6),1);
T137 = exp(y(12))*getPowerDeriv(exp(y(12))*y(13),1-params(6),1);
T143 = exp(y(12))/y(11);
T149 = (-y(11))/(y(13)*y(13));
T154 = (-(getPowerDeriv(1-y(13),params(2),1)));
T163 = exp(y(12))*y(13)*getPowerDeriv(exp(y(12))*y(13),1-params(6),2);
T190 = getPowerDeriv(T38,1-params(6),2);
T191 = T113*T190;
T220 = getPowerDeriv(y(11)/y(13),params(6),2);
T221 = 1/y(13)*T220;
T253 = getPowerDeriv(y(4)/y(14),params(3),2);
T254 = 1/y(14)*T253;
lhs =y(5);
rhs =T13*T19;
residual(1)= lhs-rhs;
lhs =y(9);
rhs =1/(1-params(3))*(y(4)^(1-params(3))-1)+params(1)*log(1-y(13));
residual(2)= lhs-rhs;
lhs =y(7);
rhs =params(7)*params(6)*T38^(1-params(6));
residual(3)= lhs-rhs;
lhs =y(8);
rhs =T45*T47;
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
rhs =T66*(1+y(15)-params(5));
residual(8)= lhs-rhs;
lhs =y(12);
rhs =params(8)*y(3)+x(it_, 1);
residual(9)= lhs-rhs;
lhs =y(8)*T79*T82;
rhs =params(1);
residual(10)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(10, 16);

  %
  % Jacobian matrix
  %

  g1(1,5)=1;
  g1(1,11)=(-(T19*T108));
  g1(1,12)=(-(T13*T125));
  g1(1,13)=(-(T13*T137));
  g1(2,4)=(-(1/(1-params(3))*getPowerDeriv(y(4),1-params(3),1)));
  g1(2,9)=1;
  g1(2,13)=(-(params(1)*(-1)/(1-y(13))));
  g1(3,7)=1;
  g1(3,11)=(-(params(7)*params(6)*T113*T114));
  g1(3,12)=(-(params(7)*params(6)*T38*T114));
  g1(3,13)=(-(params(7)*params(6)*T114*T143));
  g1(4,8)=1;
  g1(4,11)=(-(T45*1/y(13)*T119));
  g1(4,12)=(-(T47*T133));
  g1(4,13)=(-(T45*T119*T149));
  g1(5,1)=1;
  g1(5,2)=1-params(5);
  g1(5,11)=(-1);
  g1(6,4)=1;
  g1(6,5)=(-1);
  g1(6,6)=1;
  g1(7,10)=1;
  g1(7,12)=(-exp(y(12)));
  g1(8,4)=(-((1+y(15)-params(5))*params(4)*1/y(14)*T89));
  g1(8,14)=(-((1+y(15)-params(5))*params(4)*T89*T99));
  g1(8,15)=(-T66);
  g1(9,3)=(-params(8));
  g1(9,12)=1;
  g1(9,16)=(-1);
  g1(10,4)=T82*y(8)*getPowerDeriv(y(4),(-params(3)),1);
  g1(10,8)=T79*T82;
  g1(10,13)=y(8)*T79*T154;
end
if nargout >= 3,
  %
  % Hessian matrix
  %

  v2 = zeros(46,3);
  v2(1,1)=1;
  v2(1,2)=171;
  v2(1,3)=(-(T19*params(7)*getPowerDeriv(y(11),params(6),2)));
  v2(2,1)=1;
  v2(2,2)=187;
  v2(2,3)=(-(T108*T125));
  v2(3,1)=1;
  v2(3,2)=172;
  v2(3,3)=  v2(2,3);
  v2(4,1)=1;
  v2(4,2)=188;
  v2(4,3)=(-(T13*(T125+exp(y(12))*y(13)*T163)));
  v2(5,1)=1;
  v2(5,2)=203;
  v2(5,3)=(-(T108*T137));
  v2(6,1)=1;
  v2(6,2)=173;
  v2(6,3)=  v2(5,3);
  v2(7,1)=1;
  v2(7,2)=204;
  v2(7,3)=(-(T13*(T137+exp(y(12))*T163)));
  v2(8,1)=1;
  v2(8,2)=189;
  v2(8,3)=  v2(7,3);
  v2(9,1)=1;
  v2(9,2)=205;
  v2(9,3)=(-(T13*exp(y(12))*exp(y(12))*getPowerDeriv(exp(y(12))*y(13),1-params(6),2)));
  v2(10,1)=2;
  v2(10,2)=52;
  v2(10,3)=(-(1/(1-params(3))*getPowerDeriv(y(4),1-params(3),2)));
  v2(11,1)=2;
  v2(11,2)=205;
  v2(11,3)=(-(params(1)*(-1)/((1-y(13))*(1-y(13)))));
  v2(12,1)=3;
  v2(12,2)=171;
  v2(12,3)=(-(params(7)*params(6)*(T114*(-((-(exp(y(12))*y(13)))*(y(11)+y(11))))/(y(11)*y(11)*y(11)*y(11))+T113*T191)));
  v2(13,1)=3;
  v2(13,2)=187;
  v2(13,3)=(-(params(7)*params(6)*(T113*T114+T38*T191)));
  v2(14,1)=3;
  v2(14,2)=172;
  v2(14,3)=  v2(13,3);
  v2(15,1)=3;
  v2(15,2)=188;
  v2(15,3)=(-(params(7)*params(6)*(T38*T114+T38*T38*T190)));
  v2(16,1)=3;
  v2(16,2)=203;
  v2(16,3)=(-(params(7)*params(6)*(T143*T191+T114*(-exp(y(12)))/(y(11)*y(11)))));
  v2(17,1)=3;
  v2(17,2)=173;
  v2(17,3)=  v2(16,3);
  v2(18,1)=3;
  v2(18,2)=204;
  v2(18,3)=(-(params(7)*params(6)*(T114*T143+T143*T38*T190)));
  v2(19,1)=3;
  v2(19,2)=189;
  v2(19,3)=  v2(18,3);
  v2(20,1)=3;
  v2(20,2)=205;
  v2(20,3)=(-(params(7)*params(6)*T143*T143*T190));
  v2(21,1)=4;
  v2(21,2)=171;
  v2(21,3)=(-(T45*1/y(13)*T221));
  v2(22,1)=4;
  v2(22,2)=187;
  v2(22,3)=(-(1/y(13)*T119*T133));
  v2(23,1)=4;
  v2(23,2)=172;
  v2(23,3)=  v2(22,3);
  v2(24,1)=4;
  v2(24,2)=188;
  v2(24,3)=(-(T47*params(7)*(1-params(6))*(exp(y(12))*getPowerDeriv(exp(y(12)),1-params(6),1)+exp(y(12))*exp(y(12))*getPowerDeriv(exp(y(12)),1-params(6),2))));
  v2(25,1)=4;
  v2(25,2)=203;
  v2(25,3)=(-(T45*(T149*T221+T119*(-1)/(y(13)*y(13)))));
  v2(26,1)=4;
  v2(26,2)=173;
  v2(26,3)=  v2(25,3);
  v2(27,1)=4;
  v2(27,2)=204;
  v2(27,3)=(-(T133*T119*T149));
  v2(28,1)=4;
  v2(28,2)=189;
  v2(28,3)=  v2(27,3);
  v2(29,1)=4;
  v2(29,2)=205;
  v2(29,3)=(-(T45*(T149*T149*T220+T119*(-((-y(11))*(y(13)+y(13))))/(y(13)*y(13)*y(13)*y(13)))));
  v2(30,1)=7;
  v2(30,2)=188;
  v2(30,3)=(-exp(y(12)));
  v2(31,1)=8;
  v2(31,2)=52;
  v2(31,3)=(-((1+y(15)-params(5))*params(4)*1/y(14)*T254));
  v2(32,1)=8;
  v2(32,2)=212;
  v2(32,3)=(-((1+y(15)-params(5))*params(4)*(T99*T254+T89*(-1)/(y(14)*y(14)))));
  v2(33,1)=8;
  v2(33,2)=62;
  v2(33,3)=  v2(32,3);
  v2(34,1)=8;
  v2(34,2)=222;
  v2(34,3)=(-((1+y(15)-params(5))*params(4)*(T99*T99*T253+T89*(-((-y(4))*(y(14)+y(14))))/(y(14)*y(14)*y(14)*y(14)))));
  v2(35,1)=8;
  v2(35,2)=228;
  v2(35,3)=(-(params(4)*1/y(14)*T89));
  v2(36,1)=8;
  v2(36,2)=63;
  v2(36,3)=  v2(35,3);
  v2(37,1)=8;
  v2(37,2)=238;
  v2(37,3)=(-(params(4)*T89*T99));
  v2(38,1)=8;
  v2(38,2)=223;
  v2(38,3)=  v2(37,3);
  v2(39,1)=10;
  v2(39,2)=52;
  v2(39,3)=T82*y(8)*getPowerDeriv(y(4),(-params(3)),2);
  v2(40,1)=10;
  v2(40,2)=116;
  v2(40,3)=T82*getPowerDeriv(y(4),(-params(3)),1);
  v2(41,1)=10;
  v2(41,2)=56;
  v2(41,3)=  v2(40,3);
  v2(42,1)=10;
  v2(42,2)=196;
  v2(42,3)=y(8)*getPowerDeriv(y(4),(-params(3)),1)*T154;
  v2(43,1)=10;
  v2(43,2)=61;
  v2(43,3)=  v2(42,3);
  v2(44,1)=10;
  v2(44,2)=200;
  v2(44,3)=T79*T154;
  v2(45,1)=10;
  v2(45,2)=125;
  v2(45,3)=  v2(44,3);
  v2(46,1)=10;
  v2(46,2)=205;
  v2(46,3)=y(8)*T79*getPowerDeriv(1-y(13),params(2),2);
  g2 = sparse(v2(:,1),v2(:,2),v2(:,3),10,256);
end
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],10,4096);
end
end

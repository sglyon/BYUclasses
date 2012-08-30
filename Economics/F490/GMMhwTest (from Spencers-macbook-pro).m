clear
clc
tic
cd('/Users/spencerlyon2/Desktop');
data = csvread('gmm_data.csv');
riskfree  = data(:,8);
n = 626;
theta = ones(1,12);
format short
format compact



% Setup all returns in excess of risk free rate:
    r1 = data(:,1) - riskfree;
    r2 = data(:,2) - riskfree;
    r3 = data(:,3) - riskfree;
    r4 = data(:,4) - riskfree;
    r5 = data(:,5) - riskfree;
    r6 = data(:,6) - riskfree;
    rm = data(:,7) - riskfree;
    
    
% Setup h and g
h = @(a) [r1'-a(1)-a(7).*rm'; r2'-a(2)-a(8).*rm'; r3'-a(3)-a(9).*rm'; r4'-a(4)-a(10).*rm'; r5'-a(5)-a(11).*rm'; r6'-a(6)-a(12).*rm';rm'.*(r1'-a(1)-a(7).*rm'); rm'.*(r2'-a(2)-a(8).*rm'); rm'.*(r3'-a(3)-a(9).*rm'); rm'.*(r4'-a(4)-a(10).*rm'); rm'.*(r5'-a(5)-a(11).*rm'); rm'.*(r6'-a(6)-a(12).*rm')];
g = @(a) sum(h(a),2)/n;




objective = @(a,WT)  g(a)' * WT * g(a);
S1 = @(a) (h(a)*h(a)')/n;
error = 1;
tolerance = 1*10^-15;
oldTheta = theta;
WT1 = eye(12,12);
ind=0;

D = [-1*eye(6,6) -(sum(rm))/n * eye(6,6); -(sum(rm)/n)*eye(6,6) -(sum(rm.^2))/n * eye(6,6)];

% optionsc = optimset('Display','off','MaxFunEvals',100000,'MaxIter',1000,...
%                     'TolFun',1e-15,'Algorithm','active-set') ;

while error > tolerance
    [newTheta, val] = fminsearch(@(a) objective(a,WT1),oldTheta);
% [newTheta,val] = fmincon(@(a) objective(a,WT1),oldTheta,[],[],[],[],-.01,...
%                              2,[],optionsc) ;
    WT1 = pinv(S1(newTheta));
    error = max(abs(oldTheta-newTheta));
    oldTheta = newTheta;
    ind=ind+1;
    values(ind) = val;
end

varCov = inv(D*WT1*D')/n;
disp('Parameter Values  ')
disp(newTheta')
disp(' ')
disp('StandardErrors  ')
disp(sqrt(diag(varCov)))

figure 
x = 0:.01:1.5;
scatter(newTheta(7:12),[mean(r1) mean(r2) mean(r3) mean(r4) mean(r5) mean(r6)])
hold on
plot(x,0.00592887*x)
hold off
axis([0 1.5 -.005 .01])
% scatter(newTheta(7),mean(r1),...
%         newTheta(8),mean(r2),...
%         newTheta(9),mean(r3),...
%         newTheta(10),mean(r4),...
%         newTheta(11),mean(r5),...
%         newTheta(12),mean(r6))
toc

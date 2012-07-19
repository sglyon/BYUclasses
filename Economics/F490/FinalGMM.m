%% Prepare workspace
clear
clc
starttime = clock ; % start timer

%% Setup Data

cd('/Users/spencerlyon2/Desktop');
data = csvread('gmm_data.csv');
riskfree  = data(:,8);
len = 626;
theta = [-0.0016833 0.0034237 0.005079 -0.000311309 0.000969196...
    0.00223331 1.33919 1.06817 1.05665 1.00764 0.902066 0.911814...
    0.00592887];
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

% r1 = 100.*(data(:,1) - riskfree);
% r2 = 100.*(data(:,2) - riskfree);
% r3 = 100.*(data(:,3) - riskfree);
% r4 = 100.*(data(:,4) - riskfree);
% r5 = 100.*(data(:,5) - riskfree);
% r6 = 100.*(data(:,6) - riskfree);
% rm = 100.*(data(:,7) - riskfree);


%% Define Functions

% Setup h and g
h = @(a) [r1'-a(1)-a(7).*rm'; r2'-a(2)-a(8).*rm'; r3'-a(3)-a(9).*rm'; ...
          r4'-a(4)-a(10).*rm'; r5'-a(5)-a(11).*rm'; r6'-a(6)-a(12).*rm';...
          rm'.*(r1' - a(1) - a(7).*rm'); rm'.*(r2' - a(2) - a(8).*rm');...
          rm'.*(r3' - a(3) - a(9).*rm'); rm'.*(r4' - a(4) - a(10).*rm');...
          rm'.*(r5' - a(5) - a(11).*rm'); rm'.*(r6'- a(6) - a(12).*rm');...
          r1'- a(7)*a(13); r2'- a(8)*a(13); r3'- a(9)*a(13);...
          r4'- a(10)*a(13); r5'- a(11)*a(13); r6'- a(12)*a(13)];
g = @(a) sum(h(a),2)/len;



objective = @(a,WT)  g(a)' * WT * g(a);
S1 = @(a) (h(a)*h(a)')/len;
error = 1;
tolerance = 1*10^-8;
oldTheta = theta;
WT1 = eye(18,18);
options = optimset('MaxFunEvals', 18*450,'MaxIter',18*450);
ind=1;

optionsc = optimset('Display','off','MaxFunEvals',100000,'MaxIter',1000,...
                    'TolFun',1e-15,'Algorithm','active-set') ;

%% The main Loop

while error > tolerance
%     [newTheta,val] = fminsearch(@(a) 100 * objective(a,WT1),oldTheta,...
%                                 options);

    [newTheta,val] = fmincon(@(a) objective(a,WT1),oldTheta,[],[],[],[],-.01,...
                             2,[],optionsc) ;
    WT1 = pinv(S1(newTheta));
    error = abs(norm(newTheta)-norm(oldTheta));
    oldTheta = newTheta;
    ind=ind+1
    newTheta'
    values(ind) = val;
end

%% Results

theta = newTheta;
betas = theta(7:12)';
D = [-1*eye(6,6) -(sum(rm)/len)*eye(6,6) zeros(6,1);...
     -(sum(rm)/len)*eye(6,6) -(sum(rm.^2)/len)*eye(6,6) zeros(6,1);...
     zeros(6,6) -theta(13)*eye(6,6) -1.*betas];

varCov = pinv(D'*WT1*D)/len;
newTheta'
sqrt(diag(varCov))
runtime = etime(clock,starttime) ; % end timer

%% TODO
% check notes to see what obj function is so I can write the grad to give
% fminunc.  Also look at Optimization toolbox for examples on how to do it.

% use command 'type brownfgh' for an example obj func file. 

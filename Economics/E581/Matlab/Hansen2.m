%% Hansen's model with indivisable labor

clear; close all; clc;

tic;

global gamma beta delta theta A rho sigma B mu

%% Set model parameters
gamma = 2.0;
beta = 0.995;
delta = 0.025;
theta = 0.33;
A = 1;
rho = 0.9;
sigma = 0.02;
B = 2.5;
mu = 1.0;

%% Set numerical parameters
nx = 1;  % X = k
ny = 5;  % Y = (y, c, h, w, r)
nz = 1;  % Z = z

options = optimset('Display','iter','TolFun',.000000000001,'TolX',.000000000001);
numerical = 1;
nobs = 500;  % num of periods per monte carlo (2 * desired and toss 1st 1/2)
goodobs = 250;
nmc = 1000;  % num monte carlos to do

%% Set parameters for Uhlig
message = '                                                                       ';
warnings = [];
DISPLAY_IMMEDIATELY = 1;
TOL = .000001; % Roots smaller than TOL are regarded as zero.
               % Complex numbers with distance less than TOL are regarded as equal.
if exist('MANUAL_ROOTS')~=1,
   MANUAL_ROOTS = 0; % = 1, if you want to choose your own
                               % roots, otherwise set = 0.
                               % See SOLVE.M for instructions.
end;
if exist('IGNORE_VV_SING')~=1,
   IGNORE_VV_SING = 1; % =1: Ignores, if VV is singular.
                       % Sometimes useful for sunspots.  Cross your fingers...
end;
DO_QZ=0;

%% Set options for sol_out.m (Uhlig)
DISPLAY_ROOTS = 1;  % Set = 1, if you want to see the roots.
MANUAL_ROOTS = 0;
%     MANUAL_ROOTS = 1;
%     Xi_manual = 2;

zbar = 0;
%% Solve for SS numerically
%ssGuess = [2; 1; .5; .5; 1; 1];
ssGuess = ones(6, 1) * 0.8;

XYbar = fsolve(@hansen2ss, ssGuess, options);  % TODO: Unpack this correctly

kbar = XYbar(1);
ybar = XYbar(2);
cbar = XYbar(3);
hbar = XYbar(4);
wbar = XYbar(5);
rbar = XYbar(6);

inSS = [kbar; kbar; kbar;
      ybar; cbar; hbar; wbar; rbar;
      ybar; cbar; hbar; wbar; rbar;
      0; 0];

%% Get Uhlig's derivative matricies AA-NN
[AA, BB, CC, DD, FF, GG, HH, JJ, KK, LL, MM] = RBCnumerderiv(@hansen2dyn,inSS,nx,ny,nz);

NN = rho;
%% Prepare for Uhlig's solve.m and then call it
[~, m_states] = size(AA);
[~, n_endog ] = size(CC);
[l_equ, k_exog  ] = size(DD);
solve;  % Calling it!


%% Do monte carlo simulations
mcmoments = zeros(9,6);
for m = 1:nmc
    %initialize series for state variables
    Xtilde = zeros(nobs, nx);
    Ytilde = zeros(nobs, ny);
    z = zeros(nobs, nz);

    %generate eps shock series
    eps = sigma * randn(nobs, nz);

    %iteratively generate time series
    %start at SS (tilde stuff is zero in ss)
    Xtilde(1, :) = zeros(1, nx);
    Yrilde(1, :) = zeros(1, ny);
    z(1, :) = zeros(1, nz);
    for t=2:nobs
        z(t, :) = NN * z(t - 1, :) + eps(t, :);
        Xtilde(t, :) = PP * Xtilde(t - 1, :) + QQ * z(t, :);
        Ytilde(t, :) = RR * Xtilde(t - 1, :) + RR * z(t, :);
    end

    %transform Xtilde into k
    k = kbar * exp(Xtilde);
    %transform Ytilde into y c w & r
    y = ybar * exp(Ytilde(:, 1));
    c = cbar * exp(Ytilde(:, 2));
    h = hbar * exp(Ytilde(:, 3));
    w = wbar * exp(Ytilde(:, 4));
    r = rbar * exp(Ytilde(:, 5));

    % get in period utility
    u = (c .^ (1 - gamma)  - 1) / (1 - gamma) + B * log(1 - h);


    %put all time sereis into a matrix
    data = [y c h w r exp(z) u];
     % drop first 1/2 of observations
    data = data(goodobs:nobs, :);

    %get i
    i = (1 - delta) * k;
    % appropriately lag X to get k timing correct
    k = k(goodobs:nobs);
    i = i(goodobs:nobs);
    i = k - i;

    % add k
    data = [k i data];

    %calculate moments
    moments = zeros(9, 6);
    means = mean(data);
    stdevs = std(data);
    coefvars = stdevs./means;
    correls = corrcoef(data);
    data2 = [data(1:goodobs - 2,:) data(2:goodobs - 1,:)];
    autocorrs = corrcoef(data2);
    for i=1:9
        moments(i,:) = [means(i) stdevs(i) coefvars(i) correls(i,3) correls(i,7) autocorrs(i,i+8)];
    end
    mcmoments = mcmoments*(m-1)/m + moments/m;
end
display('kiychwrlu')
mcmoments


%% Plot results
figure;
for i=1:9
    subplot(5,2,i)
    plot(data(:,i),'k-');
end

toc;

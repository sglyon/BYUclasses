%
% Status : main Dynare file 
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

clear all
clear global
tic;
global M_ oo_ options_ ys0_ ex0_ estimation_info
options_ = [];
M_.fname = 'money_in_utility';
%
% Some global variables initialization
%
global_initialization;
diary off;
logname_ = 'money_in_utility.log';
if exist(logname_, 'file')
    delete(logname_)
end
diary(logname_)
M_.exo_names = 'epsilon_z';
M_.exo_names_tex = 'epsilon\_z';
M_.exo_names = char(M_.exo_names, 'epsilon_g');
M_.exo_names_tex = char(M_.exo_names_tex, 'epsilon\_g');
M_.endo_names = 'c';
M_.endo_names_tex = 'c';
M_.endo_names = char(M_.endo_names, 'k');
M_.endo_names_tex = char(M_.endo_names_tex, 'k');
M_.endo_names = char(M_.endo_names, 'h');
M_.endo_names_tex = char(M_.endo_names_tex, 'h');
M_.endo_names = char(M_.endo_names, 'y');
M_.endo_names_tex = char(M_.endo_names_tex, 'y');
M_.endo_names = char(M_.endo_names, 'w');
M_.endo_names_tex = char(M_.endo_names_tex, 'w');
M_.endo_names = char(M_.endo_names, 'r');
M_.endo_names_tex = char(M_.endo_names_tex, 'r');
M_.endo_names = char(M_.endo_names, 'P');
M_.endo_names_tex = char(M_.endo_names_tex, 'P');
M_.endo_names = char(M_.endo_names, 'i');
M_.endo_names_tex = char(M_.endo_names_tex, 'i');
M_.endo_names = char(M_.endo_names, 'u');
M_.endo_names_tex = char(M_.endo_names_tex, 'u');
M_.endo_names = char(M_.endo_names, 'lam');
M_.endo_names_tex = char(M_.endo_names_tex, 'lam');
M_.endo_names = char(M_.endo_names, 'g');
M_.endo_names_tex = char(M_.endo_names_tex, 'g');
M_.endo_names = char(M_.endo_names, 'z');
M_.endo_names_tex = char(M_.endo_names_tex, 'z');
M_.param_names = 'cbeta';
M_.param_names_tex = 'cbeta';
M_.param_names = char(M_.param_names, 'delta');
M_.param_names_tex = char(M_.param_names_tex, 'delta');
M_.param_names = char(M_.param_names, 'theta');
M_.param_names_tex = char(M_.param_names_tex, 'theta');
M_.param_names = char(M_.param_names, 'eta');
M_.param_names_tex = char(M_.param_names_tex, 'eta');
M_.param_names = char(M_.param_names, 'a');
M_.param_names_tex = char(M_.param_names_tex, 'a');
M_.param_names = char(M_.param_names, 'B');
M_.param_names_tex = char(M_.param_names_tex, 'B');
M_.param_names = char(M_.param_names, 'h0');
M_.param_names_tex = char(M_.param_names_tex, 'h0');
M_.param_names = char(M_.param_names, 'n');
M_.param_names_tex = char(M_.param_names_tex, 'n');
M_.param_names = char(M_.param_names, 'mu');
M_.param_names_tex = char(M_.param_names_tex, 'mu');
M_.param_names = char(M_.param_names, 'rho');
M_.param_names_tex = char(M_.param_names_tex, 'rho');
M_.param_names = char(M_.param_names, 'sigma_z');
M_.param_names_tex = char(M_.param_names_tex, 'sigma\_z');
M_.param_names = char(M_.param_names, 'Psi');
M_.param_names_tex = char(M_.param_names_tex, 'Psi');
M_.param_names = char(M_.param_names, 'sigma_g');
M_.param_names_tex = char(M_.param_names_tex, 'sigma\_g');
M_.param_names = char(M_.param_names, 'D');
M_.param_names_tex = char(M_.param_names_tex, 'D');
M_.exo_det_nbr = 0;
M_.exo_nbr = 2;
M_.endo_nbr = 12;
M_.param_nbr = 14;
M_.orig_endo_nbr = 12;
M_.aux_vars = [];
M_.Sigma_e = zeros(2, 2);
M_.H = 0;
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
erase_compiled_function('money_in_utility_static');
erase_compiled_function('money_in_utility_dynamic');
M_.lead_lag_incidence = [
 0 4 16;
 1 5 0;
 0 6 0;
 0 7 0;
 0 8 0;
 0 9 17;
 0 10 0;
 0 11 0;
 0 12 0;
 0 13 0;
 2 14 0;
 3 15 0;]';
M_.nstatic = 7;
M_.nfwrd   = 2;
M_.npred   = 3;
M_.nboth   = 0;
M_.equations_tags = {
};
M_.exo_names_orig_ord = [1:2];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(12, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(2, 1);
M_.params = NaN(14, 1);
M_.NNZDerivatives = zeros(3, 1);
M_.NNZDerivatives(1) = 42;
M_.NNZDerivatives(2) = 48;
M_.NNZDerivatives(3) = -1;
M_.params( 1 ) = 0.995;
cbeta = M_.params( 1 );
M_.params( 2 ) = 0.025;
delta = M_.params( 2 );
M_.params( 3 ) = 0.33;
theta = M_.params( 3 );
M_.params( 4 ) = 0.25;
eta = M_.params( 4 );
M_.params( 6 ) = 2.5;
B = M_.params( 6 );
M_.params( 7 ) = 0.583;
h0 = M_.params( 7 );
M_.params( 8 ) = 0.00125;
n = M_.params( 8 );
M_.params( 5 ) = 0.00375;
a = M_.params( 5 );
M_.params( 9 ) = 0.01;
mu = M_.params( 9 );
M_.params( 10 ) = 0.995;
rho = M_.params( 10 );
M_.params( 11 ) = 0.02;
sigma_z = M_.params( 11 );
M_.params( 12 ) = 0.9;
Psi = M_.params( 12 );
M_.params( 13 ) = 0.01;
sigma_g = M_.params( 13 );
M_.params( 14 ) = 0.01;
D = M_.params( 14 );
%
% INITVAL instructions
%
options_.initval_file = 0;
oo_.steady_state( 1 ) = 4.39441;
oo_.steady_state( 2 ) = 245.166;
oo_.steady_state( 3 ) = 0.439769;
oo_.steady_state( 4 ) = 11.7494;
oo_.steady_state( 5 ) = 7.8735;
oo_.steady_state( 6 ) = 0.033801;
oo_.steady_state( 7 ) = 0.229838;
oo_.steady_state( 8 ) = 7.35497;
oo_.steady_state( 9 ) = 0.0318162;
oo_.steady_state( 10 ) = 1.;
oo_.steady_state( 11 ) = 0.;
oo_.steady_state( 12 ) = 0.;
if M_.exo_nbr > 0;
	oo_.exo_simul = [ones(M_.maximum_lag,1)*oo_.exo_steady_state'];
end;
if M_.exo_det_nbr > 0;
	oo_.exo_det_simul = [ones(M_.maximum_lag,1)*oo_.exo_det_steady_state'];
end;
%
% SHOCKS instructions
%
make_ex_;
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = M_.params(11)^2;
M_.Sigma_e(2, 2) = M_.params(13)^2;
M_.sigma_e_is_diagonal = 1;
steady;
var_list_=[];
info = stoch_simul(var_list_);
save('money_in_utility_results.mat', 'oo_', 'M_', 'options_');


disp(['Total computing time : ' dynsec2hms(toc) ]);
diary off

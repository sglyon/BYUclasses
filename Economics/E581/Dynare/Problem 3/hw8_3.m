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
M_.fname = 'hw8_3';
%
% Some global variables initialization
%
global_initialization;
diary off;
logname_ = 'hw8_3.log';
if exist(logname_, 'file')
    delete(logname_)
end
diary(logname_)
M_.exo_names = 'eps';
M_.exo_names_tex = 'eps';
M_.endo_names = 'c';
M_.endo_names_tex = 'c';
M_.endo_names = char(M_.endo_names, 'y');
M_.endo_names_tex = char(M_.endo_names_tex, 'y');
M_.endo_names = char(M_.endo_names, 'i');
M_.endo_names_tex = char(M_.endo_names_tex, 'i');
M_.endo_names = char(M_.endo_names, 'r');
M_.endo_names_tex = char(M_.endo_names_tex, 'r');
M_.endo_names = char(M_.endo_names, 'w');
M_.endo_names_tex = char(M_.endo_names_tex, 'w');
M_.endo_names = char(M_.endo_names, 'u');
M_.endo_names_tex = char(M_.endo_names_tex, 'u');
M_.endo_names = char(M_.endo_names, 'lam');
M_.endo_names_tex = char(M_.endo_names_tex, 'lam');
M_.endo_names = char(M_.endo_names, 'k');
M_.endo_names_tex = char(M_.endo_names_tex, 'k');
M_.endo_names = char(M_.endo_names, 'z');
M_.endo_names_tex = char(M_.endo_names_tex, 'z');
M_.param_names = 'B';
M_.param_names_tex = 'B';
M_.param_names = char(M_.param_names, 'mu');
M_.param_names_tex = char(M_.param_names_tex, 'mu');
M_.param_names = char(M_.param_names, 'gam');
M_.param_names_tex = char(M_.param_names_tex, 'gam');
M_.param_names = char(M_.param_names, 'bet');
M_.param_names_tex = char(M_.param_names_tex, 'bet');
M_.param_names = char(M_.param_names, 'delt');
M_.param_names_tex = char(M_.param_names_tex, 'delt');
M_.param_names = char(M_.param_names, 'thet');
M_.param_names_tex = char(M_.param_names_tex, 'thet');
M_.param_names = char(M_.param_names, 'hbar');
M_.param_names_tex = char(M_.param_names_tex, 'hbar');
M_.param_names = char(M_.param_names, 'A');
M_.param_names_tex = char(M_.param_names_tex, 'A');
M_.param_names = char(M_.param_names, 'rho');
M_.param_names_tex = char(M_.param_names_tex, 'rho');
M_.param_names = char(M_.param_names, 'sigm');
M_.param_names_tex = char(M_.param_names_tex, 'sigm');
M_.param_names = char(M_.param_names, 'eta');
M_.param_names_tex = char(M_.param_names_tex, 'eta');
M_.exo_det_nbr = 0;
M_.exo_nbr = 1;
M_.endo_nbr = 9;
M_.param_nbr = 11;
M_.orig_endo_nbr = 9;
M_.aux_vars = [];
M_.Sigma_e = zeros(1, 1);
M_.H = 0;
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
erase_compiled_function('hw8_3_static');
erase_compiled_function('hw8_3_dynamic');
M_.lead_lag_incidence = [
 0 4 13;
 0 5 0;
 1 6 0;
 0 7 14;
 0 8 0;
 0 9 0;
 0 10 0;
 2 11 0;
 3 12 0;]';
M_.nstatic = 4;
M_.nfwrd   = 2;
M_.npred   = 3;
M_.nboth   = 0;
M_.equations_tags = {
};
M_.exo_names_orig_ord = [1:1];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(9, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(1, 1);
M_.params = NaN(11, 1);
M_.NNZDerivatives = zeros(3, 1);
M_.NNZDerivatives(1) = 25;
M_.NNZDerivatives(2) = 22;
M_.NNZDerivatives(3) = -1;
M_.params( 3 ) = 2;
gam = M_.params( 3 );
M_.params( 4 ) = 0.995;
bet = M_.params( 4 );
M_.params( 5 ) = 0.025;
delt = M_.params( 5 );
M_.params( 6 ) = 0.33;
thet = M_.params( 6 );
M_.params( 7 ) = 0.3;
hbar = M_.params( 7 );
M_.params( 8 ) = 1;
A = M_.params( 8 );
M_.params( 9 ) = 0.9;
rho = M_.params( 9 );
M_.params( 10 ) = 0.02;
sigm = M_.params( 10 );
M_.params( 1 ) = 2.5;
B = M_.params( 1 );
M_.params( 2 ) = 1;
mu = M_.params( 2 );
M_.params( 11 ) = 0.25;
eta = M_.params( 11 );
%
% INITVAL instructions
%
options_.initval_file = 0;
oo_.steady_state( 1 ) = 0.7;
oo_.steady_state( 2 ) = 0.9;
oo_.steady_state( 3 ) = 0.2;
oo_.steady_state( 4 ) = .03;
oo_.steady_state( 5 ) = 2.1;
oo_.steady_state( 6 ) = .5;
oo_.steady_state( 7 ) = 1;
oo_.steady_state( 8 ) = 10;
oo_.steady_state( 9 ) = 0;
if M_.exo_nbr > 0;
	oo_.exo_simul = [ones(M_.maximum_lag,1)*oo_.exo_steady_state'];
end;
if M_.exo_det_nbr > 0;
	oo_.exo_det_simul = [ones(M_.maximum_lag,1)*oo_.exo_det_steady_state'];
end;
steady;
%
% SHOCKS instructions
%
make_ex_;
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = M_.params(10)^2;
M_.sigma_e_is_diagonal = 1;
var_list_=[];
info = stoch_simul(var_list_);
save('hw8_3_results.mat', 'oo_', 'M_', 'options_');


disp(['Total computing time : ' dynsec2hms(toc) ]);
diary off

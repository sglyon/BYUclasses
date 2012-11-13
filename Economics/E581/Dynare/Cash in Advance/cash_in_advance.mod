%----------------------------------------------------------------
% 1. Defining variables
%----------------------------------------------------------------

var c k h y w r P i u lam g z;
varexo epsilon_z epsilon_g ;

parameters cbeta delta theta eta a B h0 n mu rho sigma_z Psi sigma_g;

//----------------------------------------------------------------
// 2. Calibration
//----------------------------------------------------------------

cbeta    = 0.995;
delta   = 0.025;
theta   = 0.33;
eta     = 0.25;
B       = 2.5;
h0      = 0.583;
n       = 0.00125;
a       = 0.00375;
mu      = 0.01;
rho     = 0.995;
sigma_z = 0.02;
Psi     = 0.9;
sigma_g = 0.01;

//----------------------------------------------------------------
// 3. Model
//----------------------------------------------------------------

model;
    c = (1 + mu + g) / P ;
    h * w = k * (1 + a + n) + (1 + mu + g) / P - (1 + r - delta) * k(-1) ;
    1 = cbeta * ((1 + r(+1) - delta) * (1 - h) / (1 - h(+1)) * (w /( exp(a)*w(+1)))) ;
    1 = cbeta * (w * P * (1-h))/ (c(+1) * P(+1) * exp(g(+1) - n)) ;
    r = theta * k(-1) ^ (eta - 1) * (theta * k(-1)^eta + (1 - theta) * (h * lam)^ eta) ^(1/eta - 1) ;
    w = (1 - theta) * lam * (h * lam) ^(eta - 1) * (( 1 - theta) * (h * lam) ^ eta + theta * k(-1) ^ eta) ^ (1 / eta - 1) ;
    g = Psi * g(-1) + epsilon_g ;
    z = rho * z(-1) + epsilon_z ;
    lam = exp(z) ;
    i = (1 + a + n) * k - (1 - delta) * k(-1) ;
    y = (theta * k(-1)^eta + (1 - theta) * (lam * h)^eta) ^(1 / eta) ;
    u = log(c) + B * log(1 - h) ;

end;

//----------------------------------------------------------------
// 4. Computation
//----------------------------------------------------------------

initval;
    c = 1.5;
    k = 5.5;
    h = 1.5;
    y = 1.5;
    w = 1.5;
    r = 1.5;
    P = 1.5;
    i = 1.5;
    u = 1.5;
    lam = 1.5;
    g = 0.01;
    z = 0;
end;

shocks;
var epsilon_z = sigma_z ^ 2;
var epsilon_g = sigma_g ^ 2;
end;

steady;

stoch_simul;

//----------------------------------------------------------------
// 5. Some Results
//----------------------------------------------------------------
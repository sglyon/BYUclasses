var c y i r w u lam k z h;
varexo eps ;
parameters B mu gam bet delt thet A rho sigm eta;

//Fill in parameter values
gam = 2;
bet = 0.995;
delt = 0.025;
thet = 0.33;
A = 1;
rho = 0.9;
sigm = 0.02;
B = 2.5;
mu = 1;
eta = 0.25;

/*---------------------------------Model Block --------------------------*/
model;
y = A * (thet * k ^ eta + (1 - thet) * (exp(z) * h) ^ eta ) ^ (1 / eta);
u = 1 / (1 - gam) * (c ^(1 - gam) - 1) + B * log(1 -h);
r = A * thet * k^ (eta - 1) * ((1 - thet) * (h * exp(z)) ^ eta + thet * k ^eta)^(1/eta - 1);
w = (A * (1 - thet) * (h * exp(z)) ^ eta * (thet * k^eta - (thet - 1) * (h *exp(z)) ^ eta)^(1 / eta - 1)) / h;
i(-1) = k - (1 - delt) * k(-1);
c = y - i;
lam = exp(z);
1 = bet * (c / c(+1)) ^ (gam) * (1 + r(+1) - delt);
z = rho * z(-1) + eps;
c ^(-gam) * w * (1 - h) ^ (mu) = B;
end;

initval;
c = 0.7;
y = 0.9;
i = 0.2;
r = .03;
w = 2.1;
u = .5;
lam = 1;
k = 10;
z = 0;
h = 0.583;

end;
steady;


/*-----------------------------------------------------------------------*/


/*-----------------------------Shock Block-------------------------------*/




shocks;
var eps = sigm ^ 2;
end;

/*-----------------------------------------------------------------------*/


/*---------------------------Simluation Block----------------------------*/
//Running the Simulation non -stochastic
//simul(periods =250);

//Running Stochastic simluation
stoch_simul;
/*-----------------------------------------------------------------------*/
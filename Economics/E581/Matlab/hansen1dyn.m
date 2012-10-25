function vals = hansen1dyn(in)

global gamma beta delta theta hbar A rho sigma

kpp = in(1);
kp =  in(2);
k =   in(3);
yp =  in(4);
cp =  in(5);
wp =  in(6);
rp =  in(7);
y =   in(8);
c =   in(9);
w =   in(10);
r =   in(11);
zp =  in(12);
z =   in(13);

out1 = y - (A * (k ^ theta)) * (exp(z) * hbar) ^ (1 - theta);  % production func
out2 = r - (theta * A) * ((exp(z) * hbar) / k) ^(1 - theta); % r = MPl
out3 = w - (1 - theta) * A * (k / hbar) ^ (theta) * exp(z) ^ (1- theta);  % w = MPk
out4 = y - c - kp + (1 - delta) * k;  % Budget Constraint
out5 = beta *((c / cp) ^ gamma) * (rp + 1 - delta) - 1;  % Euler Eq.

vals = [out1; out2; out3; out4; out5];

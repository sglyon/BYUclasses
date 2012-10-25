function vals = hansen2dyn(in)

global gamma beta delta theta A rho sigma B mu

kpp = in(1);
kp =  in(2);
k =   in(3);
yp =  in(4);
cp =  in(5);
hp =  in(6);
wp =  in(7);
rp =  in(8);
y =   in(9);
c =   in(10);
h =   in(11);
w =   in(12);
r =   in(13);
zp =  in(14);
z =   in(15);

out1 = y - (A * (k ^ theta)) * (exp(z) * h) ^ (1 - theta);  % production func
out2 = r - (theta * A) * ((exp(z) * h) / k) ^ (1 - theta); % r = MPl
out3 = w - (1 - theta) * A * (k / h) ^ (theta) * exp(z) ^ (1- theta);  % w = MPk
out4 = y - c - kp + (1 - delta) * k;  % Budget Constraint
out5 = beta * ((c / cp) ^ gamma) * (rp + 1 - delta) - 1;  % Intertemp Euler Eq.
out6 = c ^ (- gamma) * w * B ^(-1) * ((1 - h) ^ (-mu)) - 1;  % labor/leisure Euler Eq.

vals = [out1; out2; out3; out4; out5; out6];

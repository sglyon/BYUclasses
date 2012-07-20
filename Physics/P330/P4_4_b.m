function out = P4_4_b(in)

x = in(1);
y = in(2);
z = in(3);

out = zeros(3,1);

out(1) = x^2 + y^2 + z^2 - 139;
out(2) = x / (x + y - z) - 3;
out(3) = x*sqrt(z) - (10 - y) ^2;

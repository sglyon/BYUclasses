% Verifying perturbation theory

x = 0;
xnew = 1;

while abs((x - xnew)) > 1e-16
    x = xnew ;
    xnew = (1 + 0.1 * exp(x)) ^ (1 / 3);
    fprintf(' xnew = %16.15f \n', xnew);
end

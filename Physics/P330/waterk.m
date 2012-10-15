% function to calculate the water dispersion relation
function k = waterk(w,g,d)

% Make an approximate k. Error is less that 1e-15 for |kd| > 20
k = w.*abs(w) / g;

% Fix the errors for |kd| < 20 using dsolve
disp('Refining the dispersion relation.  Please be patient.');
disp('If your w array has a lot of small values, this can take a while.')

eq = inline('w^2 - g*k*tanh(k*d)','k','w','g','d');
for istep = 1:length(k)
    if (abs(k(istep)*d) < 20)
        k(istep) = fzero(@(k) eq(k,w(istep),g,d),k(istep));
    end
end
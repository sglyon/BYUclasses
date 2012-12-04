function F = rhs13(t, y)
    global A w gamma

    F = zeros(length(y), 1);

    x = y(1); v = y(2);

    %define restoring force
    restore =  - 2 / 3 * tanh(3 * x / 2) / (cosh(3 * x / 2) .^ 2);

    F(1) = v;
    F(2) = -2 * gamma * v + restore +  A * cos(w .* t);
    return

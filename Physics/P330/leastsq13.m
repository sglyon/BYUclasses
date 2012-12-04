function S = leastsq13(guess)
    global A w gamma S

    T = 2 * pi / w;

    optionode = odeset ('RelTol', 1e-6');
    [~, yode] = ode45(@rhs13, [0 T], guess, optionode);
    x = yode(:, 1); v = yode(:, 2);
    S = w ^ 2 * (x(end) - x(1)) ^ 2 + (v(end) - v(1)) ^ 2;
    return

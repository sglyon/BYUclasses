clear; close all; clc;

global A gamma w S
A = 0.136;
gamma = 0.15;
w1vec = [2, 0.7, 0.2, 0.6, 0.6];
w2vec = [0.7, 0.55, 0.7, 0.55, 0.7];
Nvec = [30, 30, 30, 20, 20];
% w1 = input('Enter a value for w1: ');
% w2 = input('Enter a value for w2: ');
% N = input('Enter a value for N: ');



% x0 = input('Enter a value for x0: ');
% v0 = input('Enter a value for v0: ');
x0vec = [0.05, 0.02, 0.02,  0.35, 0.35];
v0vec = [0.02, 0.01, 0.015, 0.31, 0.31];
Amp = 0;

for part =1:5
    w1 = w1vec(part);
    w2 = w2vec(part);
    N = Nvec(part);
    x0 = x0vec(part);
    v0 = v0vec(part);
    h = (w2 - w1) / N;
    wscan = linspace(w1, w2, N);
    clear Amp j
    guess = [x0; v0];
    for j=1:N
        % display(j);
        % display(guess);
        w = wscan(j);
        T = 2 * pi / w;
        optionfmin = optimset('TolX', 1e-6);
        answer = fminsearch(@leastsq13, guess, optionfmin);
        % display(S);

        if S > 1e-8 && j > 10
            break
        end

        optionode = odeset ('RelTol', 1e-6');
        [t, yode] = ode45(@rhs13, [0, T], answer, optionode);
        x = yode(:, 1); v = yode(:, 2);

        Amp(j) = max(x);

        % plot(t, x, 'b-', t, v, 'r-');
        % title(sprintf('\\omega = %g ', w));
        % xlabel('t'); ylabel('x(t), v(t)');

        % pause(0.02)

        guess = answer;
    end
    wscan = wscan(1:length(Amp));
    figure
    plot(wscan, Amp);
    filename = strcat('scan', sprintf('%i', part));
    savename = strcat(filename, '.mat')
    save(savename, 'Amp', 'wscan')
end
lab13results




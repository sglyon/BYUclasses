clear; clc; close all;
w0 = 200 ;
W_array = [10 1 0.1] ;
N = 2^17;
tmax = 32;
t0 = tmax / 2;
tao = 32 / N;
time = 0: tao: 32 - tao ;

f = @(t, W) cos(w0 .* t) .* exp(-(t - t0).^2 ./W^2);

f1 = f(time, W_array(1));
f2 = f(time, W_array(2));
f3 = f(time, W_array(3));

g1 = fft(f1);
P1 = abs(g1) .^ 2;

g2 = fft(f2);
P2 = abs(g2) .^ 2;

g3 = fft(f3);
P3 = abs(g3) .^ 2;

dw = 2 * pi / (N * tao);
w = 0: dw : 2 * pi / tao - dw; % (angular frequency, radians/sec)


figure
subplot(2,1,1)
plot(time, f1);
title('Time series with W = 10')

subplot(2,1,2)
plot(w, P1)
title('Angular frequency with W = 10')



figure
subplot(2,1,1)
plot(time, f2);
title('Time series with W = 1')

subplot(2,1,2)
plot(w, P2)
title('Angular frequency with W = 1')



figure
subplot(2,1,1)
plot(time, f3);
title('Time series with W = .1')

subplot(2,1,2)
plot(w, P3)
title('Angular frequency with W = .1')


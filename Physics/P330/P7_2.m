clear; close all; clc;

f = wavread('~/Documents/School/BYUclasses/Physics/P330/Data/beethoven.wav') ;

N = length(f);
tfinal = N / 11025;
tao = tfinal / (N - 1);

time = linspace(0, tfinal, N);

plot(time, f)
xlabel('time')
ylabel('signal')
title('Signal versus time')


dv = 1 / (N * tao);
v = 0:dv:(N - 1) / (N * tao);

g = fft(f);
P = abs(g) .^ 2;

found = find(v>1000);
the_index = found(1);


figure
plot(v(1:the_index), P(1:the_index))
xlabel('\nu')
ylabel('P(\nu)')
title('Power Spectrum. Normal Axis')

figure
semilogy(v(1:the_index), P(1:the_index))  % TODO: check this plot. May be bad.
xlabel('\nu')
ylabel('P(\nu)')
title('Power Spectrum. Semilogy Axis')
axis([0 1000 100 10^6])

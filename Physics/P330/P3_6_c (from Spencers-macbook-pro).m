clear;
clc;
close all;

N = 1000;
Se = zeros(N,1);
err = zeros(N,1);

for n=1:N
	[Se(n), err(n)] = EulerSum(n);
end

figure;
subplot(2,1,1);
plot(1:1:N, Se);
hold on;
title('Euler Sum');

subplot(2,1,2);
semilogy(1:1:N, err);
title('Error term');
hold off;


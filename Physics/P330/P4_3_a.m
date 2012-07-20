tic;
clear; clc; close all;

x = 0:.01:3;
f = exp(-x).*besselj(1, x);

p4_fit = polyfit(x,f,4);
p4_data = polyval(p4_fit, x);

figure
plot(x, f, 'b', x, p4_data, 'r');
title('4th order fit and function');

figure
plot(x, p4_data, 'k--');
title('4th order fit');

p6_fit = polyfit(x,f,6);
p6_data = polyval(p6_fit, x);


figure
plot(x, f, 'b', x, p6_data, 'r');
title('6th order fit and function');

figure
plot(x, p6_data, 'k--');
title('6th order fit');



toc;

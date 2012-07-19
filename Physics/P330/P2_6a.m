x = 0:.01:50;
y = besselj(0, x);
y2 = besselj(2,x);
plot(x,y, 'r', x, y2, 'k')
legend('\\J_0(x)', '\\J_1(x)')

xlabel('x coordinates')
ylabel('y coordinates')
title('\\J_0(x) and \\J_1(x)')
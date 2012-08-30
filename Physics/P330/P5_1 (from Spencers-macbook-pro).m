% Create course x and y grids.
x=0:2*pi;
y=sin(x);

% Create fine x and y grids
xfine=-2*pi:0.1:2*pi;
yfine=sin(xfine);

% Do linear interpolation
ylin = [y(1) y(2)];
xlin = [x(1) x(2)];
p1 = polyfit(xlin, ylin, 1);
y1 = polyval(p1, xfine);

% Do quadradtic interpolation
yquad = [y(1) y(2) y(3)];
xquad = [x(1) x(2) x(3)];
p2 = polyfit(xquad, yquad, 2);
y2 = polyval(p2, xfine);

% Plot everything
plot(x, y, 'r*', xfine, yfine, 'b', xfine, y1, 'k', xfine, y2, 'g');
legend('Coarse Data', 'Fine Data', 'Linear interpolation', 'Quadratic Interpolation');

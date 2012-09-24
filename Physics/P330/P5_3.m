clear;
clc;
close all;
x0 = 0;
y0 = 1;
vx0 = 1;
vy0 = 0;

tao = 0.01;

xs = x0;
ys = y0;
hits = 0;

while x0 < 10
	if (y0 + (vy0 - (9.8) * tao) * tao) <= 0
        hits = hits + 1;
		% Find tao1 and tao1
		x_yto0 = interp1(ys, xs, 0, 'spline');
		tao1 = (x_yto0 - x0) / vx0;
		tao2 = tao - tao1;
		
		% Do first half of split bounce
		x1 = x0 + vx1 * tao1;
		vy1 = vy0 - (9.8) * tao1;
		y1 = y0 + vy1 * tao1;
		x0 = x1; 
		y0 = y1;
		vx0 = vx1;
		vy0=  vy1;
		
		% Do second half of split bounce.
		vy0 = 0.95 * abs(vy0);
		x1 = x0 + vx1 * tao2;
		vy1 = vy0 - (9.8) * tao2;
		y1 = y0 + vy1 * tao2;
		x0 = x1; 
		y0 = y1;
		vx0 = vx1;
		vy0=  vy1;
	else	
		vx1 = vx0;
		x1 = x0 + vx1 * tao;
		vy1 = vy0 - (9.8) * tao;
		y1 = y0 + vy1 * tao;
    
    % Check to see if we are on our way down. If, so start making new x, y
    % lists
        if (y1 - y0) <= 0 
            xs = [xs x1];
            ys = [ys y1];
        else
            xs = x0;
            ys = y0;
        end
        x0 = x1; 
		y0 = y1;
		vx0 = vx1;
		vy0=  vy1;
    end
	plot(x1, y1, '.');
	axis([0 10 0 1.5]);
	pause(0.001);
end

	
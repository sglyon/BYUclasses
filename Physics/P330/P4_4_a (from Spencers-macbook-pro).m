clear; clc;
bessel0 = zeros(40,1);

for i=1:40
	bessel0(i) = fzero(@(x) besselj(0,x), [pi*(2*i-1)/2, pi*(2*i+1)/2]);
end

x = 0:.1:130;
plot(x, besselj(0,x), 'b-', bessel0, besselj(0, bessel0), 'rx')


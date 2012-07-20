function [sum, error] = EulerSum(N)

sum=0;
gamma = 0.577215664901532;

for i=1:N
	sum = sum + (1/i);
end

sum = sum - log(N);
error = abs(sum - gamma);
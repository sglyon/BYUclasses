clear; clc; close all;
N = 1000;
S = zeros(N,1);

for i=1:N
   S(i) = InvSum(i);
end
plot(1:1:N, S)
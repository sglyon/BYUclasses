clear; close all;

P=1;  % set the first term in the product
N=20;  % set the upper limit of the product

for n=2:N % start the loop at n=2 because we already loaded n=1
  P=P*n; % multiply by n each time, put the answer back into P
end % end of the loop

fprintf(' N!  = %g \n',P)  % print the answer

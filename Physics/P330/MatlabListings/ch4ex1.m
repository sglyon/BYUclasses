clear; close all;

% set s to zero so that 1/n^2 can be repeatedly added to it
s=0;
N=10000; % set the upper limit of the sum
for n=1:N % start of the loop

    s = s + 1/n^2; % add 1/n^2 to s each iteration

end % end of the loop
fprintf(' Sum = %g \n',s) % print the answer

clear; close all;

term=1  % load the first term in the sum, 1/1^2=1
s=term;  % load s with this first term

% start of the loop - set a counter n to one

n=1;

while term > 1e-10  % loop until term drops below 1e-10
   n=n+1; % add 1 to n so that it will count: 2,3,4,5,...
   term=1/n^2; % calculate the next term to add
   s=s+term;  % add 1/n^2 to s until the condition is met
end  % end of the loop

fprintf(' Sum = %g \n',s)

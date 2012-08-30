clear; close all;

term=1;  % load the first term in the sum, 1/1^2=1
s=term;  % load s with this first term

% start of the loop - set a counter n to one
n=1;

while term > 1e-100  % set a ridiculously small term.
                     % Don't really do this, as you
                     % only have 15 digits of precision.

   n=n+1; % add 1 to n so that it will count: 2,3,4,5,...
   term=1/n^2;
   s=s+term;

   if (n > 1000) % Break stop if it is taking too long
       disp('This is taking too long.  I''m out of here...')
       break
   end
end  % end of the loop

fprintf(' Sum = %g \n',s)

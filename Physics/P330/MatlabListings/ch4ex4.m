clear; close all;

a(1)=1;  % put the first element into the array
N=19;  % the first one is loaded, so let's load 19 more

for n=1:N %  start the loop
   a(n+1)=(2*n-1)/(2*n+1)*a(n); % the recursion relation
end

disp(a) %  display the resulting array of values

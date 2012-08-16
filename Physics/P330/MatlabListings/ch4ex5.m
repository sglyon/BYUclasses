clear; close all;

a=1;
b=3;

if a>0
   c=1  % If a is positive set c to 1
else
   c=0  %if a is 0 or negative, set c to zero
end

% if either a or b is non-negative, add them to obtain c;
% otherwise multiply a and b to obtain c
if a>=0 | b>=0  % either non-negative
   c=a+b
else
   c=a*b  % otherwise multiply them to obtain c
end

clear; close all;

% This is how to obtain the double integral over
% the xy rectangle (0,2)X(0,2).  It runs lots
% faster if you use the 'quadl' option, as shown below

dblquad(@f2int,0,2,0,2,1e-10,'quadl')

clear; clc;
% P4_2a
A = [1 2 3];
B = [-3 2 1];

angle = acos(dot(A,B) / (norm(A) * norm(B)));

% P4_2b
r = [1 2 3];
v = [6 3 1];
m = 2.3;
L = m*cross(r,v);

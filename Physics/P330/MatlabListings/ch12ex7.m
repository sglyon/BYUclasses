clear; close all;

% once fint.m is stored in your current directory
% you can use the following commands to integrate.

% simple integral, medium accuracy
quad(@fint,0,2)

% integrate with specified relative accuracy
quad(@fint,0,2,1e-8)

% integrate with specified relative accuracy
% using quadl (notice that quadl is faster--
% always try it first)

quadl(@fint,0,2,1e-8)

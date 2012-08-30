clear; close all;

% build an array of x-values from 0 to 1 in steps of 0.1
x=0:.1:1;

% check the length of the x array
N=length(x)

% build a 2xN matrix with a row of x and a row of exp(x)
y=[x;exp(x)];

% Open a file in which to write the matrix - fid is a unit
% number to be used later when we write the file and close it.
% There is nothing special about the name fid - fxd works too,
% and, in fact, any variable is OK.
fid=fopen('file1.txt','w')

% write the matrix to the file - note that it will be in the
% current Matlab directory.  Type cd to see where you are.
% Matlab writes the file as two columns instead of two rows.
fprintf(fid,'%6.2f  %12.8f \r\n',y)

% close the file
st=fclose(fid);

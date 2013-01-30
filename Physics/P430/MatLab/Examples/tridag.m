function x = tridag(A,r)

% Solves A*x=r where A contains the three diagonals
% of a tridiagonal matrix.  A contains the three
% non-zero elements of the tridiagonal matrix,
% i.e., A has n rows and 3 columns.
% r is the column vector on the right-hand side

% The solution x is a column vector

% first check that A is tridiagonal and compatible
% with r

[n,m]=size(A);
[j,k]=size(r);

if n ~= j
    error(' The sizes of A and r do not match')
end

if m ~= 3
    error(' A must have 3 columns')
end

if k ~= 1
    error(' r must have 1 column')
end

% load diagonals into separate vectors
a(1:n-1) = A(2:n,1);
b(1:n) = A(1:n,2);
c(1:n-1) = A(1:n-1,3);

% forward elimination
for i=2:n
    coeff = a(i-1)/b(i-1);
    b(i) = b(i) - coeff*c(i-1);
    r(i) = r(i) - coeff*r(i-1);
end

% back substitution
x(n) = r(n)/b(n);
for i=n-1:-1:1
    x(i) = (r(i) - c(i)*x(i+1))/b(i);
end

x = x.';   % Return x as a column vector

return;

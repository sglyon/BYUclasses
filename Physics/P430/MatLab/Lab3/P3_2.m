clear; close all; clc;

mu = 0.003;
T = 127;
L = 1.2;
omega = 400;

n = 50;
xmin = 0; xmax = L;
h = (xmax - xmin) / (n - 1);
x = xmin: h: xmax;
x = x';


A = zeros(n, n);  % Preallocate memory for A
A(1, 1) = 1;  % Set first row of A
A(n, n) = 1;  % Set last row of A

for jrow = 2: n - 1  % fill in all other rows of A
    A(jrow, jrow - 1: jrow + 1) = [1 / (h ^ 2),  - 2 / (h ^ 2), 1 / (h ^ 2)];
end

B = eye(n);
B(1, 1) = 0;
B(n, n) = 0;

[V,D]=eig(A,B); % find the eigenvectors and eigenvalues
w2raw=-(T/mu)*diag(D);  % convert lambda to omega^2
[w2,k]=sort(w2raw);  % sort omega^2 into ascending along with a
                     % sort key k(n) that remembers where each
                     % omega^2 came from so we can plot the proper
                     % eigenvector in V
for n=1:n  % run through the sorted list and plot each eigenvector
   % load the plot title into t
   t=sprintf(' w^2 = %g w = %g ',w2(n),sqrt(abs(w2(n))) );
   gn=V(:,k(n)); % extract the eigenvector
   plot(x,gn,'b-');  % plot the eigenvector that goes with omega^2
   title(t);xlabel('x');ylabel('g(n,x)');  % label the graph
   pause
end


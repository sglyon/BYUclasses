% Korteweg-deVries equation on a periodic
% cell-centered grid using Crank-Nicolson
clear; close all;

N=500;
L=10;
h=L/N;
x=h/2:h:L-h/2;
x=x'; % turn x into a column vector

alpha=input(' Enter alpha - ')

ymax=input(' Enter initial amplitude of y - ')

% load an initial Gaussian centered on the computing region
y=ymax*exp(-(x-.5*L).^2);

% choose a time step
tau=input(' Enter the time step - ')

% select the time to run
tfinal=input(' Enter the time to run - ')
Nsteps=ceil(tfinal/tau);

iskip=input(' Enter the plot skip factor - ')

% Initialize the parts of the A and B matrices that
% do not depend on ybar and load them into At and Bt.
% Make them be sparse so the code will run fast.

At=sparse(N,N);
Bt=At;

% Build integer arrays for handling the wrapped points at the ends
% (periodic system)

jm=1:N;
jp=mod(jm,N)+1;
jpp=mod(jm+1,N)+1;
jmm=mod(jm-2,N)+1;

% load the matrices with the terms that don't depend on ybar
for j=1:N
    At(j,jmm(j))=-0.5*alpha/h^3;
    At(j,jm(j))=0.5/tau+3/2*alpha/h^3;
    At(j,jp(j))=0.5/tau-3/2*alpha/h^3;
    At(j,jpp(j))=0.5*alpha/h^3;
    Bt(j,jmm(j))=0.5*alpha/h^3;
    Bt(j,j)=0.5/tau-3/2*alpha/h^3;
    Bt(j,jp(j))=0.5/tau+3/2*alpha/h^3;
    Bt(j,jpp(j))=-0.5*alpha/h^3;
end

for n=1:Nsteps

    % do the predictor step
    A=At;B=Bt;
    % load ybar, then add its terms to A and B
    ybar=y;
    for j=1:N
        tmp=0.25*(ybar(jp(j))+ybar(jm(j)))/h;
        A(j,jm(j))=A(j,jm(j))-tmp;
        A(j,jp(j))=A(j,jp(j))+tmp;
        B(j,jm(j))=B(j,jm(j))+tmp;
        B(j,jp(j))=B(j,jp(j))-tmp;
    end

    % do the predictor solve
    r=B*y;
    yp=A\r;

    % corrector step
     A=At;B=Bt;
     % average current and predicted y's to correct ybar
     ybar=.5*(y+yp);
     for j=1:N
        tmp=0.25*(ybar(jp(j))+ybar(jm(j)))/h;
        A(j,jm(j))=A(j,jm(j))-tmp;
        A(j,jp(j))=A(j,jp(j))+tmp;
        B(j,jm(j))=B(j,jm(j))+tmp;
        B(j,jp(j))=B(j,jp(j))-tmp;
    end

    % do the final corrected solve
    r=B*y;
    y=A\r;

    if rem(n-1,iskip)==0
      plot(x,y)
      xlabel('x');ylabel('y')
      pause(.1)
    end

end

clear
clc
cd('/Users/spencerlyon2/Desktop');
data = csvread('gmm_data.csv');
riskfree  = data(:,8);
n = 626;
theta = [1 1];
format short
format compact



% Setup all returns in excess of risk free rate:
    r1 = data(:,1) - riskfree;
    r2 = data(:,2) - riskfree;
    r3 = data(:,3) - riskfree;
    r4 = data(:,4) - riskfree;
    r5 = data(:,5) - riskfree;
    r6 = data(:,6) - riskfree;
    rm = data(:,7) - riskfree;
    
% Get the D matrix ready for standard error evaluations later
    D = [-1 -sum(rm)/n; -sum(rm)/n -sum(rm.^2)/n];

% make x matrix 
	x = [ones(1,n); rm'];
    
    
    
    % setup h's
    
    h1 = @(var, dat) [r1'-var*dat; rm'.*(r1' - var*dat)];
    h2 = @(var, dat) [r2'-var*dat; rm'.*(r2' - var*dat)];
    h3 = @(var, dat) [r3'-var*dat; rm'.*(r3' - var*dat)];
    h4 = @(var, dat) [r4'-var*dat; rm'.*(r4' - var*dat)];
    h5 = @(var, dat) [r5'-var*dat; rm'.*(r5' - var*dat)];
    h6 = @(var, dat) [r6'-var*dat; rm'.*(r6' - var*dat)];

    
    
    
    %set up g's
    g1 = @(var,dat) sum(h1(var,dat),2)/n;
	g2 = @(var,dat) sum(h2(var,dat),2)/n;
    g3 = @(var,dat) sum(h3(var,dat),2)/n;
    g4 = @(var,dat) sum(h4(var,dat),2)/n;
    g5 = @(var,dat) sum(h5(var,dat),2)/n;
    g6 = @(var,dat) sum(h6(var,dat),2)/n;
    
%-------------------------------------------------------------------------%    
    %Define Objective Function for case 1
    obj1 = @(var, dat, WT)  g1(var,dat)' * WT * g1(var, dat);
    S1 = @ (var,dat) (h1(var,dat)* h1(var,dat)')/n;
    err1 =1 ;
	tol1 = 1*10^-12;
    oldGamma1 = theta;
    WT1 = eye(2,2);
    
    while err1 > tol1
        newGamma1 = fminsearch(@(a) obj1(a,x,WT1),oldGamma1);
        WT1 = inv(S1(newGamma1,x));
        err1 = max(abs(oldGamma1 - newGamma1));
        oldGamma1 = newGamma1;
    end
    
    varTheta1 = inv(D*WT1*D)/n;
    seAlpha1 = sqrt(varTheta1(1,1));
    seBeta1 = sqrt(varTheta1(2,2));
    
    %Define Objective Function for case 2
    obj2 = @(var, dat, WT)  g2(var,dat)' * WT * g2(var, dat);
    S2 = @ (var,dat) (h2(var,dat)* h2(var,dat)')/n;
    err2 =1 ;
	tol2 = 1*10^-12;
    oldGamma2 = theta;
    WT2 = eye(2,2);
    
    while err2 > tol2
        newGamma2 = fminsearch(@(a) obj2(a,x,WT2),oldGamma2);
        WT2 = inv(S2(newGamma2,x));
        err2 = max(abs(oldGamma2 - newGamma2));
        oldGamma2 = newGamma2;
    end 
    
    varTheta2 = inv(D*WT2*D)/n;
    seAlpha2 = sqrt(varTheta2(1,1));
    seBeta2 = sqrt(varTheta2(2,2));
    
     %Define Objective Function for case 3
    obj3 = @(var, dat, WT)  g3(var,dat)' * WT * g3(var, dat);
    S3 = @ (var,dat) (h3(var,dat)* h3(var,dat)')/n;
    err3 =1 ;
	tol3 = 1*10^-12;
    oldGamma3 = theta;
    WT3 = eye(2,2);
    
    while err3 > tol3
        newGamma3 = fminsearch(@(a) obj3(a,x,WT3),oldGamma3);
        WT3 = inv(S3(newGamma3,x));
        err3 = max(abs(oldGamma3 - newGamma3));
        oldGamma3 = newGamma3;
    end
    
    varTheta3 = inv(D*WT3*D)/n;
    seAlpha3 = sqrt(varTheta3(1,1));
    seBeta3 = sqrt(varTheta3(2,2));
    
     %Define Objective Function for case 4
    obj4 = @(var, dat, WT)  g4(var,dat)' * WT * g4(var, dat);
    S4 = @ (var,dat) (h4(var,dat)* h4(var,dat)')/n;
    err4 =1 ;
	tol4 = 1*10^-12;
    oldGamma4 = theta;
    WT4 = eye(2,2);
    
    while err4 > tol4
        newGamma4 = fminsearch(@(a) obj4(a,x,WT4),oldGamma4);
        WT4 = inv(S4(newGamma4,x));
        err4 = max(abs(oldGamma4 - newGamma4));
        oldGamma4 = newGamma4;
    end
    
    varTheta4 = inv(D*WT4*D)/n;
    seAlpha4 = sqrt(varTheta4(1,1));
    seBeta4 = sqrt(varTheta4(2,2));
    
     %Define Objective Function for case 5
    obj5 = @(var, dat, WT)  g5(var,dat)' * WT * g5(var, dat);
    S5 = @ (var,dat) (h5(var,dat)* h5(var,dat)')/n;
    err5 =1 ;
	tol5 = 1*10^-12;
    oldGamma5 = theta;
    WT5 = eye(2,2);
    
    while err5 > tol5
        newGamma5 = fminsearch(@(a) obj5(a,x,WT5),oldGamma5);
        WT5 = inv(S5(newGamma5,x));
        err5 = max(abs(oldGamma5 - newGamma5));
        oldGamma5 = newGamma5;
    end
    
    varTheta5 = inv(D*WT5*D)/n;
    seAlpha5 = sqrt(varTheta5(1,1));
    seBeta5 = sqrt(varTheta5(2,2));
    
     %Define Objective Function for case 6
    obj6 = @(var, dat, WT)  g6(var,dat)' * WT * g6(var, dat);
    S6 = @ (var,dat) (h6(var,dat)* h6(var,dat)')/n;
    err6 =1 ;
	tol6 = 1*10^-15;
    oldGamma6 = theta;
    WT6 = eye(2,2);
    
    while err6 > tol6
        newGamma6 = fminsearch(@(a) obj6(a,x,WT6),oldGamma6);
        WT6 = inv(S6(newGamma6,x));
        err6 = max(abs(oldGamma6 - newGamma6));
        oldGamma6 = newGamma6;
    end
    
    varTheta6= inv(D*WT6*D)/n;
    seAlpha6 = sqrt(varTheta6(1,1));
    seBeta6 = sqrt(varTheta6(2,2));
    
    %-------------------------------------------------------------------------%
    finalGamma = [newGamma1(1); newGamma2(1); newGamma3(1); newGamma4(1); newGamma5(1); newGamma6(1); newGamma1(2); newGamma2(2); newGamma3(2); newGamma4(2); newGamma5(2); newGamma6(2)] 
    finalSe = [seAlpha1; seAlpha2; seAlpha3; seAlpha4; seAlpha5; seAlpha6; seBeta1; seBeta2; seBeta3; seBeta4; seBeta5; seBeta6]
    
    
%     newGamma1
%     seAlpha1
%     seBeta1
%     fprintf('\n \n \n')
%     newGamma2
%     seAlpha2
%     seBeta2
%     fprintf('\n \n \n')
%     newGamma3
%     seAlpha3
%     seBeta3
%     fprintf('\n \n \n')
%     newGamma4
%     seAlpha4
%     seBeta4
%     fprintf('\n \n \n')
%     newGamma5
%     seAlpha5
%     seBeta5
%     fprintf('\n \n \n')
%     newGamma6
%     seAlpha6
%     seBeta6
%     
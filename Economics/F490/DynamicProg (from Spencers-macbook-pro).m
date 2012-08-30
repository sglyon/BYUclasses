clear
clc

%constants
beta = .95;
r = .03;
S=0:.25:1;
P=[.4,.3,.15,.12,.03;.18,.42,.20,.15,.05; .1,.15,.5,.15,.1;.05,.15,.2,.42,.18;.03,.12,.15,.3,.4];
gamma = 3;
A=.0001:.005:3.0001;
a= length(A);
n_S = length(S);
sa = a*n_S;
v_0 = randn(a,n_S);
tol = 0.1;

%functions
u = @(x) x^(1-gamma)/(1-gamma);
c_t = @(a_t, a_t1, s_t) (1 +r)*a_t+s_t - a_t1;


%creating utilty matricies
util1 = ones(a,a);
util2 = ones(a,a);
util3 = ones(a,a);
util4 = ones(a,a);
util5 = ones(a,a);



% here we make sure that we have rows representing tommorrow's savings
% and the columns are for today's. We also say that any entry with negative 
% consumtption needs to be set to -inf so it doesn't interfere with the loop. 

for i=1:a
    for j=1:a
        if c_t(A(j),A(i),S(1)) > 0
           util1(i,j)=u(c_t(A(j),A(i),S(1)));
        else
            util1(i,j)= -inf;
        end
    end
end

for i=1:a
    for j=1:a
        if c_t(A(j),A(i),S(2)) > 0
            util2(i,j)=u(c_t(A(j),A(i),S(2)));
        else
             util2(i,j)=-inf;
        end
    end
end

for i=1:a
    for j=1:a
        if c_t(A(j),A(i),S(3)) > 0
            util3(i,j)=u(c_t(A(j),A(i),S(3)));
        else
            util3(i,j)= -inf;
        end
    end
end

for i=1:a
    for j=1:a
        if c_t(A(j),A(i),S(4)) > 0
            util4(i,j)=u(c_t(A(j),A(i),S(4)));
        else
            util4(i,j) = -inf;
        end
    end
end

for i=1:a
    for j=1:a
        if c_t(A(j),A(i),S(5)) > 0
            util5(i,j)=u(c_t(A(j),A(i),S(5)));
        else
            util5(i,j) = -inf;
        end
    end
end



% Note we could have put all 5 of the util matricies in the same for loop. 
% I did it this way for clarity. 
 
% Allocate memory for iteration variables
r1 = zeros(a,1);

r2 = zeros(a,1);

r3 = zeros(a,1);

r4 = zeros(a,1);

r5 = zeros(a,1);


% This is just using the v_0 defined in the constants section to give us our first policy function
% and our first real value function.

[tv1, tdec1] = max(util1 + beta*repmat(v_0*transpose(P(1,:)),1,a));
[tv2, tdec2] = max(util2 + beta*repmat(v_0*transpose(P(2,:)),1,a));
[tv3, tdec3] = max(util3 + beta*repmat(v_0*transpose(P(3,:)),1,a));
[tv4, tdec4] = max(util4 + beta*repmat(v_0*transpose(P(4,:)),1,a));
[tv5, tdec5] = max(util5 + beta*repmat(v_0*transpose(P(5,:)),1,a));

% If you look the value function input in the above lines (v_0) needs to be n x s. 
% The return value of the max function is an n x 1 vector, one for each state.
% The line below takes those vectors and makes them into an n x s matrix.

tvnew = [tv1; tv2; tv3; tv4; tv5]';


% Just creating an arbirary starting norm that is greater than tol. 
% also creating an indexing variable "n" that tells us how many times we ran the loop. 
theNorm = 5;
n=1;
    
    
%--------------------------------------------------------------------------
% the main loop

while theNorm > tol
    
% Find new policy function  
[tv1, tdec1] = max(util1 + beta*repmat(tvnew*transpose(P(1,:)),1,a));
[tv2, tdec2] = max(util2 + beta*repmat(tvnew*transpose(P(2,:)),1,a));
[tv3, tdec3] = max(util3 + beta*repmat(tvnew*transpose(P(3,:)),1,a));
[tv4, tdec4] = max(util4 + beta*repmat(tvnew*transpose(P(4,:)),1,a));
[tv5, tdec5] = max(util5 + beta*repmat(tvnew*transpose(P(5,:)),1,a));

% Prepare value function for checking norm and conforming shape for matrix equations.
% Similar to what we did above.

tvold = [tv1; tv2; tv3; tv4; tv5]';
tpol = [tdec1; tdec2; tdec3; tdec4; tdec5]; % we don't actually use this


% Reset J matricies. If we didn't they would be 'collecting' 1's that shouldn't persist. 

J1 = zeros(a,a);
J2 = zeros(a,a);
J3 = zeros(a,a);
J4 = zeros(a,a);
J5 = zeros(a,a);

% re-populate the r vectors and the J matricies using new policy funciton.
% like creating utilty matricies we could have done this with a single for loop. 
for i = 1:a
     r1(i) = util1(tdec1(i),i);
     J1(i, tdec1(i))=1;
end

for i = 1:a
    r2(i) = util2(tdec2(i),i);
    J2(i, tdec2(i))=1;
end

for i = 1:a
    r3(i) = util3(tdec3(i),i);
    J3(i, tdec3(i))=1;
end

for i = 1:a
    r4(i) = util4(tdec4(i),i);
    J4(i, tdec4(i))=1;
end

for i = 1:a
    r5(i) = util5(tdec5(i),i);
    J5(i, tdec5(i))=1;
end

% Apply the policy function over infinite horizion. Get expected value function. The tvn equation does this. 
% Output is an ns x 1 vector where we have s nx1 vectors stacked on eachother to make a huge column vector. 
tvn = (eye(a*n_S) - beta*[P(1,1)*J1 P(1,2)*J1 P(1,3)*J1 P(1,4)*J1 P(1,5)*J1; P(2,1)*J2 P(2,2)*J2 P(2,3)*J2 P(2,4)*J2 P(2,5)*J2; P(3,1)*J3 P(3,2)*J3 P(3,3)*J3 P(3,4)*J3 P(3,5)*J3; P(4,1)*J4 P(4,2)*J4 P(4,3)*J4 P(4,4)*J4 P(4,5)*J4; P(5,1)*J5 P(5,2)*J5 P(5,3)*J5 P(5,4)*J5 P(5,5)*J5])\[r1; r2; r3; r4; r5];

%Change output from previous line from ns x 1 to n x s (to compare with tvold and to become tvnew in next iteration)
tvnew = reshape(tvn,a,n_S);

%Update the value of theNorm to check for convergence. Repeat.
% The equaiton I chose to compute the norm is totally made up. It could be any measure of distance you want. 
% This one just made sense mathematically. 
theNorm = abs(norm(tvnew)- norm(tvold));

% This is just a placeholder vector that stores the value of the norm on each iteration.
storeNorm(n) = theNorm;

% Increment the indexing variable n and we are done!
n=n+1;

end
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% create plots.
% you must type figure in a script file if you want to get more than one graph out of it. (the command...
% tells MatLab to create a new figure each time it is called)


% creating the plot of the policy funcitons.
% the horizontal axis is savings today. The vertical axis is savings tomorrow. 
figure
polPlot = plot(A,tdec1,A,tdec2,A,tdec3,A,tdec4,A,tdec5);
xlabel('at')
ylabel('at+1 (index in A)')
title('optimal policy funciton')
legend1 = legend('state 1', 'state 2', 'state 3', 'state 4', 'state 5');
set(legend1, 'Location','SouthEast')

% In this one we had to set the axis. Axis are usually set with first x,y pair (in this case A,tv1)
% but the range for tv1 is very different than that of the other value functions so I used the axis
% command to make the window size of the plot fit the data well.
% The horizontal axis is savings tomorrow. The vertical axis is the value associated with that level of savings. 
figure
valPlot = plot(A,tv1, A, tv2, A, tv3, A, tv4, A, tv5);
xlabel('at')
ylabel('value')
title('optimal value function')
axis([0 3.5 -350 0])
legend2 = legend('state 1', 'state 2', 'state 3', 'state 4', 'state 5');
set(legend2, 'Location','SouthEast')



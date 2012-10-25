function out = hansen1ss(in)

% TODO: fix which vals I solve for
kbar = in(1);
ybar = in(2);
cbar = in(3);
wbar = in(4);
rbar = in(5);

vector = [kbar; kbar; kbar;
          ybar; cbar; wbar; rbar;
          ybar; cbar; wbar; rbar;
          0; 0];
out = hansen1dyn(vector);

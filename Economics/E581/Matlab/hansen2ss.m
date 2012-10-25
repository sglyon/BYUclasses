function out = hansen2ss(in)
kbar = in(1);
ybar = in(2);
cbar = in(3);
hbar = in(4);
wbar = in(5);
rbar = in(6);

vector = [kbar; kbar; kbar;
          ybar; cbar; hbar; wbar; rbar;
          ybar; cbar; hbar; wbar; rbar;
          0; 0];

out = hansen2dyn(vector);

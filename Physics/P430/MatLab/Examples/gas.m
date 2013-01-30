% Gas Dynamics in a closed tube, Physics 430
clear;close all;

global gamma kB mu M F A B h tau N;

% Physical Constants
gamma = 1.4;     % Adiabatic Exponent
kappa = 0.024;   % Thermal conductivity
kB = 1.38e-23;   % Boltzman Constant
mu = 1.82e-5;    % Coefficient of viscosity
M = 29*1.67e-27; % Mass of air molecule (Average)
F = (gamma-1)*M*kappa/kB;   % a useful constant

% System Parameters
L=10.0;          % Length of tube
T0 = 293;        % Ambient temperature
rho0 = 1.3;      % static density (sea level)

% speed of sound
c=sqrt(gamma * kB * T0 /M);

% cell-center grid with ghost points
N=100;
h=L/N;
x=-.5*h:h:L+.5*h;
x=x'; % turn x into a column vector

% initial distributions
rho = rho0 * ones(N+2,1);
T = T0 * ones(N+2,1);
v = exp(-200*(x/L-0.5).^2) * c/100;

% taulim=...;
% fprintf(' Courant limit on time step: %g \n',taulim);
tau=1e-4;     %input(' Enter the time step - ')
tfinal = 0.1; %input(' Enter the run time - ')
nsteps = tfinal/tau;

skip = 5;  %input(' Steps to skip between plots - ')

A=zeros(N+2,N+2);
B=A;

for n=1:nsteps

    time = (n-1) * tau;

    % Plot the current values before stepping
    if mod((n-1),skip)==0
        subplot(3,1,1)
        plot(x,rho);
        ylabel('\rho');
        axis([0 L 1.28 1.32])
        title(['time=' num2str(time)])
        subplot(3,1,2)
        plot(x,T);
        ylabel('T')
        axis([0 L 292 294])
        subplot(3,1,3)
        plot(x,v);
        ylabel('v');
        axis([0 L -4 4])
        pause(0.1)
    end

% 1. Predictor step for rho
    rhop = Srho(rho,v,v);

% 2. Predictor step for T
    Tp = ST(T,v,v,rho,rhop);

% 3. Predictor step for v
    vp = Sv(v,v,v,rho,rhop,T,Tp);

% 4. Corrector step for rho
    rhop = Srho(rho,v,vp);

% 5. Corrector step for T
    Tp = ST(T,v,vp,rho,rhop);

% 6. Corrector step for v
    v = Sv(v,v,vp,rho,rhop,T,Tp);

    % Now put rho and T at the same time-level as v
    rho = rhop;
    T = Tp;
end

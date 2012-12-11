% Superconductor diode calibration
% Do a linear fit to the temperature data
clear; close all; clc;

% average the last 20 data points after the voltage
% was roughly constant
% liquid nitrogen
liqNit=importdata('liquidnitrogen.csv');
liqNit=liqNit';
n1=length(liqNit);
voltN=sum(liqNit(n1-20:n1))/length(liqNit(n1-20:n1));
% water
water=importdata('water.csv');
water=water';
n2=length(water);
voltW=sum(water(n2-20:n2))/length(water(n2-20:n2));

% combine the voltages into a list
volt=[voltN voltW];

% make temp array to plot against
tempN=-196; % Celcius
tempW=0.2; % Celcius
temp=[tempN tempW];

% fit the data
temp1=[1 tempN;1 tempW];
volt=volt';
B=(temp1'*temp1)\temp1'*volt;

%%%%%% Make a publication quality plot %%%%%%
% Choose the size of the final figure
Units='Centimeters';
figWidth=8.5;
figHeight=7;

% Create a figure window with the correct size
ff=figure('Units',Units,'Position',[10 10 figWidth figHeight]);

% Plot the data and the fit
T=linspace(-200,10,100);
coef=B(1)+B(2)*T;
% s1=sprintf('V_{0} = %1.6f',B(1));
% str1(1)={s1};
% s2=sprintf('a_{0} = %1.6f',B(2));
% str1(2)={s2};
pp=plot(T,coef,'b-',temp,volt,'r*');

% Set the lineseries visual properties
set(pp(1),'LineWidth',1,'LineStyle','-');  % Make the First Transition line thicker
set(pp(2),'MarkerSize',10,'Marker','.');  % Make the dots a bit bigger

% Set the plot limits and put on labels
ymin=0.4;ymax=1;
axis([-200 1 ymin ymax])
xlabel('T')
ylabel('V(T)')
title('Voltage vs. Temperature')
legend('fit','data')
% text(-75,0.8,str1)

% get a handle to the axes and set the axes visual properties
aa=gca;

% Make the ticks a little longer and set the minor ticks
% to display
% Fill Array with tick marks
%m=1;
%M=((280-80)/10)+2;
%xTick=zeros(1,M);
%while m<M
%    r=80+10*(m-1);
%    if rem(r,20)==0
%        xTick(m)=80+10*(m-1);
%    end
%    m=m+1;
%end

%n=1;
%N=length(xTick);
%while n<=N
%    if xTick(n)~=0
%        xTick(n)=xTick(n);
%    end
%end
% Set ticks
set(aa,'LineWidth',1,...
    'TickLength',get(aa,'TickLength')*2,...
    'FontSize',8,...    % Set the font for the axes
    'XTick',[-200 -175 -150 -125 -100 -75 -50 -25 0],...%xTick(1:end-1),...
    'XMinorTick','On',...
    'YMinorTick','On')

% Put in a legend
legend('Fit','Data')

% Set the output size for the figure.
% DO THIS LAST because the margins depend on font size, etc.
set(aa,'Units',Units,'OuterPosition',[0 0 figWidth figHeight])

% Calculate where the axes box should be placed inside the
% figure (using information from 'TightInset').
newPos=get(aa,'OuterPosition')-...
    get(aa,'TightInset')*[-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1];

% The 'Position' property describes the rectangle
% around the plotted data. Set the position of
% the axes within the figure.
set(aa,'Position',newPos)
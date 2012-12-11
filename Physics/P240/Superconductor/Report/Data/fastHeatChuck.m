% Plot the data for the fast heating of the superconductor
clear; close all; clc;

% import data
fastR=importdata('fastHeatR.csv');
fastV=importdata('fastHeatV.csv');

% Convert voltage to temperature
Voff=0.000366;
Vo=0.460024;
a0=-0.002698;
fastT=(fastV+Voff-Vo)./a0+273;

% initialize time array
time=linspace(0,100,length(fastR));

%%%%%% Make a publication quality plot %%%%%%
% Choose the size of the final figure
Units='Centimeters';
figWidth=8.5;
figHeight=7;

% Create a figure window with the correct size
ff=figure('Units',Units,'Position',[10 10 figWidth figHeight]);

% Plot the data
% Create a line at First deviation and zero resistance
% ymin=-2e-3;ymax=25e-3;
% y1=linspace(ymin,ymax);
% y2=linspace(ymin,ymax);
% x1=120;x2=108;
% pp=plot(fastT,fastR,'k.',x1,y1,'r-',x2,y2,'b-');
pp = plot(fastT, fastR, 'r.')

% Create text to label the lines on the plot
% s1=sprintf('First \nDeviation');
% s2=sprintf('Zero \nResistance');
% text(130,2.5e-3,s1);
% text(85,15e-3,s2);

% Set the lineseries visual properties
set(pp(1),'MarkerSize',1.5,'Marker','x', 'MarkerFaceColor','r');  % Make the dots a bit bigger
% set(pp(2),'LineWidth',1);  % Make the First Transition line thicker
% set(pp(3),'LineWidth',1);  % Make the Zero Resistance line thicker

% Set the plot limits and put on labels
ymin=-2e-3;ymax=0.0215;
axis([78 282 ymin ymax])
title('Resistance vs Temperature')
xlabel('T (K)')
ylabel('R(T) (\Omega)')

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
    'XTick',[80 100 120 140 160 180 200 220 240 260 280],...%xTick(1:end-1),...
    'XMinorTick','On',...
    'YMinorTick','On')

% Put in a legend
%legend('Temperature','First Deviation','Zero Resistance','Location','NorthWest')
%%%%%%%% NOTE THAT THE LEGEND COMMAND IS NOT WORKING PROPERLY FOR PLOTTING
%%%%%%%% MULTIPLE LINES

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
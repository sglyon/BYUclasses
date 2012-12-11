% Plot the data for the fast heating of the superconductor
clear;  clc;

% import data
slowR=importdata('slowHeatR.csv');
slowV=importdata('slowHeatV.csv');

% Convert voltage to temperature
Voff=0.000366;
Vo=0.460024;
a0=-0.002698;
slowT=(slowV+Voff-Vo)./a0+273;

% initialize time array
time=linspace(0,1000,length(slowR));

%%%%%% Make a publication quality plot %%%%%%
% Choose the size of the final figure
Units='Centimeters';
figWidth=8.5;
figHeight=7;

% Create a figure window with the correct size
ff=figure('Units',Units,'Position',[10 10 figWidth figHeight]);

% Plot the data
% Create a line at First deviation and zero resistance
% ymin=-2e-3;ymax=10e-3;
% y1=linspace(ymin,ymax);
% y2=linspace(ymin,ymax);
% x1=116;x2=102.5;
% pp=plot(slowT,slowR,'k.',x1,y1,'r-',x2,y2,'b-');
pp = plot(slowT, slowR, 'b.');

% Set the lineseries visual properties
set(pp(1),'MarkerSize',1.5,'Marker','x',...
    'MarkerFaceColor','b');% Make the dots a bit bigger
%set(pp(2),'MarkerSize',1.5,'Marker','.',...
%    'MarkerFaceColor','b');  % Make the dots a bit bigger
%set(pp(3),'MarkerSize',1.5,'Marker','.',...
%    'MarkerFaceColor','r');  % Make the dots a bit bigger
%set(pp(2),'LineWidth',1,'LineStyle','-');  % Make the First Transition line thicker
%set(pp(3),'LineWidth',1,'LineStyle','-');  % Make the Zero Resistance line thicker

% Set the plot limits and put on labels
ymin=-2e-3;ymax=10e-3;
axis([78 132 ymin ymax])
title('Resistance vs Temperature')
xlabel('T (K)')
ylabel('R(T) (\Omega)')

% Create text to label the lines on the plot
% s1=sprintf('First \nDeviation');
% s2=sprintf('Zero \nResistance');
% text(112.5,1e-3,s1);
% text(97.5,8e-3,s2);

% get a handle to the axes and set the axes visual properties
aa=gca;

% Make the ticks a little longer and set the minor ticks
% to display
% Fill Array with tick marks
m=1;
M=12;
xTick=zeros(1,M);
while m<M
    xTick(m)=80+5*(m-1);
    m=m+1;
end
% Set ticks
set(aa,'LineWidth',1,...
    'TickLength',get(aa,'TickLength')*2,...
    'FontSize',8,...    % Set the font for the axes
    'XTick',xTick(1:end-1),...
    'XMinorTick','On',...
    'YMinorTick','On')

% Put in a legend
%legend('Temperature',...
%    'First Deviation','Zero Resistance','Location','NorthWest')
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
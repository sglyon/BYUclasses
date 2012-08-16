clear;close all;

x=0:0.05:2*pi;
f=sin(x);
data = f + rand(1,length(x))-0.5;
err_hi = f + 0.5;
err_low = f - 0.5;

% Choose what size the final figure should be
Units = 'Centimeters';
figWidth = 8.5;
figHeight = 7;

% Create a figure window of a specific size.  Note that we
% also get a handle to the entire figure (ff) for later use
ff=figure('Units',Units,'Position',[10 10 figWidth figHeight])

% Plot the data and get handles to the lineseries objects.
pp=plot(x,f,'b',x,data,'b.',x,err_hi,'r-.',x,err_low,'g--');

% Set the lineseries visual properties.
set(pp(1),'LineWidth',2); % Make the main sine a heavy line
set(pp(2),'MarkerSize',8);% Make the dots a bit bigger
set(pp(3),'LineWidth',1); % Make the error bound lines heavier
set(pp(4),'LineWidth',1); % Make the error bound lines heavier

% Set the plot limits and put on labels
axis([0 2*pi -1.6 1.6])
xlabel('\theta')
ylabel('sin(\theta)')
title('Fake measurement of Sine function')

% Get a handle to the axes and set the axes visual properties
aa=gca;

% Make the ticks a little longer, put the symbol for pi in the
% number labels using the symbol font (LaTex won't work there),
% and set the minor ticks to display.
set(aa,'LineWidth',1,...
       'TickLength',get(aa,'TickLength')*2,...
       'FontSize',8,...        % Set the font for the axes
       'FontName','Symbol',... % to get the pi symbol in labels
       'XTick',[0  pi/2 pi 3*pi/2 2*pi],...
       'XTickLabel',{'0';'p/2';'p';'3p/2';'2p'},...
       'XMinorTick','On',...
       'YTick',[-1 -.5 0 .5 1],...
       'YMinorTick','On')

% Put in a legend.  We have to specify the font back to
% Helvetica (default) because we changed to the symbol font
% above for the pi tick labels.
ll=legend('Sine','Fake Data','Upper Limit','Lower Limit');
set(ll,'FontName','Helvetica')

% Set the output size for the figure.
% DO THIS LAST because the margins depend on font size, etc.

% Set the outside dimensions of the figure.
set(aa,'Units',Units,'OuterPosition',[0 0 figWidth figHeight])

% Calculate where the axes box should be placed
newPos = get(aa, 'OuterPosition') - ...
   get(aa,'TightInset')*[-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1];

% Set the position of the axes box within the figure
set(aa, 'Position', newPos);

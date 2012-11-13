clear; close all; clc;

x=0:pi / 200:2 * pi;
f=sin(x) .* exp(-x) + 0.01 * sin(15 * x);
data = f + 0.1 * rand(1, length(x)) - 0.05;

Units = 'Centimeters';
figWidth = 16.;
figHeight = 8.;

ff=figure('Units',Units,'Position',[10 10 figWidth figHeight]);

pp=plot(x,f,'b',x,data,'ro');

axis([0 2*pi -1.6 1.6])
xlabel('\theta')
ylabel('sin(\theta)')
title('Fake measurement of Sine function')

aa=gca;

set(aa,'LineWidth',1,...
       'TickLength',get(aa,'TickLength')*2,...
       'FontSize',8,...        % Set the font for the axes
       'FontName','Symbol',... % to get the pi symbol in labels
       'XTick',[0  pi/2 pi 3*pi/2 2*pi],...
       'XTickLabel',{'0';'p/2';'p';'3p/2';'2p'},...
       'XMinorTick','On',...
       'YTick',[-1 -.5 0 .5 1],...
       'YMinorTick','On')

ll=legend('Model','Data')
set(ll,'FontName','Helvetica')

set(aa,'Units',Units,'OuterPosition',[0 0 figWidth figHeight])

newPos = get(aa, 'OuterPosition') - ...
   get(aa,'TightInset')*[-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1];

set(aa, 'Position', newPos);

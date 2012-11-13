clear; close all; clc;

x=0:pi / 200:2 * pi;
f= sin(x).*exp(-x) + 0.01 * sin(15 * x);
data = f + 0.1 * rand(1, length(x)) - 0.05;

Units = 'Centimeters';
figWidth = 16;
figHeight = 8;

ff=figure('Units',Units,'Position',[10 10 figWidth figHeight])

pp=plot(x, f, 'b', x, data, 'ro', x);

set(pp(1),'LineWidth',2); % Make the main sine a heavy line
set(pp(2),'MarkerSize',8);% Make the dots a bit bigger
set(pp(3),'LineWidth',1); % Make the error bound lines heavier
set(pp(4),'LineWidth',1); % Make the error bound lines heavier

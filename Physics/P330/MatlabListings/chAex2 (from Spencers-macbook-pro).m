clear;close all;

x=0:0.05:2*pi;
f=sin(x);
data = f + rand(1,length(x))-0.5;
err_hi = f + 0.5;
err_low = f - 0.5;

% Store our target size in variables. Using these variables
% whenever you reference size will help keep things cleaner.
Units = 'Centimeters';
figWidth = 8.5;
figHeight = 7;

% Create a figure window with the correct size
figure('Units',Units,'Position',[10 10 figWidth figHeight])

% Plot the data
plot(x,f,'b',x,data,'b.',x,err_hi,'r-.',x,err_low,'g--');

% Get a handle to the newly created axes
aa = gca;

% Set the outer dimensions of the axes to be the same as the
% figure.  The 'OuterPosition' property describes the
% boundary of the whole figure.
set(aa,'Units',Units,'OuterPosition',[0 0 figWidth figHeight])

% Calculate where the axes box should be placed inside the
% figure (using information from 'TightInset').
newPos = get(aa, 'OuterPosition') - ...
   get(aa,'TightInset')*[-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1];

% The 'Position' property describes the the rectangle
% around the plotted data
set(aa, 'Position', newPos);

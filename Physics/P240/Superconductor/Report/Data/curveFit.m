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

%plot the fit

figure
T=linspace(-200,10,100);
coef=B(1)+B(2)*T;
s1=sprintf('Vo = %1.6f',B(1));
str1(1)={s1};
s2=sprintf('a0 = %1.6f',B(2));
str1(2)={s2};
plot(T,coef,'b-',temp,volt,'r*')
title('Voltage vs. Temperature')
legend('fit','data')
figfontsizes(11, 9);
text(-20,0.8,str1)
clear; close all;

f=inline('exp(-x).*cos(x)','x')

quadl(f,0,2,1e-8)

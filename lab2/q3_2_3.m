clc 

x_bar = [0.5;0];
u_bar = (7*sqrt(5))/10;
[A,B,C,D] = linmod('maglev', x_bar, u_bar)
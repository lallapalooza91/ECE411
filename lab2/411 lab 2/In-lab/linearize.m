clear all;
clc;
k = 1;
g = 9.8;
x_bar = [0.5; 0];
u_bar = sqrt(g*x_bar(1)^2);

%3.2: calculating the linearized State Space Model
[A B C D] = linmod('maglev', x_bar, u_bar);

%4.1: calculating the gain K for state and output feedback
poles = [-1, -2];
K =  -place(A, B, poles);

%4.2: implementing state and output feedback in digital control form
T = 0.05
sys = tf([(K(1) + 10*K(2)), (10*K(1))], [1, 10]);
sysd = c2d(sys, T, 'tustin')
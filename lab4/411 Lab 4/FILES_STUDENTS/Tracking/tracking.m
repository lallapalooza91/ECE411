clear all

% Plant Parameters
M = 1/17.13;
Kp = 2.46*M;

% Plant Matrices
A1 = [0 1; 0 -1/M];
B1 = [0; Kp/M];
C1 = [1 0];
D = [0];
% Exosystem matrix

A2 = [0 -1; 1 0];
Z1 = [0 0;0 0];
Z2 = [0; 0];

% Augmented continuous-time system matrices

A = [A1 Z1; Z1 A2];

B = [B1; Z2 ];

C = [1 0 -1 0; 0 1 0 -1];

D = [0];

% Sampling time

T_sampling = 0.01;

% Tranformation to digital system

sys = ss(A,B,C,D);
sys_d= c2d(sys,T_sampling);
[Ad,Bd,dummy1,dummy2] = ssdata(sys_d);
Ad
Bd
% Definition of matrix blocks

A1_d = Ad(1:2,1:2);
A2_d = Ad(3:4,3:4);
A3_d = Ad(1:2,3:4);

B1_d = Bd(1:2);

C1_d = C(1:2,1:2);
C2_d = C(1:2,3:4);

% Design F1 so that A1_d+B1_d*K1

F1 = -place(A1_d, B1_d, [0.2 0.3]);

% X = eye(2) is solution of C1*X = -C2, in this case
X = eye(2);

% Computation of the solution of (A1_d+B1_d*F1)*X - X*A2_d + A3_d +
% B1_d*F_2 = 0

Z = -(A1_d+B1_d*F1) + A2_d - A3_d;

% B1_d*F2 = Z

F2 = B1_d\Z;

% Final controller

F = [F1 F2]

L = place(A1_d',C1',[0.3 0.4])








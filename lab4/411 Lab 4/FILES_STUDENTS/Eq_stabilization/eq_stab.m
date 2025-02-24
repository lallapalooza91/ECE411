clear all

%% DESIGN OF THE POLE PLACEMENT CONTROLLER

% Sampling time
T_sampling = 0.05;

% Plant parameters
M = 1/17.13;
Kp = 2.46*M;

% Plant matrices
A = [0 1; 0 -1/M];
B = [0; Kp/M];
C = [1 0];
D = [0];

% Digital system tranformation
sys = ss(A,B,C,D);
sys_d = c2d(sys,T_sampling);
[Ad,Bd,dummy1,dummy2] = ssdata(sys_d)

% Controller and Observer design
K = place(Ad,Bd,[0.2 0.3])
L = place(Ad',C',[0.3 0.4])

Kc = place(A,B,[-20 -21])
Lc = place(A',C',[-10 -12])




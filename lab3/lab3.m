clc;
clear;

% defining system matrices from page 123
A = [0 1 0 0 0; -1 0 0 -1 0; 0 0 0 0 0; 0 0 0 0 1; 0 0 0 -100 0];
B = [0; 1; 0; 0; 0];
D = [-1 0 1 0 0];

% defining sample time 
T  = 0.1;

% finding A_d and B_d
[A_d, B_d] =  c2d(A, B, T);

% partitioning 
A1 = A_d(1:2, 1:2);
A2 = A_d(3:5, 3:5);
A3 = A_d(1:2, 3:5);
B1 = B_d(1:2);
D1 = D(1:2);
D2 = D(3:5);

% choosing F1 
F1_1 = -acker(A1, B1, [0,0]);
F1_2 = -place(A1, B1, [0.8 + 0.2*1i, 0.8 - 0.2*1i]);

% solving equation 4.8
% choice 1
lhs_matrix_1 = [kron(eye(3),(A1+B1*F1_1)) - kron(A2',eye(2)), kron(eye(3),B1);
             kron(eye(3), D1), zeros(3,3)];

rhs_vector = -[A3(:);D2(:)];

kronresult1 = lhs_matrix_1 \ rhs_vector;

X_1 = reshape(kronresult1(1:6), [2,3]);
F2_1 = reshape(kronresult1(7:9), [1,3]);

% choice 2
lhs_matrix_2 = [kron(eye(3),(A1+B1*F1_2)) - kron(A2',eye(2)), kron(eye(3),B1);
             kron(eye(3), D1), zeros(3,3)];

kronresult2 = lhs_matrix_2 \ rhs_vector;

X_2 = reshape(kronresult2(1:6), [2,3]);
F2_2 = reshape(kronresult2(7:9), [1,3]);

% designing observers
L1 = -acker(A_d', D', [0,0,0,0,0])';
L2 = -place(A_d', D', [0.1,0.1+0.3*1i,0.1-0.3*1i,0.2+0.2i,0.2-0.2i])';

% finding transfer functions
% controller 1
F1 = [F1_1 F2_1];
A_ctller1 = A_d + B_d*F1 + L1*D;
[num1, den1] = ss2tf(A_ctller1, -L1, F1, 0);
tf1 = tf(num1, den1, T)

% controller 2
F2 = [F1_2 F2_2];
A_ctller1 = A_d + B_d*F2 + L2*D;
[num2, den2] = ss2tf(A_ctller1, -L2, F2, 0);
tf2 = tf(num2, den2, T)
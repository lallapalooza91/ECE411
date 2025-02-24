k = 1;
g = 9.8;
x_bar = [0.5; 0];
u_bar = sqrt(g*x_bar(1)^2);

%calculating the State Space Model
[A B C D] = linmod('magball', x_bar, u_bar)


%calculating the TF from SS
[b a] = ss2tf(A,B,C,D)


close all;

%frequency response from 0 to 6
subplot(1,3,1);
G = tf([1],[1 0.8 1]);
bode(G, {0,6});
%setoptions(h, 'FreqUnits', 'Hz', 'Phase Visible', 'off');
title('Frequency response of G(s) over the frequency range [0 6].')

%impulse response 
subplot(1,3,2);
sysd = c2d(G, 1, 'impulse');
dbode(sysd, 1, {0,10});
%setoptions(h, 'FreqUnits', 'Hz', 'Phase Visible', 'off');
title('Frequency response of G(ejωT ) over the frequency range [0 10].')

%computing Ad Bd
[A, B, C, D] = tf2ss([1],[1 0.8 1]);
[Ad, Bd] = c2d(A,B,1);
subplot(1,3,3);
[b, a] = ss2tf(Ad, Bd, C, D);
Gd = tf(b,a,1);
dbode(Gd, 1, {0,10});
%setoptions(h, 'FreqUnits', 'Hz', 'Phase Visibile', 'off');
title('Frequency response of G_d(ejωT ) over the frequency range [0 10].')

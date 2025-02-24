s = tf('s');
P = 0.1 / s*(s+0.1);
Pd = c2d(P, 1);
z = tf('z');
Cd = 9*(z - 0.8) / (z+0.8);
Gd = (Pd * Cd)/ (1+(Pd * Cd))
step(Gd);


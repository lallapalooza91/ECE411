function [exec, data] = codefcn3(seg, data)

switch seg
 case 1
  x1A = ttAnalogIn(1); % Read reference
  x2A = ttAnalogIn(2); % Read process output
  x3A = ttAnalogIn(3);
  x4A = ttAnalogIn(4);
  
  data.u1 = data.K1 * [x1A;x2A;x3A;x4A]; % Calculate PID action
  exectime1 = 0.01;

  x1B = ttAnalogIn(5); % Read reference
  x2B = ttAnalogIn(6); % Read process output
  x3B = ttAnalogIn(7);
  x4B = ttAnalogIn(8);
  
  data.u2 = data.K2 * [x1B;x2B;x3B;x4B]; % Calculate PID action
  exectime2 = 0.014;

  x1C = ttAnalogIn(9); % Read reference
  x2C = ttAnalogIn(10); % Read process output
  x3C = ttAnalogIn(11);
  x4C = ttAnalogIn(12);
  
  data.u3 = data.K3 * [x1C;x2C;x3C;x4C]; % Calculate PID action
  exectime3 = 0.017;
  
  exec = exectime1+exectime2 + exectime3;
 case 2
  ttAnalogOut(1, data.u1); % Output control signal
  exectime1 = -1;
  ttAnalogOut(2, data.u2); % Output control signal
  exectime2 = -1;
  ttAnalogOut(3, data.u3); % Output control signal
  exectime3 = -1;

  exec = exectime1+exectime2 + exectime3;
end
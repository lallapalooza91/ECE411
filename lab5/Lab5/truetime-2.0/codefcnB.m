function [exectime, data] = codefcnB(seg, data)

switch seg
 case 1
  x1 = ttAnalogIn(1); % Read reference
  x2 = ttAnalogIn(2); % Read process output
  x3 = ttAnalogIn(3);
  x4 = ttAnalogIn(4);
  
  data.u = data.K * [x1;x2;x3;x4]; % Calculate PID action
  exectime = 0.014;
 case 2
  ttAnalogOut(1, data.u); % Output control signal
  exectime = -1;
end
function node_init(arg)

% Task scheduling and control.
%
% This example extends the simple PID control example (located in
% $DIR/examples/servo) to the case of three PID-tasks running
% concurrently on the same CPU controlling three different servo
% systems. The effect of the scheduling policy on the global control
% performance is demonstrated.

% Initialize TrueTime kernel

switch arg
 case 1   % DM scheduling
  ttInitKernel('prioFP')
 case 2
  ttInitKernel('prioDM')
 case 3   % EDF scheduling, skip next job if current one late
  ttInitKernel('prioEDF')
  otherwise
  error('Illegal init argument')
end

% Task parameters
starttimes = [0];
periods = [0.0142];
tasknames = {'cartA'};

data.K = [4.929 4.528 23.1766 3.7074];
data.u = 0;
data.exectime = 0.01;


ttCreatePeriodicTask(tasknames{1}, starttimes, periods, 'codefcn', data);
ttCreateHandler('DL_handler_1', 1, 'hdlcode');
ttAttachDLHandler('cartA', 'DL_handler_1');

end

function node_initC(arg)

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
periods = [0.024];
tasknames = {'cartA'};

data.K = [6.56 6.037 30.41 5.54];
data.u = 0;
data.exectime = 0.017;


ttCreatePeriodicTask(tasknames{1}, starttimes, periods, 'codefcnC', data);
ttCreateHandler('DL_handler_1', 1, 'hdlcode');
ttAttachDLHandler('cartA', 'DL_handler_1');

end
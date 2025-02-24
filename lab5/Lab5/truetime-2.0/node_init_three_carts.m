function node_init_three_carts(arg)

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
starttimes = {0, 0, 0};
periods = {0.0142, 0.02, 0.024};
tasknames = {'cartA', 'cartB', 'cartC'};

data.K1 = [4.929 4.528 23.1766 3.7074];
data.K2 = [5.7411 5.877 26.85 4.59];
data.K3 = [6.56 6.037 30.41 5.54];
data.u1 = 0;
data.u2 = 0;
data.u3 = 0;
data.exectime1 = 0.01;
data.exectime2 = 0.014;
data.exectime3 = 0.017;

for i = 1:3
    ttCreatePeriodicTask(tasknames{i}, starttimes{i}, periods{i}, 'codefcn3', data);
    ttSetPriority(4-i, tasknames{i})
end
ttCreateHandler('DL_handler_1', 1, 'hdlcode');
for i = 1:3
    ttAttachDLHandler(tasknames{i}, 'DL_handler_1');

end
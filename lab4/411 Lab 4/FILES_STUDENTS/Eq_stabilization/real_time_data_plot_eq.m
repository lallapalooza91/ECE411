

%% Create the serial object

clear all
close all



%% PARAMETERS (CAN BE CHANGED)

save_file = 'experiment_digital_50';


%% PARAMETERS (DO NOT CHANGE)

%% Set the time span and interval for data collection
stopTime = 10;
T_plot = 0.05;
encoder_to_pos = 2.2749*0.00001;



%serialPort = '/dev/tty.usbmodemfd121';
serialPort = 'COM4';
serialObject = serial(serialPort);
fopen(serialObject);



%% Set up the figure window


position = 0;

figureHandle = figure('NumberTitle','off',...
    'Name','Tracking' );
 
% Set axes
axesHandle = axes('Parent',figureHandle,...
    'YGrid','on', 'XGrid','on' );
  

hold on;

plotHandle = plot(axesHandle,0,position,'Marker','.','LineWidth',1);

xlim(axesHandle,[0 stopTime]);

% Create xlabel
xlabel('Time','FontWeight','bold','FontSize',14);

% Create ylabel
ylabel('Position [m]','FontWeight','bold','FontSize',14);

% Create title
title('Tracking','FontWeight','bold','FontSize',15);

plot([0 15],[0.3 0.3],'--k','Linewidth',2);

%% Collect data
count = 2;
time = [0];
ref = [0.3];
position(1) = 0;
obs(1)=0;
obs_v(1)=0;
while time(end)<stopTime

    time = [time count*T_plot];
    position(count) = fscanf(serialObject,'%f') ; 
    position(count) = position(count)*encoder_to_pos;
   
    
     set(plotHandle,'YData',position,'XData',time);
     
     
     obs(count) = fscanf(serialObject,'%f')/1000;
   
     
     obs_v(count) = fscanf(serialObject,'%f')/1000;
          
     set(figureHandle,'Visible','on');

    count = count +1;
    
    
end
legend('Cart Position','Reference Position')

figure(2)
plot(time,obs,'b','Linewidth',2)
hold on
plot(time,position,'k','Linewidth',2)
grid on
xlabel('Time [s]','FontWeight','bold','FontSize',16)
ylabel('Position [m]','FontWeight','bold','FontSize',16)
title('Observer Peformance','FontWeight','bold','FontSize',16)
legend({'Cart Position','Observer Data'},'FontWeight','bold','FontSize',14)



figure(3)
plot(time,obs_v,'b','Linewidth',2)
hold on
grid on
velocity(1)=0;
velocity = [velocity(1) (position(3:end)-position(1:end-2))/(2*T_plot) (position(end)-position(end-1))/T_plot];
plot(time,velocity,'k','Linewidth',2)

xlabel('Time [s]','FontWeight','bold','FontSize',16)
ylabel('Velocity [m/s]','FontWeight','bold','FontSize',16)
title('Observer Peformance','FontWeight','bold','FontSize',16)
legend({'Cart Velocity','Observer Data'},'FontWeight','bold','FontSize',14)



%% Modify file name to save the data
save(save_file);  


%% Clean up the serial object
fclose(serialObject);
delete(serialObject);
clear serialObject;
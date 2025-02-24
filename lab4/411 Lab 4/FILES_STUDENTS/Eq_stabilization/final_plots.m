

load experiment_digital_10

figure(1)
plot(time,position,'b','Linewidth',2)
hold on
grid on
plot(time(:),ref,'r','Linewidth',2)
xlabel('Time [s]','FontWeight','bold','FontSize',16)
ylabel('Position [m]','FontWeight','bold','FontSize',16)


figure(2)
plot(time2,x_obs/10000,'b','Linewidth',2)
hold on
grid on
plot(time,position,'r','Linewidth',2)
xlabel('Time [s]','FontWeight','bold','FontSize',16)
ylabel('Position [m]','FontWeight','bold','FontSize',16)
legend('Observed position','Real position')

load experiment_digital_20

figure(1)
plot(time,position,'c','Linewidth',2)

figure(3)
plot(time2,x_obs/10000,'b','Linewidth',2)
hold on
grid on
plot(time,position,'r','Linewidth',2)
xlabel('Time [s]','FontWeight','bold','FontSize',16)
ylabel('Position [m]','FontWeight','bold','FontSize',16)
legend('Observed position','Real position')


load experiment_digital_50

figure(1)
plot(time,position,'g','Linewidth',2)

figure(4)
plot(time2,x_obs/10000,'b','Linewidth',2)
hold on
grid on
plot(time,position,'r','Linewidth',2)
xlabel('Time [s]','FontWeight','bold','FontSize',16)
ylabel('Position [m]','FontWeight','bold','FontSize',16)
legend('Observed position','Real position')


load experiment_digital_100

figure(1)
plot(time,position,'k','Linewidth',2)


figure(5)
plot(time2,x_obs/10000,'b','Linewidth',2)
hold on
grid on
plot(time,position,'r','Linewidth',2)
xlabel('Time [s]','FontWeight','bold','FontSize',16)
ylabel('Position [m]','FontWeight','bold','FontSize',16)
legend('Observed position','Real position')


load experiment_cont


figure(1)
plot(time,position,'m','Linewidth',2)
hold on


figure(6)
plot(time2,x_obs/10000,'b','Linewidth',2)
hold on
grid on
plot(time,position,'r','Linewidth',2)
xlabel('Time [s]','FontWeight','bold','FontSize',16)
ylabel('Position [m]','FontWeight','bold','FontSize',16)
legend('Observed position','Real position')


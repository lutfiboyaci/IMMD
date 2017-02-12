timeaxis = iload(:,1);
figure;
subplot(3,2,1)
plot(timeaxis,vabc(:,2),'b -','Linewidth',1.5);
hold on;
plot(timeaxis,vabc(:,3),'r -','Linewidth',1.5);
hold on;
plot(timeaxis,vabc(:,4),'k -','Linewidth',1.5);
hold off;
grid on;
set(gca,'FontSize',12);
xlim([0.46 0.5]);
ylabel('Grid voltages, va, vb, vc (V)','FontSize',12,'FontWeight','Bold')

subplot(3,2,2)
plot(timeaxis,iabc(:,2),'b -','Linewidth',1.5);
hold on;
plot(timeaxis,iabc(:,3),'r -','Linewidth',1.5);
hold on;
plot(timeaxis,iabc(:,4),'k -','Linewidth',1.5);
hold off;
grid on;
set(gca,'FontSize',12);
xlim([0.46 0.5]);
ylabel('Grid currents, ia, ib, ic (A)','FontSize',12,'FontWeight','Bold')

subplot(3,2,3)
plot(timeaxis,vdc(:,2),'b -','Linewidth',1.5);
grid on;
set(gca,'FontSize',12);
xlim([0.46 0.5]);
ylim([0 580]);
ylabel('Rectifier output voltage, Vdc (V)','FontSize',12,'FontWeight','Bold')

subplot(3,2,4)
plot(timeaxis,idc(:,2),'b -','Linewidth',1.5);
grid on;
set(gca,'FontSize',12);
xlim([0.46 0.5]);
ylim([0 80]);
ylabel('Rectifier output current, idc (V)','FontSize',12,'FontWeight','Bold')
xlabel('Time (sec)','FontSize',12,'FontWeight','Bold')

subplot(3,2,5)
plot(timeaxis,vload(:,2),'b -','Linewidth',1.5);
grid on;
set(gca,'FontSize',12);
xlim([0.46 0.5]);
ylim([0 580]);
ylabel('Load voltage, vload (V)','FontSize',12,'FontWeight','Bold')

subplot(3,2,6)
plot(timeaxis,iload(:,2),'b -','Linewidth',1.5);
grid on;
set(gca,'FontSize',12);
xlim([0.46 0.5]);
ylim([0 56]);
ylabel('Load current, iload (A)','FontSize',12,'FontWeight','Bold')


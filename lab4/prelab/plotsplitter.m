% Load saved figures
c=hgload('T100msprelab_position.fig');
k=hgload('T100msprelab_velocity.fig');
% Prepare subplots
figure
h(1)=subplot(1,2,1);
h(2)=subplot(1,2,2);
% Paste figures on the subplots
copyobj(allchild(get(c,'CurrentAxes')),h(1));
copyobj(allchild(get(k,'CurrentAxes')),h(2));
% Add legends
l(1)=legend(h(1),'Observer Data', 'Cart Position')
l(2)=legend(h(2),'Observer Data', 'Cart Velocity')
t(1) = title(h(1), 'Observer Performance for Position','FontSize',15,'FontWeight','bold')
t(2) = title(h(2), 'Observer Performance for Velocity','FontSize',15,'FontWeight','bold')
x = xlabel(h, 'Time (s)')
y(1) = ylabel(h(1), 'Position(m)')
y(2) = ylabel(h(2), 'Velocity(m/s)')

% Load saved figures
c=hgload('4.1.1.fig');
k=hgload('4.1.2.fig');
% Prepare subplots
figure
h(1)=subplot(1,2,1);
h(2)=subplot(1,2,2);
% Paste figures on the subplots
copyobj(allchild(get(c,'CurrentAxes')),h(1));
copyobj(allchild(get(k,'CurrentAxes')),h(2));
% Add legends
l(1)=legend(h(1),'Stable')
l(2)=legend(h(2),'Unstable')
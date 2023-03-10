clear;

 f1 = load('fig12.mat');
 

 pr = f1.pr;

 th = f1.th_struct;
 wth1_e = th{1};
 wth2_e = th{2};
 wth3_e = th{3};
 wth1_w = th{4};
 wth2_w = th{5};
 wth3_w = th{6};

 qtot1_e = th{7};
 qtot2_e = th{8};
 qtot3_e = th{9};
 qtot1_w = th{10};
 qtot2_w = th{11};
 qtot3_w = th{12};


AxisFontsize=12;
TextFontsize=10;
ArrowWidth=10;
FigNum=1;

hf = figure;
s1 = subplot(1,3,1);
hold on
 ax1 = gca;
 ax1.YDir = 'reverse';
 %ax1.YDir = 'reverse';
 plot((wth1_e),pr,'r-',(wth2_e),pr,'g-',(wth3_e),pr,'b-',(wth1_w),pr,'r--',(wth2_w),pr,'g--',(wth3_w),pr,'b--','LineWidth',2.0)
 
 ylabel('Pressure in hPa')
 xlabel('K/day')
 %legend('L75O100 EP','L100O100 EP','L75O75 EP','L75O100 WP','L100O100 WP','L75O75 WP');

 ylim([100 1000])
 box on
 xlim([-4.0 4.0]);

% set some properties
%set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on','fontweight','bold');
% set the position of the axes in the figure
%set(gca,'Position',[0.0 0.5 0.45 0.45])

pbaspect([1.0 1.5 1.0])
dim = [0.08 0.4 0.3 0.3];
str = {'(a)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');

 s2 =subplot(1,3,2);
hold on;
 ax2 = gca;
ax2.YDir = 'reverse';
plot((qtot1_e),pr,'r-',(qtot2_e),pr,'g-',(qtot3_e),pr,'b-',(qtot1_w),pr,'r--',(qtot2_w),pr,'g--',(qtot3_w),pr,'b--','LineWidth',2.0)
 
 %ylabel('Pressure in hPa')
 xlabel('K/day')
% hleg = legend('L75O100 EP','L100O100 EP','L75O75 EP','L75O100 WP','L100O100 WP','L75O75 WP');
% set(hleg, 'location', 'northeastoutside')
 box on
 ylim([100.0 1000.0])
 xlim([-4.0 4.0])
 
% set some properties
%set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on','fontweight','bold');
% set the position of the axes in the figure
%set(gca,'Position',[0.5 0.5 0.45 0.45])
pbaspect([1.0 1.5 1.0])
dim = [0.35 0.4 0.3 0.3];
str = {'(b)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');
hold on

 s3 =subplot(1,3,3);
  plot(1, nan, 'r-',1, nan,'g-',1,nan,'b-',1,nan,'r--',1,nan,'g--',1,nan,'b--','LineWidth',2.0); 
  set(s3, 'Visible', 'off');
  legend(s3,'L75O100 EP','L100O100 EP','L75O75 EP','L75O100 WP','L100O100 WP','L75O75 WP');

hold off

print -depsc2 Fig12.eps
close

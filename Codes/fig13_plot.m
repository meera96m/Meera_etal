clear;


 f1 = load('fig13.mat');

 pr = f1.pr;

 th = f1.th_struct;

 rad1_e = th{1};
 rad2_e = th{2};
 rad3_e = th{3};
 rad1_w = th{4};
 rad2_w = th{5};
 rad3_w = th{6};

 conv1_e = th{7};
 conv2_e = th{8};
 conv3_e = th{9};
 conv1_w = th{10};
 conv2_w = th{11};
 conv3_w = th{12};

 ls1_e = th{13};
 ls2_e = th{14};
 ls3_e = th{15};
 ls1_w = th{16};
 ls2_w = th{17};
 ls3_w = th{18};

 bl1_e = th{19};
 bl2_e = th{20};
 bl3_e = th{21};
 bl1_w = th{22};
 bl2_w = th{23};
 bl3_w = th{24};


AxisFontsize=12;
TextFontsize=10;
ArrowWidth=10;
FigNum=1;

hf = figure
s1 = subplot(1,4,1);
hold on
 ax1 = gca;
 ax1.YDir = 'reverse';
 %ax1.YDir = 'reverse';

 plot((rad1_e),pr,'r-',(rad2_e),pr,'g-',(rad3_e),pr,'b-',(rad1_w),pr,'r--',(rad2_w),pr,'g--',(rad3_w),pr,'b--','LineWidth',2.0)
 ylabel('Pressure in hPa')
 xlabel('K/day')
 %legend('L75O100 EP','L100O100 EP','L75O75 EP','L75O100 WP','L100O100 WP','L75O75 WP');
 pbaspect([1.0 1.5 1.0])
 ylim([100 1000])
 box on
 xlim([-4.0 4.0]);

% set some properties
%set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on','fontweight','bold');
% set the position of the axes in the figure
%set(gca,'Position',[0.0 0.5 0.45 0.45])

dim = [0.11 0.43 0.3 0.3];
str = {'(a) '};
annotation('textbox',dim,'String',str,'EdgeColor','none');

 s2 =subplot(1,4,2);
hold on;
 ax2 = gca;
ax2.YDir = 'reverse';
 plot((conv1_e),pr,'r-',(conv2_e),pr,'g-',(conv3_e),pr,'b-',(conv1_w),pr,'r--',(conv2_w),pr,'g--',(conv3_w),pr,'b--','LineWidth',2.0)
 %ylabel('Pressure in hPa')
 xlabel('K/day')
 %set(gca,'YTick',[]);
 set(gca,'YTickLabel',[]);

% hleg = legend('L75O100 EP','L100O100 EP','L75O75 EP','L75O100 WP','L100O100 WP','L75O75 WP');
% set(hleg, 'location', 'northeastoutside')
 pbaspect([1.0 1.5 1.0])
 box on
 ylim([100.0 1000.0])
 xlim([-4.0 4.0])
 
% set some properties
%set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on','fontweight','bold');
% set the position of the axes in the figure
%set(gca,'Position',[0.5 0.5 0.45 0.45])
dim = [0.32 0.43 0.3 0.3];
str = {'(b)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');
hold on

 s3 =subplot(1,4,3);
hold on;
 ax3 = gca;
ax3.YDir = 'reverse';
 plot((ls1_e),pr,'r-',(ls2_e),pr,'g-',(ls3_e),pr,'b-',(ls1_w),pr,'r--',(ls2_w),pr,'g--',(ls3_w),pr,'b--','LineWidth',2.0)
 xlabel('K/day')
 % set(gca,'YTick',[]);
 set(gca,'YTickLabel',[]);
% hleg = legend('L75O100 EP','L100O100 EP','L75O75 EP','L75O100 WP','L100O100 WP','L75O75 WP');
% set(hleg, 'location', 'northeastoutside')
 pbaspect([1.0 1.5 1.0])
 box on
 ylim([100.0 1000.0])
 xlim([-4.0 4.0])

% set some properties
%set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on','fontweight','bold');
% set the position of the axes in the figure
%set(gca,'Position',[0.5 0.5 0.45 0.45])
dim = [0.53 0.43 0.3 0.3];
str = {'(c)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');
hold on

 s4 =subplot(1,4,4);
hold on;
 ax4 = gca;
ax4.YDir = 'reverse';
 plot((bl1_e),pr,'r-',(bl2_e),pr,'g-',(bl3_e),pr,'b-',(bl1_w),pr,'r--',(bl2_w),pr,'g--',(bl3_w),pr,'b--','LineWidth',2.0)
 %ylabel('Pressure in hPa')
 xlabel('K/day')
  %set(gca,'YTick',[]);
 set(gca,'YTickLabel',[]);
% hleg = legend('L75O100 EP','L100O100 EP','L75O75 EP','L75O100 WP','L100O100 WP','L75O75 WP');
% set(hleg, 'location', 'northeastoutside')
 pbaspect([1.0 1.5 1.0])
 box on
 ylim([100.0 1000.0])
 xlim([-4.0 4.0])

% set some properties
%set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on','fontweight','bold');
% set the position of the axes in the figure
%set(gca,'Position',[0.5 0.5 0.45 0.45])
dim = [0.73 0.43 0.3 0.3];
str = {'(d)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');

hold off


print -depsc2 Fig13.eps
close

clear;

 f1 = load('fig8.mat');

 %CP L75O100
 prcl1 = f1.parcel1;
 cape1 = prcl1{4};
 cpr1  = prcl1{6};

%CP L75O75
 prcl2 = f1.parcel2;
 cape2 = prcl2{4};
 cpr2  = prcl2{6};

%WP L75O100
 prcl3 = f1.parcel3;
 cape3 = prcl3{4};
 cpr3  = prcl3{6};

%WP L75O75
 prcl4 = f1.parcel4;
 cape4 = prcl4{4};
 cpr4  = prcl4{6};

 m1 = mean(cape1(:))
 m2 = mean(cape2(:))
 m3 = mean(cape3(:))
 m4 = mean(cape4(:))

 p1 = mean(cpr1(:))
 p2 = mean(cpr2(:))
 p3 = mean(cpr3(:))
 p4 = mean(cpr4(:))

 AxisFontsize=12;
TextFontsize=10;
ArrowWidth=10;
FigNum=1;

 hf = figure;
s1 = subplot(3,2,1);
Xedges = 0.0:1.0:15.0;
Yedges = 0.0:500.0:4000.0;
%title('Central Pacific')
histogram2(cpr1(:),cape1(:),Xedges,Yedges,'Normalization','probability','DisplayStyle','tile','ShowEmptyBins','on');
[N3,Xe,Ye]= histcounts2(cpr1(:),cape1(:),Xedges,Yedges,'Normalization','probability');
histogram2(cpr2(:),cape2(:),Xedges,Yedges,'Normalization','probability','DisplayStyle','tile','ShowEmptyBins','on')
[N4,Xe,Ye]= histcounts2(cpr2(:),cape2(:),Xedges,Yedges,'Normalization','probability');
Xe = Xe(2:end) - (Xe(2)-Xe(1))/2;

plot(Xe, N3(:,5),'b-',Xe,N4(:,5),'r-','LineWidth',2.0 )
%set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on','fontweight','bold');
legend('L75O100','L75O75')
legend boxoff
xlabel('Convective precipitation in mm/day');
ylabel('Probability');
title('Central Pacific')
xlim([0 15])
ylim([0 0.08])
dim = [0.07 0.67 0.3 0.3];
str = {'(a)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');

s2 = subplot(3,2,2);
Xedges = 0.0:1.0:15.0;
Yedges = 0.0:500.0:4000.0;
%title('Western Pacific')
histogram2(cpr3(:),cape3(:),Xedges,Yedges,'Normalization','probability','DisplayStyle','tile','ShowEmptyBins','on');
[N1,Xe,Ye]= histcounts2(cpr3(:),cape3(:),Xedges,Yedges,'Normalization','probability');
histogram2(cpr4(:),cape4(:),Xedges,Yedges,'Normalization','probability','DisplayStyle','tile','ShowEmptyBins','on')
[N2,Xe,Ye]= histcounts2(cpr4(:),cape4(:),Xedges,Yedges,'Normalization','probability');
Xe = Xe(2:end) - (Xe(2)-Xe(1))/2;

plot(Xe, N1(:,6),'b-',Xe,N2(:,6),'r-','LineWidth',2.0 )
%set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on','fontweight','bold');
legend('L75O100','L75O75')
legend boxoff
xlabel('Convective precipitation in mm/day');
ylabel('Probability');
title('Western Pacific')
xlim([0 15])
ylim([0 0.08])
dim = [0.5 0.67 0.3 0.3];
str = {'(b)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');

s3 = subplot(3,2,3);
%title('Central Pacific')
edges=0.0:250.0:4000.0;%1.0:15.0;%250.0:4000.0;
h3 = histogram(cape1(:),edges,'facealpha',.5,'Normalization','probability');
%set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on','fontweight','bold');
xlim([0.0 4000.0])
ylim([0.0 0.5])
line(m1*[1 1],ylim,'LineWidth', 2, 'Color', 'b')
xlabel('CAPE in J/kg');
ylabel('Probability');
hold on

h4 = histogram(cape2(:),edges,'facealpha',.5,'Normalization','probability');
xlim([0.0 4000.0])
ylim([0.0 0.5])
line(m2*[1 1],ylim,'LineWidth', 2, 'Color', 'r')
legend('L75O100','','L75O75','','location','northwest')
legend boxoff
dim = [0.07 0.35 0.3 0.3];
str = {'(c)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');


s4 = subplot(3,2,4);

%title('Western Pacific')
edges=0.0:250.0:4000.0;%1.0:15.0;%250.0:4000.0;
h1 = histogram(cape3(:),edges,'facealpha',.5,'Normalization','probability');
%set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on','fontweight','bold');
xlim([0.0 4000.0])
ylim([0.0 0.5])
line(m3*[1 1],ylim,'LineWidth', 2, 'Color', 'b')
xlabel('CAPE in J/kg');
ylabel('Probability');
hold on

h2 = histogram(cape4(:),edges,'facealpha',.5,'Normalization','probability');
xlim([0.0 4000.0])
ylim([0.0 0.5])
line(m4*[1 1],ylim,'LineWidth', 2, 'Color', 'r')
legend('L75O100','','L75O75','','location','northwest')
legend boxoff

dim = [0.5 0.35 0.3 0.3];
str = {'(d)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');

s5 = subplot(3,2,5);
edges=0.0:1.0:15.0;%250.0:4000.0;
hh3 = histogram(cpr1(:),edges,'facealpha',.5,'Normalization','probability');
%set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on','fontweight','bold');
xlim([0.0 15.0])
ylim([0.0 0.5])
line(p1*[1 1],ylim,'LineWidth', 2, 'Color', 'b')
xlabel('Convective precipitation in mm/day');
ylabel('Probability');

hold on

hh4 = histogram(cpr2(:),edges,'facealpha',.5,'Normalization','probability');
xlim([0.0 15.0])
ylim([0.0 0.5])
line(p2*[1 1],ylim,'LineWidth', 2, 'Color', 'r')
legend('L75O100','','L75O75','','location','northeast')
legend boxoff
dim = [0.07 0.083 0.3 0.3];
str = {'(e)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');

s6 = subplot(3,2,6);
edges=0.0:1.0:15.0;%250.0:4000.0;
hh1 = histogram(cpr3(:),edges,'facealpha',.5,'Normalization','probability');
%set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on','fontweight','bold');
xlim([0.0 15.0])
ylim([0.0 0.5])
line(p3*[1 1],ylim,'LineWidth', 2, 'Color', 'b')
xlabel('Convective precipitation in mm/day');
ylabel('Probability');
hold on

hh2 = histogram(cpr4(:),edges,'facealpha',.5,'Normalization','probability');
xlim([0.0 15.0])
ylim([0.0 0.5])
line(p4*[1 1],ylim,'LineWidth', 2, 'Color', 'r')
legend('L75O100','','L75O75','','location','northeast')
legend boxoff
dim = [0.5 0.083 0.3 0.3];
str = {'(f)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');


hold off

print -depsc2 Fig8.eps


 close


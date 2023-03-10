
clear;

 f1 = load('fig6.mat');

 prcl1 = f1.parcel1;
 cape1 = prcl1{4};
 cpr1  = prcl1{6};

 prcl2 = f1.parcel2;
 cape2 = prcl2{4};
 cpr2  = prcl2{6};

 m1 = mean(cape1(:))
 m2 = mean(cape2(:))

 p1 = mean(cpr1(:))
 p2 = mean(cpr2(:))

 AxisFontsize=12;
TextFontsize=10;
ArrowWidth=10;
FigNum=1;

 hf = figure;

s1 = subplot(2,2,1);

Xedges = 0.0:1.0:15.0;
Yedges = 0.0:500.0:4000.0;

histogram2(cpr1(:),cape1(:),Xedges,Yedges,'Normalization','probability','DisplayStyle','tile','ShowEmptyBins','on');
[N1,Xe,Ye]= histcounts2(cpr1(:),cape1(:),Xedges,Yedges,'Normalization','probability');
histogram2(cpr2(:),cape2(:),Xedges,Yedges,'Normalization','probability','DisplayStyle','tile','ShowEmptyBins','on')
[N2,Xe,Ye]= histcounts2(cpr2(:),cape2(:),Xedges,Yedges,'Normalization','probability');
Xe = Xe(2:end) - (Xe(2)-Xe(1))/2;

plot(Xe, N1(:,6)./sum(N1(:,6),1),'b-',Xe,N2(:,6)./sum(N2(:,6),1),'r-','LineWidth',2.0 )
%set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on','fontweight','bold');
legend('L75O100','L100O100')
legend boxoff
xlabel('Convective precipitation in mm/day');
ylabel('Probability');
xlim([0 15])
ylim([0 0.5])
dim = [0.05 0.68 0.3 0.3];
str = {'(a)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');

s2 = subplot(2,2,2);
edges=0.0:250.0:4000.0;
h1 = histogram(cape1(:),edges,'facealpha',.5,'Normalization','probability');
%set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on','fontweight','bold');
xlim([0.0 4000.0])
ylim([0.0 0.5])
line(m1*[1 1],ylim,'LineWidth', 2, 'Color', 'b')
xlabel('CAPE in J/kg');

hold on

h2 = histogram(cape2(:),edges,'facealpha',.5,'Normalization','probability');
xlim([0.0 4000.0])
ylim([0.0 0.5])
line(m2*[1 1],ylim,'LineWidth', 2, 'Color', 'r')
legend('L75O100','','L100O100','','location','northwest')
legend boxoff

dim = [0.5 0.68 0.3 0.3];
str = {'(b)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');


hold on

s3 = subplot(2,2,3.5);
edges=0.0:1.0:15.0;
hh1 = histogram(cpr1(:),edges,'facealpha',.5,'Normalization','probability');
%set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on','fontweight','bold');
xlim([0.0 15.0])
ylim([0.0 0.5])
line(p1*[1 1],ylim,'LineWidth', 2, 'Color', 'b')
xlabel('Convective precipitation in mm/day');

hold on

hh2 = histogram(cpr2(:),edges,'facealpha',.5,'Normalization','probability');
xlim([0.0 15.0])
ylim([0.0 0.5])
line(p2*[1 1],ylim,'LineWidth', 2, 'Color', 'r')
legend('L75O100','','L100O100','','location','northeast')
legend boxoff
dim = [0.26 0.18 0.3 0.3];
str = {'(c)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');


hold off

print -depsc2 Fig6.eps
 close


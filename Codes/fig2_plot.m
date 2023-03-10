clear;


f1 = load('fig2.mat');

 w1 = f1.midw1;
 w_land = f1.midw_land;
 w_ocean = f1.midw_ocean;

lat = f1.lat;
lon = f1.lon;


%%
[lonn,latn]=meshgrid(lon,lat);
load coastlines

AxisFontsize=12;
TextFontsize=10;
ArrowWidth=10;
FigNum=1;

 levels  = -10.0:2.0:10.0;
 levels1 = -2.0:0.5:2.0;
 levels2 = -2.0:0.5:2.0;

 h=figure;
 s1 = subplot(2,2,1);

 ax1 = worldmap('world');
 setm(ax1,'parallellabel','off','meridianlabel','off')
 setm(ax1,'MLabelParallel',-90)
 setm(ax1,'MLabelLocation',90)
 setm(ax1,'FontName','Times','Fontsize',9)

 latbox =[5,5:-1:-5,-5:1:5];
 lonebox = [-160,-80*ones(1,11),-160*ones(1,11)];
 lonwbox=[80,160*ones(1,11),80*ones(1,11)];
  [xe,ye]=mfwdtran(latbox,lonebox);
  [xw,yw]=mfwdtran(latbox,lonwbox);

 % set the figure size and position
%set(gcf,'PaperPosition',[0 0 6 6]);
% set some properties
set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on','fontweight','bold');
% set the position of the axes in the figure
set(gca,'Position',[0.0 0.5 0.45 0.45])

 contourfm(latn,lonn,(w1)','LevelList',levels,'LineStyle','None');

 c1=jet(200);
 %c1=flipud(c1);
  for ii=81:120
      c1(ii,:)=[1 1 1];
  end
 colormap(c1(1:200,:));

  cb1 = contourcbar('peer',ax1);
  caxis([-10.0 10.0])
cb1.XLabel.String = strcat(" *10^{-2} Pa/s");

pos1 = get(cb1,'Position');
cb1.Label.Position = [pos1(1)/2 pos1(2)+11.4]; % to change its position
cb1.Label.Rotation = 0; % to rotate the text

dim = [0.0 0.6 0.3 0.3];
str = {'(a)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');
hold on

line(xe,ye,'color','k','LineWidth',1.4)
line(xw,yw,'color','k','LineWidth',1.4)
geoshow(coastlat, coastlon, 'Color', 'black', 'LineWidth', 1.0)
tightmap


 s2 = subplot(2,2,2);
  latlim = [-25 25];
  lonlim = [-180 180];

ax2 = worldmap('world');
 setm(ax2,'parallellabel','off','meridianlabel','off')
 setm(ax2,'MLabelParallel',-90)
 setm(ax2,'MLabelLocation',90)
 setm(ax2,'FontName','Times','Fontsize',9)

  latbox =[5,5:-1:-5,-5:1:5];
 lonebox = [-160,-80*ones(1,11),-160*ones(1,11)];
 lonwbox=[80,160*ones(1,11),80*ones(1,11)];

   [xe,ye]=mfwdtran(latbox,lonebox);
  [xw,yw]=mfwdtran(latbox,lonwbox);

 % set the figure size and position
%set(gcf,'PaperPosition',[0 0 6 6]);
% set some properties
set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on','fontweight','bold');
% set the position of the axes in the figure
set(gca,'Position',[0.5 0.5 0.45 0.45])

 contourfm(latn,lonn,(w_land)','LevelList',levels1,'LineStyle','None');

 c2=jet(200);
 %c2=flipud(c2);
  for ii=81:120
      c2(ii,:)=[1 1 1];
  end
 colormap(c2(1:200,:));

  cb2 = contourcbar('peer',ax2);
  caxis([-2.0 2.0])
cb2.XLabel.String = strcat("*10^{-2} Pa/s");

pos2 = get(cb2,'Position');
cb2.Label.Position = [pos2(1)/2+1.8 pos2(2)+2.3]; % to change its position
cb2.Label.Rotation = 0; % to rotate the text

dim = [0.5 0.6 0.3 0.3];
str = {'(b)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');
hold on

line(xe,ye,'color','k','LineWidth',1.4)
line(xw,yw,'color','k','LineWidth',1.4)
geoshow(coastlat, coastlon, 'Color', 'black', 'LineWidth', 1.0)
tightmap

s3 = subplot(2,2,3);
  latlim = [-25 25];
  lonlim = [-180 180];

ax3 = worldmap('world');
 setm(ax3,'parallellabel','off','meridianlabel','off')
 setm(ax3,'MLabelParallel',-90)
 setm(ax3,'MLabelLocation',90)
 setm(ax3,'FontName','Times','Fontsize',9)

  latbox =[5,5:-1:-5,-5:1:5];
 lonebox = [-160,-80*ones(1,11),-160*ones(1,11)];
 lonwbox=[80,160*ones(1,11),80*ones(1,11)];

   [xe,ye]=mfwdtran(latbox,lonebox);
  [xw,yw]=mfwdtran(latbox,lonwbox);

 % set the figure size and position
%set(gcf,'PaperPosition',[0 0 6 6]);
% set some properties
set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on','fontweight','bold');
% set the position of the axes in the figure
set(gca,'Position',[0.25 0.2 0.45 0.45])%[0.1 0.1 0.8 0.3])

 contourfm(latn,lonn,(w_ocean)','LevelList',levels2,'LineStyle','None');

 c3=jet(200);
 %c2=flipud(c2);
  for ii=81:120
      c3(ii,:)=[1 1 1];
  end
 colormap(c3(1:200,:));

  cb3 = contourcbar('peer',ax3);
  caxis([-2.0 2.0])
cb3.XLabel.String = strcat("*10^{-2} Pa/s");

pos3 = get(cb3,'Position');
cb3.Label.Position = [pos3(1)/2 pos3(2)+2.4]; % to change its position
cb3.Label.Rotation = 0; % to rotate the text
dim1 = [0.2 0.28 0.3 0.3];%[0.05 0.09 0.3 0.3];
str1 = {'(c)'};
annotation('textbox',dim1,'String',str1,'EdgeColor','none');

hold on
line(xe,ye,'color','k','LineWidth',1.4)
line(xw,yw,'color','k','LineWidth',1.4)
geoshow(coastlat, coastlon, 'Color', 'black', 'LineWidth', 1.0)
tightmap

hold off

print -depsc2 Fig2.eps
close

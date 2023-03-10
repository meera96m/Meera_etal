clear;

fl1 = load('fig4.mat');

 wv = fl1.wv_struct;
 dyn_ch = wv{1};
 therm_ch = wv{2};
 qdiff = wv{3};

 lat = fl1.lat;
 lon = fl1.lon;


[lonn,latn]=meshgrid(lon,lat);
load coastlines

AxisFontsize=12;
TextFontsize=10;
ArrowWidth=10;
FigNum=1;


 levels2 = -6.0:1.0:6.0;
 levels = -2.0:0.5:2.0;


 h=figure;
 s1 =subplot(2,2,1);
 pd = "plot1"
 axd = worldmap('world');
 setm(axd,'parallellabel','off','meridianlabel','off')
 setm(axd,'MLabelParallel',-90)
 setm(axd,'MLabelLocation',90)
 setm(axd,'FontName','Times','Fontsize',9)

% set some properties
set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on','fontweight','bold');
% set the position of the axes in the figure
set(gca,'Position',[0.0 0.5 0.45 0.45])

 contourfm(latn,lonn,(dyn_ch)','LevelList',levels2,'LineStyle','None');

 cd=jet(200);
 cd=flipud(cd);
  for ii=77:124
      cd(ii,:)=[1 1 1];
  end
 colormap(s1,cd(1:200,:));

  cbd = contourcbar('peer',axd);
  caxis([-6.0 6.0])
cbd.XLabel.String = strcat("*10^{-1}  mm/day");

posd = get(cbd,'Position');
cbd.Label.Position = [posd(1)/2 posd(2)+7.5]; % to change its position
cbd.Label.Rotation = 0; % to rotate the text

dim = [0.0 0.6 0.3 0.3];
str = {'(a)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');
hold on
geoshow(coastlat, coastlon, 'Color', 'black', 'LineWidth', 1.0)
tightmap

 s2 =subplot(2,2,2);
 p2 = "plot2"
 ax2 = worldmap('world');
 setm(ax2,'parallellabel','off','meridianlabel','off')
 setm(ax2,'MLabelParallel',-90)
 setm(ax2,'MLabelLocation',90)
 setm(ax2,'FontName','Times','Fontsize',9)

% set some properties
set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on','fontweight','bold');
% set the position of the axes in the figure
set(gca,'Position',[0.5 0.5 0.45 0.45])

 contourfm(latn,lonn,(therm_ch)','LevelList',levels2,'LineStyle','None');

 c2=jet(200);
 c2=flipud(c2);
  for ii=77:124
      c2(ii,:)=[1 1 1];
  end
 colormap(s2,c2(1:200,:));

  cb2 = contourcbar('peer',ax2);
  caxis([-6.0 6.0])
cb2.XLabel.String = strcat("*10^{-1} mm/day");
pos2 = get(cb2,'Position');
cb2.Label.Position = [pos2(1)/2+1.8 pos2(2)+7]; % to change its position
cb2.Label.Rotation = 0; % to rotate the text

dim = [0.5 0.6 0.3 0.3];
str = {'(b)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');
hold on
geoshow(coastlat, coastlon, 'Color', 'black', 'LineWidth', 1.0)
tightmap

 s3 =subplot(2,2,3);
 p3 = "plot3"
 ax3 = worldmap('world');
 setm(ax3,'parallellabel','off','meridianlabel','off')
 setm(ax3,'MLabelParallel',-90)
 setm(ax3,'MLabelLocation',90)
 setm(ax3,'FontName','Times','Fontsize',9)

% set some properties
set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on','fontweight','bold');
% set the position of the axes in the figure
set(gca,'Position',[0.25 0.2 0.45 0.45])

 contourfm(latn,lonn,(qdiff)','LevelList',levels,'LineStyle','None');

 c3=jet(200);
 c3=flipud(c3);
  for ii=81:120
      c3(ii,:)=[1 1 1];
  end
 colormap(s3,c3(1:200,:));
   cb3 = contourcbar('peer',ax3);
  caxis([-2.0 2.0])
cb3.XLabel.String = strcat("g/kg");

pos3 = get(cb3,'Position');
cb3.Label.Position = [pos3(1)/2 pos3(2)+2.4]; % to change its position
cb3.Label.Rotation = 0; % to rotate the text

dim = [0.2 0.28 0.3 0.3];
str = {'(c)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');
hold on
geoshow(coastlat, coastlon, 'Color', 'black', 'LineWidth', 1.0)
tightmap

hold off

print -depsc2 Fig4.eps
close

clear;

fl1 = load('fig3.mat')

wv = fl1.wv_struct;

dyn_ch = wv{1};
therm_ch = wv{2};
tot_ch = wv{3};
tot_conv = wv{4};
pe1 = wv{5};
pediff = wv{6};
 
lon = fl1.lon;
lat = fl1.lat;

   
%%
[lonn,latn]=meshgrid(lon,lat);
load coastlines

AxisFontsize=12;
TextFontsize=10;
ArrowWidth=10;
FigNum=1;

 
 levels1 = -6.0:1.0:6.0;
 levels2 = -2.0:0.25:2.0;
 levels3 = -2.0:0.25:2.0;
 levels4 = -2.0:0.25:2.0;


 h=figure;
 s1 =subplot(3,2,1);
 axd = worldmap('world');
 setm(axd,'parallellabel','off','meridianlabel','off')
 setm(axd,'MLabelParallel',-90)
 setm(axd,'MLabelLocation',90)
 setm(axd,'FontName','Times','Fontsize',9)

% set some properties
set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on');%,'fontweight','bold');
% set the position of the axes in the figure
set(gca,'Position',[0.05 0.7 0.33 0.33])

 contourfm(latn,lonn,(tot_conv)','LevelList',levels1,'LineStyle','None');

 cd=jet(200);
 cd=flipud(cd);
  for ii=77:124
      cd(ii,:)=[1 1 1];
  end
 colormap(s1,cd(1:200,:));

  cbd = contourcbar('peer',axd);
  caxis([-6.0 6.0])
cbd.XLabel.String = strcat("mm/day");

posd = get(cbd,'Position');
cbd.Label.Position = [posd(1)/2 posd(2)+7.5]; % to change its position
cbd.Label.Rotation = 0; % to rotate the text

dim = [0.0 0.71 0.3 0.3];
str = {'(a)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');
hold on
geoshow(coastlat, coastlon, 'Color', 'black', 'LineWidth', 1.0)
tightmap

 
 s2 =subplot(3,2,2);
 pl = "plot2"
 ax1 = worldmap('world');
 setm(ax1,'parallellabel','off','meridianlabel','off')
 setm(ax1,'MLabelParallel',-90)
 setm(ax1,'MLabelLocation',90)
 setm(ax1,'FontName','Times','Fontsize',9)
 
% set some properties
set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on');%,'fontweight','bold');
% set the position of the axes in the figure
set(gca,'Position',[0.4 0.7 0.33 0.33])

 contourfm(latn,lonn,(pe1)','LevelList',levels1,'LineStyle','None');

 c1=jet(200);
 c1=flipud(c1);
  for ii=81:120
      c1(ii,:)=[1 1 1];
  end
 colormap(s2,c1(1:200,:));

  cb1 = contourcbar('peer',ax1);
  caxis([-6.0 6.0])
cb1.XLabel.String = strcat("mm/day");

pos1 = get(cb1,'Position');
cb1.Label.Position = [pos1(1)/2 pos1(2)+7.2]; % to change its position
cb1.Label.Rotation = 0; % to rotate the text

dim = [0.38 0.71 0.3 0.3];
str = {'(b)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');
hold on
geoshow(coastlat, coastlon, 'Color', 'black', 'LineWidth', 1.0)
tightmap

s3 = subplot(3,2,3);
pl = "plot3"
ax2 = worldmap('world');
 setm(ax2,'parallellabel','off','meridianlabel','off')
 setm(ax2,'MLabelParallel',-90)
 setm(ax2,'MLabelLocation',90)
 setm(ax2,'FontName','Times','Fontsize',9)

% set some properties
set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on');%,'fontweight','bold');
% set the position of the axes in the figure
set(gca,'Position',[0.05 0.44 0.33 0.33])

 contourfm(latn,lonn,(tot_ch)','LevelList',levels2,'LineStyle','None');

 c2=jet(200);
 c2=flipud(c2);
  for ii=81:120
      c2(ii,:)=[1 1 1];
  end
 colormap(s3,c2(1:200,:));

  cb2 = contourcbar('peer',ax2);
  caxis([-2.0 2.0])
cb2.XLabel.String = strcat("mm/day");

pos2 = get(cb2,'Position');
cb2.Label.Position = [pos2(1)/2 pos2(2)+2.8]; % to change its position
cb2.Label.Rotation = 0; % to rotate the text
dim = [0.0 0.45 0.3 0.3];
str = {'(c)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');
hold on
geoshow(coastlat, coastlon, 'Color', 'black', 'LineWidth', 1.0)
tightmap

s4 = subplot(3,2,4);
pl = "plot4"
ax3 = worldmap('world');
 setm(ax3,'parallellabel','off','meridianlabel','off')
 setm(ax3,'MLabelParallel',-90)
 setm(ax3,'MLabelLocation',90)
 setm(ax3,'FontName','Times','Fontsize',9)

% set some properties
set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on');%,'fontweight','bold');
% set the position of the axes in the figure
set(gca,'Position',[0.4 0.44 0.33 0.33])

 contourfm(latn,lonn,(pediff)','LevelList',levels3,'LineStyle','None');

 c3=jet(200);
 c3=flipud(c3);
  for ii=81:120
      c3(ii,:)=[1 1 1];
  end
 colormap(s4,c3(1:200,:));

  cb3 = contourcbar('peer',ax3);
  caxis([-2.0 2.0])
cb3.XLabel.String = strcat("mm/day");
pos3 = get(cb3,'Position');
cb3.Label.Position = [pos3(1)/2 pos3(2)+2.5]; % to change its position
cb3.Label.Rotation = 0; % to rotate the text
dim = [0.38 0.45 0.3 0.3];
str = {'(d)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');
hold on
geoshow(coastlat, coastlon, 'Color', 'black', 'LineWidth', 1.0)
tightmap


s5 = subplot(3,2,5);
pl = "plot5"
ax4 = worldmap('world');
 setm(ax4,'parallellabel','off','meridianlabel','off')
 setm(ax4,'MLabelParallel',-90)
 setm(ax4,'MLabelLocation',90)
 setm(ax4,'FontName','Times','Fontsize',9)

% set some properties
set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on');%,'fontweight','bold');
% set the position of the axes in the figure
set(gca,'Position',[0.05 0.19 0.33 0.33])

 contourfm(latn,lonn,(dyn_ch)','LevelList',levels4,'LineStyle','None');

 c4=jet(200);
 c4=flipud(c4);
  for ii=81:120
      c4(ii,:)=[1 1 1];
  end
 colormap(s5,c4(1:200,:));

  cb4 = contourcbar('peer',ax4);
  caxis([-2.0 2.0])
cb4.XLabel.String = strcat("mm/day");
pos4 = get(cb4,'Position');
cb4.Label.Position = [pos4(1)/2 pos4(2)+2.8]; % to change its position
cb4.Label.Rotation = 0; % to rotate the text
dim = [0.0 0.2 0.3 0.3];
str = {'(e)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');
hold on
geoshow(coastlat, coastlon, 'Color', 'black', 'LineWidth', 1.0)
tightmap

s6 = subplot(3,2,6);
pl = "plot6"
ax5 = worldmap('world');
 setm(ax5,'parallellabel','off','meridianlabel','off')
 setm(ax5,'MLabelParallel',-90)
 setm(ax5,'MLabelLocation',90)
 setm(ax5,'FontName','Times','Fontsize',9)

% set some properties
set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on');%,'fontweight','bold');
% set the position of the axes in the figure
set(gca,'Position',[0.4 0.19 0.33 0.33])

 contourfm(latn,lonn,(therm_ch)','LevelList',levels4,'LineStyle','None');

 c5=jet(200);
 c5=flipud(c5);
  for ii=81:120
      c5(ii,:)=[1 1 1];
  end
 colormap(s6,c5(1:200,:));

  cb5 = contourcbar('peer',ax4);
  caxis([-2.0 2.0])
cb5.XLabel.String = strcat("mm/day");
pos5 = get(cb5,'Position');
cb5.Label.Position = [pos5(1)/2 pos5(2)+2.8]; % to change its position
cb5.Label.Rotation = 0; % to rotate the text
dim = [0.38 0.2 0.3 0.3];
str = {'(f)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');
hold on
geoshow(coastlat, coastlon, 'Color', 'black', 'LineWidth', 1.0)
tightmap

hold off

print -depsc2 Fig3.eps
close

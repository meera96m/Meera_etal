clear;

fl1 = load('fig10.mat');

lat = fl1.lat;
lon = fl1.lon;

wth1 = fl1.wth1;
wthdiff = fl1.wthdiff;

qtot1 = fl1.diabatic1;
qtotdiff = fl1.diabaticdiff;


[latn,lonn]=meshgrid(lat,lon);

load coastlines

AxisFontsize=12;
TextFontsize=10;
ArrowWidth=10;
FigNum=1;

 
 levels1 = -2.0:0.5:2.0;
 levels2 = -2.0:0.5:2.0;
 levels3 = -1.0:0.25:1.0;
 levels4 = -1.0:0.25:1.0;


 hf=figure;

 s1 = subplot(4,1,1);
  latlim = [-25 25];
  lonlim = [-180 180];

axd = worldmap(latlim,lonlim);
 
 setm(axd,'parallellabel','off','meridianlabel','off')
 setm(axd,'MLabelParallel',-90)
 setm(axd,'MLabelLocation',90)
 setm(axd,'FontName','Times','Fontsize',9)

  %daspect([1 0.55 1])
% set some properties
set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on','fontweight','bold');
% set the position of the axes in the figure
 %set(gca,'Position',[0.01 0.8 0.2 0.2])

 contourfm(latn,lonn,(wth1),'LevelList',levels1,'LineStyle','None');

 cd=jet(200);%jet
 %cd=flipud(cd);
  for ii=81:120
      cd(ii,:)=[1 1 1];
  end
 colormap(s1,cd(1:200,:));
  cbd = contourcbar('peer',axd);
  caxis([-2.0 2.0])
cbd.XLabel.String = strcat("*10^{-1} kgm^{-2}s^{-1}K");

posd = get(cbd,'Position');
cbd.Label.Position = [posd(1)/2 posd(2)/2+2.7];% to change its position
cbd.Label.Rotation = 0; % to rotate the text

dim = [0.05 0.62 0.3 0.3];
str = {'(a)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');
hold on
geoshow(coastlat, coastlon, 'Color', 'black', 'LineWidth', 1.0)
tightmap

 s2 =subplot(4,1,2);
 ax1 = worldmap(latlim,lonlim);

 setm(ax1,'parallellabel','off','meridianlabel','off')
 setm(ax1,'MLabelParallel',-90)
 setm(ax1,'MLabelLocation',90)
 setm(ax1,'FontName','Times','Fontsize',9)
 
 %daspect([1 0.55 1])
% set some properties
set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on','fontweight','bold');
% set the position of the axes in the figure
%set(gca,'Position',[0.01 0.6 0.2 0.2])

 contourfm(latn,lonn,(qtot1),'LevelList',levels1,'LineStyle','None');

 c1=jet(200);
 %c1=flipud(c1);
  for ii=81:120
      c1(ii,:)=[1 1 1];
  end
 colormap(s2,c1(1:200,:));

  cb1 = contourcbar('peer',ax1);
  caxis([-2.0 2.0])
cb1.XLabel.String = strcat("*10^{-1} kgm^{-2}s^{-1}K");

pos1 = get(cb1,'Position');
cb1.Label.Position = [pos1(1)/2 pos1(2)+2.6]; % to change its position
cb1.Label.Rotation = 0; % to rotate the text

dim = [0.05 0.42 0.3 0.3];
str = {'(b)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');
hold on
geoshow(coastlat, coastlon, 'Color', 'black', 'LineWidth', 1.0)
tightmap

s3 = subplot(4,1,3);
ax2 = worldmap(latlim,lonlim);

 setm(ax2,'parallellabel','off','meridianlabel','off')
 setm(ax2,'MLabelParallel',-90)
 setm(ax2,'MLabelLocation',90)
 setm(ax2,'FontName','Times','Fontsize',9)

 %daspect([1 0.55 1])
% set some properties
set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on','fontweight','bold');
% set the position of the axes in the figure
%set(gca,'Position',[0.01 0.4 0.2 0.2])

 contourfm(latn,lonn,(wthdiff),'LevelList',levels3,'LineStyle','None');

 c2=jet(200);
 %c2=flipud(c2);
  for ii=81:120
      c2(ii,:)=[1 1 1];
  end
 colormap(s3,c2(1:200,:));

  cb2 = contourcbar('peer',ax2);
  caxis([-1.0 1.0])
%cb2.XLabel.String = strcat("*10^{-1} kgm^{-2}s^{-1}K");

%pos2 = get(cb2,'Position');
%cb2.Label.Position = [pos2(1)/2 pos2(2)+2.8]; % to change its position
%cb2.Label.Rotation = 0; % to rotate the text
dim = [0.05 0.23 0.3 0.3];
str = {'(c)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');
hold on
geoshow(coastlat, coastlon, 'Color', 'black', 'LineWidth', 1.0)
tightmap

s4 = subplot(4,1,4);
ax3 = worldmap(latlim,lonlim);

 setm(ax3,'parallellabel','off','meridianlabel','off')
 setm(ax3,'MLabelParallel',-90)
 setm(ax3,'MLabelLocation',90)
 setm(ax3,'FontName','Times','Fontsize',9)

 % daspect([1 0.55 1])
% set some properties
set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on','fontweight','bold');
% set the position of the axes in the figure
%set(gca,'Position',[0.01 0.2 0.2 0.2])

 contourfm(latn,lonn,(qtotdiff),'LevelList',levels3,'LineStyle','None');

 c3=jet(200);
 %c3=flipud(c3);
  for ii=81:120
      c3(ii,:)=[1 1 1];
  end
 colormap(s4,c3(1:200,:));

  cb3 = contourcbar('peer',ax3);
  caxis([-1.0 1.0])
%cb3.XLabel.String = strcat("*10^{-1} kgm^{-2}s^{-1}K");
%pos3 = get(cb3,'Position');
%cb3.Label.Position = [pos3(1)/2 pos3(2)+3.1]; % to change its position
%cb3.Label.Rotation = 0; % to rotate the text
dim = [0.05 0.05 0.3 0.3];
str = {'(d)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');
hold on
geoshow(coastlat, coastlon, 'Color', 'black', 'LineWidth', 1.0)
tightmap

hold off

print -depsc2 Fig10.eps
close

clear;

 f1 = load('fig5.mat');

lat = f1.lat;
lon = f1.lon;

sh_land = f1.shdiff;
lh_land = f1.lhdiff;

%%
[lonn,latn]=meshgrid(lon,lat);
load coastlines

AxisFontsize=12;
TextFontsize=10;
ArrowWidth=10;
FigNum=1;

 
 levels1 = -20.0:2.5:20.0;
 levels2 = -20.0:2.5:20.0;



 h=figure;

 p1 = "plot1"
 s1 = subplot(2,1,1);
  axd = worldmap('world');
 setm(axd,'parallellabel','off','meridianlabel','off')
 setm(axd,'MLabelParallel',-90)
 setm(axd,'MLabelLocation',90)
 setm(axd,'FontName','Times','Fontsize',9)

% set some properties
set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on','fontweight','bold');
% set the position of the axes in the figure
set(gca,'Position',[0.01 0.5 0.45 0.45])

 contourfm(latn,lonn,(sh_land)','LevelList',levels1,'LineStyle','None');

 cd=jet(200);%jet
% cd=flipud(cd);
  for ii=81:120
      cd(ii,:)=[1 1 1];
  end
 colormap(s1,cd(1:200,:));
  cbd = contourcbar('peer',axd);
  caxis([-20.0 20.0])
%cbd.XLabel.String = strcat("W/m^2");

%posd = get(cbd,'Position');
%cbd.Label.Position = [0.38 0.2]; % to change its position
%cbd.Label.Rotation = 0; % to rotate the text

dim = [0.0 0.6 0.3 0.3];
str = {'(a)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');
hold on
geoshow(coastlat, coastlon, 'Color', 'black', 'LineWidth', 1.0)
tightmap

 s2 =subplot(2,1,2);
 ax1 = worldmap('world');
 setm(ax1,'parallellabel','off','meridianlabel','off')
 setm(ax1,'MLabelParallel',-90)
 setm(ax1,'MLabelLocation',90)
 setm(ax1,'FontName','Times','Fontsize',9)
 
% set some properties
set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on','fontweight','bold');
% set the position of the axes in the figure
set(gca,'Position',[0.5 0.5 0.45 0.45])

 contourfm(latn,lonn,(lh_land)','LevelList',levels2,'LineStyle','None');

 c1=jet(200);
 %c1=flipud(c1);
  for ii=81:120
      c1(ii,:)=[1 1 1];
  end
 colormap(s2,c1(1:200,:));

  cb1 = contourcbar('peer',ax1);
  caxis([-20.0 20.0])
%cb1.XLabel.String = strcat("W/m^2");

%pos1 = get(cb1,'Position');
%cb1.Label.Position = [0.9 0.2]; % to change its position
%cb1.Label.Rotation = 0; % to rotate the text

dim = [0.5 0.6 0.3 0.3];
str = {'(b)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');
hold on
geoshow(coastlat, coastlon, 'Color', 'black', 'LineWidth', 1.0)
tightmap


hold off

print -depsc2 Fig5.eps
close

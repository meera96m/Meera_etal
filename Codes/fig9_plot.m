clear;


 f1 = load('fig9.mat');
 
lat= f1.lat(130:231);
lon= f1.lon;

rh1 = f1.midrh2(:,130:231);
rhdiff = f1.midrhdiff(:,130:231);


[latn,lonn]=meshgrid(lat,lon);

load coastlines

AxisFontsize=12;
TextFontsize=10;
ArrowWidth=10;
FigNum=1;

 levels1 = 0.0:10.0:80.0;
 levels2 = -10:2.0:10.0;

 hf=figure;

s1 = subplot(2,1,1);
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
set(gca,'Position',[0.01 0.6 0.95 0.45])

 contourfm(latn,lonn,(rh1),'LevelList',levels1,'LineStyle','None');

 cd=jet(200);%jet
 cd=flipud(cd);
%  for ii=81:120
%      cd(ii,:)=[1 1 1];
%  end
 colormap(s1,cd(1:200,:));
  cbd = contourcbar('peer',axd);
 caxis([0.0 80.0])
%cbd.XLabel.String = strcat("%");

%posd = get(cbd,'Position');
%cbd.Label.Position = [posd(1)/2 posd(2)/2+8];% to change its position
%cbd.Label.Rotation = 0; % to rotate the text

dim = [0.0 0.64 0.3 0.3];
str = {'(a)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');
 hold on
geoshow(coastlat, coastlon, 'Color', 'black', 'LineWidth', 1.0)
tightmap

s2 = subplot(2,1,2);
  latlim = [-25 25];
  lonlim = [-180 180];

  ax1 = worldmap(latlim,lonlim);

 setm(ax1,'parallellabel','off','meridianlabel','off')
 setm(ax1,'MLabelParallel',-90)
 setm(ax1,'MLabelLocation',90)
 setm(ax1,'FontName','Times','Fontsize',9)

  %daspect([1 0.55 1])
% set some properties
set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on','fontweight','bold');
% set the position of the axes in the figure
set(gca,'Position',[0.01 0.4 0.95 0.45])

 contourfm(latn,lonn,(rhdiff),'LevelList',levels2,'LineStyle','None');

 c1=jet(200);%jet
 c1=flipud(c1);
  for ii=81:120
      c1(ii,:)=[1 1 1];
  end
 colormap(s2,c1(1:200,:));
  cb1 = contourcbar('peer',ax1);
 caxis([-10.0 10.0])
%cb1.XLabel.String = strcat("%");

%pos1 = get(cb1,'Position');
%cb1.Label.Position = [pos1(1)/2 pos1(2)/2]+5;% to change its position
%cb1.Label.Rotation = 0; % to rotate the text

dim = [0.0 0.42 0.3 0.3];
str = {'(b)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');
 hold on
geoshow(coastlat, coastlon, 'Color', 'black', 'LineWidth', 1.0)
tightmap


hold off

print -depsc2 Fig9.eps
close


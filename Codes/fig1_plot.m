clear;

fl1 = load('fig1.mat')


pr_default = fl1.pr1;
pr_land = fl1.pr_land;
pr_ocean = fl1.pr_ocean;

lat = fl1.lat;
lon = fl1.lon;
%%
[lonn,latn]=meshgrid(lon,lat);
load coastlines

AxisFontsize=12;
TextFontsize=10;
ArrowWidth=10;
FigNum=1;

 
 levels = -2.0:0.25:2.0;
 levelsd = 0.0:1.0:10.0;

 h=figure;
% t = tiledlayout(2,2);

 s1 = subplot(2,2,1);
 %nexttile
  axd = worldmap('world');
 setm(axd,'parallellabel','off','meridianlabel','off')
 setm(axd,'MLabelParallel',-90)
 setm(axd,'MLabelLocation',90)
 setm(axd,'FontName','Times','Fontsize',9)

 % set the figure size and position
%set(gcf,'PaperPosition',[0 0 4 4]);
% set some properties
set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on','fontweight','bold');
% set the position of the axes in the figure
set(gca,'Position',[0.0 0.5 0.45 0.45])

 contourfm(latn,lonn,(pr_default)','LevelList',levelsd,'LineStyle','None');

 cd=jet(200);%jet
 cd=flipud(cd);
 % for ii=1:20
 % cd(ii,:)=[1 1 1];
 % end
 colormap(s1,cd(1:200,:));
  cbd = contourcbar('peer',axd);
  caxis([0.0 10.0])
cbd.XLabel.String = strcat(" mm/day");

posd = get(cbd,'Position');
cbd.Label.Position = [posd(1)/2 posd(2)+11]; % to change its position
cbd.Label.Rotation = 0; % to rotate the text

dim = [0.0 0.6 0.3 0.3];
str = {'(a)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');
hold on
geoshow(coastlat, coastlon, 'Color', 'black', 'LineWidth', 1.0)
tightmap

 %nexttile
 s2 =subplot(2,2,2);
 ax1 = worldmap('world');
 setm(ax1,'parallellabel','off','meridianlabel','off')
 setm(ax1,'MLabelParallel',-90)
 setm(ax1,'MLabelLocation',90)
 setm(ax1,'FontName','Times','Fontsize',9)
 
 % set the figure size and position
%set(gcf,'PaperPosition',[0 0 4 4]);
% set some properties
set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on','fontweight','bold');
% set the position of the axes in the figure
set(gca,'Position',[0.5 0.5 0.45 0.45])

 contourfm(latn,lonn,(pr_land)','LevelList',levels,'LineStyle','None');

 c1=jet(200);
 c1=flipud(c1);
  for ii=81:120
      c1(ii,:)=[1 1 1];
  end
 colormap(s2,c1(1:200,:));

  cb1 = contourcbar('peer',ax1);
  caxis([-2.0 2.0])
cb1.XLabel.String = strcat(" mm/day");

pos1 = get(cb1,'Position');
cb1.Label.Position = [pos1(1)/2+1.8 pos1(2)+2.3]; % to change its position
cb1.Label.Rotation = 0; % to rotate the text

dim = [0.5 0.6 0.3 0.3];
str = {'(b)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');
hold on
geoshow(coastlat, coastlon, 'Color', 'black', 'LineWidth', 1.0)
tightmap

%nexttile
s3 = subplot(2,2,3);
ax2 = worldmap('world');
 setm(ax2,'parallellabel','off','meridianlabel','off')
 setm(ax2,'MLabelParallel',-90)
 setm(ax2,'MLabelLocation',90)
 setm(ax2,'FontName','Times','Fontsize',9)

 % set the figure size and position
%set(gcf,'PaperPosition',[0 0 4 4]);
% set some properties
set(gca,'fontsize',AxisFontsize,'xgrid','on','ygrid','on','fontweight','bold');
% set the position of the axes in the figure
set(gca,'Position',[0.25 0.2 0.45 0.45])

 contourfm(latn,lonn,(pr_ocean)','LevelList',levels,'LineStyle','None');

 c2=jet(200);
 c2=flipud(c2);
  for ii=81:120
      c2(ii,:)=[1 1 1];
  end
 colormap(s3,c2(1:200,:));

  cb2 = contourcbar('peer',ax2);
  caxis([-2.0 2.0])
cb2.XLabel.String = strcat(" mm/day");

pos2 = get(cb2,'Position');
cb2.Label.Position = [pos2(1)/2 pos2(2)+2.4]; % to change its position
cb2.Label.Rotation = 0; % to rotate the text
dim = [0.2 0.28 0.3 0.3];
str = {'(c)'};
annotation('textbox',dim,'String',str,'EdgeColor','none');
hold on
geoshow(coastlat, coastlon, 'Color', 'black', 'LineWidth', 1.0)
tightmap

hold off

%print -depsc2 Fig1.eps
 print -dpdf Fig1.pdf
close

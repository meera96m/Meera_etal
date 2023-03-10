clear;

fl1 = load('fig14.mat')

lev = fl1.pres;
lat = fl1.lat;

psi1 = fl1.psi1;
psi_land = fl1.psi_land;
psi_ocean = fl1.psi_ocean;


[levn, latn] = meshgrid(lev, lat);

 levels = -10.0:2.0:10.0;
AxisFontsize=10;
TextFontsize=8;
 
hf = figure
s1 = subplot(2,2,1);

 
  c=jet(200);
  %c=flipud(c);
 for ii=81:120
 c(ii,:)= [1 1 1]; %white
 end
 colormap(s1,c(1:200,:));
% 
hold on
ax = gca;
ax.YDir = 'reverse';
set(gca,'fontsize',AxisFontsize);
  %title(strcat(vname," : ",lofactor),'fontsize',11)
   ylabel('Pressure in hPa')
   xlabel('Latitude')
     cb = colorbar;
  cb.XLabel.String = "*10^{10} kg/s";
  caxis([-10 10])
  xlim([-40 40])
  ylim([100 1000])
box on  
[C,hContour] = contourf(latn,levn,psi1, 'ShowText','on', 'LevelStep',2); drawnow

s2 = subplot(2,2,2);

 
  c1=jet(200);
  %c=flipud(c);
 for ii=81:120
 c1(ii,:)= [1 1 1]; %white
 end
 colormap(s2,c1(1:200,:));
% 
hold on
ax1 = gca;
ax1.YDir = 'reverse';
set(gca,'fontsize',AxisFontsize);
  
   ylabel('Pressure in hPa')
   xlabel('Latitude')
     cb1 = colorbar;
  cb1.XLabel.String = "*10^{9} kg/s";
  caxis([-10 10])
  xlim([-40 40])
  ylim([100 1000])
box on  
[C1,hContour1] = contourf(latn,levn,psi_land, 'ShowText','on', 'LevelStep',2); drawnow

s3 = subplot(2,2,3.5);

 
  c2=jet(200);
  %c=flipud(c);
 for ii=81:120
 c2(ii,:)= [1 1 1]; %white
 end
 colormap(s3,c2(1:200,:));
% 
hold on
ax2 = gca;
ax2.YDir = 'reverse';
set(gca,'fontsize',AxisFontsize);
  
   ylabel('Pressure in hPa')
   xlabel('Latitude')
     cb2 = colorbar;
  cb2.XLabel.String = "*10^{9} kg/s";
  caxis([-10 10])
  xlim([-40 40])
  ylim([100 1000])
box on  
[C2,hContour2] = contourf(latn,levn,psi_ocean, 'ShowText','on', 'LevelStep',2); drawnow

hold off

print -depsc2 Fig14.eps 
close
 

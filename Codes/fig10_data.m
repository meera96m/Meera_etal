clear;
ent = ["L75O100";"L75O75"];


flname1 = strcat('fig10_',ent(1),'.mat');
flname2 = strcat('fig10_',ent(2),'.mat');

f1 = load(flname1);
f2 = load(flname2);

lat = f1.lat(130:231);
lon = f1.lon;
pres = f1.pres;

tdt_lw1 = f1.tdt_lw;
tdt_sw1 = f1.tdt_sw;
tdt_conv1 = f1.tdt_conv;
tdt_ls1 = f1.tdt_ls;
tdt_bl1 = f1.tdt_bl;
omega1 = f1.omega1;
temp1 = f1.temp1;

tdt_lw2 = f2.tdt_lw;
tdt_sw2 = f2.tdt_sw;
tdt_conv2 = f2.tdt_conv;
tdt_ls2 = f2.tdt_ls;
tdt_bl2 = f2.tdt_bl;
omega2 = f2.omega1;
temp2 = f2.temp1;
%---------------------------------
 tdt_lw1 = tdt_lw1(:,130:231,end:-1:1);
 tdt_lw2 = tdt_lw2(:,130:231,end:-1:1);
 tdt_sw1 = tdt_sw1(:,130:231,end:-1:1);
 tdt_sw2 = tdt_sw2(:,130:231,end:-1:1);
 tdt_conv1 = tdt_conv1(:,130:231,end:-1:1);
 tdt_conv2 = tdt_conv2(:,130:231,end:-1:1);
 tdt_ls1 = tdt_ls1(:,130:231,end:-1:1);
 tdt_ls2 = tdt_ls2(:,130:231,end:-1:1);
 tdt_bl1 = tdt_bl1(:,130:231,end:-1:1);
 tdt_bl2 = tdt_bl2(:,130:231,end:-1:1);

 omega1 = omega1(:,130:231,end:-1:1);
 omega2 = omega2(:,130:231,end:-1:1);
 temp1 = temp1(:,130:231,end:-1:1);
 temp2 = temp2(:,130:231,end:-1:1);

 tdt1 = tdt_lw1+tdt_sw1+tdt_conv1+tdt_ls1+tdt_bl1;
 tdt2 = tdt_lw2+tdt_sw2+tdt_conv2+tdt_ls2+tdt_bl2;

%from 996hPa to 110hPa
 tdt_tot1 = tdt1(:,:,1:23);
 tdt_tot2 = tdt2(:,:,1:23);

 w1 = omega1(:,:,1:23);
 w2 = omega2(:,:,1:23);
 t1 = temp1(:,:,1:23);
 t2 = temp2(:,:,1:23);

 pres = pres(end:-1:1);
 pr = pres(1:23);
%----------------------------------
 rd = 287.0;
 cp = 1004.0;
 k = rd/cp;
 grav = 9.8;

 th1 = t1;
 th2 = t2;

%potential temperature
for ii=1:23
        th1(:,:,ii)=t1(:,:,ii)*((1000/pr(ii))^k);
        th2(:,:,ii)=t2(:,:,ii)*((1000/pr(ii))^k);

end

pr = pr*100;

 radius          = 6.4e6;%PARS('radius_earth');
 deg             = pi/180;

y      = lat*radius*deg;
x = lon*radius*deg;


 lat_3d = repmat(lat,[1 length(lon) length(pr)]);

 thmod = permute(th1,[2,1,3]);
  [~,~,dp_th] = gradient(thmod,x,y,pr);
  dp_th1 = w1.*permute(dp_th,[2,1,3]);

 thmod = permute(th2,[2,1,3]);
  [~,~,dp_th] = gradient(thmod,x,y,pr);
  dp_th2 = w2.*permute(dp_th,[2,1,3]); %omega*dtheta/dp

  %vertical integration
 wth1 = pres_int(dp_th1,pr)./grav;
 wth2 = pres_int(dp_th2,pr)./grav;

%diabatic potential temp tendency
 tdt_tot1 = tdt_tot1.*(th1/t1);
 tdt_tot2 = tdt_tot2.*(th2/t2);

 diabatic1 = pres_int(tdt_tot1,pr)./grav;
 diabatic2 = pres_int(tdt_tot2,pr)./grav;
  
%scaling 
 diabatic1 = -diabatic1*10;
 diabatic2 = -diabatic2*10;

 wth1 = wth1*10;
 wth2 = wth2*10;

 wthdiff = wth2-wth1;
 diabaticdiff = diabatic2-diabatic1;

 units = ["*10^{-1} kgm^{-2}s^{-1}K"];

 fprintf('\n');
 disp('Saving data');
 var_names = ["vertical theta advection L75O100";"vertical theta advection L75O75-L75O100";"diabatic theta tendency L75O100";"diabatic theta tendency L75O75-L75O100"];
 save('fig10.mat','wth1','wthdiff','diabatic1','diabaticdiff','lon','lat','var_names','units')



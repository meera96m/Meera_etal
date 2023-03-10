clear;
ent = ["L75O100"];


flname1 = strcat('fig10_',ent(1),'.mat');

f1 = load(flname1);

lat = f1.lat;
lon = f1.lon;
pres = f1.pres;

tdt_lw1 = f1.tdt_lw;
tdt_sw1 = f1.tdt_sw;
tdt_conv1 = f1.tdt_conv;
tdt_ls1 = f1.tdt_ls;
tdt_bl1 = f1.tdt_bl;
temp1 = f1.temp1;

%---------------------------------
 tdt_lw1 = tdt_lw1(:,130:231,end:-1:1);
 tdt_sw1 = tdt_sw1(:,130:231,end:-1:1);
 tdt_conv1 = tdt_conv1(:,130:231,end:-1:1);
 tdt_ls1 = tdt_ls1(:,130:231,end:-1:1);
 tdt_bl1 = tdt_bl1(:,130:231,end:-1:1);


 temp1 = temp1(:,:,end:-1:1);


%from 996hPa to 110hPa

 t1 = temp1(:,130:231,1:23);
 pres = pres(end:-1:1);
 pr = pres(1:23);
%----------------------------------
 rd = 287.0;
 cp = 1004.0;
 k = rd/cp;
 grav = 9.8;

 th1 = t1;

%potential temperature
for ii=1:23
        th1(:,:,ii)=t1(:,:,ii)*((1000/pr(ii))^k);

end

pr = pr*100;

 radius          = 6.4e6;%PARS('radius_earth');
 deg             = pi/180;

y      = lat*radius*deg;
x = lon*radius*deg;


 lat_3d = repmat(lat,[1 length(lon) length(pr)]);

%diabatic potential temp tendencies
 lw1 = tdt_lw1(:,:,1:23).*(th1./t1);
 sw1 = tdt_sw1(:,:,1:23).*(th1./t1);
 conv1 = tdt_conv1(:,:,1:23).*(th1./t1);
 ls1 = tdt_ls1(:,:,1:23).*(th1./t1);
 bl1 = tdt_bl1(:,:,1:23).*(th1./t1);

%vert integration
 qrad1 = pres_int(lw1+sw1,pr)./grav;
 qconv1 = pres_int(conv1,pr)./grav;
 qls1 = pres_int(ls1,pr)./grav;
 qbl1 = pres_int(bl1,pr)./grav;

 qtot1 = qrad1+qconv1+qls1+qbl1;
 
 %scaling 
 qrad1 = -qrad1*10;
 qconv1 = -qconv1*10;
 qls1 = -qls1*10;
 qbl1 = -qbl1*10;
 qtot1 = -qtot1*10;

 units = ["*10^{-1} kgm^{-2}s^{-1}K"];

 fprintf('\n');
 disp('Saving data');
 var_names = ["diabatic heating L75O100";"radiative cooling L75O100";"convective heating L75O100";"large-scale heating L75O100";"boundary layer heating L75O100"];
 save('fig11.mat','qtot1','qrad1','qconv1','qls1','qbl1','lon','lat','var_names','units')



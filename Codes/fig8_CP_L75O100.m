clear;
%var = lonxlatxprxtime
%ent = ["L75O100";"L100O100";"L75O75"];
ent = ["lof_75";"lof_100";"lof_100mod"];

varname1 ='prec_conv'; %(parameterized)convective precipitation rate
varname2 = 'zsurf';  %surface height
varname3 = 'ps'; %surface pressure
varname4 = 't_surf'; %surface temperature
varname5 = 'q_ref'; %specific humidity at 2m
varname6 = 'temp'; %temperature
varname7 = 'sphum'; %specific humidity

flname1 = strcat('/home/mmohan/projects/ctb-tmerlis/mmohan/Data/test_lofactor/',ent(1),'/1981jan01h00.atmos_month.nc');

lat = ncread(flname1,'grid_yt'); %latitude
lon = ncread(flname1,'grid_xt'); %longitude
pres = ncread(flname1,'pfull'); %pressure

path1 =strcat('/home/mmohan/projects/ctb-tmerlis/mmohan/Data/test_lofactor/',ent(1),'/');

        
 year =string(1981:2000);

 z1 = 0.0; %zs L75O100
 pr1 = 0.0; %ps L75O100
 ts1 = 0.0; %ts L75O100
 qr1 = 0.0; %qref L75O100
 temp1 = 0.0;%temp
 sp1 = 0.0;%sphum

   disp('Reading data');

   for ii=1:length(year)
       flst1=strcat(path1,year(ii));
       flend = 'jan01h00.atmos_month.nc';
       flname1 = strcat(flst1,flend);
        
     z1 = z1 + double(ncread(flname1,varname2));
    pr1 = pr1 + double(ncread(flname1,varname3));
     ts1 = ts1 + double(ncread(flname1,varname4));
     qr1 = qr1 + double(ncread(flname1,varname5));
   temp1 = temp1 + double(ncread(flname1,varname6));
    sp1 = sp1 + double(ncread(flname1,varname7));

 
   end


 cpr1    = zeros(240,3,3);%conv precip L75O100

cc=1;
for jj =1:12
   for ii=1:length(year)
       flst=strcat(path,year(ii));
       flend = 'jan01h00.atmos_month.nc';
        flname = strcat(flst,flend);

     cpr1(cc,:,:) = double(ncread(flname,varname1,[329,165,jj],[3,3,1]));
     cc = cc+1;
   end
 end

 %averaging over years
 z1= z1/length(year);
 spr1= spr1/length(year);
 ts1= ts1/length(year);
qr1= qr1/length(year);
temp1= temp1/length(year);
sp1= sp1/length(year);

%convert from kg/m^2/s to mm/day
 cpr1 = cpr1*86400;
  
%averaging over months
 zs1 = mean(z1,3);
 ps1 = mean(spr1,3);
 tsurf1 = mean(ts1,3);
 qref1 = mean(qr1,3);
 t1 = mean(temp1,4);
 q1 = mean(sp1,4);
%---------------------------------------------
 units = ["mm/day";"m";"Pa";"K";"kg/kg";"kg/kg";"K"];
 fprintf('\n');
 disp('Saving data');
  var_names = ["convective precipitation L75O100";"surface height L75O100";"surface pressure L75O100";"surface temperature L75O100";"reference sphum L75O100";"sphum L75O100";"temperature L75O100"];
save('fig8_CP_L75O100.mat','cpr1','zs1','ps1','tsurf1','qref1','q1','t1','lon','lat','pres','var_names','units')

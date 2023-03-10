clear;
%var = lonxlatxprxtime
%ent = ["L75O100";"L100O100";"L75O75"];
ent = ["lof_75";"lof_100";"lof_100mod"];

%Temperature tendencies
varname1 ='tdt_lw'; %Longwave
varname2 = 'tdt_sw';  %Shortwave
varname3 = 'tdt_conv'; %Convective
varname4 = 'tdt_ls'; %Large-scale (stratiform)
varname5 = 'tdt_vdif'; %Boundary layer vertical diffusion
varname6 = 'omega';%vertical velocity
varname7 = 'temp';%temperature

flname1 = strcat('/home/mmohan/projects/ctb-tmerlis/mmohan/Data/test_lofactor/',ent(1),'/1981jan01h00.atmos_month.nc');

lat = ncread(flname1,'grid_yt'); %latitude
lon = ncread(flname1,'grid_xt'); %longitude
pres = ncread(flname1,'pfull'); %pressure

path1 =strcat('/home/mmohan/projects/ctb-tmerlis/mmohan/Data/test_lofactor/',ent(1),'/');

        
 year =string(1981:2000);
 lw1 = 0.0; 
 sw1 = 0.0; 
 cv1 = 0.0; 
 ls1 = 0.0; 
 bl1 = 0.0; 
 w1  = 0.0;
 t1  = 0.0;

   disp('Reading data');

   for ii=1:length(year)
       flst1=strcat(path1,year(ii));
       flend = 'jan01h00.atmos_month.nc';
       flname1 = strcat(flst1,flend);
     
     lw1 = lw1 + double(ncread(flname1,varname1));
     sw1 = sw1 + double(ncread(flname1,varname2));
     cv1 = cv1 + double(ncread(flname1,varname3));
     ls1 = ls1 + double(ncread(flname1,varname4));
     bl1 = bl1 + double(ncread(flname1,varname5));
     w1 = w1 + double(ncread(flname1,varname6));
     t1 = t1 + double(ncread(flname1,varname7));
   end

 lw1= lw1/length(year); %averaging over years
 sw1= sw1/length(year);
 cv1= cv1/length(year); 
 ls1= ls1/length(year);
 bl1 = bl1/length(year);
 w1= w1/length(year);
 t1 = t1/length(year);
 %averaging over months 
 tdt_lw = mean(lw1,4);
 tdt_sw = mean(sw1,4);
 tdt_conv = mean(cv1,4;
 tdt_ls = mean(ls1,4);
 tdt_bl = mean(bl1,4);

 omega1= mean(w1,4);
 temp1 = mean(t1,4);
%---------------------------------------------
 units = ["K/s";"Pa/s";"K"];
 fprintf('\n');
 disp('Saving data');
  var_names = ["LW Temp tendency L75O100";"SW Temp tendency L75O100";"Conv Temp tendency L75O100";"LS Temp tendency L75O100";"BL Temp tendency L75O100";"omega L75O100";"Temp L75O100"];
save('fig10_L75O100.mat','tdt_lw','tdt_sw','tdt_conv','tdt_ls','tdt_bl','omega1','temp1','lon','lat','pres','var_names','units')

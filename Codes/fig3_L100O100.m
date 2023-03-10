clear;
%var = lonxlatxprxtime
%ent = ["L75O100";"L100O100"];
ent = ["lof_75";"lof_100"];

varname1 ='precip'; %total precipitation rate
varname2 = 'evap';  %evaporation rate
varname3 = 'ucomp'; %zonal wind
varname4 = 'vcomp'; %meridional wind
varname5 = 'sphum'; %specific humidity

flname1 = strcat('/home/mmohan/projects/ctb-tmerlis/mmohan/Data/test_lofactor/',ent(2),'/1981jan01h00.atmos_month.nc');

lat = ncread(flname1,'grid_yt'); %latitude
lon = ncread(flname1,'grid_xt'); %longitude
pres = ncread(flname1,'pfull'); %pressure

path1 =strcat('/home/mmohan/projects/ctb-tmerlis/mmohan/Data/test_lofactor/',ent(2),'/');

        
 year =string(1981:2000);
 p1 = 0.0; %precip L100O100
 e1 = 0.0; %evap L100O100
 q1 = 0.0; %q L100O100
 u1 = 0.0; %u L100O100
 v1 = 0.0; %v L100O100

   disp('Reading data');

   for ii=1:length(year)
       flst1=strcat(path1,year(ii));
       flend = 'jan01h00.atmos_month.nc';
       flname1 = strcat(flst1,flend);
     
     p1 = p1 + double(ncread(flname1,varname1));
     e1 = e1 + double(ncread(flname1,varname2));
    u1 = u1 + double(ncread(flname1,varname3));
     v1 = v1 + double(ncread(flname1,varname4));
     q1 = q1 + double(ncread(flname1,varname5));
   end

 p1= p1/length(year); %averaging over years
 e1= e1/length(year);
 
 pe1 = mean(p1,3) - mean(e1,3); 

%convert from kg/m^2/s to mm/day
 pe1 = pe1*86400;
 q1= q1/length(year); %averaging over years
 
 %averaging over months
 sp1 = mean(q1,4);

 u1= u1/length(year); %averaging over years
 
 %averaging over months
 uwind1 = mean(u1,4);

 v1= v1/length(year); %averaging over years
 
 %averaging over months
 vwind1 = mean(v1,4);
%---------------------------------------------
 units = ["mm/day";"kg/kg";"m/s";"m/s"];
 fprintf('\n');
 disp('Saving data');
  var_names = ["P-E L100O100";"sphum L100O100";"uwind L100O100";"vwind L100O100"];
save('fig3_L100O100.mat','pe1','sp1','uwind1','vwind1','lon','lat','pres','var_names','units')

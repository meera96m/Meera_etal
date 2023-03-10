clear;
%var = lonxlatxprxtime
%ent = ["L75O100";"L100O100"];
ent = ["lof_75";"lof_100"];

varname1 ='shflx'; %sensible heat flux
varname2 = 'evap';  %evaporation rate

flname1 = strcat('/home/mmohan/projects/ctb-tmerlis/mmohan/Data/test_lofactor/',ent(1),'/1981jan01h00.atmos_month.nc');

lat = ncread(flname1,'grid_yt'); %latitude
lon = ncread(flname1,'grid_xt'); %longitude
pres = ncread(flname1,'pfull'); %pressure

path1 =strcat('/home/mmohan/projects/ctb-tmerlis/mmohan/Data/test_lofactor/',ent(1),'/');

        
 year =string(1981:2000);
 s1 = 0.0; %SH L75O100
 e1 = 0.0; %evap L75O100

   disp('Reading data');

   for ii=1:length(year)
       flst1=strcat(path1,year(ii));
       flend = 'jan01h00.atmos_month.nc';
       flname1 = strcat(flst1,flend);
     
     s1 = s1 + double(ncread(flname1,varname1));
     e1 = e1 + double(ncread(flname1,varname2));
   end

 s1= s1/length(year); %averaging over years
 e1= e1/length(year);
 
 sh1 = mean(s1,3);
 ev1 = mean(e1,3);

%---------------------------------------------
 units = ["W/m^2";"kg/m^2/s"];
 fprintf('\n');
 disp('Saving data');
  var_names = ["SH L75O100";"evap L75O100"];
save('fig5_L75O100.mat','sh1','ev1','lon','lat','var_names','units')

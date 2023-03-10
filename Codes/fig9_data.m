clear;
%var = lonxlatxprxtime
%ent = ["L75O75";"L75O100"];
ent = ["lof_100mod";"lof_75"];

varname1 ='rh'; %RH

flname1 = strcat('/home/mmohan/projects/ctb-tmerlis/mmohan/Data/test_lofactor/',ent(1),'/1981jan01h00.atmos_month.nc');
flname2 = strcat('/home/mmohan/projects/ctb-tmerlis/mmohan/Data/test_lofactor/',ent(2),'/1981jan01h00.atmos_month.nc');

lat = ncread(flname1,'grid_yt'); %latitude
lon = ncread(flname1,'grid_xt'); %longitude
pres = ncread(flname1,'pfull'); %pressure

path1 =strcat('/home/mmohan/projects/ctb-tmerlis/mmohan/Data/test_lofactor/',ent(1),'/');
path2 =strcat('/home/mmohan/projects/ctb-tmerlis/mmohan/Data/test_lofactor/',ent(2),'/');
        
 year =string(1981:2000);
 rh1 = 0.0; %RH L75O75
 rh2 = 0.0; %RH L75O100

   disp('Reading data');

   for ii=1:length(year)
       flst1=strcat(path1,year(ii));
       flend = 'jan01h00.atmos_month.nc';
       flname1 = strcat(flst1,flend);
      flst2=strcat(path2,year(ii));
      flname2 = strcat(flst2,flend);     
     rh1 = rh1 + double(ncread(flname1,varname1));
     rh2 = rh2 + double(ncread(flname2,varname1));
   end

 rh1= rh1/length(year); %averaging over years
 rh2= rh2/length(year);
 
 %averaging over months
 relh1 = mean(rh1,4);
 relh2 = mean(rh2,4);

%---------------------------------------------
relh1 = relh1(:,:,end:-1:1);
relh2 = relh2(:,:,end:-1:1);

midrh1 = mean(relh1(:,:,10:15),3);
midrh2 = mean(relh2(:,:,10:15),3);

midrhdiff = midrh1 - midrh2;
%---------------------------------------------
units = ["%"];
 fprintf('\n');
 disp('Saving data');
  var_names = ["Midlevel RH L75O100";"Midlevel RH L75O75-L75O100"];
save('fig9.mat','midrh2','midrhdiff','lon','lat','var_names','units')

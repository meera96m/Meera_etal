clear;
%var = lonxlatxprxtime
%ent = ["L75O100";"L100O100";"L75O75"]
ent = ["lof_75";"lof_100";"lof_100mod"];

varname1 ='precip'; %total precipitation rate

flname1 = strcat('/home/mmohan/projects/ctb-tmerlis/mmohan/Data/test_lofactor/',ent(1),'/1981jan01h00.atmos_month.nc');
flname2 = strcat('/home/mmohan/projects/ctb-tmerlis/mmohan/Data/test_lofactor/',ent(2),'/1981jan01h00.atmos_month.nc');
flname3 = strcat('/home/mmohan/projects/ctb-tmerlis/mmohan/Data/test_lofactor/',ent(3),'/1981jan01h00.atmos_month.nc');

lat = ncread(flname1,'grid_yt'); %latitude
lon = ncread(flname1,'grid_xt'); %longitude
pr = ncread(flname1,'pfull'); %pressure

path1 =strcat('/home/mmohan/projects/ctb-tmerlis/mmohan/Data/test_lofactor/',ent(1),'/');
path2 =strcat('/home/mmohan/projects/ctb-tmerlis/mmohan/Data/test_lofactor/',ent(2),'/');
path3 =strcat('/home/mmohan/projects/ctb-tmerlis/mmohan/Data/test_lofactor/',ent(3),'/');
        
 year =string(1981:2000);
 p1 = 0.0; %precip L75O100
 p2 = 0.0; %precip L100O100
 p3 = 0.0; %precip L75O75

   disp('Reading data');

   for ii=1:length(year)
       flst1=strcat(path1,year(ii));
       flend = 'jan01h00.atmos_month.nc';
       flname1 = strcat(flst1,flend);
	 flst2=strcat(path2,year(ii));
       flname2 = strcat(flst2,flend);
	 flst3=strcat(path3,year(ii));
       flname3 = strcat(flst3,flend);
     
     p1 = p1 + double(ncread(flname1,varname1));
     p2 = p2 + double(ncread(flname2,varname1));
     p3 = p3 + double(ncread(flname3,varname1));
   end

 p1= p1/length(year); %averaging over years
 p2= p2/length(year);
 p3= p3/length(year);
 
 pr1 = mean(p1,3);
 pr2 = mean(p2,3);
 pr3 = mean(p3,3); 

%convert from kg/m^2/s to mm/day
 pr1 = pr1*86400;
 pr2 = pr2*86400;
 pr3 = pr3*86400;

 pr_land = pr1-pr2;
 pr_ocean = pr3-pr1;

 unit = 'mm/day';

 fprintf('\n');
 disp('Saving data');
 save2mat = 'fig1.mat';
 var_names = ["P L75O100";"P L75O100-L100O100";"P L75O75-L75O100"];
 save(save2mat,'pr1','pr_land','pr_ocean','lon','lat','var_names','unit'); 
 disp(save2mat);



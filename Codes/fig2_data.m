clear;
%var = lonxlatxprxtime
%ent = ["L75O100";"L100O100";"L75O75"]
ent = ["lof_75";"lof_100";"lof_100mod"];

varname1 ='omega'; %vertical pressure velocity


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
 w1 = 0.0; %omega L75O100
 w2 = 0.0; %omega L100O100
 w3 = 0.0; %omega L75O75

   disp('Reading data');
   for ii=1:length(year)
       flst1=strcat(path1,year(ii));
       flend = 'jan01h00.atmos_month.nc';
       flname1 = strcat(flst1,flend);
	 flst2=strcat(path2,year(ii));
       flname2 = strcat(flst2,flend);
	 flst3=strcat(path3,year(ii));
       flname3 = strcat(flst3,flend);
     
     w1 = w1 + double(ncread(flname1,varname1));
     w2 = w2 + double(ncread(flname2,varname1));
     w3 = w3 + double(ncread(flname3,varname1));

   end

 w1= w1/length(year); %averaging over years
 w2= w2/length(year);
 w3= w3/length(year);
 
 %averaging over months
 omega1 = mean(w1,4);
 omega2 = mean(w2,4);
 omega3 = mean(w3,4);

%convert from Pa/s to *10^-2 Pa/s

 omega1 = omega1*100;
 omega2 = omega2*100;
 omega3 = omega3*100;

 omega1 = omega1(:,:,end:-1:1);
 omega2 = omega2(:,:,end:-1:1):
 omega3 = omega3(:,:,end:-1:1):

 midw1 = omega1(:,:,15); %omega 500hPa L75O100
 midw2 = omega2(:,:,15); %omega 500hPa L100O100
 midw3 = omega3(:,:,15); %omega 500hPa L75O75

 midw_land = midw1-midw2;
 midw_ocean = midw3-midw1;

 unit = '*10^-2 Pa/s';

 fprintf('\n');
 disp('Saving data');
 save2mat = 'fig2.mat';
 var_names = ["omega_500 L75O100";"omega_500 L75O100-L100O100";"omega_500 L75O75-L75O100"];
 save(save2mat,'midw1','midw_land','midw_ocean','lon','lat','var_names','unit'); 
 disp(save2mat);



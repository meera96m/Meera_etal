clear;
%var = lonxlatxprxtime
%ent = ["L75O100";"L100O100";"L75O75"]
ent = ["lof_75";"lof_100";"lof_100mod"];

varname1 ='vcomp'; %meridional velocity


flname1 = strcat('/home/mmohan/projects/ctb-tmerlis/mmohan/Data/test_lofactor/',ent(1),'/1981jan01h00.atmos_month.nc');
flname2 = strcat('/home/mmohan/projects/ctb-tmerlis/mmohan/Data/test_lofactor/',ent(2),'/1981jan01h00.atmos_month.nc');
flname3 = strcat('/home/mmohan/projects/ctb-tmerlis/mmohan/Data/test_lofactor/',ent(3),'/1981jan01h00.atmos_month.nc');

lat = ncread(flname1,'grid_yt'); %latitude
lon = ncread(flname1,'grid_xt'); %longitude
pres = ncread(flname1,'pfull'); %pressure

path1 =strcat('/home/mmohan/projects/ctb-tmerlis/mmohan/Data/test_lofactor/',ent(1),'/');
path2 =strcat('/home/mmohan/projects/ctb-tmerlis/mmohan/Data/test_lofactor/',ent(2),'/');
path3 =strcat('/home/mmohan/projects/ctb-tmerlis/mmohan/Data/test_lofactor/',ent(3),'/');
        
 year =string(1981:2000);
 v1 = 0.0; %v L75O100
 v2 = 0.0; %v L100O100
 v3 = 0.0; %v L75O75

   disp('Reading data');
   for ii=1:length(year)
       flst1=strcat(path1,year(ii));
       flend = 'jan01h00.atmos_month.nc';
       flname1 = strcat(flst1,flend);
	 flst2=strcat(path2,year(ii));
       flname2 = strcat(flst2,flend);
	 flst3=strcat(path3,year(ii));
       flname3 = strcat(flst3,flend);
     
     v1 = v1 + double(ncread(flname1,varname1));
     v2 = v2 + double(ncread(flname2,varname1));
     v3 = v3 + double(ncread(flname3,varname1));

   end

 v1= v1/length(year); %averaging over years
 v2= v2/length(year);
 v3= v3/length(year);
 
 %averaging over months
 vv1 = mean(v1,4);
 vv2 = mean(v2,4);
 vv3 = mean(v3,4);


 vv1 = vv1(:,:,end:-1:1);
 vv2 = vv2(:,:,end:-1:1):
 vv3 = vv3(:,:,end:-1:1):

 pres = pres(end:-1:1);

 V1(:,:) = mean(vv1,1);
 V2(:,:) = mean(vv2,1);
 V3(:,:) = mean(vv3,1);

%calculating streamfunction
psi1 = TropD_Calculate_StreamFunction(V1,lat,pres); 
psi2 = TropD_Calculate_StreamFunction(V2,lat,pres);
psi3 = TropD_Calculate_StreamFunction(V3,lat,pres);

psi_land = psi1 - psi2;
psi_ocean = psi3 - psi1;

psi1 = psi1*(10^(-10));
psi_land = psi_land*(10^(-9));
psi_ocean = psi_ocean*(10^(-9));

 units = ["*10^-10 kg/s";"*10^-9 kg/s";"*10^-9 kg/s"];

 fprintf('\n');
 disp('Saving data');

 var_names = ["Streamfunction L75O100";"Streamfunction L75O100-L100O100";"Streamfucntion L75O75-L75O100"];
 save('fig14.mat','psi1','psi_land','psi_ocean','lat','pres','var_names','units'); 




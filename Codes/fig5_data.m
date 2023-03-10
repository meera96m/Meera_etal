clear;
ent = ["L75O100";"L100O100"];


flname1 = strcat('fig5_',ent(1),'.mat');
flname2 = strcat('fig5_',ent(2),'.mat');
f1 = load(flname1);
f2 = load(flname2);

lat = f1.lat;
lon = f1.lon;

sh1 = f1.sh1;
ev1 = f1.ev1;

sh2 = f2.sh1;
ev2 = f2.ev1;
%---------------------------------
Lv = 2.5*(10^6);
lh1 = ev1*Lv;%latent heat flux
lh2 = ev2*Lv;

%L75O100 - L100O100 
shdiff = sh1-sh2;
lhdiff = lh1-lh2;


 unit = 'W/m^2';


 fprintf('\n');
 disp('Saving data');
 var_names = ["SH L75O100-L100O100";"LH L75O100-L100O100"];
 save('fig5.mat','shdiff','lhdiff','lon','lat','var_names','unit')



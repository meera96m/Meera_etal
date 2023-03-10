clear;
ent = ["L75O75";"L75O100";"L75O75"];


flname1 = strcat('fig10_',ent(1),'.mat');
flname2 = strcat('fig10_',ent(2),'.mat');
flname3 = strcat('fig10_',ent(3),'.mat');

f1 = load(flname1);
f2 = load(flname2);
f2 = load(flname2);

lat = f1.lat(130:231);
lon = f1.lon;
pres = f1.pres;

temp1 = f1.temp1(:,130:231,end:-1:1);
temp2 = f2.temp1(:,130:231,end:-1:1);
temp3 = f3.temp1(:,130:231,end:-1:1);

t1 = temp1(:,:,1:23);
t2 = temp2(:,:,1:23);
t3 = temp3(:,:,1:23);


 pres = pres(end:-1:1);
 pr = pres(1:23);

 rd = 287.0;
 cp = 1004.0;
 k = rd/cp;
 grav = 9.8;

 th1 = t1;
 th2 = t2;
 th3 = t3;

%potential temperature
for ii=1:23
        th1(:,:,ii)=t1(:,:,ii)*((1000/pr(ii))^k);
        th2(:,:,ii)=t2(:,:,ii)*((1000/pr(ii))^k);
        th3(:,:,ii)=t3(:,:,ii)*((1000/pr(ii))^k);

end

pr = pr*100;

 var = f1.tdt_lw(:,130:231,end:-1:1);
 lw1 = var(:,:,1:23).*(th1./t1);
 var = f2.tdt_lw(:,130:231,end:-1:1);
 lw2 = var(:,:,1:23).*(th2./t2);
 var = f3.tdt_lw(:,130:231,end:-1:1);
 lw3 = var(:,:,1:23).*(th3./t3);

 var = f1.tdt_sw(:,130:231,end:-1:1);
 sw1 = var(:,:,1:23).*(th1./t1);
 var = f2.tdt_sw(:,130:231,end:-1:1);
 sw2 = var(:,:,1:23).*(th2./t2);
 var = f3.tdt_sw(:,130:231,end:-1:1);
 sw3 = var(:,:,1:23).*(th3./t3);

 var = f1.tdt_conv(:,130:231,end:-1:1);
 conv1 = var(:,:,1:23).*(th1./t1);
 var = f2.tdt_conv(:,130:231,end:-1:1);
 conv2 = var(:,:,1:23).*(th2./t2);
 var = f3.tdt_conv(:,130:231,end:-1:1);
 conv3 = var(:,:,1:23).*(th3./t3);

 var = f1.tdt_ls(:,130:231,end:-1:1);
 ls1 = var(:,:,1:23).*(th1./t1);
 var = f2.tdt_ls(:,130:231,end:-1:1);
 ls2 = var(:,:,1:23).*(th2./t2);
 var = f3.tdt_ls(:,130:231,end:-1:1);
 ls3 = var(:,:,1:23).*(th3./t3);

 var = f1.tdt_bl(:,130:231,end:-1:1);
 bl1 = var(:,:,1:23).*(th1./t1);
 var = f2.tdt_bl(:,130:231,end:-1:1);
 bl2 = var(:,:,1:23).*(th2./t2);
 var = f3.tdt_bl(:,130:231,end:-1:1);
 bl3 = var(:,:,1:23).*(th3./t3);


lonw_ind = (129:257); %80 to 160E
lone_ind = 320:448;%160W to 80W
laty_ind = 41:61; %-5 to 5

rad1 = lw1+sw1;
rad2 = lw2+sw2;
rad3 = lw3+sw3;

rad1_e = squeeze(mean(rad1(lone_ind,laty_ind,:),[1,2]))*86400;
rad2_e = squeeze(mean(rad2(lone_ind,laty_ind,:),[1,2]))*86400;
rad3_e = squeeze(mean(rad3(lone_ind,laty_ind,:),[1,2]))*86400;
rad1_w = squeeze(mean(rad1(lonw_ind,laty_ind,:),[1,2]))*86400;
rad2_w = squeeze(mean(rad2(lonw_ind,laty_ind,:),[1,2]))*86400;
rad3_w = squeeze(mean(rad3(lonw_ind,laty_ind,:),[1,2]))*86400;

conv1_e = squeeze(mean(conv1(lone_ind,laty_ind,:),[1,2]))*86400;
conv2_e = squeeze(mean(conv2(lone_ind,laty_ind,:),[1,2]))*86400;
conv3_e = squeeze(mean(conv3(lone_ind,laty_ind,:),[1,2]))*86400;
conv1_w = squeeze(mean(conv1(lonw_ind,laty_ind,:),[1,2]))*86400;
conv2_w = squeeze(mean(conv2(lonw_ind,laty_ind,:),[1,2]))*86400;
conv3_w = squeeze(mean(conv3(lonw_ind,laty_ind,:),[1,2]))*86400;

ls1_e = squeeze(mean(ls1(lone_ind,laty_ind,:),[1,2]))*86400;
ls2_e = squeeze(mean(ls2(lone_ind,laty_ind,:),[1,2]))*86400;
ls3_e = squeeze(mean(ls3(lone_ind,laty_ind,:),[1,2]))*86400;
ls1_w = squeeze(mean(ls1(lonw_ind,laty_ind,:),[1,2]))*86400;
ls2_w = squeeze(mean(ls2(lonw_ind,laty_ind,:),[1,2]))*86400;
ls3_w = squeeze(mean(ls3(lonw_ind,laty_ind,:),[1,2]))*86400;

bl1_e = squeeze(mean(bl1(lone_ind,laty_ind,:),[1,2]))*86400;
bl2_e = squeeze(mean(bl2(lone_ind,laty_ind,:),[1,2]))*86400;
bl3_e = squeeze(mean(bl3(lone_ind,laty_ind,:),[1,2]))*86400;
bl1_w = squeeze(mean(bl1(lonw_ind,laty_ind,:),[1,2]))*86400;
bl2_w = squeeze(mean(bl2(lonw_ind,laty_ind,:),[1,2]))*86400;
bl3_w = squeeze(mean(bl3(lonw_ind,laty_ind,:),[1,2]))*86400;

%-----------------------------------------
 units = ["K/day"];

 fprintf('\n');
 disp('Saving data');
 
  th_struct ={};
  th_struct{1}=rad1_e;
  th_struct{2}=rad2_e;
  th_struct{3}=rad3_e;
  th_struct{4} = rad1_w;
  th_struct{5}= rad2_w;
  th_struct{6} = rad3_w;
  th_struct{7} = conv1_e;
  th_struct{8} = conv2_e;
  th_struct{9} = conv3_e;
  th_struct{10} = conv1_w;
  th_struct{11} = conv2_w;
  th_struct{12} = conv3_w;
  th_struct{13} = ls1_e;
  th_struct{14} = ls2_e;
  th_struct{15} = ls3_e;
  th_struct{16} = ls1_w;
  th_struct{17} = ls2_w;
  th_struct{18} = ls3_w;
  th_struct{19} = bl1_e;
  th_struct{20} = bl2_e;
  th_struct{21} = bl3_e;
  th_struct{22} = bl1_w;
  th_struct{23} = bl2_w;
  th_struct{24} = bl3_w;

 pr = pr/100; %hPa

 var_names = ["Radiative cooling L75O100 EP";"Radiative cooling L100O100 EP";"Radiative cooling L75O75 EP";"Radiative cooling L75O100 WP";"Radiative cooling L100O100 WP";"Radiative cooling L75O75 WP";"Convective heating L75O100 EP";"Convective heating L100O100 EP";"Convective heating L75O75 EP";"Convective heating L75O100 WP";"Convective heating L100O100 WP";"Convective heating L75O75 WP";"LS heating L75O100 EP";"LS heating L100O100 EP";"LS heating L75O75 EP";"LS heating L75O100 WP";"LS heating L100O100 WP";"LS heating L75O75 WP";"BL heating L75O100 EP";"BL heating L100O100 EP";"BL heating L75O75 EP";"BL heating L75O100 WP";"BL heating L100O100 WP";"BL heating L75O75 WP"];
 save('fig13.mat','th_struct','pr','var_names','units')



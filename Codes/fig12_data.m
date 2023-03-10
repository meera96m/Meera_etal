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


 tot1 = lw1+sw1+conv1+ls1+bl1;
 tot2 = lw2+sw2+conv2+ls2+bl2;
 tot3 = lw3+sw3+conv3+ls3+bl3;

lonw_ind = (129:257); %80 to 160E
lone_ind = 320:448;%160W to 80W
laty_ind = 41:61; %-5 to 5


tot1_e = squeeze(mean(tot1(lone_ind,laty_ind,:),[1,2]))*86400;
tot2_e = squeeze(mean(tot2(lone_ind,laty_ind,:),[1,2]))*86400;
tot3_e = squeeze(mean(tot3(lone_ind,laty_ind,:),[1,2]))*86400;
tot1_w = squeeze(mean(tot1(lonw_ind,laty_ind,:),[1,2]))*86400;
tot2_w = squeeze(mean(tot2(lonw_ind,laty_ind,:),[1,2]))*86400;
tot3_w = squeeze(mean(tot3(lonw_ind,laty_ind,:),[1,2]))*86400;


omega1 = f1.omega1(:,130:231,end:-1:1);
w1 = omega1(:,:,1:23);
omega2 = f2.omega1(:,130:231,end:-1:1);
w2 = omega2(:,:,1:23);
omega3 = f3.omega1(:,130:231,end:-1:1);
w3 = omega3(:,:,1:23);


radius          = 6.4e6;%PARS('radius_earth');
 deg             = pi/180;

y      = lat*radius*deg;
x = lon*radius*deg;


lat_3d = repmat(lat,[1 length(lon) length(pr)]);

 thmod = permute(th1,[2,1,3]);
  [~,~,dp_th] = gradient(thmod,x,y,pr);
  dp_th1 = w1.*permute(dp_th,[2,1,3]);

 thmod = permute(th2,[2,1,3]);
  [~,~,dp_th] = gradient(thmod,x,y,pr);
  dp_th2 = w2.*permute(dp_th,[2,1,3]);

  thmod = permute(th3,[2,1,3]);
  [~,~,dp_th] = gradient(thmod,x,y,pr);
  dp_th3 = w3.*permute(dp_th,[2,1,3]);

th1_e = squeeze(mean(dp_th1(lone_ind,laty_ind,:),[1,2]));
th2_e = squeeze(mean(dp_th2(lone_ind,laty_ind,:),[1,2]));
th3_e = squeeze(mean(dp_th3(lone_ind,laty_ind,:),[1,2]));

th1_w = squeeze(mean(dp_th1(lonw_ind,laty_ind,:),[1,2]));
th2_w = squeeze(mean(dp_th2(lonw_ind,laty_ind,:),[1,2]));
th3_w = squeeze(mean(dp_th3(lonw_ind,laty_ind,:),[1,2]));

%vertical theta advection in K/day
th1_e = -th1_e*86400;
th2_e = -th2_e*86400;
th3_e = -th3_e*86400;

th1_w = -th1_w*86400;
th2_w = -th2_w*86400;
th3_w = -th3_w*86400;

%-----------------------------------------
 units = ["K/day"];

 fprintf('\n');
 disp('Saving data');
 
  th_struct ={};
  th_struct{1}=th1_e;
  th_struct{2}=th2_e;
  th_struct{3}=th3_e;
  th_struct{4} = th1_w;
  th_struct{5}= th2_w;
  th_struct{6} = th3_w;
  th_struct{7} = tot1_e;
  th_struct{8} = tot2_e;
  th_struct{9} = tot3_e;
  th_struct{10} = tot1_w;
  th_struct{11} = tot2_w;
  th_struct{12} = tot3_w;

 pr = pr/100; %hPa

 var_names = ["vertical theta advection L75O100 EP";"vertical theta advection L100O100 EP";"vertical theta advection L75O75 EP";"vertical theta advection L75O100 WP";"vertical theta advection L100O100 WP";"vertical theta advection L75O75 WP";"diabatic theta tendency L75O100 EP";"diabatic theta tendency L100O100 EP";"diabatic theta tendency L75O75 EP";"diabatic theta tendency L75O100 WP";"diabatic theta tendency L100O100 WP";"diabatic theta tendency L75O75 WP"];
 save('fig12.mat','th_struct','pr','var_names','units')



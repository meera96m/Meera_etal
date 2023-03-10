clear;
ent = ["L75O100";"L100O100"];


flname1 = strcat('fig3_',ent(1),'.mat');
flname2 = strcat('fig3_',ent(2),'.mat');

f1 = load(flname1)
f2 = load(flname2)

lat = f1.lat;
lon = f1.lon;
pres = f1.pres;

pe1 = f1.pe1;
sp1 = f1.sp1;
uwind1 = f1.uwind1;
vwind1 = f1.vwind1;

pe2 = f2.pe2;
sp2 = f2.sp2;
uwind2 = f2.uwind2;
vwind2 = f2.vwind2;
%---------------------------------
 sp1 = sp1(:,:,end:-1:1);
 sp2 = sp2(:,:,end:-1:1);
 uwind1 = uwind1(:,:,end:-1:1);
 uwind2 = uwind2(:,:,end:-1:1);
 vwind1 = vwind1(:,:,end:-1:1);
 vwind2 = vwind2(:,:,end:-1:1);

%from 996hPa to 110hPa
 qq1 = sp1(:,:,1:23);
 qq2 = sp2(:,:,1:23);
 uu1 = uwind1(:,:,1:23);
 uu2 = uwind2(:,:,1:23);
 vv1 = vwind1(:,:,1:23);
 vv2 = vwind2(:,:,1:23);

 pres = pres(end:-1:1);
 pr = pres(1:23)*100; %convert to Pa

%L75O100 - L100O100 
udiff = uu1-uu2;
vdiff = vv1-vv2;
qdiff = qq1-qq2;
pediff = pe1-pe2;

 radius          = 6.4e6; %radius of earth'
 grav            = 9.8; %gravity
 deg             = pi/180;
  
y      = lat * radius * deg;
x = lon*radius*deg;

 lat_3d = repmat(lat,[1 length(lon) length(pr)]);

 rescaling = 86400;
 
  qmod=permute(qq1,[2,1,3]);
   [~,dy_q,~] = gradient(qmod.*cos(lat_3d*deg),x,y,pr);
  dy_q = (dy_q)./cos(lat_3d*deg)*rescaling;

  vdiffmod = permute(vdiff,[2,1,3]);
 [~,dy_v,~] = gradient(vdiffmod.*cos(lat_3d*deg),x,y,pr);
  dy_v = (dy_v)./cos(lat_3d*deg)*rescaling;
 
  [dx_q,~,~] = gradient(qmod,x,y,pr);
  dx_q = (dx_q)./cos(lat_3d*deg)*rescaling;
  
  udiffmod = permute(udiff,[2,1,3]);
  [dx_u,~,~] = gradient(udiffmod,x,y,pr);
  dx_u = (dx_u)./cos(lat_3d*deg)*rescaling;

  %dynamic change
  qdelu = qmod.*udiffmod;
  qdelv = qmod.*vdiffmod;

  [dx_qdu,~,~] = gradient(qdelu,x,y,pr);
  dx_qdu = (dx_qdu)./cos(lat_3d*deg)*rescaling;
  
  [~,dy_qdv,~] = gradient(qdelv.*cos(lat_3d*deg),x,y,pr);
  dy_qdv = (dy_qdv)./cos(lat_3d*deg)*rescaling;

 %thermodynamic change
  
  qdiffmod = permute(qdiff,[2,1,3]);
  umod = permute(uu1,[2,1,3]);
  vmod = permute(vv1,[2,1,3]);
  delqu = qdiffmod.*umod;
  delqv = qdiffmod.*vmod;
  
  [dx_dqu,~,~] = gradient(delqu,x,y,pr);
  dx_dqu = (dx_dqu)./cos(lat_3d*deg)*rescaling;
  
  [~,dy_dqv,~] = gradient(delqv.*cos(lat_3d*deg),x,y,pr);
  dy_dqv = (dy_dqv)./cos(lat_3d*deg)*rescaling;

  %total change
  qmod2 = permute(qq2,[2,1,3]);
  umod2 = permute(uu2,[2,1,3]);
  vmod2 = permute(vv2,[2,1,3]);

  q1u1 = qmod.*umod;
  q1v1 = qmod.*vmod;

  [dx_qu,~,~] = gradient(q1u1,x,y,pr);
  dx_qu = (dx_qu)./cos(lat_3d*deg)*rescaling;

  [~,dy_qv,~] = gradient(q1v1.*cos(lat_3d*deg),x,y,pr);
  dy_qv = (dy_qv)./cos(lat_3d*deg)*rescaling;

  q2u2 = qmod2.*umod2;
  q2v2 = qmod2.*vmod2;

  [dx_q2u2,~,~] = gradient(q2u2,x,y,pr);
  dx_q2u2 = (dx_q2u2)./cos(lat_3d*deg)*rescaling;

  [~,dy_q2v2,~] = gradient(q2v2.*cos(lat_3d*deg),x,y,pr);
  dy_q2v2 = (dy_q2v2)./cos(lat_3d*deg)*rescaling;

  %vertical integration
  

  adv = pres_int((udiffmod.*dx_q + vdiffmod.*dy_q),pr)./grav;
  div = pres_int((qmod.*(dx_u + dy_v)),pr)./grav;
  dyn_ch = pres_int((dx_qdu + dy_qdv),pr)./grav;
  therm_ch = pres_int((dx_dqu + dy_dqv),pr)./grav;
  tot_ch = pres_int((dx_qu + dy_qv)-(dx_q2u2 + dy_q2v2),pr)./grav;
  tot_conv = pres_int((dx_qu + dy_qv),pr)./grav;

  wv_struct ={};
  
  wv_struct{1}= dyn_ch';
  wv_struct{2} = therm_ch';
  wv_struct{3} = tot_ch';
  wv_struct{4} = tot_conv';
  wv_struct{5} = pe1;
  wv_struct{6} = pediff;

 unit = 'mm/day';


 fprintf('\n');
 disp('Saving data');
 field_names = ["dynamic change L75O100-L100O100";"thermodynamic change L75O100-L100O100";"total change L75O100-L100O100";"total moisture convergence L75O100";"P-E L75O100";"P-E L75O100-L100O100"];
 save('fig3.mat','wv_struct','lon','lat','field_names','unit')



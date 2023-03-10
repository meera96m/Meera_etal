clear;
ent = ["L75O100";"L100O100"];


flname1 = strcat('fig6_Amz_',ent(1),'.mat');
flname2 = strcat('fig6_Amz_',ent(2),'.mat');

f1 = load(flname1);
f2 = load(flname2);

lat = f1.lat;
lon = f1.lon;
pres = f1.pres;

sp1 = f1.q1;
temp1 = f1.t1;
ps1 = f1.ps1;
zs1 = f1.zs1;
ts1 = f1.tsurf1;
qr1 = f1.qref1;
cpr1 = f1.cpr1;

sp2 = f2.q1;
temp2 = f2.t1;
ps2 = f2.ps1;
zs2 = f2.zs1;
ts2 = f2.tsurf1;
qr2 = f2.qref1;
cpr2 = f2.cpr1;
%---------------------------------
 sp1 = sp1(:,:,end:-1:1);
 sp2 = sp2(:,:,end:-1:1);
 temp1 = temp1(:,:,end:-1:1);
 temp2 = temp2(:,:,end:-1:1);
 

%from 996hPa to 110hPa
 qq1 = sp1(:,:,1:23);
 qq2 = sp2(:,:,1:23);
 t1 = temp1(:,:,1:23);
 t2 = temp2(:,:,1:23);

 pres = pres(end:-1:1);
 pr = pres(1:23); 

u = 0.0;
v = 0.0;

%convert to g/kg
qr1 = qr1*1000;
qr2 = qr2*1000;

%mixing ratio
qs1 = qr1./(1-qr1);
qs2 = qr2./(1-qr2);

%calculation for L75O100 -- Amazon
lcl1=0.0;
lnb1 = 0.0;
lfc1 = 0.0;
cape1 = 0.0;
cin1 = 0.0;

ht1 = zeros(1,1,length(pr));

i=1;

for ii=450:450
    j=1;
    for jj=180:180
        
        [soundstr,z] = cape_input(pr,t1(ii,jj,:),qq1(ii,jj,:),u,v,zs1(ii,jj),ps1(ii,jj),qs1(ii,jj),ts1(ii,jj),ent(1));
        [lcl,lfc,lnb,cape,cin]= calc_parcel(soundstr);
        
        lcl1(i,j) = lcl
        lnb1(i,j) = lnb
        lfc1(i,j) = lfc
        cape1(i,j) = cape
        cin1(i,j) = cin
        ht1(i,j,:)=z; 

        j=j+1;
    end
    i=i+1;
end
 
%calculation for L100O100 -- Amazon
lcl2=0.0;
lnb2 = 0.0;
lfc2 = 0.0;
cape2 = 0.0;
cin2 = 0.0;

ht2 = zeros(1,1,length(pr));

i=1;

for ii=450:450
    j=1;
    for jj=180:180
        
        [soundstr,z] = cape_input(pr,t2(ii,jj,:),qq2(ii,jj,:),u,v,zs2(ii,jj),ps2(ii,jj),qs2(ii,jj),ts2(ii,jj));
        [lcl,lfc,lnb,cape,cin]= calc_parcel(soundstr);
        
        lcl2(i,j) = lcl
        lnb2(i,j) = lnb
        lfc2(i,j) = lfc
        cape2(i,j) = cape
        cin2(i,j) = cin
        ht2(i,j,:)=z; 

        j=j+1;
    end
    i=i+1;
end

 
 parcel1={};
 parcel1{1} = lcl1;
 parcel1{2} = lfc1;
 parcel1{3} = lnb1;
 parcel1{4} = cape1;
 parcel1{5} = cin1;
 parcel1{6} = cpr1;

 parcel2={};
 parcel2{1} = lcl2;
 parcel2{2} = lfc2;
 parcel2{3} = lnb2;
 parcel2{4} = cape2;
 parcel2{5} = cin2;
 parcel2{6} = cpr2;

 units =["m";"m";"m";"J/kg";"J/kg";"mm/day"];

 field_names = ["LCL";"LFC";"LNB";"CAPE";"CIN";"Convective precipitation"];
 save('fig6.mat','parcel1','parcel2','field_names','units')




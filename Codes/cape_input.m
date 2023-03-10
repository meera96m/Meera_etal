function [soundstr,z]=cape_input(pr,temp,q,u,v,zs,ps,qs,ts,locn,ent)
%create input file for profile
%pr in hPa
%temp in K
%q in kg/kg

Rd=287.04;
Cp=1004.0;
rdocp = Rd/Cp;
g = 9.8;

p00 = 1.0e3;
pii=(pr/p00).^rdocp;

theta = temp;

for p=1:length(pr)
 theta(p) = temp(p)/pii(p);
end


thetas = ts/((ps/p00)^rdocp);

soundstr = strcat('input_sounding_',locn,'_',ent);
%writing to file
fileID = fopen(soundstr,'w');

fprintf(fileID,'%9.2f%14.3f%14.4f\n',ps,thetas,qs);

qs = qs/1000;
qv = q;
tv = temp.*(1+0.61*qv);
tvsurf = ts*(1+0.61*qs);

len = length(pr);
z = zeros(len,1);
z(1)= log(ps/pr(1))*(Rd*(tvsurf+tv(1))*0.5)/g + zs;


  % Hydrostatic pressure integration
  for k=2:len
      z(k)= log(pr(k-1)/pr(k))*(Rd*(tv(k-1)+tv(k))*0.5)/g + z(k-1);

  end
  
  qv = qv*1000;
  
for ii=1:len
fprintf(fileID,'%9.2f%14.3f%14.4f%14.3f%14.3f\n',z(ii),theta(ii),qv(ii),u,v);
end
fclose(fileID);


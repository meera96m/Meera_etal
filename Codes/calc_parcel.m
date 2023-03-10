%function to calculate LFC,LNB,LCL,CAPE,CIN
function [lcl,lfc,lnb,cape,cin]= calc_parcel(soundstr)


%iwind=0; % Add wind barbs
%iprcl=1; % 1: add parcel profile
%ithe=0; % Add theta_e profile next to plot
%ianno=0; % Add LCL, LFC, and LNB annotation

%dashes={'-','-'};
%windgap=[0.0,0];

global Rd Rv cp eps reps rdocp cpord g p00 T0 a b tmin tmax pma ang ymin ymax ytick

% Thermodynamic constants
Rd=287.04;
Rv=461.5;
cp=1004.0;
eps=Rd/Rv;
reps=Rv/Rd;
rdocp=Rd/cp;
cpord=cp/Rd;
g=9.806;
p00=1.0e5;
T0=273.15;
a=17.27;
b=237.7;

%---------------------------------------------------------------------------
% Plot settings

%hgt=0.6; % axes height (nominally 0.6)
%fsize=10; % Main font size (nominally 10)
%windbarbdist=500; % If iwind=1, controls height between plotted barbs (nominally 500 m)
%aspect=2; % Plot aspect ratio (nominally 2)

% theta_e profile settings
%themin=320.0;
%themax=themin+50.0;

% Try not to touch these settings below
%ymin=100.0; % hPa
%ymax=1000.0;
%ytick=100.0;
%ylogmin=log10(100*ymin);
%ylogmax=log10(100*ymax);
%yticks=100.0*(ymin:ytick:ymax);

%---------------------------------------------------------------------------
% Initialize plot axis for skewt-logp plot

%ax2=axes('Position',[0.1 0.12 hgt/aspect hgt]);

%---------------------------------------------------------------------------
% Draw skew-T background

%[ax2,pma]=skewt_bknd(ax2,fsize,'Title');
%---------------------------------------------------------------------------
% Process sounding(s)

%nsound=length(soundstr);
%is = 1;
%for is=1:nsound
  skew = dlmread(char(soundstr));%dlmread(char(soundstr(is)));
  len=size(skew,1);

  % Surface conditions
  p(1)=skew(1,1)*100;
  pii(1)=(p(1)/p00)^rdocp;
  th(1)=skew(1,2);
  qv(1) = 0.001*skew(1,3);
  thv(1)=skew(1,2)*(1+0.61*(qv(1)));
  qv(1) = 0.001*skew(1,3);
  t(1) = th(1)*pii(1);
  z(1)=0.0;
  the(1)=thefunc(p(1),t(1),qv(1));
  rh(1)=qv(1)/rslf(p(1),t(1));

  % Upper air
  z(2:len)=skew(2:end,1);
  th(2:len)=skew(2:end,2);
  qv(2:len)=0.001*skew(2:end,3);
  thv(2:len)=th(2:len).*(1.0+0.61*qv(2:len));
  u=skew(2:end,4);
  v=skew(2:end,5);

  % Hydrostatic pressure integration
  %disp('Hydrostatic pressure int');
  for k=2:len
    pii(k)=pii(k-1)-2.0*g/cp/(thv(k)+thv(k-1))*(z(k)-z(k-1)); %using mean thv 
    t(k)=pii(k)*th(k);
    p(k)=p00*pii(k).^cpord;
    the(k)=thefunc(p(k),t(k),qv(k));
    rh(k)=qv(k)/rslf(p(k),t(k));
  end

  % Calculate dewpoint and other things
  %disp('Calculating dew point');
  %tc=t-T0;
  %for k=1:len
    %alpha=a*tc(k)/(b+tc(k))+log(rh(k));
    %td(k)=b*alpha/(a-alpha);
  %  if (k >= 2)
     % spd(k)=sqrt(u(k-1)^2+v(k-1)^2);
     % dir(k)=270.0-180.0/pi*max(atan2(v(k-1),u(k-1)),2*pi+atan2(v(k-1),u(k-1)));
   % end
 % end
   %---------------------------------------------------------------------------
  % Compute parcel profile, overlay it on background if desired
  %disp('Compute profile of parcel');

  %if (iprcl)
    [~,~,lcl,lfc,lnb,cape,cin]=parcelv_ent(z,p,t,qv);%,lam);

    %tadsnd=tp-T0+(max(logpma)-logp)*(tmax-tmin)/(max(logpma)-min(logpma));
    %pad=plot(ax2,tadsnd,logp,'m','LineWidth',1,'LineStyle',char(dashes(is)));
    %disp(['sounding number=',num2str(is),', CAPE=',num2str(cape),', CIN=',num2str(cin)])
  %end

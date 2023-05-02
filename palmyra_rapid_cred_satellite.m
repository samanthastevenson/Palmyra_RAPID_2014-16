% Plot data from BOTH the RAPID AND the CRED deployments, look at how
% everything compares with satellite etc
% July 2020
% Sam Stevenson

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CRED
% 2009-2012
[tarr37,datarr37,sitenames37]=readcreddata_sbe37_temp;

% 2002-2015
sitenamesnc={'004','005','016','036','042','048','049','053','054'};
tarrnc=cell(9,1);
datarrnc=cell(9,1);

nc=netcdf('~/Box Sync/PalmyraFieldwork/Data/CRED/PAL/PAL_OCEAN_004.nc');
tarrnc{1}=nc{'time'}(:);
datarrnc{1}=nc{'temperature'}(:);
nc=netcdf('~/Box Sync/PalmyraFieldwork/Data/CRED/PAL/PAL_OCEAN_005.nc');
tarrnc{2}=nc{'time'}(:);
datarrnc{2}=nc{'temperature'}(:);
nc=netcdf('~/Box Sync/PalmyraFieldwork/Data/CRED/PAL/PAL_OCEAN_016.nc');
tarrnc{3}=nc{'time'}(:);
datarrnc{3}=nc{'temperature'}(:);
nc=netcdf('~/Box Sync/PalmyraFieldwork/Data/CRED/PAL/PAL_OCEAN_036.nc');
tarrnc{4}=nc{'time'}(:);
ttmp=tarrnc{4};
tmp=nc{'temperature'}(:);
myt=find(ttmp >= datenum(2003,5,25) & ttmp <= datenum(2003,6,1));
tmp(myt)=0/0;
datarrnc{4}=tmp;
nc=netcdf('~/Box Sync/PalmyraFieldwork/Data/CRED/PAL/PAL_OCEAN_042.nc');
tarrnc{5}=nc{'time'}(:);
datarrnc{5}=nc{'temperature'}(:);
nc=netcdf('~/Box Sync/PalmyraFieldwork/Data/CRED/PAL/PAL_OCEAN_048.nc');
tarrnc{6}=nc{'time'}(:);
datarrnc{6}=nc{'temperature'}(:);
nc=netcdf('~/Box Sync/PalmyraFieldwork/Data/CRED/PAL/PAL_OCEAN_049.nc');
tarrnc{7}=nc{'time'}(:);
datarrnc{7}=nc{'temperature'}(:);
nc=netcdf('~/Box Sync/PalmyraFieldwork/Data/CRED/PAL/PAL_OCEAN_053.nc');
tarrnc{8}=nc{'time'}(:);
datarrnc{8}=nc{'temperature'}(:);
nc=netcdf('~/Box Sync/PalmyraFieldwork/Data/CRED/PAL/PAL_OCEAN_054.nc');
tarrnc{9}=nc{'time'}(:);
datarrnc{9}=nc{'temperature'}(:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RAPID

% SBE37
[tarr_sbe37,datarr_sbe37,sitenames_sbe37]=readsbe37data_temp_interp;
% SBE56
[tarr_sbe56,datarr_sbe56,sitenames_sbe56]=readsbe56data_temp;
% AQD
[tarr_aqd,datarr_aqd,sitenames_aqd]=readaqddata_temp;


% Define time range 
tarr_dy=linspace(datenum(2002,1,1),datenum(2017,6,15),datenum(2017,6,15)-datenum(2002,1,1)+1);
% Output array
temp_daily37=zeros(length(sitenames37),length(tarr_dy));
temp_dailync=zeros(length(sitenamesnc),length(tarr_dy));
temp_daily=zeros(length(sitenames_sbe37),length(tarr_dy));

% Compute daily averages for each site
for dd=1:length(sitenames37)   
   t37tmp=datarr37{dd};
   ttmp=tarr37{dd};
   
   for tt=1:length(tarr_dy)
       temp_daily37(dd,tt)=nanmean(t37tmp(find(floor(ttmp) == tarr_dy(tt))));       
   end
end
for dd=1:length(sitenamesnc)   
   tnctmp=datarrnc{dd};
   ttmp=tarrnc{dd};
   
   for tt=1:length(tarr_dy)
       temp_dailync(dd,tt)=nanmean(tnctmp(find(floor(ttmp) == tarr_dy(tt))));       
   end
end

for dd=1:length(sitenames_sbe37)
   site=sitenames_sbe37{dd};
   sind56=find(string(sitenames_sbe56) == site);
   sinda=find(string(sitenames_aqd) == site);
   
   t37tmp=datarr_sbe37{dd};
   t56tmp=datarr_sbe56{sind56};
   taqdtmp=datarr_aqd{sinda};
   time37=tarr_sbe37{dd};
   time56=tarr_sbe56{sind56};
   timeaqd=tarr_aqd{sinda};
   
   for tt=1:length(tarr_dy)
       t37=nanmean(t37tmp(find(floor(time37) == tarr_dy(tt))));
       t56=nanmean(t56tmp(find(floor(time56) == tarr_dy(tt))));
       taqd=nanmean(taqdtmp(find(floor(timeaqd) == tarr_dy(tt))));
       
       temp_daily(dd,tt)=nanmean([t37 t56 taqd]);
   end
end


% TAO
nc=netcdf(strcat('~/Box Sync/TAOdata/sst5n155w_dy.nc'));
taotime=nc{'time'}(:)+datenum(1991,7,18);
taosst=nc{'T_25'}(:);
taosst(abs(taosst) > 1e10)=0/0;

% OISST
nc=netcdf(strcat('~/OISSTv2/avhrr-only-v2.19810101-20180228_25S-25N_90-300E.nc'));
oitime=nc{'time'}(:)+datenum(1978,1,1);
olat=nc{'lat'}(:);
olon=nc{'lon'}(:);
mylat=find(olat == 5.875);
mylon=find(olon == 197.875);
oisst=squeeze(nc{'sst'}(:,1,mylat,mylon))*0.01;
oisst(abs(oisst) > 1e10)=0/0;


% ERSSTv5
nc=netcdf(strcat('~/ERSSTv5/ersst_v5_185401-201802.nc'));
etmp=nc{'time'}(:);    % minutes since 1854-01-01, 360-day calendar... seriously??
nt=length(etmp);
timesst=datenum(cat(2,ones(nt,1)*1854,(1:nt)',ones(nt,1)));
alat=nc{'lat'}(:);
alon=nc{'lon'}(:);
mytime=find(timesst >= datenum(1979,1,1));
timesst=timesst(mytime);
[sstyr,sstmon,~]=datevec(timesst);
mylat=find(alat >= 5 & alat <= 6);
mylon=find(alon >= 197 & alon <= 198);
alat=alat(mylat);
alon=alon(mylon);
sst=squeeze(nc{'sst'}(mytime,1,mylat,mylon));



%cols={'b','k','r','m','g'};
cols=[0 0.4470 0.7410;
    0.8500 0.3250 0.0980;
    0.9290 0.6940 0.1250;
    0.4940 0.1840 0.5560;
    0.4660 0.6740 0.1880];


figure(1)
clf
for dd=1:length(sitenames37)
    plot(tarr_dy,temp_daily37(dd,:),'--','LineWidth',2)
    hold all
end
for dd=1:length(sitenamesnc)
    plot(tarr_dy,temp_dailync(dd,:),'LineWidth',2)
end
for dd=1:length(sitenames_sbe37)
    plot(tarr_dy,temp_daily(dd,:),'Color',cols(dd,:),'LineWidth',2)
    hold all
end

set(gca,'FontSize',24)
title('Temperature data: Palmyra')
ylabel('T (^{\circ}C)')
datetick('x','mmm-yy','keeplimits')
plot(taotime,taosst,'--','Color','k','LineWidth',3)
plot(timesst,sst,'Color','k','LineWidth',2)
plot(oitime,oisst,':','Color','k','LineWidth',3)

legend([sitenames37,sitenamesnc,sitenames_sbe37 'TAO SST (5N, 155W)' 'ERSSTv5 (6N, 198E)' 'OISSTv2 (5.875N, 197.875E)'])
xlim([datenum(2002,1,1) datenum(2017,10,1)])
saveas(gcf,'~/Box Sync/PalmyraFieldwork/plots/temperature_rapid_cred_dailyfilt.fig','fig');

% Make atoll-mean time series and monthly climatology
palmntemp=nanmean(cat(1,temp_daily37,temp_dailync,temp_daily),1);
palclimT=zeros(12,1);
oisstclimT=zeros(12,1);
[oyr,omon,ody]=datevec(oitime);

[yr,mon,dy]=datevec(tarr_dy);
for mm=1:12
   myt=find(mon == mm);
   palclimT(mm)=nanmean(palmntemp(myt));
   myt=find(omon == mm & oyr >= 2002 & oyr <= 2017);
   oisstclimT(mm)=nanmean(oisst(myt));
end

figure(1)
clf
plot(1:12,palclimT,'Color','b','LineWidth',2)
hold all
plot(1:12,oisstclimT,':','Color','k','LineWidth',1.5)
set(gca,'FontSize',24)
ylabel('T (^{\circ}C)')
xlabel('Month')
title('T climatology: Palmyra')
legend({'In situ' 'OISST'})
saveas(gcf,'~/Box Sync/PalmyraFieldwork/plots/temperatureclim_rapidcred_oisst.fig','fig');

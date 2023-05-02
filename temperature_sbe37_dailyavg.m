% Plot temperature from all Palmyra sampling locations, match the salinity
% time series plot
% July 2020
% Sam Stevenson

[tarr,datarr,sitenames]=readsbe37data_temp_interp;

% Define time range 
tarr_dy=linspace(datenum(2014,9,1),datenum(2017,9,30),datenum(2017,9,30)-datenum(2014,9,1)+1);

% Output array
temp_daily=zeros(length(sitenames),length(tarr_dy));

% Compute daily averages for each site
for dd=1:length(sitenames)   
   ttmp=datarr{dd};
   time=tarr{dd};
   
   for tt=1:length(tarr_dy)
       t37=nanmean(ttmp(find(floor(time) == tarr_dy(tt))));       
       temp_daily(dd,tt)=nanmean(t37);
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
for dd=1:size(datarr,1)
    plot(tarr_dy,temp_daily(dd,:),'Color',cols(dd,:),'LineWidth',2)
    hold all
end
set(gca,'FontSize',24)
title('Temperature data: Palmyra')
ylabel('T (^{\circ}C)')
xlim([datenum(2014,8,15) datenum(2017,6,15)])
datetick('x','mmm-yy','keeplimits')
plot(taotime,taosst,'--','Color','k','LineWidth',3)
plot(timesst,sst,'Color','k','LineWidth',2)
plot(oitime,oisst,':','Color','k','LineWidth',3)
legend([sitenames 'TAO SST (5N, 155W)' 'ERSSTv5 (6N, 198E)' 'OISSTv2 (5.875N, 197.875E)'])

saveas(gcf,'~/Box Sync/PalmyraFieldwork/plots/temperature_sbe37_clean_dailyfilt.fig','fig');

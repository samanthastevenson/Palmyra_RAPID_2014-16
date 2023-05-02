% Plot NINO3.4 time series from OISST, ERSST for comparison with Palmyra
% time series data
% July 2020
% Sam Stevenson

% OISST
nc=netcdf(strcat('~/OISSTv2/avhrr-only-v2.19810101-20180228_25S-25N_90-300E.nc'));
oitime=nc{'time'}(:)+datenum(1978,1,1);
olat=nc{'lat'}(:);
olon=nc{'lon'}(:);
mylat=find(olat >= -5 & olat <= 5);
mylon=find(olon >= 190 & olon <= 240);
oisst=squeeze(nc{'sst'}(:,1,mylat,mylon))*0.01;
oisst(abs(oisst) > 1e10)=0/0;
n34oisst=squeeze(nanmean(nanmean(oisst,2),3));
n34oisst=subtractclim(oitime,n34oisst);


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
mylat=find(alat >= -5 & alat <= 5);
mylon=find(alon >= 190 & alon <= 240);
alat=alat(mylat);
alon=alon(mylon);
sst=squeeze(nc{'sst'}(mytime,1,mylat,mylon));
n34ersst=squeeze(nanmean(nanmean(sst,2),3));
n34ersst=subtractclim(timesst,n34ersst);

figure(1)
clf
plot(timesst,n34ersst,'Color','k','LineWidth',3)
hold all
plot(oitime,n34oisst,':','Color','k','LineWidth',3)
set(gca,'FontSize',30)
ylabel('NINO3.4 (^{\circ}C)')
legend({'ERSSTv5','OISSTv2'})
xlim([datenum(2014,8,15) datenum(2017,6,15)])
datetick('x','mmm-yy','keeplimits')
saveas(gcf,'~/Box Sync/PalmyraFieldwork/plots/nino34_ersstv5_oisstv2.fig','fig');

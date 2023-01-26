% Make composite plots of temperature, currents over El Nino events
% January 2016
% Sam Stevenson

tstart=datenum(2016,3,1);
tstop=datenum(2016,5,31);
% tstart=datenum(2014,12,1);
% tstop=datenum(2015,2,28);
% tstart=datenum(2015,3,1);
% tstop=datenum(2015,5,31);

% El Nino life cycle
% tstart=datenum(2015,6,1);
% tstop=datenum(2015,8,31);
% tstart=datenum(2015,9,1);
% tstop=datenum(2015,11,30);
% tstart=datenum(2015,12,1);
% tstop=datenum(2016,2,29);
% tstart=datenum(2016,3,1);
% tstop=datenum(2016,5,31);

% Mesoscale effects?
% tstart=datenum(2015,7,25);
% tstop=datenum(2015,8,1);
% tstart=datenum(2014,11,15);
% tstop=datenum(2014,12,10);
% tstart=datenum(2016,2,1);
% tstop=datenum(2016,2,29);
% tstart=datenum(2014,11,23);
% tstop=datenum(2014,11,30);

% TIWs?
% tstart=datenum(2010,11,1);
% tstop=datenum(2010,11,15);
% tstart=datenum(2012,2,1);
% tstop=datenum(2012,2,28);
% tstart=datenum(2015,10,1);
% tstop=datenum(2015,10,15);

% Peaks of El Nino influence at Palmyra
% tstart=datenum(2015,7,1);
% tstop=datenum(2015,10,1);
% tstart=datenum(2014,11,1);
% tstop=datenum(2015,1,1);


proxylat=5.9;
proxylon=197.9;
cm=1-[[1*(1:-.1:0)' 1*(1:-.1:0)' 0*(1:-.1:0)'];[0*(0:.1:1)' 1*(0:.1:1)' 1*(0:.1:1)']];

%%%%%%%%%%%%%%%%%%%%%% Gridded products, bathymetry %%%%%%%%%%%%%%%%%%%%%%%%%%%
% OSCAR
%[olon,olat,otime,uvel,vvel]=readoscar([proxylat-25,proxylat+10,proxylon-30,proxylon+30],datenum(2014,9,1),datenum(2015,9,1),0);
% [olon,olat,otime,uvel,vvel]=readoscar([-10,15,130,280],datenum(2014,9,1),datenum(2015,9,1),0);
% myu=squeeze(nanmean(nanmean(uvel,2),3));
% myv=squeeze(nanmean(nanmean(vvel,2),3));
nc=netcdf('~/OSCAR/oscar_thirddeg_20S-20N_1992-2016.nc');
olat=nc{'lat'}(:);
olon=nc{'lon'}(:);
mylat=find(olat >= -10 & olat <= 15);
mylon=find(olon >= 130 & olon <= 280);
olat=olat(mylat);
olon=olon(mylon);
uvel=squeeze(nc{'u'}(:,1,mylat,mylon));
vvel=squeeze(nc{'v'}(:,1,mylat,mylon));
otime=nc{'time'}(:)+datenum(1992,10,21);
[Oln,Olg]=meshgrid(olon,olat);
uvel=subtractclim(otime,uvel);
vvel=subtractclim(otime,vvel);

% AVHRR OISST
nc=netcdf(strcat('~/OISSTv2/avhrr-only-v2.19810101-20180228_25S-25N_90-300E.nc'));
timesstoi=nc{'time'}(:)+datenum(1978,1,1);
alat=nc{'lat'}(:);
alon=nc{'lon'}(:);
mylat=find(alat >= -10 & alat <= 15);
mylon=find(alon >= 130 & alon <= 280);
alat=alat(mylat);
alon=alon(mylon);
sstoi=squeeze(nc{'sst'}(:,1,mylat,mylon))*0.01;
sstoi(abs(sstoi) > 1e10)=0/0;
sstoi=subtractclim(timesstoi,sstoi);

% % Read in the CRED bathymetry dataset
% % construct lat/lon grid to match
% %nc=netcdf('~/ROMSgrids/palmyragrd_smoothbathy_N20.nc');o
% nc=netcdf('~/ROMSgrids/Palmyra-2.5km_grd_GEBCOcredbathy.nc');
% credhr=nc{'h'}(:,:);
% long=nc{'lon_rho'}(:,:);
% latg=nc{'lat_rho'}(:,:);

%%%%%%%%%%%%%%%%%%%%%% Plot appropriate times %%%%%%%%%%%%%%%%%%%%%%%%%%%
myt_temp=find(timesstoi > tstart & timesstoi <= tstop);     % OISST
myt_osc=find(otime >= tstart & otime <= tstop);             % OSCAR

fig=figure(1);
clf    
%m_proj('mercator','lon',[proxylon-5,proxylon+5],'lat',[proxylat-5,proxylat+5]) 
m_proj('mercator','lon',[130 280],'lat',[-10 15]) 
%m_proj('mercator','lon',[197 207],'lat',[-2 8]) 
m_pcolor(alon,alat,squeeze(nanmean(sstoi(myt_temp,:,:),1)))
m_grid('xaxis','bottom','tickdir','out','linewidth',3,'FontSize',24);
shading flat
colorbar('FontSize',24)
% caxis([23 31])
%caxis([22 32]
caxis([-3 3])
m_coast('color',[0 0 0]);
set(gca,'DataAspectRatio',[1 0.7 1])
colormap(cm)
hold all
m_plot(197.9,5.9,'o','MarkerFaceColor','w','MarkerEdgeColor','k','MarkerSize',15)   % Palmyra 'centroid'
hold all
%[C,h]=m_contour(long,latg,credhr,[300 600 900 1200 1300 1800 2100 2800 2700 3000 3300],'Color','k');
%[C,h]=m_contour(long,latg,credhr,[500 1000 1300 2000 2500 3000 3500 4000],'Color','k');
%clabel(C,h,'FontSize',24)
% m_quiver(Oln,Olg,squeeze(nanmean(uvel(myt_osc,:,:),1)),squeeze(nanmean(vvel(myt_osc,:,:),1)),20,'Color','b','LineWidth',1.5)
m_quiver(Oln(1:5:end,1:5:end),Olg(1:5:end,1:5:end),squeeze(nanmean(uvel(myt_osc,1:5:end,1:5:end),1)),squeeze(nanmean(vvel(myt_osc,1:5:end,1:5:end),1)),3,'Color','k','LineWidth',1)
title(strcat(datestr(tstart),' to ',datestr(tstop)),'FontSize',24)
set(gcf,'renderer','painters')
saveas(gcf,strcat('/Users/samstevenson/Box Sync/PalmyraFieldwork/plots/sstavelcomp_sat_',datestr(tstart),'_',datestr(tstop),'.fig'),'fig')

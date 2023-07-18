% Make composite vector map of Aquadopp velocities at Palmyra
% July 2020
% Sam Stevenson
cm=1-[[1*(1:-.1:0)' 1*(1:-.1:0)' 0*(1:-.1:0)'];[0*(0:.1:1)' 1*(0:.1:1)' 1*(0:.1:1)']];

% Time range of interest
% tstart=datenum(2015,7,1);
% tstop=datenum(2015,10,1);
tstart=datenum(2014,11,1);
tstop=datenum(2015,1,1);

% Aquadopp data
load('~/Box Sync/PalmyraFieldwork/Data/AQD_MMprocess_mar2016/AQDprocessed/CHL.mat')
CHL.lon=-162.105;
CHL.lat=5.878;
load('~/Box Sync/PalmyraFieldwork/Data/AQD_MMprocess_mar2016/AQDprocessed/RT4.mat')
RT4.lon=-162.129;
RT4.lat=5.876;
load('~/Box Sync/PalmyraFieldwork/Data/AQD_MMprocess_mar2016/AQDprocessed/FR5.mat')
FR5.lon=-162.075;
FR5.lat=5.869;
load('~/Box Sync/PalmyraFieldwork/Data/AQD_MMprocess_mar2016/AQDprocessed/FR7.mat')
FR7.lon=-162.078;
FR7.lat=5.897;
load('~/Box Sync/PalmyraFieldwork/Data/AQD_MMprocess_mar2016/AQDprocessed/FR9.mat')
FR9.lon=-162.128;
FR9.lat=5.896;

load('~/Box Sync/PalmyraFieldwork/CREDdata/Palmyra_40m.asc/palmyra_40m.mat')
credhr(credhr == 99999)=0/0;

% Subtract climatologies
RT4.v=subtractclim(RT4.t,RT4.v);
RT4.u=subtractclim(RT4.t,RT4.u);
CHL.v=subtractclim(CHL.t,CHL.v);
CHL.u=subtractclim(CHL.t,CHL.u);
FR5.v=subtractclim(FR5.t,FR5.v);
FR5.u=subtractclim(FR5.t,FR5.u);
FR7.v=subtractclim(FR7.t,FR7.v);
FR7.u=subtractclim(FR7.t,FR7.u);
FR9.v=subtractclim(FR9.t,FR9.v);
FR9.u=subtractclim(FR9.t,FR9.u);

sfac=0.75;
figure(1)
clf
m_proj('mercator','lon',[-162.2 -161.95],'lat',[5.8 5.95]) 
m_pcolor(long,latg,-1*credhr')
m_grid('xaxis','bottom','tickdir','out','linewidth',3,'FontSize',24);
shading flat
colorbar('FontSize',24)
m_coast('color',[0 0 0]);
set(gca,'DataAspectRatio',[1 0.7 1])
hold all
caxis([0 2000])
%m_plot(197.9,5.9,'o','MarkerFaceColor','w','MarkerEdgeColor','k','MarkerSize',15)   % Palmyra 'centroid'
hold all
myt=find(RT4.t >= tstart & RT4.t <= tstop);
m_quiver(RT4.lon,RT4.lat,nanmean(RT4.u(myt)),nanmean(RT4.v(myt)),sfac,'Color','k','LineWidth',5,'AutoScale','off')
myt=find(CHL.t >= tstart & CHL.t <= tstop);
m_quiver(CHL.lon,CHL.lat,nanmean(CHL.u(myt)),nanmean(CHL.v(myt)),sfac,'Color','k','LineWidth',5,'AutoScale','off')
myt=find(FR5.t >= tstart & FR5.t <= tstop);
m_quiver(FR5.lon,FR5.lat,nanmean(FR5.u(myt)),nanmean(FR5.v(myt)),sfac,'Color','k','LineWidth',5,'AutoScale','off')
myt=find(FR7.t >= tstart & FR7.t <= tstop);
m_quiver(FR7.lon,FR7.lat,nanmean(FR7.u(myt)),nanmean(FR7.v(myt)),sfac,'Color','k','LineWidth',5,'AutoScale','off')
myt=find(FR9.t >= tstart & FR9.t <= tstop);
m_quiver(FR9.lon,FR9.lat,nanmean(FR9.u(myt)),nanmean(FR9.v(myt)),sfac,'Color','k','LineWidth',5,'AutoScale','off')
% m_quiver(Oln(1:6:end,1:8:end),Olg(1:6:end,1:8:end),squeeze(nanmean(uvel(myt_osc,1:6:end,1:8:end),1)),squeeze(nanmean(vvel(myt_osc,1:6:end,1:8:end),1)),3,'Color','k','LineWidth',3)
title(strcat(datestr(tstart),' to ',datestr(tstop)),'FontSize',24)
saveas(gcf,strcat('~/Box Sync/PalmyraFieldwork/plots/AQDcomp_',datestr(tstart),'_',datestr(tstop),'.fig'),'fig')

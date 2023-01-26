% Plot time series of seawater d18O budget terms from isoROMS assimilation
% last updated: January 2023
% Sam Stevenson

%'dRdt','mnzadvanomgradavg','mnmadvanomgradavg','anomzadvmngradavg','anommadvmngradavg','anomzadvanomgradavg','anommadvanomgradavg','Rflux'

load '/glade/campaign/univ/ucsb0006/ROMSassim/w4d_frinkiac/w4d_2013-2017/output/isoratiobudget_rd_mld16m_01-Jan-2013-31-Dec-2018isoROMSassim_highfreq.mat'
dir='/glade/campaign/univ/ucsb0006/ROMSassim/w4d_frinkiac/w4d_2013-2017/output/';
fac=(31556926/12)*(1000/2005.2e-6);  % convert s^-1 to per mil/month
cm=1-[[1*(1:-.1:0)' 1*(1:-.1:0)' 0*(1:-.1:0)'];[0*(0:.1:1)' 1*(0:.1:1)' 1*(0:.1:1)']];
% Palmyra
plat=5.9;
plon=197.9;
% Christmas
% plat=1.9;
% plon=202.6;

[yr,mon,dy]=datevec(tavg);

zonadvavg=-1*(mnzadvanomgradavg+anomzadvmngradavg+anomzadvanomgradavg-mn_anomzadvanomgradavg);      % total zonal advection
meridadvavg=-1*(mnmadvanomgradavg+anommadvmngradavg+anommadvanomgradavg-mn_anommadvanomgradavg);    % total meridional advection

% Calculate budget residual, units /s
% flux units: /s
% time derivative units: /day
% advective term units: 
resid=dRdt/86400.-(Rflux-(zonadvavg+meridadvavg));


mylat=find(paclatr(:,1) >= plat-1 & paclatr(:,1) <= plat+1);
mylon=find(paclonr(1,:) >= plon-1 & paclonr(1,:) <= plon+1);

figure(1)
clf
plot(tavg,squeeze(nanmean(nanmean(dRdt(:,mylat,mylon),2),3))*fac/86400.,'LineWidth',3,'Color','k');
hold all
plot(tavg,squeeze(nanmean(nanmean(Rflux(:,mylat,mylon),2),3))*fac,'--','Color','b');
plot(tavg,squeeze(nanmean(nanmean(-1*zonadvavg(:,mylat,mylon),2),3))*fac,'-.','Color','r');
plot(tavg,squeeze(nanmean(nanmean(-1*meridadvavg(:,mylat,mylon),2),3))*fac,':','Color','g');
plot(tavg,squeeze(nanmean(nanmean(resid(:,mylat,mylon),2),3))*fac,'--','LineWidth',1,'Color','k');
set(gca,'FontSize',24)
datetick
legend({'Tendency','Flux','Zon. adv.','Merid. adv.','Vert adv/diff'})
strcat(dir,'d18Oswbudgetts_rd_romsassim.fig')
saveas(gcf,strcat(dir,'d18Oswbudgetts_rd_romsassim.fig'),'fig');


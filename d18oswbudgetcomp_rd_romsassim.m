% Plot seawater d18O budget component maps for isoROMS assimilation
% August 2020
% Sam Stevenson

load '/glade/campaign/univ/ucsb0006/ROMSassim/w4d_frinkiac/w4d_2013-2017/output/isoratiobudget_rd_mld16m_01-Jan-2013-31-Dec-2018isoROMSassim_highfreq.mat'
dir='/glade/campaign/univ/ucsb0006/ROMSassim/w4d_frinkiac/w4d_2013-2017/output/';
% load '/glade/scratch/samantha/ROMSruns_v36_apr16/isonlmF_N30/isoratiobudget_rd_mld16m_01-Jan-1980-31-Dec-2009_isonlmF-N30.mat'
% dir='/glade/scratch/samantha/ROMSruns_v36_apr16/isonlmF_N30/';
fac=(31556926/12)*(1000/2005.2e-6);  % convert yr^-1 to per mil/month
%yrs=[1983,1987,1988,1992,1998,2003,2004,2007];    % EP El Nino
yrs=[2016]; % 2014-15 El Nino

cm=1-[[1*(1:-.1:0)' 1*(1:-.1:0)' 0*(1:-.1:0)'];[0*(0:.1:1)' 1*(0:.1:1)' 1*(0:.1:1)']];

zonadvavg=-1*(mnzadvanomgradavg+anomzadvmngradavg+anomzadvanomgradavg-mn_anomzadvanomgradavg);      % total zonal advection
meridadvavg=-1*(mnmadvanomgradavg+anommadvmngradavg+anommadvanomgradavg-mn_anommadvanomgradavg);    % total meridional advection

% Calculate budget residual
resid=dRdt/86400.-(Rflux-(zonadvavg+meridadvavg));


[yr,mon,dy]=datevec(tavg);

% Locate relevant indices
% tstrt=datenum(2014,11,1);
% tstp=datenum(2015,1,1);
% tstrt=datenum(2015,7,1);
% tstp=datenum(2015,9,30);
% tstrt=datenum(2002,11,1);
% tstp=datenum(2003,1,1);

myt=[];
for yy=1:length(yrs)
    %myt=[myt,find(tavg >= datenum(yrs(yy)-1,6,1) & tavg < datenum(yrs(yy)-1,9,1))];  % JJA +0
%     myt=[myt,find(tavg >= datenum(yrs(yy)-1,11,1) & tavg < datenum(yrs(yy),2,1))];  % NDJ +0-1
    %myt=[myt,find(tavg >= datenum(yrs(yy)-1,10,1) & tavg < datenum(yrs(yy)-1,10,31))];  % Oct +0
    myt=[myt,find(tavg >= datenum(yrs(yy)-1,7,1) & tavg < datenum(yrs(yy),10,1))];  % JAS +0
end


% Plot
fig=figure(1);
clf    
subplot('Position',[0.1 0.77 0.8 0.15])
cla
m_proj('mercator','lon',[130 280],'lat',[-24 12]) 
m_pcolor(paclonr,paclatr,squeeze(nanmean(dRdt(myt,:,:),1))*fac/86400.)  
m_grid('xaxis','bottom','tickdir','out','linewidth',3,'FontSize',20);
shading flat
colorbar('FontSize',20)
caxis([-0.05 0.05])
m_coast('color',[0 0 0]);
set(gca,'DataAspectRatio',[1 0.8 1])
colormap(cm)
hold all
m_plot(197.9,5.9,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',1.5)   % Palmyra
hold all
title('a) Time rate of change','FontSize',20)
set(gcf,'renderer','painters')

subplot('Position',[0.1 0.59 0.8 0.15])
cla
m_proj('mercator','lon',[130 280],'lat',[-24 12]) 
m_pcolor(paclonr,paclatr,squeeze(nanmean(Rflux(myt,:,:),1))*fac)  
m_grid('xaxis','bottom','tickdir','out','linewidth',3,'FontSize',20);
shading flat
colorbar('FontSize',20)
caxis([-0.05 0.05])
m_coast('color',[0 0 0]);
set(gca,'DataAspectRatio',[1 0.8 1])
colormap(cm)
hold all
m_plot(197.9,5.9,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',1.5)   % Palmyra
hold all
title('b) Surface flux','FontSize',20)

subplot('Position',[0.1 0.41 0.8 0.15])
cla
m_proj('mercator','lon',[130 280],'lat',[-24 12]) 
m_pcolor(paclonr,paclatr,squeeze(-1*(nanmean(zonadvavg(myt,:,:),1))+nanmean(meridadvavg(myt,:,:),1))*fac)  
m_grid('xaxis','bottom','tickdir','out','linewidth',3,'FontSize',20);
shading flat
colorbar('FontSize',20)
caxis([-0.05 0.05])
m_coast('color',[0 0 0]);
set(gca,'DataAspectRatio',[1 0.8 1])
colormap(cm)
hold all
m_plot(197.9,5.9,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',1.5)   % Palmyra
hold all
title('c) Horizontal advection','FontSize',20)

subplot('Position',[0.1 0.23 0.8 0.15])
% cla
% m_proj('mercator','lon',[130 280],'lat',[-24 12]) 
% m_pcolor(paclonr,paclatr,squeeze(-1*nanmean(meridadvavg(myt,:,:),1))*fac)  
% m_grid('xaxis','bottom','tickdir','out','linewidth',3,'FontSize',20);
% shading flat
% colorbar('FontSize',20)
% caxis([-0.05 0.05])
% m_coast('color',[0 0 0]);
% set(gca,'DataAspectRatio',[1 0.8 1])
% colormap(cm)
% hold all
% m_plot(197.9,5.9,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',1.5)   % Palmyra
% hold all
% title('d) Meridional advection','FontSize',20)
% 
% subplot('Position',[0.1 0.05 0.8 0.15])
cla
m_proj('mercator','lon',[130 280],'lat',[-24 12]) 
m_pcolor(paclonr,paclatr,squeeze(nanmean(resid(myt,:,:),1))*fac)  
m_grid('xaxis','bottom','tickdir','out','linewidth',3,'FontSize',20);
shading flat
colorbar('FontSize',20)
caxis([-0.05 0.05])
m_coast('color',[0 0 0]);
set(gca,'DataAspectRatio',[1 0.8 1])
colormap(cm)
hold all
m_plot(197.9,5.9,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',1.5)   % Palmyra
hold all
title('d) Vertical advection/diffusion','FontSize',20)

strcat(dir,'d18Oswbudget_rd_isonlmF-N30_2015-16elninocomp_JAS0.fig')
saveas(gcf,strcat(dir,'d18Oswbudget_rd_isonlmF-N30_2015-16elninocomp_JAS0.fig'),'fig');


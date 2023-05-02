% Plot rainfall vs. salinity for Palmyra, get a sense for how important
% lagoonal outflow is at generating salinity anomalies
% August 2020
% Sam Stevenson

% use "Import Data" wizard to read rainfall:
% PalmyraFieldwork/Palmyra_rainamounts_2014-15.txt
% variables Rain, RainTime
% save('~/Box Sync/PalmyraFieldwork/Palmyra_rainamounts_2014-15.mat','Rain','RainTime')
load('~/Box Sync/PalmyraFieldwork/Palmyra_rainamounts_2014-15.mat')

% SBE37 data
[sites,tarr,datarr]=readsbedata_salt_interp;

% Define time range 
tarr_dy=linspace(datenum(2014,9,1),datenum(2017,9,30),datenum(2017,9,30)-datenum(2014,9,1)+1);

% Output array
sal_daily=zeros(length(sites),length(tarr_dy));
rain_daily=zeros(1,length(tarr_dy));

% Compute daily averages for each site, both salinity and rainfall
for dd=1:length(sites)   
   ttmp=datarr{dd};
   time=tarr{dd};
   
   for tt=1:length(tarr_dy)
       t37=nanmean(ttmp(find(floor(time) == tarr_dy(tt))));       
       sal_daily(dd,tt)=nanmean(t37);
       if dd == 1
           rdy=nanmean(Rain(find(floor(RainTime == tarr_dy(tt))))); 
            rain_daily(tt)=nanmean(rdy);
       end
   end
end

% Make scatter plot
figure(1)
clf
plot(rain_daily,sal_daily,'o','MarkerSize',10,'MarkerEdgeColor','b','MarkerFaceColor','b')
set(gca,'FontSize',24)
xlabel('Rain (mm/day)')
ylabel('Salinity (ppt)')
title('Rain vs. salinity: Palmyra')
saveas(gcf,strcat('~/Box Sync/PalmyraFieldwork/plots/palmyra_rainvsal.fig'),'fig')

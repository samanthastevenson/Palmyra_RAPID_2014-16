% Plot rainfall data from Palmyra as a time series
% July 2020
% Sam Stevenson

load('~/Box Sync/PalmyraFieldwork/Data/BottleRainfall/PALMYRA_RAINFALL_2014-2016_WithIso_updatedfeb2018.mat')

figure(1)
clf
yyaxis left
plot(Date,Precip,'-s','MarkerEdgeColor','b','MarkerFaceColor','b')
xlim([datetime(2014,8,15) datetime(2017,6,15)])
ylim([0 280])
set(gca,'FontSize',36)
datetick('x','mmm-yy','keeplimits')
ylabel('P (mm)')
hold all
yyaxis right
plot(Date,d18Op,'-o','MarkerFaceColor','r','MarkerEdgeColor','r')
ylim([-25 4])
title('Precip/\delta^{18}O_p')
saveas(gcf,'~/Box Sync/PalmyraFieldwork/plots/precipd18op_wsatellite.fig','fig');

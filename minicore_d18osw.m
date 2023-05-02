% Plot mini-core data from Palmyra, along with seawater bottle samples
% July 2020
% Sam Stevenson

load('~/Box Sync/PalmyraFieldwork/Data/Minicores/SanchezPalmyrad18Odata_jul2020.mat')

cols=[0 0.4470 0.7410;
    0.8500 0.3250 0.0980;
    0.9290 0.6940 0.1250;
    0.4940 0.1840 0.5560;
    0.4660 0.6740 0.1880];

myt=find(RT4(:,1) >= datenum(2015,9,1) & RT4(:,1) <= datenum(2015,12,1));
RT4mn=nanmean(RT4(myt,2));
myt=find(RT4S(:,1) >= datenum(2015,9,1) & RT4S(:,1) <= datenum(2015,12,1));
RT4Smn=nanmean(RT4S(myt,2));
myt=find(RT10(:,1) >= datenum(2015,9,1) & RT10(:,1) <= datenum(2015,12,1));
RT10mn=nanmean(RT10(myt,2));
myt=find(FR3(:,1) >= datenum(2015,9,1) & FR3(:,1) <= datenum(2015,12,1));
FR3mn=nanmean(FR3(myt,2));


figure(1)
clf
yyaxis left
plot(RT4(:,1),RT4(:,2),'-','Color',cols(1,:),'LineWidth',3)
hold all
plot(RT4S(:,1),RT4S(:,2)+(RT4mn-RT4Smn),'--','Color',cols(1,:),'LineWidth',3)
plot(RT10(:,1),RT10(:,2)+(RT4mn-RT10mn),'-','Color',cols(2,:),'LineWidth',3)
plot(FR3(:,1),FR3(:,2)+(RT4mn-FR3mn),'-','Color',cols(3,:),'LineWidth',3)
xlim([datenum(2014,8,15) datenum(2017,6,15)])
set(gca,'FontSize',36)
datetick('x','mmm-yy','keeplimits')
ylabel('Coral \delta^{18}O (per mil)')
set(gca,'YColor','k','YDir','reverse')

load('/Users/samstevenson/Box Sync/PalmyraFieldwork/Data/SeawaterBottles/PALMYRA_D18OSW_2014-2016.mat')
yyaxis right
plot(datenum(DATE),d18Osw,'o','MarkerSize',15,'MarkerEdgeColor','b','MarkerFaceColor','b')
xlim([datenum(2014,8,15) datenum(2017,6,15)])
ylabel('Seawater \delta^{18}O (per mil)')
set(gca,'YColor','b','YDir','reverse')
title('Coral, seawater \delta^{18}O (Palmyra)')
legend({'RT4','RT4(2)','RT10','FR3','\delta^{18}O_{sw}'})
saveas(gcf,'~/Box Sync/PalmyraFieldwork/plots/minicore_d18osw.fig','fig');



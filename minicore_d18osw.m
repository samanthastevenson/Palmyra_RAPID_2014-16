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
%xlim([datenum(2014,8,15) datenum(2017,6,15)])
set(gca,'FontSize',36)
datetick('x','mmm-yy','keeplimits')
ylabel('Coral \delta^{18}O (per mil)')
set(gca,'YColor','k','YDir','reverse')

load('/Users/samstevenson/Box Sync/PalmyraFieldwork/Data/SeawaterBottles/PALMYRA_D18OSW_2014-2016.mat')
yyaxis right
plot(datenum(DATE),d18Osw,'o','MarkerSize',15,'MarkerEdgeColor','b','MarkerFaceColor','b')
%xlim([datenum(2014,8,15) datenum(2017,6,15)])
ylabel('Seawater \delta^{18}O (per mil)')
set(gca,'YColor','b','YDir','reverse')
title('Coral, seawater \delta^{18}O (Palmyra)')
legend({'RT4','RT4(2)','RT10','FR3','\delta^{18}O_{sw}'})
saveas(gcf,'~/Box Sync/PalmyraFieldwork/plots/minicore_d18osw.fig','fig');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Make a version with the seasonal mean subtracted
% use the average of the climatologies of RT4, RT10 since they're the
% longest and RT4S is drilled sideways
RT4clim=zeros(1,12);
RT10clim=zeros(1,12);

[RT4yr,RT4mon,~]=datevec(RT4(:,1)+5);
[RT10yr,RT10mon,~]=datevec(RT10(:,1)+5);
[RT4Syr,RT4Smon,~]=datevec(RT4S(:,1)+5);
[FR3yr,FR3mon,~]=datevec(FR3(:,1)+5);

for mm=1:12
   myt=find(RT4mon == mm);
   RT4clim(mm)=nanmean(RT4(myt,2));
   
   myt=find(RT10mon == mm);
   RT10clim(mm)=nanmean(RT10(myt,2));
end

corald18Oclim=0.5*(RT4clim+RT10clim);

RT4anom=RT4;
RT10anom=RT10;
RT4Sanom=RT4S;
FR3anom=FR3;

for mm=1:12
   myt=find(RT4mon == mm);
   RT4anom(myt,2)=RT4anom(myt,2)-corald18Oclim(mm);
   
   myt=find(RT4Smon == mm);
   RT4Sanom(myt,2)=RT4Sanom(myt,2)-corald18Oclim(mm);

   myt=find(RT10mon == mm);
   RT10anom(myt,2)=RT10anom(myt,2)-corald18Oclim(mm);

   myt=find(FR3mon == mm);
   FR3anom(myt,2)=FR3anom(myt,2)-corald18Oclim(mm);   
end


% Load isoROMS coral d18O data, subtract seasonal cycle
load('/Users/samstevenson/Box Sync/RAPIDpaper/ROMSassim_d18Osw_Palmyra_datenum.mat')

[yr,mon,dy]=datevec(savets(:,1));
for mm=1:12
   myt=find(mon == mm);
   savets(myt,2)=savets(myt,2)-nanmean(savets(myt,2));
end

% Make mean d18O line up 
myt=find(RT10anom(:,1) >= datenum(2014,10,1) & RT10anom(:,1) <= datenum(2014,11,30));
coralmn=nanmean(RT10anom(myt,2));
myt=find(savets(:,1) >= datenum(2014,10,1) & savets(:,1) <= datenum(2014,11,30));
romsmn=nanmean(savets(myt,2));
savets(:,2)=savets(:,2)-romsmn+coralmn;


figure(1)
clf
plot(RT4anom(:,1),RT4anom(:,2),'-','Color',cols(1,:),'LineWidth',3)
hold all
plot(RT4Sanom(:,1),RT4Sanom(:,2),'--','Color',cols(1,:),'LineWidth',3)
plot(RT10anom(:,1),RT10anom(:,2),'-','Color',cols(2,:),'LineWidth',3)
plot(FR3anom(:,1),FR3anom(:,2),'-','Color',cols(3,:),'LineWidth',3)
h=[h,plot(savets(:,1),savets(:,2),'--','Color','k','LineWidth',1.5)];
set(gca,'FontSize',36)
set(gca,'YColor','k','YDir','reverse')
ylabel('Coral \delta^{18}O anomaly (per mil)')
title('Coral \delta^{18}O (Palmyra)')
xlim([datenum(2014,8,15) datenum(2017,6,15)])
datetick('x','mmm-yy','keeplimits')
legend({'RT4','RT4(2)','RT10','FR3','isoROMS'})
saveas(gcf,'~/Box Sync/PalmyraFieldwork/plots/minicore_anomaly.fig','fig');



% Now make a version with the SST removed!
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

% Make atoll-mean time series 
palmntemp=nanmean(cat(1,temp_daily37,temp_dailync,temp_daily),1);



figure(1)
clf
h=[];
yyaxis left
plmnTint=interp1(tarr_dy,palmntemp,RT4anom(:,1));
RT4_res=RT4(:,2)+0.21*plmnTint;
h=[h,plot(RT4anom(:,1),RT4_res,'-','Color',cols(1,:),'LineWidth',3)];
hold all
plmnTint=interp1(tarr_dy,palmntemp,RT4Sanom(:,1));
RT4S_res=RT4S(:,2)+0.21*plmnTint;
h=[h,plot(RT4Sanom(:,1),RT4S_res,'--','Color',cols(1,:),'LineWidth',3)];
plmnTint=interp1(tarr_dy,palmntemp,RT10anom(:,1));
RT10_res=RT10(:,2)+0.21*plmnTint;
h=[h,plot(RT10anom(:,1),RT10_res,'-','Color',cols(2,:),'LineWidth',3)];
plmnTint=interp1(tarr_dy,palmntemp,FR3anom(:,1));
FR3_res=FR3(:,2)+0.21*plmnTint;
h=[h,plot(FR3anom(:,1),FR3_res,'-','Color',cols(3,:),'LineWidth',3)];
set(gca,'FontSize',36)
set(gca,'YColor','k','YDir','reverse')
ylabel('Coral \delta^{18}O residual (per mil)')

load('/Users/samstevenson/Box Sync/PalmyraFieldwork/Data/SeawaterBottles/PALMYRA_D18OSW_2014-2016.mat')
yyaxis right
sym=['d','h','>','<','p','s','o'];
usite=unique(SITE);
usite=usite([1:6,8]);
for ss=1:length(usite)
    mys=find(SITE == usite(ss));
    h=[h,plot(datenum(DATE(mys)),d18Osw(mys),sym(ss),'MarkerSize',15,'MarkerEdgeColor','b','MarkerFaceColor','b')];
end
%xlim([datenum(2014,8,15) datenum(2017,6,15)])
ylabel('Seawater \delta^{18}O (per mil)')
set(gca,'YColor','b','YDir','reverse')

load('/Users/samstevenson/Box Sync/RAPIDpaper/ROMSassim_d18Osw_Palmyra_datenum.mat')

% Make mean d18Osw line up 
myt=find(DATE >= datetime(2014,10,1) & DATE <= datetime(2014,11,30));
bottlemn=nanmean(d18Osw(myt));
myt=find(savets(:,1) >= datenum(2014,10,1) & savets(:,1) <= datenum(2014,11,30));
romsmn=nanmean(savets(myt,2));
savets(:,2)=savets(:,2)-romsmn+bottlemn;

h=[h,plot(savets(:,1),savets(:,2),'--','Color','k','LineWidth',1.5)];
title('Coral \delta^{18}O residual, seawater \delta^{18}O (Palmyra)')
xlim([datenum(2014,8,15) datenum(2017,6,15)])
datetick('x','mmm-yy','keeplimits')
legs=['RT4','RT4(2)','RT10','FR3',usite','isoROMS'];
legend(h,char(legs))
saveas(gcf,'~/Box Sync/PalmyraFieldwork/plots/minicore_tempresid.fig','fig');




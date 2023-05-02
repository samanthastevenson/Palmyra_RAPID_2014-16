% Plot salinity logger, bottle salinity data, and satellite salinity for
% Palmyra deployments
% July 2020
% Sam Stevenson

climsub=1;
tcstrt=datenum(2011,1,1);   % Start/end times for climatological mean
tcend=datenum(2017,6,1);

% SBE37 data
[sites,tarr,datarr]=readsbedata_salt_interp;

% Define time range 
tarr_dy=linspace(datenum(2014,9,1),datenum(2017,9,30),datenum(2017,9,30)-datenum(2014,9,1)+1);

% Output array
sal_daily=zeros(length(sites),length(tarr_dy));

% Compute daily averages for each site
for dd=1:length(sites)   
   ttmp=datarr{dd};
   time=tarr{dd};
   
   for tt=1:length(tarr_dy)
       t37=nanmean(ttmp(find(floor(time) == tarr_dy(tt))));       
       sal_daily(dd,tt)=nanmean(t37);
   end
end

% Aquarius salinity
nc=netcdf('~/Aquarius/SSS_OI_7D_2011-2015.nc');
aqtime=nc{'time'}(:)+datenum(2010,12,31);   % Julian days since Dec 31, 2010
aqlat=nc{'latitude'}(:);
aqlon=nc{'longitude'}(:);
mylat=find(aqlat >= 5.2 & aqlat <= 6.2);
mylon=find(aqlon >= -163 & aqlon <= -162);
aqsss=nc{'sss'}(:,mylat,mylon);
aqsss=squeeze(nanmean(nanmean(aqsss,2),3));

% SMAP
load('~/SMAP/SMAP_Palmyra_2015-2020.mat')
% smap_sss(smap_sss < -10)=0/0;
% mylat=find(lat >= 5.2 & lat <= 6.2);
% mylon=find(lon >= -163 & lon <= -162);
% smapts=squeeze(nanmean(nanmean(smap_sss(:,mylat,mylon),2),3));
time(time == 0)=0/0;     
time=time/86400.+datenum(2015,1,1);     % seconds since 2015-1-1

% Load bottle data: Cobb lab circa 2018
load('~/Box Sync/PalmyraFieldwork/Data/SeawaterBottles/PALMYRA_SALINITY_2014-2016.mat');

if climsub == 1
   % Monthly average for SMAP and Aquarius
   [ayr,amon,ady]=datevec(aqtime);
   [syr,smon,sdy]=datevec(time);
   [byr,bmon,bdy]=datevec(DATE);
   [cyr,cmon,cdy]=datevec(tarr_dy);

   ctime=cat(1,aqtime,time);
   sss=cat(1,aqsss,smapts);
   myt=find(ctime >= tcstrt & ctime <= tcend);
   ctime=ctime(myt);
   sss=sss(myt);
   [yr,mon,~]=datevec(ctime);

   uyrs=unique(yr);
    % Number of unique month/year combinations
    len=0;
    for yy=1:length(uyrs)
       mons=length(unique(mon(find(yr == uyrs(yy))))); 
       len=len+mons;
    end

    savg=zeros(len,1);
    tavg=zeros(len,1);
    tt=0;
    for yy=1:length(uyrs)
        mons=unique(mon(find(yr == uyrs(yy))));     % all months that exist during this year
        for mm=1:length(mons)
            tt=tt+1;
            times=find(yr == uyrs(yy) & mon == mons(mm));
            savg(tt)=nanmean(sss(times),1);
            tavg(tt)=nanmean(ctime(times));
        end
    end
    [yr,mon,~]=datevec(tavg);
    
   % Build a climatology    
   sclim=zeros(12,1);
   for mm=1:12
       mym=find(mon == mm);
       sclim(mm)= nanmean(savg(mym),1);
       
       % Subtract climatology
       mym=find(bmon == mm);
       SALINITYPSU(mym)=SALINITYPSU(mym)-sclim(mm);
       mym=find(cmon == mm);
       sal_daily(:,mym)=sal_daily(:,mym)-sclim(mm);
       mym=find(amon == mm);
       aqsss(mym)=aqsss(mym)-sclim(mm);
       mym=find(smon == mm);
       smapts(mym)=smapts(mym)-sclim(mm);
   end
   
   figure(1)
   clf
   plot(1:12,sclim)
   set(gca,'FontSize',24)
   xlabel('Month')
   ylabel('S (ppt)')
   title('Climatology: Aquarius/SMAP')
   saveas(gcf,strcat('~/Box Sync/PalmyraFieldwork/plots/salinityclim_aquariussmap',datestr(tcstrt),'-',datestr(tcend),'.fig'),'fig');
end

%cols={'b','k','r','m','g'};
cols=[0 0.4470 0.7410;
    0.8500 0.3250 0.0980;
    0.9290 0.6940 0.1250;
    0.4940 0.1840 0.5560;
    0.4660 0.6740 0.1880];
figure(1)
clf
for dd=1:length(sites)
    plot(tarr_dy,sal_daily(dd,:),'Color',cols(dd,:),'LineWidth',2)
    hold all
end
set(gca,'FontSize',24)
title('Salinity data: Palmyra')
ylabel('S (ppt)')
legend(sites)


rt4=find(SITE == 'RT4');
plot(datenum(DATE(rt4)),SALINITYPSU(rt4),'o','MarkerSize',13,'MarkerEdgeColor',cols(1,:),'MarkerFaceColor',cols(1,:))
ch1=find(SITE == 'CH1');
plot(datenum(DATE(ch1)),SALINITYPSU(ch1),'h','MarkerSize',13,'MarkerEdgeColor',cols(2,:),'MarkerFaceColor',cols(2,:))
fr7=find(SITE == 'FR7' | SITE == 'FR7S');
plot(datenum(DATE(fr7)),SALINITYPSU(fr7),'s','MarkerSize',13,'MarkerEdgeColor',cols(3,:),'MarkerFaceColor',cols(3,:))
fr5=find(SITE == 'FR5');
plot(datenum(DATE(fr5)),SALINITYPSU(fr5),'^','MarkerSize',13,'MarkerEdgeColor',cols(4,:),'MarkerFaceColor',cols(4,:))
fr9=find(SITE == 'FR9');
plot(datenum(DATE(fr9)),SALINITYPSU(fr9),'d','MarkerSize',13,'MarkerEdgeColor',cols(5,:),'MarkerFaceColor',cols(5,:))
% rw=find(SITE == 'RW');
% plot(datenum(DATE(rw)),SALINITYPSU(rw),'>','MarkerSize',7,'MarkerEdgeColor','k','MarkerFaceColor','k') % Ripple Wharf: in lagoon
str=find(SITE == 'STR' | SITE == 'STRo');
plot(datenum(DATE(str)),SALINITYPSU(str),'<','MarkerSize',13,'MarkerEdgeColor','k','MarkerFaceColor','k')
plot(aqtime,aqsss,'--','Color','k','LineWidth',3)
plot(time,smapts,'Color','k','LineWidth',3)
legend({'RT4','CH1','FR7','FR5','FR9','RT4','CH1','FR7','FR5','FR9','STR','Aquarius','SMAP'})
xlim([datenum(2014,8,15) datenum(2017,6,15)])
datetick('x','mmm-yy','keeplimits')

if climsub == 1
    saveas(gcf,'~/Box Sync/PalmyraFieldwork/plots/salinityanom_sbebottles_wsatellite.fig','fig');
else
    saveas(gcf,'~/Box Sync/PalmyraFieldwork/plots/salinity_sbebottles_wsatellite.fig','fig');
end


% Calculate the *anomalous* d18O budget in the isoROMS data assimilation experiment,
% store results for later plotting
% August 2020
% Sam Stevenson

%%%%%%%% Parameters
tstart=datenum(2013,1,1);
tstop=datenum(2018,12,31);
datevec(tstart)
datevec(tstop)

refz=10;        % Reference depth, m
thr=0.2;        % Threshold value (difference relative to reference) for MLD
flag=1;         % Flag: does the field used for MLD calculation increase or decrease with depth? 0 = increase, 1 = decrease
                % 1 is appropriate for a temperature-based threshold
maxz=1;
mlddepth=16;
regbox=[-24,11,120,280];
monavg=0;       % Save monthly averages of budget terms? 1 = yes, 0 = no

%%%%%%%% Grid and data files
pacgrd='/glade/u/home/samantha/ROMSgrids/pacific_grid_S15reprN30.nc';
% frcdirpac='/glade/scratch/samantha/ROMSruns_v36_apr16/isonlmF_N30/';
frcdirpac='/glade/campaign/univ/ucsb0006/ROMSassim/w4d_frinkiac/w4d_2013-2017/output/';
nums=linspace(23855,25367,57);
nums=[nums(1:35) nums(37:end)]; % 24800 missing for some reason

%%%%%%%% Read in coordinate information
pacg=grid_read(pacgrd);
[pacz,paczw]=grid_depth(pacg,'r');   
zsz=size(pacz,1);
pacz=pacz(maxz:end,:,:)*-1; 
paczw=paczw(maxz:end,:,:)*-1;

% rho points
lat=pacg.latr;
lon=pacg.lonr;
mylatr=find(lat(:,100) >= regbox(1) & lat(:,100) <= regbox(2));
mylonr=find(lon(100,:) >= regbox(3) & lon(100,:) <= regbox(4));

paclon=lon(mylatr,mylonr);
paclat=lat(mylatr,mylonr);
pacmaskr=pacg.maskr(mylatr,mylonr);
paczr=pacz(:,mylatr,mylonr);

% u points
lat=pacg.latu;
lon=pacg.lonu;
mylatu=find(lat(:,100) >= regbox(1) & lat(:,100) <= regbox(2));
mylonu=find(lon(100,:) >= regbox(3) & lon(100,:) <= regbox(4));
paclonu=lon(mylatu,mylonu);
paclatu=lat(mylatu,mylonu);
pacmasku=pacg.masku(mylatu,mylonu);
paczu=pacz(:,mylatu,mylonu);

% v points
lat=pacg.latv;
lon=pacg.lonv;
mylatv=find(lat(:,100) >= regbox(1) & lat(:,100) <= regbox(2));
mylonv=find(lon(100,:) >= regbox(3) & lon(100,:) <= regbox(4));
paclonv=lon(mylatv,mylonv);
paclatv=lat(mylatv,mylonv);
pacmaskv=pacg.maskv(mylatv,mylonv);
paczv=pacz(:,mylatv,mylonv);


%%%%%%%% Read in time array and other data


timearr=[];
uvelarr=[];
vvelarr=[];
O16arr=[];
O18arr=[];
flxO16arr=[];
flxO18arr=[];

for ff=2:2:length(nums)-1
    % Read in two files at a time to capture the overlapping period    
    file=strcat(frcdirpac,'Uavg_',num2str(nums(ff)),'.nc')
    utmp=squeeze(nc_varget(file,'u',[0 0 min(mylatr)-1 min(mylonr)-2],[-1 -1 length(mylatr) length(mylonr)]));
    file=strcat(frcdirpac,'Vavg_',num2str(nums(ff)),'.nc')
    vtmp=squeeze(nc_varget(file,'v',[0 0 min(mylatr)-1 min(mylonr)-2],[-1 -1 length(mylatr) length(mylonr)]));
    file=strcat(frcdirpac,'Oavg_',num2str(nums(ff)),'.nc')
    O16tmp=squeeze(nc_varget(file,'O16',[0 0 min(mylatr)-1 min(mylonr)-2],[-1 -1 length(mylatr) length(mylonr)]));
    O18tmp=squeeze(nc_varget(file,'O18',[0 0 min(mylatr)-1 min(mylonr)-2],[-1 -1 length(mylatr) length(mylonr)]));
    file=strcat(frcdirpac,'O16fluxavg_',num2str(nums(ff)),'.nc')
    f16tmp=squeeze(nc_varget(file,'O16_sflux',[0 min(mylatr)-1 min(mylonr)-2],[-1 length(mylatr) length(mylonr)]));
    file=strcat(frcdirpac,'O18fluxavg_',num2str(nums(ff)),'.nc')
    f18tmp=squeeze(nc_varget(file,'O18_sflux',[0 min(mylatr)-1 min(mylonr)-2],[-1 length(mylatr) length(mylonr)]));
    timetmp=nc_varget(file,'ocean_time');

    file=strcat(frcdirpac,'Uavg_',num2str(nums(ff+1)),'.nc')
    utmp2=squeeze(nc_varget(file,'u',[0 0 min(mylatr)-1 min(mylonr)-2],[-1 -1 length(mylatr) length(mylonr)]));
    file=strcat(frcdirpac,'Vavg_',num2str(nums(ff+1)),'.nc')
    vtmp2=squeeze(nc_varget(file,'v',[0 0 min(mylatr)-1 min(mylonr)-2],[-1 -1 length(mylatr) length(mylonr)]));
    file=strcat(frcdirpac,'Oavg_',num2str(nums(ff+1)),'.nc')
    O16tmp2=squeeze(nc_varget(file,'O16',[0 0 min(mylatr)-1 min(mylonr)-2],[-1 -1 length(mylatr) length(mylonr)]));
    O18tmp2=squeeze(nc_varget(file,'O18',[0 0 min(mylatr)-1 min(mylonr)-2],[-1 -1 length(mylatr) length(mylonr)]));
    file=strcat(frcdirpac,'O16fluxavg_',num2str(nums(ff+1)),'.nc')
    f16tmp2=squeeze(nc_varget(file,'O16_sflux',[0 min(mylatr)-1 min(mylonr)-2],[-1 length(mylatr) length(mylonr)]));
    file=strcat(frcdirpac,'O18fluxavg_',num2str(nums(ff+1)),'.nc')
    f18tmp2=squeeze(nc_varget(file,'O18_sflux',[0 min(mylatr)-1 min(mylonr)-2],[-1 length(mylatr) length(mylonr)]));
    timetmp2=nc_varget(file,'ocean_time');  

    % Get locations of the overlapping period in both arrays
    [~,if1,if2]=intersect(timetmp,timetmp2);

    % Perform blending
    newtim=unique(cat(1,timetmp,timetmp2));
    newutmp=zeros(length(newtim),size(utmp2,2),size(utmp2,3),size(utmp2,4));
    newvtmp=zeros(length(newtim),size(vtmp2,2),size(vtmp2,3),size(vtmp2,4));
    newO16tmp=zeros(length(newtim),size(O16tmp2,2),size(O16tmp2,3),size(O16tmp2,4));
    newO18tmp=zeros(length(newtim),size(O18tmp2,2),size(O18tmp2,3),size(O18tmp2,4));
    newf16tmp=zeros(length(newtim),size(f16tmp2,2),size(f16tmp2,3));
    newf18tmp=zeros(length(newtim),size(f18tmp2,2),size(f18tmp2,3));

    newutmp(1:length(timetmp)-length(if1)-1,:,:,:)=utmp(1:(end-length(if1)-1),:,:,:);
    newutmp(length(timetmp)-length(if1),:,:,:)=0.8*utmp(length(timetmp)-length(if1),:,:,:)+0.2*utmp2(1,:,:,:);
    newutmp(length(timetmp)-length(if1)+1,:,:,:)=0.6*utmp(length(timetmp)-length(if1)+1,:,:,:)+0.4*utmp2(2,:,:,:);
    newutmp(length(timetmp)-length(if1)+2,:,:,:)=0.4*utmp(length(timetmp)-length(if1)+2,:,:,:)+0.6*utmp2(3,:,:,:);
    newutmp(length(timetmp)-length(if1)+3,:,:,:)=0.2*utmp(length(timetmp)-length(if1)+2,:,:,:)+0.8*utmp2(4,:,:,:);
    newutmp(length(timetmp)-length(if1)+4:end,:,:,:)=utmp2(4:end,:,:,:);

    newvtmp(1:length(timetmp)-length(if1)-1,:,:,:)=vtmp(1:(end-length(if1)-1),:,:,:);
    newvtmp(length(timetmp)-length(if1),:,:,:)=0.8*vtmp(length(timetmp)-length(if1),:,:,:)+0.2*vtmp2(1,:,:,:);
    newvtmp(length(timetmp)-length(if1)+1,:,:,:)=0.6*vtmp(length(timetmp)-length(if1)+1,:,:,:)+0.4*vtmp2(2,:,:,:);
    newvtmp(length(timetmp)-length(if1)+2,:,:,:)=0.4*vtmp(length(timetmp)-length(if1)+2,:,:,:)+0.6*vtmp2(3,:,:,:);
    newvtmp(length(timetmp)-length(if1)+3,:,:,:)=0.2*vtmp(length(timetmp)-length(if1)+2,:,:,:)+0.8*vtmp2(4,:,:,:);
    newvtmp(length(timetmp)-length(if1)+4:end,:,:,:)=vtmp2(4:end,:,:,:);
        
    newO16tmp(1:length(timetmp)-length(if1)-1,:,:,:)=O16tmp(1:(end-length(if1)-1),:,:,:);
    newO16tmp(length(timetmp)-length(if1),:,:,:)=0.8*O16tmp(length(timetmp)-length(if1),:,:,:)+0.2*O16tmp2(1,:,:,:);
    newO16tmp(length(timetmp)-length(if1)+1,:,:,:)=0.6*O16tmp(length(timetmp)-length(if1)+1,:,:,:)+0.4*O16tmp2(2,:,:,:);
    newO16tmp(length(timetmp)-length(if1)+2,:,:,:)=0.4*O16tmp(length(timetmp)-length(if1)+2,:,:,:)+0.6*O16tmp2(3,:,:,:);
    newO16tmp(length(timetmp)-length(if1)+3,:,:,:)=0.2*O16tmp(length(timetmp)-length(if1)+2,:,:,:)+0.8*O16tmp2(4,:,:,:);
    newO16tmp(length(timetmp)-length(if1)+4:end,:,:,:)=O16tmp2(4:end,:,:,:);

    newO18tmp(1:length(timetmp)-length(if1)-1,:,:,:)=O18tmp(1:(end-length(if1)-1),:,:,:);
    newO18tmp(length(timetmp)-length(if1),:,:,:)=0.8*O18tmp(length(timetmp)-length(if1),:,:,:)+0.2*O18tmp2(1,:,:,:);
    newO18tmp(length(timetmp)-length(if1)+1,:,:,:)=0.6*O18tmp(length(timetmp)-length(if1)+1,:,:,:)+0.4*O18tmp2(2,:,:,:);
    newO18tmp(length(timetmp)-length(if1)+2,:,:,:)=0.4*O18tmp(length(timetmp)-length(if1)+2,:,:,:)+0.6*O18tmp2(3,:,:,:);
    newO18tmp(length(timetmp)-length(if1)+3,:,:,:)=0.2*O18tmp(length(timetmp)-length(if1)+2,:,:,:)+0.8*O18tmp2(4,:,:,:);
    newO18tmp(length(timetmp)-length(if1)+4:end,:,:,:)=O18tmp2(4:end,:,:,:);

    newf16tmp(1:length(timetmp)-length(if1)-1,:,:)=f16tmp(1:(end-length(if1)-1),:,:);
    newf16tmp(length(timetmp)-length(if1),:,:)=0.8*f16tmp(length(timetmp)-length(if1),:,:)+0.2*f16tmp2(1,:,:);
    newf16tmp(length(timetmp)-length(if1)+1,:,:)=0.6*f16tmp(length(timetmp)-length(if1)+1,:,:)+0.4*f16tmp2(2,:,:);
    newf16tmp(length(timetmp)-length(if1)+2,:,:)=0.4*f16tmp(length(timetmp)-length(if1)+2,:,:)+0.6*f16tmp2(3,:,:);
    newf16tmp(length(timetmp)-length(if1)+3,:,:)=0.2*f16tmp(length(timetmp)-length(if1)+2,:,:)+0.8*f16tmp2(4,:,:);
    newf16tmp(length(timetmp)-length(if1)+4:end,:,:)=f16tmp2(4:end,:,:);

    newf18tmp(1:length(timetmp)-length(if1)-1,:,:)=f18tmp(1:(end-length(if1)-1),:,:);
    newf18tmp(length(timetmp)-length(if1),:,:)=0.8*f18tmp(length(timetmp)-length(if1),:,:)+0.2*f18tmp2(1,:,:);
    newf18tmp(length(timetmp)-length(if1)+1,:,:)=0.6*f18tmp(length(timetmp)-length(if1)+1,:,:)+0.4*f18tmp2(2,:,:);
    newf18tmp(length(timetmp)-length(if1)+2,:,:)=0.4*f18tmp(length(timetmp)-length(if1)+2,:,:)+0.6*f18tmp2(3,:,:);
    newf18tmp(length(timetmp)-length(if1)+3,:,:)=0.2*f18tmp(length(timetmp)-length(if1)+2,:,:)+0.8*f18tmp2(4,:,:);
    newf18tmp(length(timetmp)-length(if1)+4:end,:,:)=f18tmp2(4:end,:,:);
    
    % Add to full array
    timearr=cat(1,timearr,newtim);
    uvelarr=cat(1,uvelarr,newutmp);   
    vvelarr=cat(1,vvelarr,newvtmp);   
    O16arr=cat(1,O16arr,newO16tmp);
    O18arr=cat(1,O18arr,newO18tmp);
    flxO16arr=cat(1,flxO16arr,newf16tmp);
    flxO18arr=cat(1,flxO18arr,newf18tmp);
end

% file=strcat(frcdirpac,'Uavg_1948-2009.nc');
% timearr=nc_varget(file,'ocean_time');
% 
timearr=timearr/86400+datenum(1948,1,15);   % seconds since 1948-1-15);
mytpac=find(timearr >= tstart & timearr <= tstop);
[yr,mon,~]=datevec(timearr(mytpac));
timearr=timearr(mytpac);
% 
% uvelarr=squeeze(nc_varget(file,'u',[min(mytpac)-1 maxz min(mylatr)-1 min(mylonr)-2],[length(mytpac) zsz-maxz length(mylatr) length(mylonr)]));
% file=strcat(frcdirpac,'Vavg_1948-2009.nc');
% vvelarr=squeeze(nc_varget(file,'v',[min(mytpac)-1 maxz min(mylatr)-1 min(mylonr)-2],[length(mytpac) zsz-maxz length(mylatr) length(mylonr)]));
% file=strcat(frcdirpac,'d18O_1948-2009.nc');
% O16arr=squeeze(nc_varget(file,'O16',[min(mytpac)-1 maxz min(mylatr)-1 min(mylonr)-2],[length(mytpac) zsz-maxz length(mylatr) length(mylonr)]));
% O18arr=squeeze(nc_varget(file,'O18',[min(mytpac)-1 maxz min(mylatr)-1 min(mylonr)-2],[length(mytpac) zsz-maxz length(mylatr) length(mylonr)]));


% Make dimensions match
%vvelarr=cat(3,vvelarr,vvelarr(:,:,end,:));
%uvelarr=cat(4,uvelarr,uvelarr(:,:,:,end));
    
% Compute upper-layer average values for budget computations
mld=zeros(size(O16arr,1),size(O16arr,3),size(O16arr,4))+mlddepth;

O16mld=mldavg_varytime(mld,O16arr,timearr,paczr);
O18mld=mldavg_varytime(mld,O18arr,timearr,paczr);
umld=mldavg_varytime(mld,uvelarr,timearr,paczr);
vmld=mldavg_varytime(mld,vvelarr,timearr,paczr);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Use Reynolds decomposition version of the horizontal advection formulation
% NB: "mean" is a repeating 12-month climatology for all budget terms
%umdSmdx,updSmdx,umdSpdx,updSpdx,vmdSmdy,vpdSmdy,vmdSpdy,vpdSpdy,dSpdt,mnupdSpdx,mnvpdSpdy
[umdO16mdx,updO16mdx,umdO16pdx,updO16pdx,vmdO16mdy,vpdO16mdy,vmdO16pdy,vpdO16pdy,dO16dt,mnupdO16pdx,mnvpdO16pdy]=advection_ml_rd(O16mld,umld,vmld,paclat,paclon,timearr,yr,mon,[min(yr),max(yr)]);
[umdO18mdx,updO18mdx,umdO18pdx,updO18pdx,vmdO18mdy,vpdO18mdy,vmdO18pdy,vpdO18pdy,dO18dt,mnupdO18pdx,mnvpdO18pdy]=advection_ml_rd(O18mld,umld,vmld,paclat,paclon,timearr,yr,mon,[min(yr),max(yr)]);
%%%%%%%% Calculate terms in isotopic ratio budget from individual
%%%%%%%% isotopologue budgets
Riso=O18mld./O16mld;
anomzadvmngrad=(1./O16mld).*(updO18mdx - Riso.*updO16mdx);
mnzadvanomgrad=(1./O16mld).*(umdO18pdx - Riso.*umdO16pdx);
anomzadvanomgrad=(1./O16mld).*(updO18pdx - Riso.*updO16pdx);
anommadvmngrad=(1./O16mld).*(vpdO18mdy - Riso.*vpdO16mdy);
mnmadvanomgrad=(1./O16mld).*(vmdO18pdy - Riso.*vmdO16pdy);
anommadvanomgrad=(1./O16mld).*(vpdO18pdy - Riso.*vpdO16pdy);
mn_anomzadvanomgrad=(1./O16mld).*(mnupdO18pdx - Riso.*mnupdO16pdx);
mn_anommadvanomgrad=(1./O16mld).*(mnvpdO18pdy - Riso.*mnvpdO16pdy);
dRdt=(1./O16mld).*(dO18dt - Riso.*dO16dt);

if monavg == 1
    % Number of unique month/year combinations
    len=0;
    uyrs=unique(yr);
    for yy=1:length(uyrs)
       mons=length(unique(mon(find(yr == uyrs(yy))))); 
       len=len+mons;
    end

    tavg=zeros(len,1);
    tt=0;
    dRdtavg=zeros(len,size(mnzadvanomgrad,2),size(mnzadvanomgrad,3));
    Ravg=zeros(len,size(mnzadvanomgrad,2),size(mnzadvanomgrad,3));
    O16avg=zeros(len,size(mnzadvanomgrad,2),size(mnzadvanomgrad,3));
    O18avg=zeros(len,size(mnzadvanomgrad,2),size(mnzadvanomgrad,3));
    mnzadvanomgradavg=zeros(len,size(mnzadvanomgrad,2),size(mnzadvanomgrad,3));
    anomzadvmngradavg=zeros(len,size(mnzadvanomgrad,2),size(mnzadvanomgrad,3));
    anomzadvanomgradavg=zeros(len,size(mnzadvanomgrad,2),size(mnzadvanomgrad,3));
    anommadvmngradavg=zeros(len,size(mnzadvanomgrad,2),size(mnzadvanomgrad,3));
    mnmadvanomgradavg=zeros(len,size(mnzadvanomgrad,2),size(mnzadvanomgrad,3));
    anommadvanomgradavg=zeros(len,size(mnzadvanomgrad,2),size(mnzadvanomgrad,3));
    mn_anomzadvanomgradavg=zeros(len,size(mnzadvanomgrad,2),size(mnzadvanomgrad,3));
    mn_anommadvanomgradavg=zeros(len,size(mnzadvanomgrad,2),size(mnzadvanomgrad,3));


    for yy=1:length(uyrs)
        mons=unique(mon(find(yr == uyrs(yy))));     % all months that exist during this year
        for mm=1:length(mons)
            tt=tt+1;
            times=find(yr == uyrs(yy) & mon == mons(mm));
            tavg(tt)=nanmean(timearr(times));

            dRdtavg(tt,:,:)=nanmean(dRdt(times,:,:),1);
            Ravg(tt,:,:)=nanmean(Riso(times,:,:),1);
            O16avg(tt,:,:)=nanmean(O16mld(times,:,:),1);
            O18avg(tt,:,:)=nanmean(O18mld(times,:,:),1);
            mnzadvanomgradavg(tt,:,:)=nanmean(mnzadvanomgrad(times,:,:),1);
            mnmadvanomgradavg(tt,:,:)=nanmean(mnmadvanomgrad(times,:,:),1);
            anomzadvmngradavg(tt,:,:)=nanmean(anomzadvmngrad(times,:,:),1);
            anommadvmngradavg(tt,:,:)=nanmean(anommadvmngrad(times,:,:),1);
            anomzadvanomgradavg(tt,:,:)=nanmean(anomzadvanomgrad(times,:,:),1);
            anommadvanomgradavg(tt,:,:)=nanmean(anommadvanomgrad(times,:,:),1);
            mn_anomzadvanomgradavg(tt,:,:)=nanmean(mn_anomzadvanomgrad(times,:,:),1);
            mn_anommadvanomgradavg(tt,:,:)=nanmean(mn_anommadvanomgrad(times,:,:),1);
        end
    end
    dRdt=dRdtavg;
else
    tavg=timearr;
    dRdtavg=dRdt;
    Ravg=Riso;
    O16avg=O16mld;
    O18avg=O18mld;
    mnzadvanomgradavg=mnzadvanomgrad;
    anomzadvmngradavg=anomzadvmngrad;
    anomzadvanomgradavg=anomzadvanomgrad;
    anommadvmngradavg=anommadvmngrad;
    mnmadvanomgradavg=mnmadvanomgrad;
    anommadvanomgradavg=anommadvanomgrad;
    mn_anomzadvanomgradavg=mn_anomzadvanomgrad;
    mn_anommadvanomgradavg=mn_anommadvanomgrad;    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dRdt(dRdt == 0 | abs(dRdt) > 1e10)=0/0;

%%%%%%%% Calculate flux term in budget
% Monthly average of isotopic fluxes
uyrs=unique(yr);

    
% Use anomalous fluxes
flxO16arr=subtractclim(timearr,flxO16arr);
flxO18arr=subtractclim(timearr,flxO18arr);

if monavg == 1
    % Number of unique month/year combinations
    len=0;
    for yy=1:length(uyrs)
       mons=length(unique(mon(find(yr == uyrs(yy))))); 
       len=len+mons;
    end

    flxO16avg=zeros(len,size(flxO16arr,2),size(flxO16arr,3));
    flxO18avg=zeros(len,size(flxO16arr,2),size(flxO16arr,3));
    tt=0;
    for yy=1:length(uyrs)
        mons=unique(mon(find(yr == uyrs(yy))));     % all months that exist during this year
        for mm=1:length(mons)
            tt=tt+1;
            times=find(yr == uyrs(yy) & mon == mons(mm));

            flxO16avg(tt,:,:,:)=nanmean(flxO16arr(times,:,:,:),1);
            flxO18avg(tt,:,:,:)=nanmean(flxO18arr(times,:,:,:),1);
        end
    end
else
    flxO16avg=flxO16arr;
    flxO18avg=flxO18arr;
end

flxO16avg=flxO16avg./mlddepth;
flxO18avg=flxO18avg./mlddepth;

Rflux=(1./O16avg).*(flxO18avg-Ravg.*flxO16avg);
Rflux(abs(Rflux) > 1e10)=0/0;

%%%%%%%% Save results
paclatr=paclat;
paclonr=paclon;
save(strcat(frcdirpac,'/isoratiobudget_rd_mld',num2str(mlddepth),'m_',datestr(tstart),'-',datestr(tstop),'isoROMSassim_highfreq.mat'),'mlddepth','dRdt', ...
    'mnzadvanomgradavg','mnmadvanomgradavg','anomzadvmngradavg','anommadvmngradavg','anomzadvanomgradavg','anommadvanomgradavg','mn_anomzadvanomgradavg', ...
    'mn_anommadvanomgradavg','Rflux','tavg','paczr','paczu','paczv','paclatr','paclonr')
% save(strcat(frcdirpac,'/isoratiobudget_rd_mld',num2str(mlddepth),'m_',datestr(tstart),'-',datestr(tstop),'_isonlmF-N30.mat'),'mlddepth','dRdt', ...
%     'mnzadvanomgradavg','mnmadvanomgradavg','anomzadvmngradavg','anommadvmngradavg','anomzadvanomgradavg','anommadvanomgradavg','mn_anomzadvanomgradavg', ...
%     'mn_anommadvanomgradavg','Rflux','tavg','paczr','paczu','paczv','paclatr','paclonr')


% Make anomaly maps of SST, SSS, d18O from the isoROMS data assimilation
% experiment, look at controls on coral and seawater d18O
% September 2019
% Sam Stevenson

% ROMS parameters
dir='/glade/campaign/univ/ucsb0006/ROMSassim/w4d_frinkiac/w4d_2013-2017/output/';
d18Odir='/glade/campaign/univ/ucsb0006/ROMSassim/w4d_frinkiac/w4d_2013-2017/output/';
nums=linspace(23855,25367,57);
nums=[nums(1:35) nums(37:end)]; % 24800 missing for some reason
%nums1=linspace(23855,25367,57);
regbox=[-24,12,130,280];
enyrs=[2015,2016];       % El Nino years (January during DJF of event peak)
climsub=1;

% proxynames={'Christmas','Palmyra'};
% proxylats=[1.8667,5.8667];   
% proxylons=[202.6,197.8667];
proxynames={'Palmyra'};
proxylats=[5.8667];   
proxylons=[197.8667];


pacg=grid_read('/glade/u/home/samantha/ROMSgrids/pacific_grid_S15reprN30.nc');
pacz=grid_depth(pacg,'r')*-1;
                                
paclat=pacg.latr;
paclon=pacg.lonr;
mylatr=find(paclat(:,100) >= regbox(1) & paclat(:,100) <= regbox(2));
mylonr=find(paclon(100,:) >= regbox(3) & paclon(100,:) <= regbox(4));
paclon=paclon(mylatr,mylonr);
paclat=paclat(mylatr,mylonr);
pacmaskr=pacg.maskr(mylatr,mylonr);

timearr=[];
temparr=[];
saltarr=[];
d18Oarr=[];

for ff=2:2:length(nums)-1
    % Read in two files at a time to capture the overlapping period    
    file=strcat(dir,'Tavg_',num2str(nums(ff)),'.nc')
    tmp=squeeze(nc_varget(file,'temp',[0 29 min(mylatr)-1 min(mylonr)-1],[-1 1 length(mylatr) length(mylonr)]));
    file=strcat(dir,'Savg_',num2str(nums(ff)),'.nc')
    stmp=squeeze(nc_varget(file,'salt',[0 29 min(mylatr)-1 min(mylonr)-1],[-1 1 length(mylatr) length(mylonr)]));
    file=strcat(dir,'d18O_',num2str(nums(ff)),'.nc')
    dtmp=squeeze(nc_varget(file,'d18O',[0 29 min(mylatr)-1 min(mylonr)-1],[-1 1 length(mylatr) length(mylonr)]));
    timetmp=nc_varget(file,'ocean_time');

    file=strcat(dir,'Tavg_',num2str(nums(ff+1)),'.nc')
    tmp2=squeeze(nc_varget(file,'temp',[0 29 min(mylatr)-1 min(mylonr)-1],[-1 1 length(mylatr) length(mylonr)]));
    file=strcat(dir,'Savg_',num2str(nums(ff+1)),'.nc')
    stmp2=squeeze(nc_varget(file,'salt',[0 29 min(mylatr)-1 min(mylonr)-1],[-1 1 length(mylatr) length(mylonr)]));
    file=strcat(dir,'d18O_',num2str(nums(ff+1)),'.nc')
    dtmp2=squeeze(nc_varget(file,'d18O',[0 29 min(mylatr)-1 min(mylonr)-1],[-1 1 length(mylatr) length(mylonr)]));
    timetmp2=nc_varget(file,'ocean_time');  

    % Get locations of the overlapping period in both arrays
    [~,if1,if2]=intersect(timetmp,timetmp2);

    % Perform blending
    newtim=unique(cat(1,timetmp,timetmp2));
    newtmp=zeros(length(newtim),size(tmp2,2),size(tmp2,3));
    newstmp=zeros(length(newtim),size(stmp2,2),size(stmp2,3));
    newdtmp=zeros(length(newtim),size(tmp2,2),size(tmp2,3));

    newtmp(1:length(timetmp)-length(if1)-1,:,:)=tmp(1:(end-length(if1)-1),:,:);
    newtmp(length(timetmp)-length(if1),:,:)=0.8*tmp(length(timetmp)-length(if1),:,:)+0.2*tmp2(1,:,:);
    newtmp(length(timetmp)-length(if1)+1,:,:)=0.6*tmp(length(timetmp)-length(if1)+1,:,:)+0.4*tmp2(2,:,:);
    newtmp(length(timetmp)-length(if1)+2,:,:)=0.4*tmp(length(timetmp)-length(if1)+2,:,:)+0.6*tmp2(3,:,:);
    newtmp(length(timetmp)-length(if1)+3,:,:)=0.2*tmp(length(timetmp)-length(if1)+2,:,:)+0.8*tmp2(4,:,:);
    newtmp(length(timetmp)-length(if1)+4:end,:,:)=tmp2(4:end,:,:);

    newstmp(1:length(timetmp)-length(if1)-1,:,:)=stmp(1:(end-length(if1)-1),:,:);
    newstmp(length(timetmp)-length(if1),:,:)=0.8*stmp(length(timetmp)-length(if1),:,:)+0.2*stmp2(1,:,:);
    newstmp(length(timetmp)-length(if1)+1,:,:)=0.6*stmp(length(timetmp)-length(if1)+1,:,:)+0.4*stmp2(2,:,:);
    newstmp(length(timetmp)-length(if1)+2,:,:)=0.4*stmp(length(timetmp)-length(if1)+2,:,:)+0.6*stmp2(3,:,:);
    newstmp(length(timetmp)-length(if1)+3,:,:)=0.2*stmp(length(timetmp)-length(if1)+2,:,:)+0.8*stmp2(4,:,:);
    newstmp(length(timetmp)-length(if1)+4:end,:,:)=stmp2(4:end,:,:);
    
    newdtmp(1:length(timetmp)-length(if1)-1,:,:)=dtmp(1:(end-length(if1)-1),:,:);
    newdtmp(length(timetmp)-length(if1),:,:)=0.8*dtmp(length(timetmp)-length(if1),:,:)+0.2*dtmp2(1,:,:);
    newdtmp(length(timetmp)-length(if1)+1,:,:)=0.6*dtmp(length(timetmp)-length(if1)+1,:,:)+0.4*dtmp2(2,:,:);
    newdtmp(length(timetmp)-length(if1)+2,:,:)=0.4*dtmp(length(timetmp)-length(if1)+2,:,:)+0.6*dtmp2(3,:,:);
    newdtmp(length(timetmp)-length(if1)+3,:,:)=0.2*dtmp(length(timetmp)-length(if1)+2,:,:)+0.8*dtmp2(4,:,:);
    newdtmp(length(timetmp)-length(if1)+4:end,:,:)=dtmp2(4:end,:,:);
    
    
    % Add to full array
    timearr=cat(1,timearr,newtim);
    temparr=cat(1,temparr,newtmp);   
    saltarr=cat(1,saltarr,newstmp);   
    d18Oarr=cat(1,d18Oarr,newdtmp);
end
timearr=timearr/86400+datenum(1948,1,15);   % seconds since 1948-1-15);
[ayr,amon,~]=datevec(timearr);       % assimilation

if climsub == 1     % Subtract climatology?
    % % Read in data from free-running simulation
    % frcdirpac='/glade/scratch/samantha/ROMSruns_v36_apr16/isonlmF_N30/output/';
    % pacnct=netcdf(strcat(frcdirpac,'Tavg_1948-2009.nc'));
    % pacncs=netcdf(strcat(frcdirpac,'Savg_1948-2009.nc'));
    % pacnco=netcdf(strcat(frcdirpac,'d18O_1948-2009.nc'));
    % pacgrd='/glade/u/home/samantha/ROMSgrids/pacific_grid_S15reprN30.nc';
    % 
    % time=pacnct{'ocean_time'}(:)/86400+datenum(1948,1,15);     % seconds since 1948-1-15
    % mytpac=find(time >= tstart & time <= tstop);
    % time=time(mytpac);
    % [yr,mon,~]=datevec(time);
    % 
    % T=squeeze(pacnct{'temp'}(mytpac,end,mylatr,mylonr));
    % S=squeeze(pacncs{'salt'}(mytpac,end,mylatr,mylonr));
    % d18O=squeeze(pacnco{'d18O'}(mytpac,end,mylatr,mylonr));

    Tclim=zeros(12,length(mylatr),length(mylonr));
    Sclim=zeros(12,length(mylatr),length(mylonr));
    Oclim=zeros(12,length(mylatr),length(mylonr));

    for mm=1:12
    %    mym=find(mon == mm);
    %    Tclim(mm,:,:)=nanmean(T(mym,:,:),1);
    %    Sclim(mm,:,:)=nanmean(S(mym,:,:),1);
    %    Oclim(mm,:,:)=nanmean(d18O(mym,:,:),1);

       myma=find(amon == mm);
       Tclim(mm,:,:)=nanmean(temparr(myma,:,:),1);
       Sclim(mm,:,:)=nanmean(saltarr(myma,:,:),1);
       Oclim(mm,:,:)=nanmean(d18Oarr(myma,:,:),1);

       temparr(myma,:,:)=temparr(myma,:,:)-Tclim(mm,:,:);
       saltarr(myma,:,:)=saltarr(myma,:,:)-Sclim(mm,:,:);
       d18Oarr(myma,:,:)=d18Oarr(myma,:,:)-Oclim(mm,:,:);
    end
end

% Make composite maps
for yy=1:length(enyrs)
    mnO=zeros(3,length(mylatr),length(mylonr));
    mnOsw=zeros(3,length(mylatr),length(mylonr));
    mnT=zeros(3,length(mylatr),length(mylonr));
    mnS=zeros(3,length(mylatr),length(mylonr));

    for tt=1:3
        if tt == 1
            myt=find(timearr >= datenum(enyrs(yy)-1,7,1) & timearr <= datenum(enyrs(yy)-1,9,30));  % El Nino initiation
        end
        if tt == 2
            myt=find(timearr >= datenum(enyrs(yy)-1,11,1) & timearr < datenum(enyrs(yy),1,1));  % El Nino peak
        end
        if tt == 3
            myt=find(timearr >= datenum(enyrs(yy),3,1) & timearr <= datenum(enyrs(yy),5,31));  % El Nino termination         
        end
        
        mnO(tt,:,:)=nanmean(d18Oarr(myt,:,:)-0.2.*temparr(myt,:,:),1);
        mnOsw(tt,:,:)=nanmean(d18Oarr(myt,:,:),1);
        mnT(tt,:,:)=nanmean(temparr(myt,:,:),1);
        mnS(tt,:,:)=nanmean(saltarr(myt,:,:),1);
    end


    % Temperature
    figure(1)
    clf
    subplot('Position',[0.1 0.7 0.8 0.25])
    cla
    m_proj('mercator','lon',[regbox(3) regbox(4)],'lat',[regbox(1) regbox(2)]) 
    m_pcolor(paclon,paclat,squeeze(mnT(1,:,:)))
    m_grid('xaxis','bottom','tickdir','out','linewidth',3,'FontSize',24);
    shading flat
    colorbar
    caxis([-1 1]) 
    m_coast('color',[0 0 0])
    set(gca,'DataAspectRatio',[1 0.9 1])
    hold all
    m_plot(proxylons,proxylats,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',10)   % coral study sites
    hold all
    set(gcf,'renderer','painters')
    title('T anomaly: initiation','FontSize',24,'FontWeight','bold')

    subplot('Position',[0.1 0.4 0.8 0.25])
    cla
    m_proj('mercator','lon',[regbox(3) regbox(4)],'lat',[regbox(1) regbox(2)]) 
    m_pcolor(paclon,paclat,squeeze(mnT(2,:,:)))
    m_grid('xaxis','bottom','tickdir','out','linewidth',3,'FontSize',24);
    shading flat
    colorbar
    caxis([-1 1]) 
    m_coast('color',[0 0 0])
    set(gca,'DataAspectRatio',[1 0.9 1])
    hold all
    m_plot(proxylons,proxylats,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',10)   % coral study sites
    hold all
    set(gcf,'renderer','painters')
    title('T anomaly: peak','FontSize',24,'FontWeight','bold')

    subplot('Position',[0.1 0.1 0.8 0.25])
    cla
    m_proj('mercator','lon',[regbox(3) regbox(4)],'lat',[regbox(1) regbox(2)]) 
    m_pcolor(paclon,paclat,squeeze(mnT(3,:,:)))
    m_grid('xaxis','bottom','tickdir','out','linewidth',3,'FontSize',24);
    shading flat
    colorbar
    caxis([-1 1]) 
    m_coast('color',[0 0 0])
    set(gca,'DataAspectRatio',[1 0.9 1])
    hold all
    m_plot(proxylons,proxylats,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',10)   % coral study sites
    hold all
    set(gcf,'renderer','painters')
    title('T anomaly: termination','FontSize',24,'FontWeight','bold')
    if climsub == 0
        strcat(dir,'isoROMSassim_Tcomp_',num2str(enyrs(yy)-1),'-',num2str(enyrs(yy)),'elnino_abs.fig')
        saveas(gcf,strcat(dir,'isoROMSassim_Tcomp_',num2str(enyrs(yy)-1),'-',num2str(enyrs(yy)),'elnino_abs.fig'),'fig')
    else
        strcat(dir,'isoROMSassim_Tcomp_',num2str(enyrs(yy)-1),'-',num2str(enyrs(yy)),'elnino_assimclimo.fig')
        saveas(gcf,strcat(dir,'isoROMSassim_Tcomp_',num2str(enyrs(yy)-1),'-',num2str(enyrs(yy)),'elnino_assimclimo.fig'),'fig')
    end

    % Salinity
    figure(1)
    clf
    subplot('Position',[0.1 0.7 0.8 0.25])
    cla
    m_proj('mercator','lon',[regbox(3) regbox(4)],'lat',[regbox(1) regbox(2)]) 
    m_pcolor(paclon,paclat,squeeze(mnS(1,:,:)))
    m_grid('xaxis','bottom','tickdir','out','linewidth',3,'FontSize',24);
    shading flat
    colorbar
    caxis([-1 1]) 
    m_coast('color',[0 0 0])
    set(gca,'DataAspectRatio',[1 0.9 1])
    hold all
    m_plot(proxylons,proxylats,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',10)   % coral study sites
    hold all
    set(gcf,'renderer','painters')
    title('S anomaly: initiation','FontSize',24,'FontWeight','bold')

    subplot('Position',[0.1 0.4 0.8 0.25])
    cla
    m_proj('mercator','lon',[regbox(3) regbox(4)],'lat',[regbox(1) regbox(2)]) 
    m_pcolor(paclon,paclat,squeeze(mnS(2,:,:)))
    m_grid('xaxis','bottom','tickdir','out','linewidth',3,'FontSize',24);
    shading flat
    colorbar
    caxis([-1 1]) 
    m_coast('color',[0 0 0])
    set(gca,'DataAspectRatio',[1 0.9 1])
    hold all
    m_plot(proxylons,proxylats,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',10)   % coral study sites
    hold all
    set(gcf,'renderer','painters')
    title('S anomaly: peak','FontSize',24,'FontWeight','bold')

    subplot('Position',[0.1 0.1 0.8 0.25])
    cla
    m_proj('mercator','lon',[regbox(3) regbox(4)],'lat',[regbox(1) regbox(2)]) 
    m_pcolor(paclon,paclat,squeeze(mnS(3,:,:)))
    m_grid('xaxis','bottom','tickdir','out','linewidth',3,'FontSize',24);
    shading flat
    colorbar
    caxis([-1 1]) 
    m_coast('color',[0 0 0])
    set(gca,'DataAspectRatio',[1 0.9 1])
    hold all
    m_plot(proxylons,proxylats,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',10)   % coral study sites
    hold all
    set(gcf,'renderer','painters')
    title('S anomaly: termination','FontSize',24,'FontWeight','bold')
    if climsub == 0
        strcat(dir,'isoROMSassim_Scomp_',num2str(enyrs(yy)-1),'-',num2str(enyrs(yy)),'elnino_abs.fig')
        saveas(gcf,strcat(dir,'isoROMSassim_Scomp_',num2str(enyrs(yy)-1),'-',num2str(enyrs(yy)),'elnino_abs.fig'),'fig')
    else
        strcat(dir,'isoROMSassim_Scomp_',num2str(enyrs(yy)-1),'-',num2str(enyrs(yy)),'elnino_assimclimo.fig')
        saveas(gcf,strcat(dir,'isoROMSassim_Scomp_',num2str(enyrs(yy)-1),'-',num2str(enyrs(yy)),'elnino_assimclimo.fig'),'fig')
    end
    

    % Coral d18O
    figure(1)
    clf
    subplot('Position',[0.1 0.7 0.8 0.25])
    cla
    m_proj('mercator','lon',[regbox(3) regbox(4)],'lat',[regbox(1) regbox(2)]) 
    m_pcolor(paclon,paclat,squeeze(mnO(1,:,:)))
    m_grid('xaxis','bottom','tickdir','out','linewidth',3,'FontSize',24);
    shading flat
    colorbar
    caxis([-1 1]) 
    m_coast('color',[0 0 0])
    set(gca,'DataAspectRatio',[1 0.9 1])
    hold all
    m_plot(proxylons,proxylats,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',10)   % coral study sites
    hold all
    set(gcf,'renderer','painters')
    title('\delta^{18}O_{coral} anomaly: initiation','FontSize',24,'FontWeight','bold')

    subplot('Position',[0.1 0.4 0.8 0.25])
    cla
    m_proj('mercator','lon',[regbox(3) regbox(4)],'lat',[regbox(1) regbox(2)]) 
    m_pcolor(paclon,paclat,squeeze(mnO(2,:,:)))
    m_grid('xaxis','bottom','tickdir','out','linewidth',3,'FontSize',24);
    shading flat
    colorbar
    caxis([-1 1]) 
    m_coast('color',[0 0 0])
    set(gca,'DataAspectRatio',[1 0.9 1])
    hold all
    m_plot(proxylons,proxylats,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',10)   % coral study sites
    hold all
    set(gcf,'renderer','painters')
    title('\delta^{18}O_{coral} anomaly: peak','FontSize',24,'FontWeight','bold')

    subplot('Position',[0.1 0.1 0.8 0.25])
    cla
    m_proj('mercator','lon',[regbox(3) regbox(4)],'lat',[regbox(1) regbox(2)]) 
    m_pcolor(paclon,paclat,squeeze(mnO(3,:,:)))
    m_grid('xaxis','bottom','tickdir','out','linewidth',3,'FontSize',24);
    shading flat
    colorbar
    caxis([-1 1]) 
    m_coast('color',[0 0 0])
    set(gca,'DataAspectRatio',[1 0.9 1])
    hold all
    m_plot(proxylons,proxylats,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',10)   % coral study sites
    hold all
    set(gcf,'renderer','painters')
    title('\delta^{18}O_{coral} anomaly: termination','FontSize',24,'FontWeight','bold')
    if climsub == 0
        strcat(dir,'isoROMSassim_d18Ocoralcomp_',num2str(enyrs(yy)-1),'-',num2str(enyrs(yy)),'elnino_abs.fig')
        saveas(gcf,strcat(dir,'isoROMSassim_d18Ocoralcomp_',num2str(enyrs(yy)-1),'-',num2str(enyrs(yy)),'elnino_abs.fig'),'fig')
    else
        strcat(dir,'isoROMSassim_d18Ocoralcomp_',num2str(enyrs(yy)-1),'-',num2str(enyrs(yy)),'elnino_assimclimo.fig')
        saveas(gcf,strcat(dir,'isoROMSassim_d18Ocoralcomp_',num2str(enyrs(yy)-1),'-',num2str(enyrs(yy)),'elnino_assimclimo.fig'),'fig')
    end

    % Seawater d18O
    figure(1)
    clf
    subplot('Position',[0.1 0.7 0.8 0.25])
    cla
    m_proj('mercator','lon',[regbox(3) regbox(4)],'lat',[regbox(1) regbox(2)]) 
    m_pcolor(paclon,paclat,squeeze(mnOsw(1,:,:)))
    m_grid('xaxis','bottom','tickdir','out','linewidth',3,'FontSize',24);
    shading flat
    colorbar
    caxis([-1 1]) 
    m_coast('color',[0 0 0])
    set(gca,'DataAspectRatio',[1 0.9 1])
    hold all
    m_plot(proxylons,proxylats,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',10)   % coral study sites
    hold all
    set(gcf,'renderer','painters')
    title('\delta^{18}O_{sw} anomaly: initiation','FontSize',24,'FontWeight','bold')

    subplot('Position',[0.1 0.4 0.8 0.25])
    cla
    m_proj('mercator','lon',[regbox(3) regbox(4)],'lat',[regbox(1) regbox(2)]) 
    m_pcolor(paclon,paclat,squeeze(mnOsw(2,:,:)))
    m_grid('xaxis','bottom','tickdir','out','linewidth',3,'FontSize',24);
    shading flat
    colorbar
    caxis([-1 1]) 
    m_coast('color',[0 0 0])
    set(gca,'DataAspectRatio',[1 0.9 1])
    hold all
    m_plot(proxylons,proxylats,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',10)   % coral study sites
    hold all
    set(gcf,'renderer','painters')
    title('\delta^{18}O_{sw} anomaly: peak','FontSize',24,'FontWeight','bold')

    subplot('Position',[0.1 0.1 0.8 0.25])
    cla
    m_proj('mercator','lon',[regbox(3) regbox(4)],'lat',[regbox(1) regbox(2)]) 
    m_pcolor(paclon,paclat,squeeze(mnOsw(3,:,:)))
    m_grid('xaxis','bottom','tickdir','out','linewidth',3,'FontSize',24);
    shading flat
    colorbar
    caxis([-1 1]) 
    m_coast('color',[0 0 0])
    set(gca,'DataAspectRatio',[1 0.9 1])
    hold all
    m_plot(proxylons,proxylats,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',10)   % coral study sites
    hold all
    set(gcf,'renderer','painters')
    title('\delta^{18}O_{sw} anomaly: termination','FontSize',24,'FontWeight','bold')
    if climsub == 0
        strcat(dir,'isoROMSassim_d18Oswcomp_',num2str(enyrs(yy)-1),'-',num2str(enyrs(yy)),'elnino_abs.fig')
        saveas(gcf,strcat(dir,'isoROMSassim_d18Oswcomp_',num2str(enyrs(yy)-1),'-',num2str(enyrs(yy)),'elnino_abs.fig'),'fig')
    else
        strcat(dir,'isoROMSassim_d18Oswcomp_',num2str(enyrs(yy)-1),'-',num2str(enyrs(yy)),'elnino_assimclimo.fig')
        saveas(gcf,strcat(dir,'isoROMSassim_d18Oswcomp_',num2str(enyrs(yy)-1),'-',num2str(enyrs(yy)),'elnino_assimclimo.fig'),'fig')
    end

end

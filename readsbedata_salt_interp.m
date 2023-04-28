% Read in SBE salinity information from Palmyra
% June 2020
% Sam Stevenson

function [sites,tarr,datarr]=readsbedata_salt_interp

    sites={'RT4','CH1','FR7','FR5','FR9'};
    tarr=cell(length(sites),1);
    datarr=cell(length(sites),1);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % RT4 
    % first deployment all bad data, ignore that section
    
    % Second deployment
    load('~/Box Sync/PalmyraFieldwork/Data/August2015/SBE/SBE2978_RT4/SBE2978.mat')
    timert4=time2978;
    salrt4=sal2978;
    
    % Third deployment
    load('~/Box Sync/PalmyraFieldwork/Data/2015.08-2016.03/SBE37/SBE2144_RT4/SBE2144_RT4_1.mat')
    tmp=find(t >= datenum(2015,10,23,0,0,0) & t <= datenum(2015,10,23,23,59,59));
    t(tmp)=0/0;
    sal(tmp)=0/0;
    sal=sal(~isnan(t));
    t=t(~isnan(t));
    [~,ix]=sort(t,'ascend');
    
    timert4=cat(1,timert4,t(ix));
    salrt4=cat(1,salrt4,sal(ix));
    
    % Fourth deployment
    load('~/Box Sync/PalmyraFieldwork/Data/September_2016/SBE37/SBE2144_RT4/SBE37_2144_201609_RT4.mat')
    tmp=find(t2144 >= datenum(2016,4,1,12,0,0) & t2144 <= datenum(2016,4,26));
    t2144(tmp)=0/0;
    sal2144(tmp)=0/0;
    tmp=find(t2144 >= datenum(2016,7,10));
    t2144(tmp)=0/0;
    sal2144(tmp)=0/0;
    sal2144=sal2144(~isnan(t2144));
    t2144=t2144(~isnan(t2144));
    [~,ix]=sort(t2144,'ascend');
    timert4=cat(1,timert4,t2144(ix));
    salrt4=cat(1,salrt4,sal2144(ix));
    
    
    % Fifth and sixth deployments
    load('~/Box Sync/PalmyraFieldwork/Data/2016.09-2017.09/SBE37/SBE2977_RT4/SBE2977_RT4.mat')
    timert4=cat(1,timert4,time);
    salrt4=cat(1,salrt4,sal);
    
    % Get rid of dropouts
    tmp=find(abs(diff(salrt4)) > 0.5);
    salrt4(tmp)=0/0;
    salrt4(tmp+1)=0/0;
    
    tarr{1}=timert4;
    datarr{1}=salrt4;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % CH1
    load('~/Box Sync/PalmyraFieldwork/Data/2014.08-2015.03/SBE/SBE1940_CH1/SBE1940_sep2014_march2015.mat')
    % Bad data: first deployment
    sal1940=sal1940(2:85500);
    time1940=time1940(2:85500);
    load('~/Box Sync/PalmyraFieldwork/Data/August2015/SBE/SBE2144_CH1/SBE2144.mat')
    % Bad data: second deployment
    sal2144=sal2144(1:75800);
    time2144=time2144(1:75800);
    salch1=cat(1,sal1940,sal2144);
    timech1=cat(1,time1940,time2144');
    
    % Third deployment
    load('~/Box Sync/PalmyraFieldwork/Data/2015.08-2016.03/SBE37/SBE2977_CH1/SBE2977_CH1.mat')
    tmp=find(t <= datenum(2016,3,3,12,0,0));
    salch1=cat(1,salch1,sal(tmp));
    timech1=cat(1,timech1,t(tmp));
    
    % Fourth deployment: no data
    
    % Fifth and sixth deployments
    load('~/Box Sync/PalmyraFieldwork/Data/2016.09-2017.09/SBE37/SBE2980_CH1/SBE2980_CH1.mat')
    tmp=find(time >= datenum(2016,9,26,12,0,0));
    salch1=cat(1,salch1,sal(tmp));
    timech1=cat(1,timech1,time(tmp));
    
    % Get rid of dropouts
    tmp=find(abs(diff(salch1)) > 0.5);
    salch1(tmp)=0/0;
    salch1(tmp+1)=0/0;
    
    tarr{2}=timech1;
    datarr{2}=salch1;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % FR7    
    load('~/Box Sync/PalmyraFieldwork/Data/2014.08-2015.03/SBE/SBE2141_FR7/2141data_sep2014-march2015.mat')
%     % Bad data: first deployment
%     timefr7=time2141(1:88720);
%     salfr7=sal2141(1:88720);
    tmp=find(time2141 <= datenum(2015,3,5,20,0,0));
    timefr7=time2141(tmp);
    salfr7=sal2141(tmp);

    % Second deployment: bad data
%     load('~/Box Sync/PalmyraFieldwork/Data/August2015/SBE/SBE12812_FR7/SBE12812.mat')
%     tmp=find(time12812 <= datenum(2015,5,25,12,0,0));
%     timefr7=cat(1,timefr7,time12812(tmp));
%     salfr7=cat(1,salfr7,sal12812(tmp));
    
%     % Third deployment: bad data
%     load('~/Box Sync/PalmyraFieldwork/Data/2015.08-2016.03/SBE37/SBE12812_FR7/SBE12812_2.mat')
%     tmp=find(time12812 <= datenum(2015,10,14,12,0,0));
%     timefr7=cat(1,timefr7,time12812(tmp)');
%     salfr7=cat(1,salfr7,sal12812(tmp));
    
    % Fourth deployment: maybe bad data??
    load('~/Box Sync/PalmyraFieldwork/Data/September_2016/SBE37/SBE2977_FR7/SBE37_2977_201609_FR9.mat')
    timefr7=cat(1,timefr7,t2977);
    salfr7=cat(1,salfr7,sal2977);
    
    % Fifth and sixth deployments: no data :( :(
    
    % Get rid of dropouts
    tmp=find(abs(diff(salfr7)) > 0.5);
    salfr7(tmp)=0/0;
    salfr7(tmp+1)=0/0;
    
    tarr{3}=timefr7;
    datarr{3}=salfr7;    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % FR5
    load('~/Box Sync/PalmyraFieldwork/Data/2014.08-2015.03/SBE/SBE2480_FR5/2480data_sep2014-march2015.mat')
    % bad data
    tmp=find(time2480 >= datenum(2014,12,13) & time2480 <= datenum(2015,1,14));
    sal2480(tmp)=0/0;
    tmp=find(time2480 > datenum(2015,3,7));
    sal2480(tmp)=0/0;
    timefr5=time2480;
    salfr5=sal2480;

    % second deployment dominated by dropouts, ignore

%     % Third deployment: bad data
%     load('~/Box Sync/PalmyraFieldwork/Data/2015.08-2016.03/SBE37/SBE2143_FR5/SBE2143_FR5.mat')
%     tmp=find(t <= datenum(2016,3,3,12,0,0));
%     timefr5=cat(1,timefr5',t(tmp));
%     salfr5=cat(1,salfr5,sal(tmp));
    
    % Fourth deployment: very likely dominated by dropouts but unclear if
    % any data is salvageable
    load('~/Box Sync/PalmyraFieldwork/Data/September_2016/SBE37/SBE2980_FR5/SBE37_2980_201609_FR5.mat')
    tmp=find(t2980 <= datenum(2016,3,19));
    sal2980(tmp)=0/0;
    tmp=find(t2980 >= datenum(2016,4,14,12,0,0) & t2980 <= datenum(2016,7,11,12,0,0));
    sal2980(tmp)=0/0;
    
    tmp=find(t2980 <= datenum(2016,9,20,12,0,0));
    timefr5=cat(1,timefr5',t2980(tmp));
    salfr5=cat(1,salfr5,sal2980(tmp));
    
    % Fifth and sixth deployments
    load('/Users/samstevenson/Box Sync/PalmyraFieldwork/Data/2016.09-2017.09/SBE37/SBE2144_FR5/SBE2144_FR5.mat')
    tmp=find(time >= datenum(2016,9,24));
    timefr5=cat(1,timefr5,time(tmp));
    salfr5=cat(1,salfr5,sal(tmp));
    
    % Get rid of dropouts
    tmp=find(abs(diff(salfr5)) > 0.5);
    salfr5(tmp)=0/0;
    salfr5(tmp+1)=0/0;
    salfr5(salfr5 < 32)=0/0;
    
    tarr{4}=timefr5;
    datarr{4}=salfr5;
    

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % FR9: dead battery = no data on first deployment
    
    % Second deployment
    load('~/Box Sync/PalmyraFieldwork/Data/August2015/SBE/SBE2143_FR9/SBE2143.mat')
    timefr9=time2143;
    salfr9=sal2143;
    % Bad data
    timefr9=timefr9(1:72400);
    salfr9=salfr9(1:72400);
    
    % Third deployment: no data :( 
    
%     % Fourth deployment: bad data
%     load('~/Box Sync/PalmyraFieldwork/Data/September_2016/SBE37/SBE2143_FR9/SBE37_2143_201609_FR9.mat')
%     tmp=find(t2143 <= datenum(2016,5,1));
%     timefr9=cat(1,timefr9',t2143(tmp));
%     salfr9=cat(1,salfr9,sal2143(tmp));
    
    % Fifth and sixth deployments: no data! Poor FR9...
    
    % Get rid of dropouts
    tmp=find(abs(diff(salfr9)) > 0.5);
    salfr9(tmp)=0/0;
    salfr9(tmp+1)=0/0;
    
  


end
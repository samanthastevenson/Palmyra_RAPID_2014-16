% Read in SBE56 temperature information from Palmyra
% April 2016
% Sam Stevenson

function [tarr,datarr,sitenames]=readsbe56data_temp_interp
    % Common time array for all instruments
    tarr=linspace(datenum(2015,8,1),datenum(2017,9,20),(datenum(2017,9,20)-datenum(2015,8,1)+1)*476);
    [yr,mon,dy]=datevec(tarr);
    datarr=zeros(length(tarr),5);
    sitenames={'RT4','FR7','FR5','CH1','FR9'};

    %%%%%
    % RT4    
    % Third deployment
    load('~/Documents/PalmyraFieldwork/Data/2015.08-2016.03/SBE56/SBE1967_RT4/SBE05601967_RT4.mat')
    timert4=t_1967;
    temprt4=temp_1967;
    % Bad data points at beginning of deployment
    timert4=timert4(75600:end);
    temprt4=temprt4(75600:end);
    
    % Fourth deployment
    load('~/Documents/PalmyraFieldwork/Data/September_2016/SBE56/SBE1856_RT4/SBE56_1856_201609_RT4.mat')
    timert4=cat(1,timert4,t1856);
    temprt4=cat(1,temprt4,temp1856);
    
    timert4=timert4(1:4314764);     % Get rid of bad data during instrument retrieval
    temprt4=temprt4(1:4314764);
    
    % Fifth and sixth deployments
    load('~/Documents/PalmyraFieldwork/Data/2016.09-2017.09/SBE56/SBE1969_RT4/SBE1969_RT4.mat')    
    timert4=cat(1,timert4,time);
    temprt4=cat(1,temprt4,temp);
    
    
    %%%%%
    % FR7
    % Third deployment
    load('~/Documents/PalmyraFieldwork/Data/2015.08-2016.03/SBE56/SBE1856_FR7/SBE05601856_FR7.mat')
    % Bad data points at beginning of deployment
    timefr7=t_1856(64800:end);
    tempfr7=temp_1856(64800:end);
    
    % Fourth deployment
    load('~/Documents/PalmyraFieldwork/Data/September_2016/SBE56/SBE1969_FR7/SBE56_1969_2016-09-21_FR7.mat')
    t1969=t1969(10802:2168101);     % Trim bad data at instrument deployment/retrieval
    temp1969=temp1969(10802:2168101);
    timefr7=cat(1,timefr7,t1969);
    tempfr7=cat(1,tempfr7,temp1969);
    
    % Fifth and sixth deployments
    load('~/Documents/PalmyraFieldwork/Data/2016.09-2017.09/SBE56/SBE1968_FR7/SBE1968_FR7.mat')
    timefr7=cat(1,timefr7,time(9000:end));
    tempfr7=cat(1,tempfr7,temp(9000:end));
    
    
    %%%%%
    % FR5
    % Third deployment
    load('~/Documents/PalmyraFieldwork/Data/2015.08-2016.03/SBE56/SBE1969_FR5/SBE05601969_FR5.mat')
    % Bad data points at beginning, end of deployment
    timefr5=t_1969(75600:2192401);
    tempfr5=temp_1969(75600:2192401);
    
    % Fourth deployment
    load('~/Documents/PalmyraFieldwork/Data/September_2016/SBE56/SBE1859_FR5/SBE56_1859_2016-09-21.mat')
    % Bad data points at beginning, end of deployment
    t1859=t1859(9451:2137051);
    temp1859=temp1859(9451:2137051);
    timefr5=cat(1,timefr5,t1859);
    tempfr5=cat(1,tempfr5,temp1859);
    
    % Fifth and sixth deployments
    load('~/Documents/PalmyraFieldwork/Data/2016.09-2017.09/SBE56/SBE1856_FR5/SBE1856_FR5.mat')
    timefr5=cat(1,timefr5,time);
    tempfr5=cat(1,tempfr5,temp);
    

    %%%%%
    % CH1
    % Third deployment
    load('~/Documents/PalmyraFieldwork/Data/2015.08-2016.03/SBE56/SBE1968_CH1/SBE05601968_CH1.mat')
    timech1=t_1968(97200:end);
    tempch1=temp_1968(97200:end);
    
    % Fourth deployment
    load('~/Documents/PalmyraFieldwork/Data/September_2016/SBE56/SBE1968_CH1/SBE56_1968_201609_CH1.mat')
    % Bad data points at beginning, end of deployment
    t1968=t1968(45901:2133001);
    temp1968=temp1968(45901:2133001);
    timech1=cat(1,timech1,t1968);
    tempch1=cat(1,tempch1,temp1968);
    
    % Fifth and sixth deployments
    load('~/Documents/PalmyraFieldwork/Data/2016.09-2017.09/SBE56/SBE1967_CH1/SBE1967_CH1.mat')
    timech1=cat(1,timech1,time);
    tempch1=cat(1,tempch1,temp);
    
    
    %%%%%
    % FR9
    % Third deployment
    load('~/Documents/PalmyraFieldwork/Data/2015.08-2016.03/SBE56/SBE1859_FR9/SBE05601859_FR9.mat')
    timefr9=t_1859(97200:end);
    tempfr9=temp_1859(97200:end);

    % Fourth deployment
    load('~/Documents/PalmyraFieldwork/Data/September_2016/SBE56/SBE1967_FR9/SBE56_1967_201609_FR9.mat')
    % Bad data points at beginning, end of deployment
    t1967=t1967(10802:2178901);
    temp1967=temp1967(10802:2178901);
    timefr9=cat(1,timefr9,t1967);
    tempfr9=cat(1,tempfr9,temp1967);
    
    % Fifth and sixth deployments
    load('~/Documents/PalmyraFieldwork/Data/2016.09-2017.09/SBE56/SBE1859_FR9/SBE1859_FR9.mat')
    timefr9=cat(1,timefr9,time(8200:end));
    tempfr9=cat(1,tempfr9,temp(8200:end));
    

    % RT4
    datarr(:,1)=interp1(timert4,temprt4,tarr);
    % FR7
    datarr(:,2)=interp1(timefr7,tempfr7,tarr);
    % FR5
    datarr(:,3)=interp1(timefr5,tempfr5,tarr);   
    % CH1
    datarr(:,4)=interp1(timech1,tempch1,tarr);
    % FR9
    datarr(:,5)=interp1(timefr9,tempfr9,tarr);
    
    % Fix missing periods in interpolated time series
    % RT4
    myt=find(tarr > datenum(2016,2,29,0,0,0) & tarr <= datenum(2016,3,7,1,0,0));
    datarr(myt,1)=0/0;    
    % FR7
    myt=find(tarr > datenum(2015,11,20,19,0,0) & tarr <= datenum(2016,3,6,1,0,0));
    datarr(myt,2)=0/0;    
    myt=find(tarr > datenum(2017,9,18,12,0,0) & tarr <= datenum(2017,9,21,0,0,0));
    datarr(myt,2)=0/0;
    % FR5
    myt=find(tarr > datenum(2016,2,26,0,0,0) & tarr <= datenum(2016,3,8,1,0,0));
    datarr(myt,3)=0/0;    
    % CH1
    myt=find(tarr > datenum(2015,11,14,3,0,0) & tarr <= datenum(2016,3,9,8,0,0));
    datarr(myt,4)=0/0;       
    myt=find(tarr > datenum(2016,9,18,0,0,0) & tarr <= datenum(2016,9,26,0,0,0));
    datarr(myt,4)=0/0;           
    % FR9
    myt=find(tarr > datenum(2016,2,20,8,0,0) & tarr <= datenum(2016,9,26,0,0,0));
    datarr(myt,5)=0/0;    
    myt=find(tarr > datenum(2016,9,22,12,0,0) & tarr <= datenum(2016,9,23,0,0,0));
    datarr(myt,5)=0/0;    
    myt=find(tarr > datenum(2017,9,13,12,0,0) & tarr <= datenum(2017,9,21,0,0,0));
    datarr(myt,5)=0/0;  
end

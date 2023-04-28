% Read in AQD temperature information from Palmyra
% March 2018
% Sam Stevenson

function [tarr,datarr,sitenames]=readaqddata_temp_interp
    % Common time array for all instruments
    tarr=linspace(datenum(2014,9,1),datenum(2017,9,20),(datenum(2017,9,20)-datenum(2014,9,1)+1)*476);
    [yr,mon,dy]=datevec(tarr);
    datarr=zeros(length(tarr),5);
    sitenames={'RT4','FR7','FR5','CH1','FR9'};

    %%%%%
    % RT4
    % First deployment
    load('~/Documents/PalmyraFieldwork/Data/2014.08-2015.03/AQD/AQD5309_RT4/AQD5309_RT4_201409-201503.mat')
    timert4=time(1:17852);
    temprt4=temperature(1:17852);
    
    % Second deployment
    load('~/Documents/PalmyraFieldwork/Data/August2015/AQD/AQD1848_RT4/AQD1848_RT4_201503-201508.mat')
    timert4=cat(1,timert4,time(1:10858));
    temprt4=cat(1,temprt4,temperature(1:10858));
    
    % Third deployment: no .mat file    
    
    % Fourth deployment: no temperature data
    
    % Fifth and sixth deployments: no .mat file
    
    %%%%%
    % FR7
    % First deployment
    load('~/Documents/PalmyraFieldwork/Data/2014.08-2015.03/AQD/AQD5327_FR7/AQD5327_FR7_201409_201503.mat')
    temperature(14921:end)=0/0; % fix bad data
    myt=find(time >= datenum(2014,12,9,15,0,0) & time <= datenum(2014,12,10,18,0,0));
    temperature(myt)=0/0;
    timefr7=time;
    tempfr7=temperature;
    
    % Second deployment
    load('~/Documents/PalmyraFieldwork/Data/August2015/AQD/AQD2839_FR7/AQD2839.mat')
    timefr7=cat(1,timefr7,time2839(1:10933));
    tempfr7=cat(1,tempfr7,temp2839(1:10933));
    
    % Third deployment: no .mat file

    % Fourth deployment: no temperature data
    
    % Fifth and sixth deployments: no .mat file
   
    
    %%%%%
    % FR5
    % First deployment
    load('~/Documents/PalmyraFieldwork/Data/2014.08-2015.03/AQD/AQD5308_FR5/AQD5308_FR5_201409-201503.mat')
    timefr5=time(1:17849);
    tempfr5=temperature(1:17849);
    
    % Second deployment
    load('/Users/samstevenson/Documents/PalmyraFieldwork/Data/August2015/AQD/AQD2841_FR5/AQD2841.mat')
    timefr5=cat(1,timefr5,time2841(1:10855));
    tempfr5=cat(1,tempfr5,temp2841(1:10855));
    
    % Third deployment: no .mat file
    
    % Fourth deployment: no temperature data
    
    % Fifth and sixth deployments: no .mat file
    
    %%%%%
    % CH1
    % First deployment
    load('~/Documents/PalmyraFieldwork/Data/2014.08-2015.03/AQD/AQD5264_CH1/AQD5264_CHAN_201409_201503.mat')
    timech1=time;
    tempch1=temperature;
    
    % Second deployment
%     load('~/Documents/PalmyraFieldwork/Data/August2015/AQD/AQD1857_CH1/AQD1857.mat')
%     timech1=cat(1,timech1,time1857(1:11377));
%     tempch1=cat(1,tempch1,temp1857(1:11377));
    
    % Third deployment: no .mat file
    
    % Fourth deployment: no temperature data
    
    % Fifth and sixth deployments: no .mat file
    
    %%%%%
    % FR9
    % First deployment
    load('~/Documents/PalmyraFieldwork/Data/2014.08-2015.03/AQD/AQD2914_FR9/AQD2914_FR9_201409_201503.mat')
    timefr9=time;
    tempfr9=temperature;
    
    % Second deployment
    load('~/Documents/PalmyraFieldwork/Data/August2015/AQD/AQD2834_FR9/AQD2834.mat')
    timefr9=cat(1,timefr9,time2834(1:10837));
    tempfr9=cat(1,tempfr9,temp2834(1:10837));
    
    % Third deployment: no .mat file
    
    % Fourth deployment: no temperature data
    
    % Fifth and sixth deployments: no .mat file
    
    
    % RT4
    datarr(:,1)=interp1(timert4(~isnan(timert4)),temprt4(~isnan(timert4)),tarr);
    % FR7
    datarr(:,2)=interp1(timefr7(~isnan(tempfr7)),tempfr7(~isnan(tempfr7)),tarr);
    % FR5
    datarr(:,3)=interp1(timefr5,tempfr5,tarr);   
    % CH1
    datarr(:,4)=interp1(timech1,tempch1,tarr);
    % FR9
    datarr(:,5)=interp1(timefr9,tempfr9,tarr);
    
    % Fix missing periods in interpolated time series
end

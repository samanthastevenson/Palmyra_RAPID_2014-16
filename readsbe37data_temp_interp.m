% Read in SBE37 temperature information from Palmyra
% December 2017
% Sam Stevenson

function [tarr,datarr,sitenames]=readsbe37data_temp_interp
%     % Common time array for all instruments
%     tarr=linspace(datenum(2014,9,1),datenum(2017,9,20),(datenum(2017,9,20)-datenum(2014,9,1)+1)*476);
%     [yr,mon,dy]=datevec(tarr);
%     datarr=zeros(length(tarr),5);
    sitenames={'RT4','CH1','FR7','FR5','FR9'};
    tarr=cell(length(sitenames),1);
    datarr=cell(length(sitenames),1);

    %%%%%
    % RT4
    % First deployment: data is funky, ignore
    
    % Second deployment
    load('~/Documents/PalmyraFieldwork/Data/August2015/SBE/SBE2978_RT4/SBE2978.mat')
    timert4=time2978;  
    temprt4=temp2978;
    
    % Third deployment
    load('~/Documents/PalmyraFieldwork/Data/2015.08-2016.03/SBE37/SBE2144_RT4/SBE2144_RT4_1.mat')
    t(26500:26785)=0/0;
    temp=temp(~isnan(t));
    t=t(~isnan(t));
    
    timert4=cat(1,timert4,t);
    temprt4=cat(1,temprt4,temp);
    load('~/Documents/PalmyraFieldwork/Data/2015.08-2016.03/SBE37/SBE2144_RT4/SBE2144_RT4_2.mat')
    timert4=cat(1,timert4,t(311:19870));
    temprt4=cat(1,temprt4,temp(311:19870));
    
    % Fourth deployment
    load('~/Documents/PalmyraFieldwork/Data/September_2016/SBE37/SBE2144_RT4/SBE37_2144_201609_RT4.mat')
    t2144=t2144(1:95880);
    temp2144=temp2144(1:95880);
    timert4=cat(1,timert4,t2144);
    temprt4=cat(1,temprt4,temp2144);
    
    % Fifth and sixth deployments
    load('~/Documents/PalmyraFieldwork/Data/2016.09-2017.09/SBE37/SBE2977_RT4/SBE2977_RT4.mat')
    timert4=cat(1,timert4,time);
    temprt4=cat(1,temprt4,temp);
    
    tarr{1}=timert4;
    datarr{1}=temprt4;  
    
    %%%%%
    % CH1
    % First deployment
    load('~/Documents/PalmyraFieldwork/Data/2014.08-2015.03/SBE/SBE1940_CH1/SBE1940_sep2014_march2015.mat')
    temp1940(temp1940 == 0)=0/0;
    
    % Second deployment
    load('~/Documents/PalmyraFieldwork/Data/August2015/SBE/SBE2144_CH1/SBE2144.mat')
    temp2144=temp2144(1:75800);
    time2144=time2144(1:75800);
    timech1=cat(1,time1940,time2144');
    tempch1=cat(1,temp1940,temp2144);

    % Third deployment
    load('~/Documents/PalmyraFieldwork/Data/2015.08-2016.03/SBE37/SBE2977_CH1/SBE2977_CH1.mat')
    timech1=cat(1,timech1,t(1:90181));
    tempch1=cat(1,tempch1,temp(1:90181));
    
    % Fourth deployment: no data
    
    % Fifth and sixth deployments
    load('~/Documents/PalmyraFieldwork/Data/2016.09-2017.09/SBE37/SBE2980_CH1/SBE2980_CH1.mat')
    timech1=cat(1,timech1,time);
    tempch1=cat(1,tempch1,temp);
    
    tarr{2}=timech1;
    datarr{2}=tempch1;  
    
    %%%%%
    % FR7
    load('~/Documents/PalmyraFieldwork/Data/2014.08-2015.03/SBE/SBE2141_FR7/2141data_sep2014-march2015.mat')
    % First deployment
    timefr7=time2141(1:88720);
    tempfr7=temp2141(1:88720);
    
    % Second deployment
    load('~/Documents/PalmyraFieldwork/Data/August2015/SBE/SBE12812_FR7/SBE12812.mat')
    time12812=time12812(1:72900);
    temp12812_90=temp12812_90(1:72900);
    timefr7=cat(1,timefr7,time12812);
    tempfr7=cat(1,tempfr7,temp12812_90);
    
    % Third deployment
    load('~/Documents/PalmyraFieldwork/Data/2015.08-2016.03/SBE37/SBE12812_FR7/SBE12812_2.mat')
    timefr7=cat(1,timefr7,time12812');
    tempfr7=cat(1,tempfr7,temp12812);

    % Fourth deployment
    load('~/Documents/PalmyraFieldwork/Data/September_2016/SBE37/SBE2977_FR7/SBE37_2977_201609_FR9.mat')
    timefr7=cat(1,timefr7,t2977);
    tempfr7=cat(1,tempfr7,temp2977);
    
    tarr{3}=timefr7;
    datarr{3}=tempfr7;  
    
    %%%%%
    % FR5
    % First deployment
    load('~/Documents/PalmyraFieldwork/Data/2014.08-2015.03/SBE/SBE2480_FR5/2480data_sep2014-march2015.mat')
    % First deployment
    time2480=time2480(1:88800);
    temp2480=temp2480(1:88800);
    
    % Second deployment
    load('~/Documents/PalmyraFieldwork/Data/August2015/SBE/SBE2142_FR5/SBE2142.mat')
    time2142=time2142(1:72400);
    temp2142=temp2142(1:72400);
    timefr5=cat(1,time2480',time2142');
    tempfr5=cat(1,temp2480,temp2142);
    
    % Third deployment
    load('~/Documents/PalmyraFieldwork/Data/2015.08-2016.03/SBE37/SBE2143_FR5/SBE2143_FR5.mat')
    timefr5=cat(1,timefr5,t(1:90120));
    tempfr5=cat(1,tempfr5,temp(1:90120));
    
    % Fourth deployment
    load('~/Documents/PalmyraFieldwork/Data/September_2016/SBE37/SBE2980_FR5/SBE37_2980_201609_FR5.mat')
    t2980=t2980(1:96360);
    temp2980=temp2980(1:96360);
    timefr5=cat(1,timefr5,t2980);
    tempfr5=cat(1,tempfr5,temp2980);
    
    % Fifth and sixth deployments
    load('~/Documents/PalmyraFieldwork/Data/2016.09-2017.09/SBE37/SBE2144_FR5/SBE2144_FR5.mat')
    tmp=find(time >= datenum(2016,9,24));
    timefr5=cat(1,timefr5,time(tmp));
    tempfr5=cat(1,tempfr5,temp(tmp));
    
    tarr{4}=timefr5;
    datarr{4}=tempfr5;  
    
    %%%%%
    % FR9
    % First deployment: no data
    
    % Second deployment
    load('~/Documents/PalmyraFieldwork/Data/August2015/SBE/SBE2143_FR9/SBE2143.mat')
    timefr9=time2143;
    tempfr9=temp2143;
    % Bad data
    timefr9=timefr9(1:72400)';
    tempfr9=tempfr9(1:72400);
    
    % Third deployment: no data
    
    % Fourth deployment
    load('~/Documents/PalmyraFieldwork/Data/September_2016/SBE37/SBE2143_FR9/SBE37_2143_201609_FR9.mat')
    t2143=t2143(1:26400);
    temp2143=temp2143(1:26400);
    timefr9=cat(1,timefr9,t2143);
    tempfr9=cat(1,tempfr9,temp2143);
    
    % Fifth and sixth deployments: no data
    
    tarr{5}=timefr9;
    datarr{5}=tempfr9;  
    
%     % RT4
%     datarr(:,1)=interp1(timert4(~isnan(timert4)),temprt4(~isnan(timert4)),tarr);
%     % FR7
%     datarr(:,2)=interp1(timefr7,tempfr7,tarr);
%     % FR5
%     datarr(:,3)=interp1(timefr5,tempfr5,tarr);   
%     % CH1
%     datarr(:,4)=interp1(timech1,tempch1,tarr);
%     % FR9
%     datarr(:,5)=interp1(timefr9,tempfr9,tarr);
%     
%     % Fix missing periods in interpolated time series
%     % RT4
%     myt=find(tarr > datenum(2015,7,12,9,0,0) & tarr <= datenum(2015,8,29,1,0,0));
%     datarr(myt,1)=0/0;    
%     % FR7
%     myt=find(tarr > datenum(2015,8,13,18,0,0) & tarr <= datenum(2015,8,29,1,0,0));
%     datarr(myt,2)=0/0;    
%     myt=find(tarr > datenum(2016,3,5,12,0,0) & tarr <= datenum(2016,3,7,12,0,0));
%     datarr(myt,2)=0/0;    
%     % FR5
%     myt=find(tarr > datenum(2015,8,6,15,0,0) & tarr <= datenum(2015,8,29,1,0,0));
%     datarr(myt,3)=0/0;    
%     % CH1
%     myt=find(tarr > datenum(2015,8,13,18,0,0) & tarr <= datenum(2015,8,29,1,0,0));
%     datarr(myt,4)=0/0;    
%     % FR9
%     myt=find(tarr > datenum(2015,8,6,19,0,0) & tarr <= datenum(2016,3,7));
%     datarr(myt,5)=0/0;
end

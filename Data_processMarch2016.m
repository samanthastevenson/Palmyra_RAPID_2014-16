% Process velocity data from Aquadopp deployments at Palmyra, including
% detiding and temporal averaging
% Mark Merrifield, March 2016
% updated by Sam Stevenson, July 2020

%get Palmyra tide gauge data

cd '~/Box Sync/PalmyraFieldwork/Data/tidegaugedata'

t = ncread('OS_UH-FDH043_20150723_D.nc','time');
t = t + datenum(1700,1,1,0,0,0);

h = ncread('OS_UH-FDH043_20150723_D.nc','sea_surface_height_above_reference_level');
h = squeeze(h);

%predicted tide
%addpath '/Users/markm/Dropbox/Sophie/t_tide_v1'
[tidecon,hp] = t_tide(h);

hr = h-hp;
hr = hr - nanmean(hr);

save palmyra_sealevel_2012_2015 t h hr hp

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Process AQD data from August 2014 deployment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cd '~/Box Sync/PalmyraFieldwork/Data/August2014/AQD/AQD2914'
clear
load AQD2914_FR9_201409_201503
FR9a.t = time;
FR9a.u = v1;
FR9a.v = v2;
FR9a.w = v3;
FR9a.p = pressure;
FR9a.T = temperature;
save '~/Box Sync/PalmyraFieldwork/Data/AQD_MMprocess_mar2016/AQDprocessed/FR9a.mat' FR9a

clear
cd '~/Box Sync/PalmyraFieldwork/Data/August2014/AQD/AQD5264'
load AQD5264_CHAN_201409_201503
CHLa.t = time;
CHLa.u = v1;
CHLa.v = v2;
CHLa.w = v3;
CHLa.p = pressure;
CHLa.T = temperature;
save '~/Box Sync/PalmyraFieldwork/Data/AQD_MMprocess_mar2016/AQDprocessed/CHLa.mat' CHLa

clear
cd '~/Box Sync/PalmyraFieldwork/Data/August2014/AQD/AQD5308'
load AQD5308_FR5_201409-201503
FR5a.t = time(1:17863);
FR5a.u = v1(1:17863,:);
FR5a.v = v2(1:17863,:);
FR5a.w = v3(1:17863,:);
FR5a.p = pressure(1:17863);
FR5a.T = temperature(1:17863);
save '~/Box Sync/PalmyraFieldwork/Data/AQD_MMprocess_mar2016/AQDprocessed/FR5a.mat' FR5a

clear
cd '~/Box Sync/PalmyraFieldwork/Data/August2014/AQD/AQD5309'
load AQD5309_RT4_201409-201503
RT4a.t = time(1:17853);
RT4a.u = v1(1:17853,:);
RT4a.v = v2(1:17853,:);
RT4a.w = v3(1:17853,:);
RT4a.p = pressure(1:17853);
RT4a.T = temperature(1:17853);
save '~/Box Sync/PalmyraFieldwork/Data/AQD_MMprocess_mar2016/AQDprocessed/RT4a.mat' RT4a

clear
cd '~/Box Sync/PalmyraFieldwork/Data/August2014/AQD/AQD5327'
load AQD5327_FR7_201409_201503
FR7a.t = time(1:17752);
FR7a.u = v1(1:17752,:);
FR7a.v = v2(1:17752,:);
FR7a.w = v3(1:17752,:);
FR7a.p = pressure(1:17752);
FR7a.T = temperature(1:17752);
FR7a.p(9446:end)= NaN;
FR7a.u(9446:end,:) =  NaN;
FR7a.v(9446:end,:) =  NaN;
FR7a.w(9446:end,:) =  NaN;
save '~/Box Sync/PalmyraFieldwork/Data/AQD_MMprocess_mar2016/AQDprocessed/FR7a.mat' FR7a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Process AQD data from March 2015 deployment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cd '~/Box Sync/PalmyraFieldwork/Data/August2015/AQD/AQD1848_RT4'
clear
load AQD1848_RT4_201503-201508
RT4b.t = time(1:10864);
RT4b.u = v1(1:10864,:);
RT4b.v = v2(1:10864,:);
RT4b.w = v3(1:10864,:);
RT4b.p = pressure(1:10864);
RT4b.T = temperature(1:10864);
save '~/Box Sync/PalmyraFieldwork/Data/AQD_MMprocess_mar2016/AQDprocessed/RT4b.mat' RT4b

cd '~/Box Sync/PalmyraFieldwork/Data/August2015/AQD/AQD1857_CH1'
clear
load AQD1857
CHLb.t = time1857(1:11380);
CHLb.u = v1(1:11380,:);
CHLb.v = v2(1:11380,:);
CHLb.w = v3(1:11380,:);
CHLb.p = p1857(1:11380);
CHLb.T = temp1857(1:11380);
save '~/Box Sync/PalmyraFieldwork/Data/AQD_MMprocess_mar2016/AQDprocessed/CHLb.mat' CHLb

cd '~/Box Sync/PalmyraFieldwork/Data/August2015/AQD/AQD2834_FR9'
clear
load AQD2834
FR9b.t = time2834(1:10870);
FR9b.u = v1(1:10870,:);
FR9b.v = v2(1:10870,:);
FR9b.w = v3(1:10870,:);
FR9b.p = p2834(1:10870);
FR9b.T = temp2834(1:10870);
save '~/Box Sync/PalmyraFieldwork/Data/AQD_MMprocess_mar2016/AQDprocessed/FR9b.mat' FR9b

cd '~/Box Sync/PalmyraFieldwork/Data/August2015/AQD/AQD2839_FR7'
clear
load AQD2839
FR7b.t = time2839(1:10936);
FR7b.u = v1(1:10936,:);
FR7b.v = v2(1:10936,:);
FR7b.w = v3(1:10936,:);
FR7b.p = p2839(1:10936);
FR7b.T = temp2839(1:10936);
save '~/Box Sync/PalmyraFieldwork/Data/AQD_MMprocess_mar2016/AQDprocessed/FR7b.mat' FR7b

cd '~/Box Sync/PalmyraFieldwork/Data/August2015/AQD/AQD2841_FR5'
clear
load AQD2841
FR5b.t = time2841(1:10860);
FR5b.u = v1(1:10860,:);
FR5b.v = v2(1:10860,:);
FR5b.w = v3(1:10860,:);
FR5b.p = p2841(1:10860);
FR5b.T = temp2841(1:10860);
save '~/Box Sync/PalmyraFieldwork/Data/AQD_MMprocess_mar2016/AQDprocessed/FR5b.mat' FR5b


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Process AQD data from August 2015 deployment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cd '~/Box Sync/PalmyraFieldwork/Data/2015.08-2016.03/AQD/AQD5309_RT4'
clear
AQD_5309 = load('AQD5309_RT4_201508-201603.sen');
v1_5309 = load('AQD5309_RT4_201508-201603.v1');
v2_5309 = load('AQD5309_RT4_201508-201603.v2');
v3_5309 = load('AQD5309_RT4_201508-201603.v3');

month = AQD_5309(:,1);
day = AQD_5309(:,2);
year = AQD_5309(:,3);
hour = AQD_5309(:,4);
min = AQD_5309(:,5);
p_dbar = AQD_5309(:,14);
temp = AQD_5309(:,15);
t = datenum(year,month,day,hour,min,0);
myt=find(t >= datenum(2015,8,13) & t <= datenum(2016,3,4));

RT4c.t = t(myt);
RT4c.u = v1_5309(myt,:);
RT4c.v = v2_5309(myt,:);
RT4c.w = v3_5309(myt,:);
RT4c.p = p_dbar(myt);
RT4c.T = temp(myt);
save '~/Box Sync/PalmyraFieldwork/Data/AQD_MMprocess_mar2016/AQDprocessed/RT4c.mat' RT4c


cd '~/Box Sync/PalmyraFieldwork/Data/2015.08-2016.03/AQD/AQD5308_FR5'
clear
AQD_5308 = load('AQD5308_FR5_201508-201603.sen');
v1_5308 = load('AQD5308_FR5_201508-201603.v1');
v2_5308 = load('AQD5308_FR5_201508-201603.v2');
v3_5308 = load('AQD5308_FR5_201508-201603.v3');

month = AQD_5308(:,1);
day = AQD_5308(:,2);
year = AQD_5308(:,3);
hour = AQD_5308(:,4);
min = AQD_5308(:,5);
p_dbar = AQD_5308(:,14);
temp = AQD_5308(:,15);
t = datenum(year,month,day,hour,min,0);
myt=find(t >= datenum(2015,8,13) & t <= datenum(2016,3,3));

FR5c.t = t(myt);
FR5c.u = v1_5308(myt,:);
FR5c.v = v2_5308(myt,:);
FR5c.w = v3_5308(myt,:);
FR5c.p = p_dbar(myt);
FR5c.T = temp(myt);
save '~/Box Sync/PalmyraFieldwork/Data/AQD_MMprocess_mar2016/AQDprocessed/FR5c.mat' FR5c

cd '~/Box Sync/PalmyraFieldwork/Data/2015.08-2016.03/AQD/AQD5264_FR7'
clear
AQD_5264 = load('AQD5264_FR7_201508-201603.sen');
v1_5264 = load('AQD5264_FR7_201508-201603.v1');
v2_5264 = load('AQD5264_FR7_201508-201603.v2');
v3_5264 = load('AQD5264_FR7_201508-201603.v3');

month = AQD_5264(:,1);
day = AQD_5264(:,2);
year = AQD_5264(:,3);
hour = AQD_5264(:,4);
min = AQD_5264(:,5);
p_dbar = AQD_5264(:,14);
temp = AQD_5264(:,15);
t = datenum(year,month,day,hour,min,0);
myt=find(t >= datenum(2015,8,13) & t <= datenum(2016,3,3));

FR7c.t = t(myt);
FR7c.u = v1_5264(myt,:);
FR7c.v = v2_5264(myt,:);
FR7c.w = v3_5264(myt,:);
FR7c.p = p_dbar(myt);
FR7c.T = temp(myt);
save '~/Box Sync/PalmyraFieldwork/Data/AQD_MMprocess_mar2016/AQDprocessed/FR7c.mat' FR7c


cd '~/Box Sync/PalmyraFieldwork/Data/2015.08-2016.03/AQD/AQD2914_FR9'
clear
AQD_2914 = load('AQD2914_FR9_201508-201603.sen');
v1_2914 = load('AQD2914_FR9_201508-201603.v1');
v2_2914 = load('AQD2914_FR9_201508-201603.v2');
v3_2914 = load('AQD2914_FR9_201508-201603.v3');

month = AQD_2914(:,1);
day = AQD_2914(:,2);
year = AQD_2914(:,3);
hour = AQD_2914(:,4);
min = AQD_2914(:,5);
p_dbar = AQD_2914(:,14);
temp = AQD_2914(:,15);
t = datenum(year,month,day,hour,min,0);
myt=find(t >= datenum(2015,8,13) & t <= datenum(2016,3,3));

FR9c.t = t(myt);
FR9c.u = v1_2914(myt,:);
FR9c.v = v2_2914(myt,:);
FR9c.w = v3_2914(myt,:);
FR9c.p = p_dbar(myt);
FR9c.T = temp(myt);
save '~/Box Sync/PalmyraFieldwork/Data/AQD_MMprocess_mar2016/AQDprocessed/FR9c.mat' FR9c


cd '~/Box Sync/PalmyraFieldwork/Data/2015.08-2016.03/AQD/AQD1848_CH1'
clear
AQD_1848 = load('AQD1848_CH1_201508-201603.sen');
v1_1848 = load('AQD1848_CH1_201508-201603.v1');
v2_1848 = load('AQD1848_CH1_201508-201603.v2');
v3_1848 = load('AQD1848_CH1_201508-201603.v3');

month = AQD_1848(:,1);
day = AQD_1848(:,2);
year = AQD_1848(:,3);
hour = AQD_1848(:,4);
min = AQD_1848(:,5);
p_dbar = AQD_1848(:,14);
temp = AQD_1848(:,15);
t = datenum(year,month,day,hour,min,0);
myt=find(t >= datenum(2015,8,13) & t <= datenum(2016,3,3));

CHLc.t = t(myt);
CHLc.u = v1_1848(myt,:);
CHLc.v = v2_1848(myt,:);
CHLc.w = v3_1848(myt,:);
CHLc.p = p_dbar(myt);
CHLc.T = temp(myt);
save '~/Box Sync/PalmyraFieldwork/Data/AQD_MMprocess_mar2016/AQDprocessed/CHLc.mat' CHLc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Process AQD data from September 2016 deployment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd '~/Box Sync/PalmyraFieldwork/Data/September_2016/AQD/AQD1844_FR5'
clear
AQD_1844 = load('AQD1844_FR5_201603-201609.sen');
v1_1844 = load('AQD1844_FR5_201603-201609.v1');
v2_1844 = load('AQD1844_FR5_201603-201609.v2');
v3_1844 = load('AQD1844_FR5_201603-201609.v3');

month = AQD_1844(:,1);
day = AQD_1844(:,2);
year = AQD_1844(:,3);
hour = AQD_1844(:,4);
min = AQD_1844(:,5);
p_dbar = AQD_1844(:,14);
temp = AQD_1844(:,15);
t = datenum(year,month,day,hour,min,0);

FR5d.t = t;
FR5d.u = v1_1844;
FR5d.v = v2_1844;
FR5d.w = v3_1844;
FR5d.p = p_dbar;
FR5d.T = temp;
save '~/Box Sync/PalmyraFieldwork/Data/AQD_MMprocess_mar2016/AQDprocessed/FR5d.mat' FR5d





cd '~/Box Sync/PalmyraFieldwork/Data/September_2016/AQD/AQD1857_FR7'
clear
AQD_1857 = load('AQD1857_FR7_201603-201609.sen');
v1_1857 = load('AQD1857_FR7_201603-201609.v1');
v2_1857 = load('AQD1857_FR7_201603-201609.v2');
v3_1857 = load('AQD1857_FR7_201603-201609.v3');

month = AQD_1857(:,1);
day = AQD_1857(:,2);
year = AQD_1857(:,3);
hour = AQD_1857(:,4);
min = AQD_1857(:,5);
p_dbar = AQD_1857(:,14);
temp = AQD_1857(:,15);
t = datenum(year,month,day,hour,min,0);
myt=find(t <= datenum(2016,9,21,12,0,0));

FR7d.t = t(myt);
FR7d.u = v1_1857(myt,:);
FR7d.v = v2_1857(myt,:);
FR7d.w = v3_1857(myt,:);
FR7d.p = p_dbar(myt);
FR7d.T = temp(myt);
save '~/Box Sync/PalmyraFieldwork/Data/AQD_MMprocess_mar2016/AQDprocessed/FR7d.mat' FR7d


cd '~/Box Sync/PalmyraFieldwork/Data/September_2016/AQD/AQD2834_FR9'
clear
AQD_2834 = load('AQD2834_FR9_201603-201609.sen');
v1_2834 = load('AQD2834_FR9_201603-201609.v1');
v2_2834 = load('AQD2834_FR9_201603-201609.v2');
v3_2834 = load('AQD2834_FR9_201603-201609.v3');

month = AQD_2834(:,1);
day = AQD_2834(:,2);
year = AQD_2834(:,3);
hour = AQD_2834(:,4);
min = AQD_2834(:,5);
p_dbar = AQD_2834(:,14);
temp = AQD_2834(:,15);
t = datenum(year,month,day,hour,min,0);
myt=find(t <= datenum(2016,9,22,12,0,0));

FR9d.t = t(myt);
FR9d.u = v1_2834(myt,:);
FR9d.v = v2_2834(myt,:);
FR9d.w = v3_2834(myt,:);
FR9d.p = p_dbar(myt);
FR9d.T = temp(myt);
save '~/Box Sync/PalmyraFieldwork/Data/AQD_MMprocess_mar2016/AQDprocessed/FR9d.mat' FR9d


cd '~/Box Sync/PalmyraFieldwork/Data/September_2016/AQD/AQD2839_RT4'
clear
AQD_2839 = load('AQD2839_RT4_201603-201609.sen');
v1_2839 = load('AQD2839_RT4_201603-201609.v1');
v2_2839 = load('AQD2839_RT4_201603-201609.v2');
v3_2839 = load('AQD2839_RT4_201603-201609.v3');

month = AQD_2839(:,1);
day = AQD_2839(:,2);
year = AQD_2839(:,3);
hour = AQD_2839(:,4);
min = AQD_2839(:,5);
p_dbar = AQD_2839(:,14);
temp = AQD_2839(:,15);
t = datenum(year,month,day,hour,min,0);
myt=find(t <= datenum(2016,9,22,12,0,0));

RT4d.t = t(myt);
RT4d.u = v1_2839(myt,:);
RT4d.v = v2_2839(myt,:);
RT4d.w = v3_2839(myt,:);
RT4d.p = p_dbar(myt);
RT4d.T = temp(myt);
save '~/Box Sync/PalmyraFieldwork/Data/AQD_MMprocess_mar2016/AQDprocessed/RT4d.mat' RT4d


cd '~/Box Sync/PalmyraFieldwork/Data/September_2016/AQD/AQD2841_CH1'
clear
AQD_2841 = load('AQ2841_CH1_201603_201609.sen');
v1_2841 = load('AQ2841_CH1_201603_201609.v1');
v2_2841 = load('AQ2841_CH1_201603_201609.v2');
v3_2841 = load('AQ2841_CH1_201603_201609.v3');

month = AQD_2841(:,1);
day = AQD_2841(:,2);
year = AQD_2841(:,3);
hour = AQD_2841(:,4);
min = AQD_2841(:,5);
p_dbar = AQD_2841(:,14);
temp = AQD_2841(:,15);
t = datenum(year,month,day,hour,min,0);
myt=find(t <= datenum(2016,9,18,12,0,0));

CHLd.t = t(myt);
CHLd.u = v1_2841(myt,:);
CHLd.v = v2_2841(myt,:);
CHLd.w = v3_2841(myt,:);
CHLd.p = p_dbar(myt);
CHLd.T = temp(myt);
save '~/Box Sync/PalmyraFieldwork/Data/AQD_MMprocess_mar2016/AQDprocessed/CHLd.mat' CHLd





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Process AQD data from 2017 deployment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd '~/Box Sync/PalmyraFieldwork/Data/2016.09-2017.09/AQD/AQD2914_RT4'
clear
AQD_2914 = load('AQD2914_RT4_start201609_end201709.sen');
v1_2914 = load('AQD2914_RT4_start201609_end201709.v1');
v2_2914 = load('AQD2914_RT4_start201609_end201709.v2');
v3_2914 = load('AQD2914_RT4_start201609_end201709.v3');

month = AQD_2914(:,1);
day = AQD_2914(:,2);
year = AQD_2914(:,3);
hour = AQD_2914(:,4);
min = AQD_2914(:,5);
p_dbar = AQD_2914(:,14);
temp = AQD_2914(:,15);
t = datenum(year,month,day,hour,min,0);

RT4e.t = t;
RT4e.u = v1_2914;
RT4e.v = v2_2914;
RT4e.w = v3_2914;
RT4e.p = p_dbar;
RT4e.T = temp;
save '~/Box Sync/PalmyraFieldwork/Data/AQD_MMprocess_mar2016/AQDprocessed/RT4e.mat' RT4e



cd '~/Box Sync/PalmyraFieldwork/Data/2016.09-2017.09/AQD/AQD5264_FR7'
clear
AQD_5264 = load('AQD5264_FR7_start201609_end201705.sen');
v1_5264 = load('AQD5264_FR7_start201609_end201705.v1');
v2_5264 = load('AQD5264_FR7_start201609_end201705.v2');
v3_5264 = load('AQD5264_FR7_start201609_end201705.v3');

month = AQD_5264(:,1);
day = AQD_5264(:,2);
year = AQD_5264(:,3);
hour = AQD_5264(:,4);
min = AQD_5264(:,5);
p_dbar = AQD_5264(:,14);
temp = AQD_5264(:,15);
t = datenum(year,month,day,hour,min,0);

FR7e.t = t;
FR7e.u = v1_5264;
FR7e.v = v2_5264;
FR7e.w = v3_5264;
FR7e.p = p_dbar;
FR7e.T = temp;
save '~/Box Sync/PalmyraFieldwork/Data/AQD_MMprocess_mar2016/AQDprocessed/FR7e.mat' FR7e




cd '~/Box Sync/PalmyraFieldwork/Data/2016.09-2017.09/AQD/AQD5308_FR5'
clear
AQD_5308 = load('AQD5308_FR5_start201609_end201707.sen');
v1_5308 = load('AQD5308_FR5_start201609_end201707.v1');
v2_5308 = load('AQD5308_FR5_start201609_end201707.v2');
v3_5308 = load('AQD5308_FR5_start201609_end201707.v3');

month = AQD_5308(:,1);
day = AQD_5308(:,2);
year = AQD_5308(:,3);
hour = AQD_5308(:,4);
min = AQD_5308(:,5);
p_dbar = AQD_5308(:,14);
temp = AQD_5308(:,15);
t = datenum(year,month,day,hour,min,0);
myt=find(t <= datenum(2017,7,3));

FR5e.t = t(myt);
FR5e.u = v1_5308(myt,:);
FR5e.v = v2_5308(myt,:);
FR5e.w = v3_5308(myt,:);
FR5e.p = p_dbar;
FR5e.T = temp(myt);
save '~/Box Sync/PalmyraFieldwork/Data/AQD_MMprocess_mar2016/AQDprocessed/FR5e.mat' FR5e




cd '~/Box Sync/PalmyraFieldwork/Data/2016.09-2017.09/AQD/AQD5309_FR9'
clear
AQD_5309 = load('AQD5309_FR9_start201609_end201707.sen');
v1_5309 = load('AQD5309_FR9_start201609_end201707.v1');
v2_5309 = load('AQD5309_FR9_start201609_end201707.v2');
v3_5309 = load('AQD5309_FR9_start201609_end201707.v3');

month = AQD_5309(:,1);
day = AQD_5309(:,2);
year = AQD_5309(:,3);
hour = AQD_5309(:,4);
min = AQD_5309(:,5);
p_dbar = AQD_5309(:,14);
temp = AQD_5309(:,15);
t = datenum(year,month,day,hour,min,0);
myt=find(t <= datenum(2017,7,18,12,0,0));

FR9e.t = t(myt);
FR9e.u = v1_5309(myt,:);
FR9e.v = v2_5309(myt,:);
FR9e.w = v3_5309(myt,:);
FR9e.p = p_dbar;
FR9e.T = temp(myt);
save '~/Box Sync/PalmyraFieldwork/Data/AQD_MMprocess_mar2016/AQDprocessed/FR9e.mat' FR9e





cd '~/Box Sync/PalmyraFieldwork/Data/2016.09-2017.09/AQD/AQD6247_CH1'
clear
AQD_6247 = load('AQD6247_CH1_start201609_end201709.sen');
v1_6247 = load('AQD6247_CH1_start201609_end201709.v1');
v2_6247 = load('AQD6247_CH1_start201609_end201709.v2');
v3_6247 = load('AQD6247_CH1_start201609_end201709.v3');

month = AQD_6247(:,1);
day = AQD_6247(:,2);
year = AQD_6247(:,3);
hour = AQD_6247(:,4);
min = AQD_6247(:,5);
p_dbar = AQD_6247(:,14);
temp = AQD_6247(:,15);
t = datenum(year,month,day,hour,min,0);

CHLe.t = t;
CHLe.u = v1_6247;
CHLe.v = v2_6247;
CHLe.w = v3_6247;
CHLe.p = p_dbar;
CHLe.T = temp;
save '~/Box Sync/PalmyraFieldwork/Data/AQD_MMprocess_mar2016/AQDprocessed/CHLe.mat' CHLe


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Work with Processed AQD data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath ~/toolbox/t_tide

clear
cd '~/Box Sync/PalmyraFieldwork/Data/AQD_MMprocess_mar2016/AQDprocessed/'

load FR5a
load FR5b
load FR5c
load FR5d
load FR5e

[tidecon,pa] = t_tide(FR5a.p,'interval',.25);
[tidecon,pb] = t_tide(FR5b.p,'interval',1/3);
[tidecon,pc] = t_tide(FR5c.p,'interval',1/3);
[tidecon,pd] = t_tide(FR5d.p,'interval',1/3);
[tidecon,pe] = t_tide(FR5e.p,'interval',1/3);

ua = mean(FR5a.u(:,1:5),2);
va = mean(FR5a.v(:,1:5),2);
wa = mean(FR5a.w(:,1:5),2);
ub = mean(FR5b.u(:,1:5),2);
vb = mean(FR5b.v(:,1:5),2);
wb = mean(FR5b.w(:,1:5),2);
uc = mean(FR5c.u(:,1:5),2);
vc = mean(FR5c.v(:,1:5),2);
wc = mean(FR5c.w(:,1:5),2);
ud = mean(FR5d.u(:,1:5),2);
vd = mean(FR5d.v(:,1:5),2);
wd = mean(FR5d.w(:,1:5),2);
ue = mean(FR5e.u(:,1:5),2);
ve = mean(FR5e.v(:,1:5),2);
we = mean(FR5e.w(:,1:5),2);
ta = FR5a.t;
tb = FR5b.t;
tc = FR5c.t;
td = FR5d.t;
te = FR5e.t;

%form daily averages

nday = floor(te(end)-ta(1));

uac = conv(ua,ones(4*24,1)/(4*24),'valid');
ubc = conv(ub,ones(4*24,1)/(4*24),'valid');
ucc = conv(uc,ones(4*24,1)/(4*24),'valid');
ucd = conv(ud,ones(4*24,1)/(4*24),'valid');
uce = conv(ue,ones(4*24,1)/(4*24),'valid');
vac = conv(va,ones(4*24,1)/(4*24),'valid');
vbc = conv(vb,ones(4*24,1)/(4*24),'valid');
vcc = conv(vc,ones(4*24,1)/(4*24),'valid');
vcd = conv(vd,ones(4*24,1)/(4*24),'valid');
vce = conv(ve,ones(4*24,1)/(4*24),'valid');
wac = conv(wa,ones(4*24,1)/(4*24),'valid');
wbc = conv(wb,ones(4*24,1)/(4*24),'valid');
wcc = conv(wc,ones(4*24,1)/(4*24),'valid');
wcd = conv(wd,ones(4*24,1)/(4*24),'valid');
wce = conv(we,ones(4*24,1)/(4*24),'valid');
tac = conv(ta,ones(4*24,1)/(4*24),'valid');
tbc = conv(tb,ones(4*24,1)/(4*24),'valid');
tcc = conv(tc,ones(4*24,1)/(4*24),'valid');
tcd = conv(td,ones(4*24,1)/(4*24),'valid');
tce = conv(te,ones(4*24,1)/(4*24),'valid');

%plot every 12 hours

nday = (tac(end)-tac(1));
nd12 = floor(nday*24);
[yr,mo,dy,hr,min,sec] = datevec(tac);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tac(1) & ti <= tac(end));
tai = ti(k);
uai = interp1(tac,uac,tai);
vai = interp1(tac,vac,tai);
wai = interp1(tac,wac,tai);

nday = (tbc(end)-tbc(1));
nd12 = floor(nday*24);
[yr,mo,dy,hr,min,sec] = datevec(tbc);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tbc(1) & ti <= tbc(end));
tbi = ti(k);
ubi = interp1(tbc,ubc,tbi);
vbi = interp1(tbc,vbc,tbi);
wbi = interp1(tbc,wbc,tbi);

nday = (tcc(end)-tcc(1));
nd12 = floor(nday*24);
[yr,mo,dy,hr,min,sec] = datevec(tcc);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tcc(1) & ti <= tcc(end));
tci = ti(k);
uci = interp1(tcc,ucc,tci);
vci = interp1(tcc,vcc,tci);
wci = interp1(tcc,wcc,tci);

nday = (tcd(end)-tcd(1));
nd12 = floor(nday*24);
[yr,mo,dy,hr,min,sec] = datevec(tcd);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tcd(1) & ti <= tcd(end));
tdi = ti(k);
udi = interp1(tcd,ucd,tdi);
vdi = interp1(tcd,vcd,tdi);
wdi = interp1(tcd,wcd,tdi);

nday = (tce(end)-tce(1));
nd12 = floor(nday*24);
[yr,mo,dy,hr,min,sec] = datevec(tce);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tce(1) & ti <= tce(end));
tei = ti(k);
uei = interp1(tce,uce,tei);
vei = interp1(tce,vce,tei);
wei = interp1(tce,wce,tei);

nday = floor((tei(end)-tai(1)));
nd12 = floor(nday*30);
[yr,mo,dy,hr,min,sec] = datevec(tac);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tac(1) & ti <= tce(end));
ti = ti(k);
[c,ia,ib] = intersect(tai,ti);
ui = NaN(length(ti),1);
vi = NaN(length(ti),1);
wi = NaN(length(ti),1);
ui(ib) = uai;
vi(ib) = vai;
wi(ib) = wai;
[c,ia,ib] = intersect(tbi,ti);
ui(ib) = ubi;
vi(ib) = vbi;
wi(ib) = wbi;
[c,ia,ic] = intersect(tci,ti);
ui(ic) = uci;
vi(ic) = vci;
wi(ic) = wci;
[c,ia,ic] = intersect(tci,ti);
ui(ic) = uci;
vi(ic) = vci;
wi(ic) = wci;
[d,ia,id] = intersect(tdi,ti);
ui(id) = udi;
vi(id) = vdi;
wi(id) = wdi;
[d,ia,ie] = intersect(tei,ti);
ui(ie) = uei;
vi(ie) = vei;
wi(ie) = wei;

FR5.t = ti;
FR5.u = ui;
FR5.v = vi;
FR5.w = wi;
save FR5 FR5

clear

load RT4a
load RT4b
load RT4c
load RT4d
load RT4e

ua = mean(RT4a.u(:,1:5),2);
va = mean(RT4a.v(:,1:5),2);
wa = mean(RT4a.w(:,1:5),2);
ub = mean(RT4b.u(:,1:5),2);
vb = mean(RT4b.v(:,1:5),2);
wb = mean(RT4b.w(:,1:5),2);
uc = mean(RT4c.u(:,1:5),2);
vc = mean(RT4c.v(:,1:5),2);
wc = mean(RT4c.w(:,1:5),2);
ud = mean(RT4d.u(:,1:5),2);
vd = mean(RT4d.v(:,1:5),2);
wd = mean(RT4d.w(:,1:5),2);
ue = mean(RT4e.u(:,1:5),2);
ve = mean(RT4e.v(:,1:5),2);
we = mean(RT4e.w(:,1:5),2);
ta = RT4a.t;
tb = RT4b.t;
tc = RT4c.t;
td = RT4d.t;
te = RT4e.t;

%form daily averages

nday = floor(te(end)-ta(1));

uac = conv(ua,ones(4*24,1)/(4*24),'valid');
ubc = conv(ub,ones(4*24,1)/(4*24),'valid');
ucc = conv(uc,ones(4*24,1)/(4*24),'valid');
ucd = conv(ud,ones(4*24,1)/(4*24),'valid');
uce = conv(ue,ones(4*24,1)/(4*24),'valid');
vac = conv(va,ones(4*24,1)/(4*24),'valid');
vbc = conv(vb,ones(4*24,1)/(4*24),'valid');
vcc = conv(vc,ones(4*24,1)/(4*24),'valid');
vcd = conv(vd,ones(4*24,1)/(4*24),'valid');
vce = conv(ve,ones(4*24,1)/(4*24),'valid');
wac = conv(wa,ones(4*24,1)/(4*24),'valid');
wbc = conv(wb,ones(4*24,1)/(4*24),'valid');
wcc = conv(wc,ones(4*24,1)/(4*24),'valid');
wcd = conv(wd,ones(4*24,1)/(4*24),'valid');
wce = conv(we,ones(4*24,1)/(4*24),'valid');
tac = conv(ta,ones(4*24,1)/(4*24),'valid');
tbc = conv(tb,ones(4*24,1)/(4*24),'valid');
tcc = conv(tc,ones(4*24,1)/(4*24),'valid');
tcd = conv(td,ones(4*24,1)/(4*24),'valid');
tce = conv(te,ones(4*24,1)/(4*24),'valid');

%plot every 12 hours

nday = (tac(end)-tac(1));
nd12 = floor(nday*24);
[yr,mo,dy,hr,min,sec] = datevec(tac);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tac(1) & ti <= tac(end));
tai = ti(k);
uai = interp1(tac,uac,tai);
vai = interp1(tac,vac,tai);
wai = interp1(tac,wac,tai);

nday = (tbc(end)-tbc(1));
nd12 = floor(nday*24);
[yr,mo,dy,hr,min,sec] = datevec(tbc);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tbc(1) & ti <= tbc(end));
tbi = ti(k);
ubi = interp1(tbc,ubc,tbi);
vbi = interp1(tbc,vbc,tbi);
wbi = interp1(tbc,wbc,tbi);

nday = (tcc(end)-tcc(1));
nd12 = floor(nday*24);
[yr,mo,dy,hr,min,sec] = datevec(tcc);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tcc(1) & ti <= tcc(end));
tci = ti(k);
uci = interp1(tcc,ucc,tci);
vci = interp1(tcc,vcc,tci);
wci = interp1(tcc,wcc,tci);

nday = (tcd(end)-tcd(1));
nd12 = floor(nday*24);
[yr,mo,dy,hr,min,sec] = datevec(tcd);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tcd(1) & ti <= tcd(end));
tdi = ti(k);
udi = interp1(tcd,ucd,tdi);
vdi = interp1(tcd,vcd,tdi);
wdi = interp1(tcd,wcd,tdi);

nday = (tce(end)-tce(1));
nd12 = floor(nday*24);
[yr,mo,dy,hr,min,sec] = datevec(tce);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tce(1) & ti <= tce(end));
tei = ti(k);
uei = interp1(tce,uce,tei);
vei = interp1(tce,vce,tei);
wei = interp1(tce,wce,tei);

nday = floor((tei(end)-tai(1)));
nd12 = floor(nday*30);
[yr,mo,dy,hr,min,sec] = datevec(tac);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tac(1) & ti <= tce(end));
ti = ti(k);
[c,ia,ib] = intersect(tai,ti);
ui = NaN(length(ti),1);
vi = NaN(length(ti),1);
wi = NaN(length(ti),1);
ui(ib) = uai;
vi(ib) = vai;
wi(ib) = wai;
[c,ia,ib] = intersect(tbi,ti);
ui(ib) = ubi;
vi(ib) = vbi;
wi(ib) = wbi;
[c,ia,ic] = intersect(tci,ti);
ui(ic) = uci;
vi(ic) = vci;
wi(ic) = wci;
[d,ia,id] = intersect(tdi,ti);
ui(id) = udi;
vi(id) = vdi;
wi(id) = wdi;
[d,ia,ie] = intersect(tei,ti);
ui(ie) = uei;
vi(ie) = vei;
wi(ie) = wei;

RT4.t = ti;
RT4.u = ui;
RT4.v = vi;
RT4.w = wi;
save RT4 RT4



clear

load FR9a
load FR9b
load FR9c
load FR9d
load FR9e

ua = mean(FR9a.u(:,1:5),2);
va = mean(FR9a.v(:,1:5),2);
wa = mean(FR9a.w(:,1:5),2);
ub = mean(FR9b.u(:,1:5),2);
vb = mean(FR9b.v(:,1:5),2);
wb = mean(FR9b.w(:,1:5),2);
uc = mean(FR9c.u(:,1:5),2);
vc = mean(FR9c.v(:,1:5),2);
wc = mean(FR9c.w(:,1:5),2);
ud = mean(FR9d.u(:,1:5),2);
vd = mean(FR9d.v(:,1:5),2);
wd = mean(FR9d.w(:,1:5),2);
ue = mean(FR9e.u(:,1:5),2);
ve = mean(FR9e.v(:,1:5),2);
we = mean(FR9e.w(:,1:5),2);
ta = FR9a.t;
tb = FR9b.t;
tc = FR9c.t;
td = FR9d.t;
te = FR9e.t;

%form daily averages

nday = floor(te(end)-ta(1));

uac = conv(ua,ones(4*24,1)/(4*24),'valid');
ubc = conv(ub,ones(4*24,1)/(4*24),'valid');
ucc = conv(uc,ones(4*24,1)/(4*24),'valid');
ucd = conv(ud,ones(4*24,1)/(4*24),'valid');
uce = conv(ue,ones(4*24,1)/(4*24),'valid');
vac = conv(va,ones(4*24,1)/(4*24),'valid');
vbc = conv(vb,ones(4*24,1)/(4*24),'valid');
vcc = conv(vc,ones(4*24,1)/(4*24),'valid');
vcd = conv(vd,ones(4*24,1)/(4*24),'valid');
vce = conv(ve,ones(4*24,1)/(4*24),'valid');
wac = conv(wa,ones(4*24,1)/(4*24),'valid');
wbc = conv(wb,ones(4*24,1)/(4*24),'valid');
wcc = conv(wc,ones(4*24,1)/(4*24),'valid');
wcd = conv(wd,ones(4*24,1)/(4*24),'valid');
wce = conv(we,ones(4*24,1)/(4*24),'valid');
tac = conv(ta,ones(4*24,1)/(4*24),'valid');
tbc = conv(tb,ones(4*24,1)/(4*24),'valid');
tcc = conv(tc,ones(4*24,1)/(4*24),'valid');
tcd = conv(td,ones(4*24,1)/(4*24),'valid');
tce = conv(te,ones(4*24,1)/(4*24),'valid');

%plot every 12 hours

nday = (tac(end)-tac(1));
nd12 = floor(nday*24);
[yr,mo,dy,hr,min,sec] = datevec(tac);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tac(1) & ti <= tac(end));
tai = ti(k);
uai = interp1(tac,uac,tai);
vai = interp1(tac,vac,tai);
wai = interp1(tac,wac,tai);

nday = (tbc(end)-tbc(1));
nd12 = floor(nday*24);
[yr,mo,dy,hr,min,sec] = datevec(tbc);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tbc(1) & ti <= tbc(end));
tbi = ti(k);
ubi = interp1(tbc,ubc,tbi);
vbi = interp1(tbc,vbc,tbi);
wbi = interp1(tbc,wbc,tbi);

nday = (tcc(end)-tcc(1));
nd12 = floor(nday*24);
[yr,mo,dy,hr,min,sec] = datevec(tcc);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tcc(1) & ti <= tcc(end));
tci = ti(k);
uci = interp1(tcc,ucc,tci);
vci = interp1(tcc,vcc,tci);
wci = interp1(tcc,wcc,tci);

nday = (tcd(end)-tcd(1));
nd12 = floor(nday*24);
[yr,mo,dy,hr,min,sec] = datevec(tcd);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tcd(1) & ti <= tcd(end));
tdi = ti(k);
udi = interp1(tcd,ucd,tdi);
vdi = interp1(tcd,vcd,tdi);
wdi = interp1(tcd,wcd,tdi);

nday = (tce(end)-tce(1));
nd12 = floor(nday*24);
[yr,mo,dy,hr,min,sec] = datevec(tce);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tce(1) & ti <= tce(end));
tei = ti(k);
uei = interp1(tce,uce,tei);
vei = interp1(tce,vce,tei);
wei = interp1(tce,wce,tei);


nday = floor((tei(end)-tai(1)));
nd12 = floor(nday*30);
[yr,mo,dy,hr,min,sec] = datevec(tac);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tac(1) & ti <= tce(end));
ti = ti(k);
[c,ia,ib] = intersect(tai,ti);
ui = NaN(length(ti),1);
vi = NaN(length(ti),1);
wi = NaN(length(ti),1);
ui(ib) = uai;
vi(ib) = vai;
wi(ib) = wai;
[c,ia,ib] = intersect(tbi,ti);
ui(ib) = ubi;
vi(ib) = vbi;
wi(ib) = wbi;
[c,ia,ic] = intersect(tci,ti);
ui(ic) = uci;
vi(ic) = vci;
wi(ic) = wci;
[d,ia,id] = intersect(tdi,ti);
ui(id) = udi;
vi(id) = vdi;
wi(id) = wdi;
[d,ia,ie] = intersect(tei,ti);
ui(ie) = uei;
vi(ie) = vei;
wi(ie) = wei;

FR9.t = ti;
FR9.u = ui;
FR9.v = vi;
FR9.w = wi;
save FR9 FR9

clear

load FR7a
load FR7b
load FR7c
load FR7d
load FR7e

ua = mean(FR7a.u(:,1:5),2);
va = mean(FR7a.v(:,1:5),2);
wa = mean(FR7a.w(:,1:5),2);
ub = mean(FR7b.u(:,1:5),2);
vb = mean(FR7b.v(:,1:5),2);
wb = mean(FR7b.w(:,1:5),2);
uc = mean(FR7c.u(:,1:5),2);
vc = mean(FR7c.v(:,1:5),2);
wc = mean(FR7c.w(:,1:5),2);
ud = mean(FR7d.u(:,1:5),2);
vd = mean(FR7d.v(:,1:5),2);
wd = mean(FR7d.w(:,1:5),2);
ue = mean(FR7e.u(:,1:5),2);
ve = mean(FR7e.v(:,1:5),2);
we = mean(FR7e.w(:,1:5),2);
ta = FR7a.t;
tb = FR7b.t;
tc = FR7c.t;
td = FR7d.t;
te = FR7e.t;

%form daily averages

nday = floor(te(end)-ta(1));

uac = conv(ua,ones(4*24,1)/(4*24),'valid');
ubc = conv(ub,ones(4*24,1)/(4*24),'valid');
ucc = conv(uc,ones(4*24,1)/(4*24),'valid');
ucd = conv(ud,ones(4*24,1)/(4*24),'valid');
uce = conv(ue,ones(4*24,1)/(4*24),'valid');
vac = conv(va,ones(4*24,1)/(4*24),'valid');
vbc = conv(vb,ones(4*24,1)/(4*24),'valid');
vcc = conv(vc,ones(4*24,1)/(4*24),'valid');
vcd = conv(vd,ones(4*24,1)/(4*24),'valid');
vce = conv(ve,ones(4*24,1)/(4*24),'valid');
wac = conv(wa,ones(4*24,1)/(4*24),'valid');
wbc = conv(wb,ones(4*24,1)/(4*24),'valid');
wcc = conv(wc,ones(4*24,1)/(4*24),'valid');
wcd = conv(wd,ones(4*24,1)/(4*24),'valid');
wce = conv(we,ones(4*24,1)/(4*24),'valid');
tac = conv(ta,ones(4*24,1)/(4*24),'valid');
tbc = conv(tb,ones(4*24,1)/(4*24),'valid');
tcc = conv(tc,ones(4*24,1)/(4*24),'valid');
tcd = conv(td,ones(4*24,1)/(4*24),'valid');
tce = conv(te,ones(4*24,1)/(4*24),'valid');

%plot every 12 hours

nday = (tac(end)-tac(1));
nd12 = floor(nday*24);
[yr,mo,dy,hr,min,sec] = datevec(tac);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tac(1) & ti <= tac(end));
tai = ti(k);
uai = interp1(tac,uac,tai);
vai = interp1(tac,vac,tai);
wai = interp1(tac,wac,tai);

nday = (tbc(end)-tbc(1));
nd12 = floor(nday*24);
[yr,mo,dy,hr,min,sec] = datevec(tbc);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tbc(1) & ti <= tbc(end));
tbi = ti(k);
ubi = interp1(tbc,ubc,tbi);
vbi = interp1(tbc,vbc,tbi);
wbi = interp1(tbc,wbc,tbi);

nday = (tcc(end)-tcc(1));
nd12 = floor(nday*24);
[yr,mo,dy,hr,min,sec] = datevec(tcc);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tcc(1) & ti <= tcc(end));
tci = ti(k);
uci = interp1(tcc,ucc,tci);
vci = interp1(tcc,vcc,tci);
wci = interp1(tcc,wcc,tci);

nday = (tcd(end)-tcd(1));
nd12 = floor(nday*24);
[yr,mo,dy,hr,min,sec] = datevec(tcd);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tcd(1) & ti <= tcd(end));
tdi = ti(k);
udi = interp1(tcd,ucd,tdi);
vdi = interp1(tcd,vcd,tdi);
wdi = interp1(tcd,wcd,tdi);

nday = (tce(end)-tce(1));
nd12 = floor(nday*24);
[yr,mo,dy,hr,min,sec] = datevec(tce);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tce(1) & ti <= tce(end));
tei = ti(k);
uei = interp1(tce,uce,tei);
vei = interp1(tce,vce,tei);
wei = interp1(tce,wce,tei);


nday = floor((tei(end)-tai(1)));
nd12 = floor(nday*30);
[yr,mo,dy,hr,min,sec] = datevec(tac);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tac(1) & ti <= tce(end));
ti = ti(k);
[c,ia,ib] = intersect(tai,ti);
ui = NaN(length(ti),1);
vi = NaN(length(ti),1);
wi = NaN(length(ti),1);
ui(ib) = uai;
vi(ib) = vai;
wi(ib) = wai;
[c,ia,ib] = intersect(tbi,ti);
ui(ib) = ubi;
vi(ib) = vbi;
wi(ib) = wbi;
[c,ia,ic] = intersect(tci,ti);
ui(ic) = uci;
vi(ic) = vci;
wi(ic) = wci;
[d,ia,id] = intersect(tdi,ti);
ui(id) = udi;
vi(id) = vdi;
wi(id) = wdi;
[d,ia,ie] = intersect(tei,ti);
ui(ie) = uei;
vi(ie) = vei;
wi(ie) = wei;

FR7.t = ti;
FR7.u = ui;
FR7.v = vi;
FR7.w = wi;
save FR7 FR7

clear

load FR5a
load FR5b
load FR5c
load FR5d
load FR5e

ua = mean(FR5a.u(:,1:5),2);
va = mean(FR5a.v(:,1:5),2);
wa = mean(FR5a.w(:,1:5),2);
ub = mean(FR5b.u(:,1:5),2);
vb = mean(FR5b.v(:,1:5),2);
wb = mean(FR5b.w(:,1:5),2);
uc = mean(FR5c.u(:,1:5),2);
vc = mean(FR5c.v(:,1:5),2);
wc = mean(FR5c.w(:,1:5),2);
ud = mean(FR5d.u(:,1:5),2);
vd = mean(FR5d.v(:,1:5),2);
wd = mean(FR5d.w(:,1:5),2);
ue = mean(FR5e.u(:,1:5),2);
ve = mean(FR5e.v(:,1:5),2);
we = mean(FR5e.w(:,1:5),2);
ta = FR5a.t;
tb = FR5b.t;
tc = FR5c.t;
td = FR5d.t;
te = FR5e.t;

%form daily averages

nday = floor(te(end)-ta(1));

uac = conv(ua,ones(4*24,1)/(4*24),'valid');
ubc = conv(ub,ones(4*24,1)/(4*24),'valid');
ucc = conv(uc,ones(4*24,1)/(4*24),'valid');
ucd = conv(ud,ones(4*24,1)/(4*24),'valid');
uce = conv(ue,ones(4*24,1)/(4*24),'valid');
vac = conv(va,ones(4*24,1)/(4*24),'valid');
vbc = conv(vb,ones(4*24,1)/(4*24),'valid');
vcc = conv(vc,ones(4*24,1)/(4*24),'valid');
vcd = conv(vd,ones(4*24,1)/(4*24),'valid');
vce = conv(ve,ones(4*24,1)/(4*24),'valid');
wac = conv(wa,ones(4*24,1)/(4*24),'valid');
wbc = conv(wb,ones(4*24,1)/(4*24),'valid');
wcc = conv(wc,ones(4*24,1)/(4*24),'valid');
wcd = conv(wd,ones(4*24,1)/(4*24),'valid');
wce = conv(we,ones(4*24,1)/(4*24),'valid');
tac = conv(ta,ones(4*24,1)/(4*24),'valid');
tbc = conv(tb,ones(4*24,1)/(4*24),'valid');
tcc = conv(tc,ones(4*24,1)/(4*24),'valid');
tcd = conv(td,ones(4*24,1)/(4*24),'valid');
tce = conv(te,ones(4*24,1)/(4*24),'valid');

%plot every 12 hours

nday = (tac(end)-tac(1));
nd12 = floor(nday*24);
[yr,mo,dy,hr,min,sec] = datevec(tac);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tac(1) & ti <= tac(end));
tai = ti(k);
uai = interp1(tac,uac,tai);
vai = interp1(tac,vac,tai);
wai = interp1(tac,wac,tai);

nday = (tbc(end)-tbc(1));
nd12 = floor(nday*24);
[yr,mo,dy,hr,min,sec] = datevec(tbc);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tbc(1) & ti <= tbc(end));
tbi = ti(k);
ubi = interp1(tbc,ubc,tbi);
vbi = interp1(tbc,vbc,tbi);
wbi = interp1(tbc,wbc,tbi);

nday = (tcc(end)-tcc(1));
nd12 = floor(nday*24);
[yr,mo,dy,hr,min,sec] = datevec(tcc);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tcc(1) & ti <= tcc(end));
tci = ti(k);
uci = interp1(tcc,ucc,tci);
vci = interp1(tcc,vcc,tci);
wci = interp1(tcc,wcc,tci);

nday = (tcd(end)-tcd(1));
nd12 = floor(nday*24);
[yr,mo,dy,hr,min,sec] = datevec(tcd);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tcd(1) & ti <= tcd(end));
tdi = ti(k);
udi = interp1(tcd,ucd,tdi);
vdi = interp1(tcd,vcd,tdi);
wdi = interp1(tcd,wcd,tdi);

nday = (tce(end)-tce(1));
nd12 = floor(nday*24);
[yr,mo,dy,hr,min,sec] = datevec(tce);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tce(1) & ti <= tce(end));
tei = ti(k);
uei = interp1(tce,uce,tei);
vei = interp1(tce,vce,tei);
wei = interp1(tce,wce,tei);



nday = floor((tei(end)-tai(1)));
nd12 = floor(nday*30);
[yr,mo,dy,hr,min,sec] = datevec(tac);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tac(1) & ti <= tce(end));
ti = ti(k);
[c,ia,ib] = intersect(tai,ti);
ui = NaN(length(ti),1);
vi = NaN(length(ti),1);
wi = NaN(length(ti),1);
ui(ib) = uai;
vi(ib) = vai;
wi(ib) = wai;
[c,ia,ib] = intersect(tbi,ti);
ui(ib) = ubi;
vi(ib) = vbi;
wi(ib) = wbi;
[c,ia,ic] = intersect(tci,ti);
ui(ic) = uci;
vi(ic) = vci;
wi(ic) = wci;
[d,ia,id] = intersect(tdi,ti);
ui(id) = udi;
vi(id) = vdi;
wi(id) = wdi;
[d,ia,ie] = intersect(tei,ti);
ui(ie) = uei;
vi(ie) = vei;
wi(ie) = wei;

FR5.t = ti;
FR5.u = ui;
FR5.v = vi;
FR5.w = wi;
save FR5 FR5



clear

load CHLa
load CHLb
load CHLc
load CHLd
load CHLe

ua = mean(CHLa.u(:,1:5),2);
va = mean(CHLa.v(:,1:5),2);
wa = mean(CHLa.w(:,1:5),2);
ub = mean(CHLb.u(:,1:5),2);
vb = mean(CHLb.v(:,1:5),2);
wb = mean(CHLb.w(:,1:5),2);
uc = mean(CHLc.u(:,1:5),2);
vc = mean(CHLc.v(:,1:5),2);
wc = mean(CHLc.w(:,1:5),2);
ud = mean(CHLd.u(:,1:5),2);
vd = mean(CHLd.v(:,1:5),2);
wd = mean(CHLd.w(:,1:5),2);
ue = mean(CHLe.u(:,1:5),2);
ve = mean(CHLe.v(:,1:5),2);
we = mean(CHLe.w(:,1:5),2);
ta = CHLa.t;
tb = CHLb.t;
tc = CHLc.t;
td = CHLd.t;
te = CHLe.t;

%form daily averages

nday = floor(td(end)-ta(1));

uac = conv(ua,ones(4*24,1)/(4*24),'valid');
ubc = conv(ub,ones(4*24,1)/(4*24),'valid');
ucc = conv(uc,ones(4*24,1)/(4*24),'valid');
ucd = conv(ud,ones(4*24,1)/(4*24),'valid');
uce = conv(ue,ones(4*24,1)/(4*24),'valid');
vac = conv(va,ones(4*24,1)/(4*24),'valid');
vbc = conv(vb,ones(4*24,1)/(4*24),'valid');
vcc = conv(vc,ones(4*24,1)/(4*24),'valid');
vcd = conv(vd,ones(4*24,1)/(4*24),'valid');
vce = conv(ve,ones(4*24,1)/(4*24),'valid');
wac = conv(wa,ones(4*24,1)/(4*24),'valid');
wbc = conv(wb,ones(4*24,1)/(4*24),'valid');
wcc = conv(wc,ones(4*24,1)/(4*24),'valid');
wcd = conv(wd,ones(4*24,1)/(4*24),'valid');
wce = conv(we,ones(4*24,1)/(4*24),'valid');
tac = conv(ta,ones(4*24,1)/(4*24),'valid');
tbc = conv(tb,ones(4*24,1)/(4*24),'valid');
tcc = conv(tc,ones(4*24,1)/(4*24),'valid');
tcd = conv(td,ones(4*24,1)/(4*24),'valid');
tce = conv(te,ones(4*24,1)/(4*24),'valid');

%plot every 12 hours

nday = (tac(end)-tac(1));
nd12 = floor(nday*24);
[yr,mo,dy,hr,min,sec] = datevec(tac);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tac(1) & ti <= tac(end));
tai = ti(k);
uai = interp1(tac,uac,tai);
vai = interp1(tac,vac,tai);
wai = interp1(tac,wac,tai);

nday = (tbc(end)-tbc(1));
nd12 = floor(nday*24);
[yr,mo,dy,hr,min,sec] = datevec(tbc);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tbc(1) & ti <= tbc(end));
tbi = ti(k);
ubi = interp1(tbc,ubc,tbi);
vbi = interp1(tbc,vbc,tbi);
wbi = interp1(tbc,wbc,tbi);

nday = (tcc(end)-tcc(1));
nd12 = floor(nday*24);
[yr,mo,dy,hr,min,sec] = datevec(tcc);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tcc(1) & ti <= tcc(end));
tci = ti(k);
uci = interp1(tcc,ucc,tci);
vci = interp1(tcc,vcc,tci);
wci = interp1(tcc,wcc,tci);

nday = (tcd(end)-tcd(1));
nd12 = floor(nday*24);
[yr,mo,dy,hr,min,sec] = datevec(tcd);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tcd(1) & ti <= tcd(end));
tdi = ti(k);
udi = interp1(tcd,ucd,tdi);
vdi = interp1(tcd,vcd,tdi);
wdi = interp1(tcd,wcd,tdi);

nday = (tce(end)-tce(1));
nd12 = floor(nday*24);
[yr,mo,dy,hr,min,sec] = datevec(tce);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tce(1) & ti <= tce(end));
tei = ti(k);
uei = interp1(tce,uce,tei);
vei = interp1(tce,vce,tei);
wei = interp1(tce,wce,tei);


nday = floor((tei(end)-tai(1)));
nd12 = floor(nday*30);
[yr,mo,dy,hr,min,sec] = datevec(tac);
ti = datenum(yr(1),mo(1),dy(1),(0:12:nd12)',0,0);
k = find(ti>= tac(1) & ti <= tce(end));
ti = ti(k);
[c,ia,ib] = intersect(tai,ti);
ui = NaN(length(ti),1);
vi = NaN(length(ti),1);
wi = NaN(length(ti),1);
ui(ib) = uai;
vi(ib) = vai;
wi(ib) = wai;
[c,ia,ib] = intersect(tbi,ti);
ui(ib) = ubi;
vi(ib) = vbi;
wi(ib) = wbi;
[c,ia,ic] = intersect(tci,ti);
ui(ic) = uci;
vi(ic) = vci;
wi(ic) = wci;
[c,ia,id] = intersect(tdi,ti);
ui(id) = udi;
vi(id) = vdi;
wi(id) = wdi;
[c,ia,ie] = intersect(tei,ti);
ui(ie) = uei;
vi(ie) = vei;
wi(ie) = wei;

CHL.t = ti;
CHL.u = ui;
CHL.v = vi;
CHL.w = wi;
save CHL CHL

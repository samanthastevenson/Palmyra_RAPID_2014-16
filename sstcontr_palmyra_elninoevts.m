% Calculate contribution of SST to coral d18O at Palmyra during the 2014-15
% and 2015-16 El Nino events
% July 2020
% Sam Stevenson

%%%%% Set time periods of interest
% Old (2020) values
%pk14=[datenum(2015,7,1) datenum(2015,9,30)];
%pk15=[datenum(2014,9,1) datenum(2014,12,31)];

% Update 4/2023 for consistency with other analyses
pk14=[datenum(2014,11,1) datenum(2015,1,31)];
pk15=[datenum(2015,7,1) datenum(2015,9,30)];
basel=[datenum(2003,1,1) datenum(2013,12,31)];

% Coral d18O
load('~/Box Sync/PalmyraFieldwork/Data/Minicores/SanchezPalmyrad18Odata_jul2020.mat')

% Atoll-averaged temperature

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

% Calculate SST difference: peak vs. baseline
myt14=find(tarr_dy >= pk14(1) & tarr_dy <= pk14(2));
myt15=find(tarr_dy >= pk15(1) & tarr_dy <= pk15(2));
mytbase=find(tarr_dy >= basel(1) & tarr_dy <= basel(2));
sstd14=nanmean(palmntemp(myt14))-nanmean(palmntemp(mytbase));
sstd15=nanmean(palmntemp(myt15))-nanmean(palmntemp(mytbase));

% Calculate coral d18O change: peak vs. baseline
coraldiff14=[];
coraldiff15=[];
% RT10
myt14=find(RT10(:,1) >= pk14(1) & RT10(:,1) <= pk14(2));
myt15=find(RT10(:,1) >= pk15(1) & RT10(:,1) <= pk15(2));
mytbase=find(RT10(:,1) >= basel(1) & RT10(:,1) <= basel(2));
coraldiff14=cat(1,coraldiff14,nanmean(RT10(myt14,2))-nanmean(RT10(mytbase,2)));
coraldiff15=cat(1,coraldiff15,nanmean(RT10(myt15,2))-nanmean(RT10(mytbase,2)));

% RT4
myt14=find(RT4(:,1) >= pk14(1) & RT4(:,1) <= pk14(2));
myt15=find(RT4(:,1) >= pk15(1) & RT4(:,1) <= pk15(2));
mytbase=find(RT4(:,1) >= basel(1) & RT4(:,1) <= basel(2));
coraldiff14=cat(1,coraldiff14,nanmean(RT4(myt14,2))-nanmean(RT4(mytbase,2)));
coraldiff15=cat(1,coraldiff15,nanmean(RT4(myt15,2))-nanmean(RT4(mytbase,2)));

% RT4S
myt14=find(RT4S(:,1) >= pk14(1) & RT4S(:,1) <= pk14(2));
myt15=find(RT4S(:,1) >= pk15(1) & RT4S(:,1) <= pk15(2));
mytbase=find(RT4S(:,1) >= basel(1) & RT4S(:,1) <= basel(2));
coraldiff14=cat(1,coraldiff14,nanmean(RT4S(myt14,2))-nanmean(RT4S(mytbase,2)));
coraldiff15=cat(1,coraldiff15,nanmean(RT4S(myt15,2))-nanmean(RT4S(mytbase,2)));

% Calculate SST contribution to coral d18O signal
sstcontr14=(-0.2*sstd14)/nanmean(coraldiff14);
sstcontr15=(-0.2*sstd15)/nanmean(coraldiff15);

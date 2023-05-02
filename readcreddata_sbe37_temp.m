% Read in SBE37 data from CRED deployments, pre-2012
% July 2020
% Sam Stevenson

function [tarr,datarr,sitenames]=readcreddata_sbe37_temp

    sitenames={'SBE1887','SBE1940','SBE2141','SBE2690','SBE2979','SBE4822','FR3'};
    tarr=cell(length(sitenames),1);
    datarr=cell(length(sitenames),1);
    
    load('~/Box Sync/PalmyraFieldwork/CREDdata/pal_sbe37s_data_2012.mat')
    load('~/Box Sync/PalmyraFieldwork/CREDdata/FR3_Samantha.mat')
    
    tarr{1}=date_1887;
    datarr{1}=sbe37_1887(:,7);
    tarr{2}=date_1940;
    datarr{2}=sbe37_1940(:,7);
    tarr{3}=date_2141;
    datarr{3}=sbe37_2141(:,7); 
    tarr{4}=date_2690;
    datarr{4}=sbe37_2690(:,7);
    tarr{5}=date_2979;
    datarr{5}=sbe37_2979(:,7);
    tarr{6}=date_4822;
    datarr{6}=sbe37_4822(:,7);
    tarr{7}=FR3(:,1);
    datarr{7}=FR3(:,2);

end
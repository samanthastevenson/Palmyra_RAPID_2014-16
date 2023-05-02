# Stevenson et al. (2023)
## Contrasting central equatorial Pacific oxygen isotopic signatures of the 2014/15 and 2015/16 El Nino events
-------------------------------------------
This repository contains all codes used to generate figures in Stevenson et al. (2023), GRL. The following is a list of the codes included, organized according to the type of functionality performed by each.

_Data pre-processing and I/O for in situ oceanographic observations_:

- readsbe37data_temp_interp.m: Helper function for reading in temperature data from 2014-16 deployment SBE37s.
- readsbe56data_temp_interp.m: Helper function for reading in temperature data from 2014-16 deployment SBE56s.
- readcreddata_sbe37_temp.m: Helper function for reading in data from NOAA CRED SBE37s.
- readsbedata_salt_interp.m: Helper function for reading in salinity data from 2014-16 deployment SBE37s.
- readaqddata_temp.m: Helper function for reading in temperature data from 2014-16 deployment Aquadopps.

_Plotting in situ observational and gridded data products_:

- nino34_ersstoisst.m: Plots NINO3.4 SST from the ERSSTv5 and OISSTv2 products. Used in main-text Figure 1a
- palmyratemp_dailyavg_allinst.m: Plots temperature data from all 2014-16 deployments. Used in main-text Figure 1c.
- palmyrasal_dailyavg_allinst.m: Plots temperature data from all 2014-16 deployments. Used in main-text Figure 1d.
- palmyrapd18op_wsatellite.m: Plots precipitation and d18O of precipitation collected from Palmyra weather station. Used in main-text Figure 1e.

- palmyra_rapid_cred_satellite.m: Plots temperature information from all in situ measurements including CRED. Used in Supplementary Figure S2.
- rainvsalinity.m: Plots rainfall versus salinity for Palmyra. Used in Supplementary Figure S8.

_Coral mini-core data I/O and calculation of SST contribution to coral d18O_:

- minicore_d18osw.m: plots mini-core coral d18O records along with bottle samples of salinity and seawater d18O. Used in main-text Figure 1b
- sstcontr_palmyra_elninoevts.m: calculates the contribution of SST to coral d18O using atoll-mean in situ temperature and Palmyra mini-core coral d18O. Used in main-text Table 1.

_isoROMS assimilation analyses_:

- enanomcomp_romsassim.m: Calculates composite anomalies in isoROMS assimilation fields. Used in main-text Figure 2.
- calc_anomd18oswbudget_assim.m: Helper function which does the computation of the Reynolds-decomposed budget of seawater d18O. 
- d18oswbudgetcomp_rd_romsassim.m: Makes composite maps of the terms in the Reynolds-decomposed seawater d18O budget. Used in main-text Figure 3.
- d18Oswbudgetts_rd_romsassim.m: Plots time series of terms in the Reynolds-decomposed seawater d18O budget. Used in main-text Figure 3.


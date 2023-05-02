# Stevenson et al. (2023)
## Contrasting central equatorial Pacific oxygen isotopic signatures of the 2014/15 and 2015/16 El Nino events
-------------------------------------------
This repository contains all codes used to generate figures in Stevenson et al. (2023), GRL. The following is a list of the codes included, organized according to the type of functionality performed by each.

_Data pre-processing and I/O for in situ oceanographic observations_:

- readsbe37data_temp_interp.m
- readsbe56data_temp_interp.m
- readcreddata_sbe37_temp.m
- readsbedata_salt_interp.m
- readaqddata_temp.m
- palmyratemp_dailyavg_allinst.m

_Coral mini-core data I/O and calculation of SST contribution to coral d18O_:

- minicore_d18osw.m
- sstcontr_palmyra_elninoevts.m

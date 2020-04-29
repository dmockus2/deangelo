# deangelo
This project verifies that the homicides reported in [CDC WONDER](https://wonder.cdc.gov/mortSQL.html "Compressed Mortality File") exclude foreign resident deaths.

## Prerequisites
To run this project, you will need:
 - Restricted access mortality data (alternatively, since the totals are national, you could use [public use mortality data](https://data.nber.org/data/vital-statistics-mortality-data-multiple-cause-of-death.html "from the NBER")
 - Take a look at the folder structure in the `analysis/data` folder; the codebooks in there come from the [public use mortality data](https://data.nber.org/data/vital-statistics-mortality-data-multiple-cause-of-death.html "from the NBER").
 
## run.do
The only code you need to edit will be `analysis/run.do` and adjust the paths where specified. However, if you only have access to [public use mortality data](https://data.nber.org/data/vital-statistics-mortality-data-multiple-cause-of-death.html "from the NBER"), make sure that your `analysis/data` folder is structured correctly or edit `analysis/1_process_raw_data' accordingly. 

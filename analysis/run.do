/*******************************************************************************
This do-file will run the do-files in order.
*******************************************************************************/

/*******************************************************************************
1. Set Up Workspace
*******************************************************************************/

clear all

global analysis "$deangelo" // CHANGE THIS TO POINT TO THE ANALYSIS FOLDER HERE

* raw restricted mortality data
global rawresmort "$BOX/UIUC/Research/Data_Storage/raw_data/20181219.Mockus" // CHANGE THIS TO POINT TO THE RESTRICTED MORTALITY FOLDER HERE

cd "$analysis"

* raw data
global raw "$analysis/data"

* intermediate data
global intermediate "$analysis/processed/intermediate"

* final data
global final "$analysis/processed"

do "$analysis/scripts/1_process_raw_data.do"

do "$analysis/scripts/2_clean_data.do"

do "$analysis/scripts/3_results.do"

* end of file
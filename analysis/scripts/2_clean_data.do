/*******************************************************************************
This do-file will clean the raw data.
*******************************************************************************/

/*******************************************************************************
1. Set Up Workspace
*******************************************************************************/

clear all

/*******************************************************************************
2. Download/Process Data
*******************************************************************************/

/*******************************************************************************
2.A. CDC WONDER
*******************************************************************************/

* load data
use "$intermediate/wonder"

keep year deaths
rename deaths homicides_wonder
label variable homicides_wonder "Number of Homicides Reported in CDC WONDER"

keep if inrange(year, 1995, 2009)

save "$final/final", replace

/*******************************************************************************
2.B. Restricted Mortality Statistics
*******************************************************************************/

forvalues year = 1995/2009 {

	use "$intermediate/mort`year'", clear
	
	if inrange(`year', 1995, 1998) {

		* tag relevant ICD-9 codes (960-969)
		tostring ucod, replace
		generate first_numbers = substr(ucod, 1, 2)
		generate homicides_mort = (first_numbers == "96")
		drop first_numbers

	}
	
	if inrange(`year', 1999, 2009) {

		* tag relevant ICD-10 codes (X85-Y09)
		generate homicides_mort = (inrange(substr(ucod, 1, 3), "X85", "X99") | inrange(substr(ucod, 1, 3), "Y00", "Y09"))

	}
	
	* indicate foreign residents
	generate foreign = (res == 4)

	collapse (sum) homicides_mort, by(foreign)

	generate year = `year'
	
	reshape wide homicides_mort, i(year) j(foreign)

	compress
	
	merge 1:1 year using "$final/final", assert(using match) nogen update
	
	save "$final/final", replace

}

label variable homicides_mort0 "US Resident Homicides"
label variable homicides_mort1 "Foreign Resident Homicides"

sort year

compress

save "$final/final", replace

* end of file
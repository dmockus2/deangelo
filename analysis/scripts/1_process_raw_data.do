/*******************************************************************************
This do-file will download/process the raw data.
*******************************************************************************/

/*******************************************************************************
1. Set Up Workspace
*******************************************************************************/

clear all

tempfile temporary1

/*******************************************************************************
2. Download/Process Data
*******************************************************************************/

/*******************************************************************************
2.A. CDC WONDER

We will consider this information as the "truth" to which to compare to. I obtain this data manually.

1. Go to https://wonder.cdc.gov/mortSQL.html
2. Select the appropriate years [NOTE: You will have to do this process twice for each set of years.]
3. Select "I Agree" at the bottom
4. OPTIONS:
 - 1. Organize table layout: Group Results By Year
 - 4. Select cause of death: 
   + For 1995 - 1998: E960-E969 (Homicide and injury purposely inflicted by other persons) [NOTE: You have to "Open" the list once.]
   + For 1999 - 2009: X85-Y09 (Assault) [NOTE: You have to "Open" the list once.]
5. Click "Send" at the bottom of the page
6. Export results
 - For 1995 - 1998, save as "Compressed Mortality, 1979-1998.txt"
 - For 1999 - 2009, save as "Compressed Mortality, 1999-2016.txt"
*******************************************************************************/

* import 1995 - 1998 data
import delimited "$raw/Compressed Mortality, 1979-1998.txt", clear

* drop notes in text
keep if year != .

* save data to temporary file
save `temporary1' 

* import 1999 - 2009 data
import delimited "$raw/Compressed Mortality, 1999-2016.txt", clear

* drop notes in text
keep if year != .

* append all years together
append using `temporary1'

sort year

compress

* save data
save "$intermediate/wonder", replace

/*******************************************************************************
2.B. Restricted Mortality Data
*******************************************************************************/

clear

forvalues year = 1995/2009 {
	
	if inrange(`year', 1995, 1998) {

		infix ///
			res			20		/// residency
			ucod		142-145 /// underlying cause of death code (ICD-9)
		using "$rawresmort/Mort`year'/MULT`year'.AllCnty.txt"
		
	}
		
	if `year' == 1999 {

		infix ///
			res			20		/// residency
			str ucod	142-145 /// underlying cause of death code (ICD-10)
		using "$rawresmort/Mort`year'/MULT`year'.AllCnty.txt"
		
	}
	
	if inrange(`year', 2000, 2002) {

		infix ///
			res			20		/// residency
			str ucod	142-145 /// underlying cause of death code (ICD-10)
		using "$rawresmort/Mort`year'/MULT`year'.USAllCnty.txt"
		
	}
	
		if inrange(`year', 2003, 2009) {

		infix ///
			res			20		/// residency
			str ucod	146-149 /// underlying cause of death code (ICD-10)
		using "$rawresmort/Mort`year'/MULT`year'.USAllCnty.txt"
		
	}
	
	compress

	save "$intermediate/mort`year'", replace

	clear
		
} 

* end of file
***********************************************************
*Creates Table 1: Summary Statistics 
***********************************************************
clear
capture log close
cd G:\daron\colonial_origins
log using maketable1, replace

/*Data Files Used
	maketable1.dta
	
*Data Files Created as Final Product
	none
	
*Data Files Created as Intermediate Product
	none*/
	

****************************
*---column 1 (whole world)
****************************

use maketable1, clear

*log GDP per capita, PPP, in 1995
summ logpgp95

*log output per worker in 1988
summ loghjypl

*Average protection against expropriation risk, 1985-1995
summ avexpr 

*Constraint on executive, 1900
summ cons00a

*Constraint on executive in first year of independence
summ cons1

*Democracy in 1900
summ democ00a

*European settlement in 1900
summ euro1900 


****************************
*---column 2 (base sample)
****************************

use maketable1, clear

keep if baseco==1

*log GDP per capita, PPP, in 1995
summ logpgp95

*log output per worker in 1988
summ loghjypl

*Average protection against expropriation risk, 1985-1995
summ avexpr 

*Constraint on executive, 1900
summ cons00a

*Constraint on executive in first year of independence
summ cons1

*Democracy in 1900
summ democ00a

*European settlement in 1900
summ euro1900 

*Log European settler mortality
summ logem4


****************************
*---columns 3-6 (quartiles)
****************************

*note - I am not sure what values of extmort4 were used to calculate quantiles, perhaps from an earlier version of the data that I do not have access to. Thus, I cannot exactly reproduce Table 1, but the summary statistics that emerge using quantiles of extmort4 in the final dataset are similar. 

*generate quartiles

egen rank=rank(extmort4), track
egen count=count(extmort4)
gen ptile=rank/count
gen q=.
replace q=1 if ptile<=.25
replace q=2 if (ptile>.25 & ptile<=.5)
replace q=3 if (ptile>.5 & ptile<=.75)
replace q=4 if ptile>.75
tab q


*log GDP per capita, PPP, in 1995
bys q: summ logpgp95

*log output per worker in 1988
bys q: summ loghjypl

*Average protection against expropriation risk, 1985-1995
bys q: summ avexpr 

*Constraint on executive, 1900
bys q: summ cons00a

*Constraint on executive in first year of independence
bys q: summ cons1

*Democracy in 1900
bys q: summ democ00a

*European settlement in 1900
bys q: summ euro1900 

*Log European settler mortality
bys q: summ logem4

capture log close


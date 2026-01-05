
clear

global rawdata "insert here file path to folder with raw data" //location of folder with all raw data files downloaded from UK Data Service

global derived "insert here file path to folder for the final derived dataset" //location of folder for derived data

*** prior non response
//Previous non-response (waves 2-7)	w7nr_cum	
use "$rawdata\ns9_2022_longitudinal_file.dta", clear
fre W1OUTCOME W2OUTCOME W3OUTCOME W4OUTCOME W5OUTCOME W6OUTCOME W7OUTCOME

cap drop w7nr_cum
egen w7nr_cum = anycount (W2OUTCOME W3OUTCOME W4OUTCOME W5OUTCOME W6OUTCOME W7OUTCOME), values(1)
recode w7nr_cum (0/5=1) (6=0)
label define w7nr_cum 0 "Complete response up to and including wave 7" 1 "One or more instances of non-response", replace
label values w7nr_cum w7nr_cum
fre w7nr_cum
label var w7nr_cum "Previous non-response (waves 2-7)"

keep NSID w7nr_cum
save "$derived\NRprior.dta", replace	


*** Sweep 1 (age 14)
//use "$rawdata\wave_one_lsype_household_grid_file_2020.dta", clear	
//use "$rawdata\wave_one_lsype_parental_attitudes_file_16_05_08.dta", clear	

use "$rawdata\wave_one_lsype_young_person_2020.dta", clear
merge 1:1 NSID using "$rawdata\wave_one_lsype_family_background_2020.dta", nogen

//Sex of the young person	W1sexYP
fre W1sexYP
replace W1sexYP=. if W1sexYP<0

//How often the young person's parents know where they going when they go out in the evening	W1gowhereYP
fre W1gowhereYP
replace W1gowhereYP=. if W1gowhereYP<0
replace  W1gowhereYP=3 if inrange(W1gowhereYP,4,5)
label define W1gowhereYP 3 "Sometimes-never", modify
label values W1gowhereYP W1gowhereYP
fre  W1gowhereYP   

//Whether the young person has been upset by name-calling, including by text or email, in the last 12 months	W1namesYP
fre W1namesYP
replace W1namesYP=. if W1namesYP<0
replace W1namesYP=0 if W1namesYP==2
label define W1namesYP 0 "No", modify
label values W1namesYP W1namesYP
fre W1namesYP

//Days per week the young person uses a home computer to play games	W1HcomGYP
fre W1HcomGYP
replace W1HcomGYP=. if W1HcomGYP<0
fre W1HcomGYP 

//Whether the young person has played a musical instrument in the last 4 weeks	W1alei1YP0h
fre W1alei1YP0h
replace W1alei1YP0h=. if W1alei1YP0h<0
fre W1alei1YP0h

//Housing tenure	W1hous12HH
fre W1hous12HH
replace W1hous12HH=. if W1hous12HH<0
replace W1hous12HH=2 if W1hous12HH==3
replace W1hous12HH=3 if inrange(W1hous12HH,4,8)
label define W1hous12HH 3 "Rented/Other", modify
label values W1hous12HH W1hous12HH
fre W1hous12HH

//Whether the young person can access the internet from home	W1condur6MP
fre W1condur6MP
replace W1condur6MP=. if W1condur6MP<0
replace W1condur6MP=0 if W1condur6MP==2
label define W1condur6MP 0 "No", modify
label values W1condur6MP W1condur6MP
fre W1condur6MP

keep NSID W1sexYP W1gowhereYP W1namesYP W1HcomGYP W1alei1YP0h W1hous12HH W1condur6MP
save "$derived\S1_age14.dta", replace	
	


*** Sweep 2 (age 15)
use "$rawdata\wave_two_lsype_young_person_2020.dta", clear

//Whether the young person's school have ever contacted their parents about their behaviour	W2SchcontMP
fre W2SchcontMP
replace W2SchcontMP=. if W2SchcontMP<0
replace W2SchcontMP=0 if W2SchcontMP==2
label define W2SchcontMP 0 "No", modify
label values W2SchcontMP W2SchcontMP
fre W2SchcontMP


//How much constantly under strain the young person has felt recently	W2strainYP
fre W2strainYP
replace W2strainYP=. if W2strainYP<0
fre W2strainYP

keep NSID W2SchcontMP W2strainYP
save "$derived\S2_age15.dta", replace	
	


***Sweep 3 (age 16)
use "$rawdata\wave_three_lsype_young_person_2020.dta", clear
merge 1:1 NSID using "$rawdata\wave_three_lsype_family_background_2020.dta", nogen

//Whether the young person ever smokes cigarettes	W3cignowYP
fre W3cignowYP
replace W3cignowYP=. if W3cignowYP<0
replace W3cignowYP=0 if W3cignowYP==2
label define W3cignowYP 0 "No", modify
label values W3cignowYP W3cignowYP
fre W3cignowYP

//Age of the young person's main parent	W3ageMP
fre W3ageMP
replace W3ageMP=. if W3ageMP<0
fre W3ageMP

keep NSID W3cignowYP W3ageMP
save "$derived\S3_age16.dta", replace	


***Sweep 4 (age 17)
//use "$rawdata\wave_four_lsype_history_2020.dta", clear
//use "$rawdata\wave_four_activity_history_file_2020.dta", clear
//use "$rawdata\wave_four_lsype_family_background_2020.dta", clear
//use "$rawdata\wave_four_lsype_parental_attitudes_june_2009.dta", clear
//use "$rawdata\wave_four_lsype_household_grid_file_2020.dta", clear
use "$rawdata\wave_four_lsype_young_person_2020.dta", clear


// NOTE THAT MERGED BELOW IS OLD DATA, WICH I CAN'T FIND ANYWHRE IN THE 2020 ASSESSIBLE DATA. IT IS LIKELY TO HAVE BEEN MOVED TO THE RESTRICTED DATA IN THE 2020 DATA DEPOSIT. SO NEED TO BE REQUESTED FROM THERE IF TO BE INCLUDED IN FINAL DERIVED DATASET.
merge 1:1 NSID using "$rawdata\wave_four_lsype_young_person_september_2009", nogen

//How often the young person goes to nightclubs	W4ClubberYP
fre W4ClubberYP
replace W4ClubberYP=. if W4ClubberYP<0
replace W4ClubberYP=1 if inrange(W4ClubberYP,2,3)
label define  W4ClubberYP 1 "Once a week or more", modify
label values W4ClubberYP W4ClubberYP
fre W4ClubberYP

//Whether the young person gives their permission to pass on their details to the Department for Work and Pensions	W4DWPLnk2YP
fre W4DWPLnk2YP
replace W4DWPLnk2YP=. if W4DWPLnk2YP<0
replace W4DWPLnk2YP=0 if W4DWPLnk2YP==2
label define W4DWPLnk2YP 0 "No", modify
label values W4DWPLnk2YP W4DWPLnk2YP
fre W4DWPLnk2YP

keep NSID W4ClubberYP W4DWPLnk2YP
save "$derived\S4_age17.dta", replace	



***Sweep 5 (age 18)

use "$rawdata\wave_five_lsype_family_background_2020.dta", clear
merge 1:1 NSID using "$rawdata\wave_five_lsype_young_person_2020.dta", nogen

//Whether the young person still lives at the same address as the previous interview	W5SameaddHH
fre W5SameaddHH
replace W5SameaddHH=. if W5SameaddHH<0
replace W5SameaddHH=1 if W5SameaddHH==3
replace W5SameaddHH=0 if W5SameaddHH==2
label define W5SameaddHH 0 "No", modify
label values W5SameaddHH W5SameaddHH
fre W5SameaddHH

//Whether there are specific groups of people that the young person feels are usually treated better by the government than people like them	W5FairTreat2YP
fre W5FairTreat2YP
replace W5FairTreat2YP=. if W5FairTreat2YP<0
replace W5FairTreat2YP=0 if W5FairTreat2YP==2
label define W5FairTreat2YP 0 "No", modify
label values W5FairTreat2YP W5FairTreat2YP
fre W5FairTreat2YP

//How well the young person thought their teachers in Year 11 and earlier expected them to do in their exams	W5TeaExpecYP
fre W5TeaExpecYP
replace W5TeaExpecYP=. if W5TeaExpecYP<0
fre W5TeaExpecYP

//Current main activity of the young person	W5actYP
fre W5actYP
replace W5actYP=. if W5actYP<0
replace W5actYP=2 if W5actYP==3
replace W5actYP=3 if inrange(W5actYP,4,7)
label define W5actYP 2 "Working or part working and part college" 3 "Other", modify
label values W5actYP W5actYP
fre W5actYP

keep NSID W5SameaddHH W5FairTreat2YP W5TeaExpecYP W5actYP
save "$derived\S5_age18.dta", replace	



***Sweep 6 (age 19)
use "$rawdata\wave_six_lsype_young_person_2020.dta", clear
//Whether the young person has spoken to a teacher for information, advice and guidance about the future	W6IagIntroYP0b
fre W6IagIntroYP0b
replace W6IagIntroYP0b=. if W6IagIntroYP0b<0
fre W6IagIntroYP0b

//Whether the young person is willing to answer questions on sexual experiences	W6SexIntroYP
fre W6SexIntroYP
replace W6SexIntroYP=. if W6SexIntroYP<0
replace W6SexIntroYP=0 if W6SexIntroYP==2
label define W6SexIntroYP 0 "No", modify
label values W6SexIntroYP W6SexIntroYP
fre W6SexIntroYP

keep NSID W6IagIntroYP0b W6SexIntroYP
save "$derived\S6_age19.dta", replace	



***Sweep 7 (age 20)
use "$rawdata\wave_seven_lsype_young_person_2020.dta", clear
//Whether the young person is willing to answer questions on sexual experiences	W7SexIntroYP
fre W7SexIntroYP
replace W7SexIntroYP=. if W7SexIntroYP<0

keep NSID W7SexIntroYP
save "$derived\S7_age20.dta", replace	


***merge all data sets
use "$derived\NRprior.dta", clear //N=16,111
merge 1:1 NSID using "$derived\S1_age14.dta", nogen
merge 1:1 NSID using "$derived\S2_age15.dta", nogen
merge 1:1 NSID using "$derived\S3_age16.dta", nogen
merge 1:1 NSID using "$derived\S4_age17.dta", nogen
merge 1:1 NSID using "$derived\S5_age18.dta", nogen
merge 1:1 NSID using "$derived\S6_age19.dta", nogen
merge 1:1 NSID using "$derived\S7_age20.dta", nogen

keep if w7nr_cum!=.

save "$derived\Next Steps non-response predictors.dta", replace		
	
//erase all temporary files	
erase "$derived\NRprior.dta"
erase "$derived\S1_age14.dta"
erase "$derived\S2_age15.dta"
erase "$derived\S3_age16.dta"
erase "$derived\S4_age17.dta"
erase "$derived\S5_age18.dta"
erase "$derived\S6_age19.dta"
erase "$derived\S7_age20.dta"



		
	
	
	
	

	
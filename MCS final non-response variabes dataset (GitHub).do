
/*Notes:
The following code derives variables that predict missingness in the MCS, generating a single datafile.   

*/

clear

global rawdata "insert here file path to folder with raw data" //location of folder with all raw data files downloaded from UK Data Service

global derived "insert here file path to folder for the final derived dataset" //location of folder for derived data



//Non-response and weights
*******************************************************************************
use "$rawdata\mcs_longitudinal_family_file.dta", replace
keep MCSID WEIGHT2 PTTYPE2 NH2 SPTN00 AAOUTC00 AOVWT2 BAOUTC00 BOVWT2 ///
CAOUTC00 COVWT2 DAOUTC00 DOVWT2 EAOUTC00 EOVWT2 FAOUTC00 FOVWT2 GAOUTC00 GOVWT2

**** Generate nonresponse variables
recode AAOUTC00 (-1=.)(2=0)(0=1), into(NR01)
recode BAOUTC00 (-1=.)(1=0)(0 2 3 4 5 6=1), into(NR02)
recode CAOUTC00 (-1=.)(1=0)(0 2 3 4 5 6=1), into(NR03)
recode DAOUTC00 (-1=.)(1=0)(0 2 3 4 5 6=1), into(NR04)
recode EAOUTC00 (-1=.)(1=0)(0 2 3 4 5 6=1), into(NR05)
recode FAOUTC00 (-1=.)(1=0)(0 2 3 4 5 6=1), into(NR06)
recode GAOUTC00 (1=0)(-1 0 2 3 4 5 6=1), into(NR07) 

lab define nr 0 "Productive" 1 "Non-productive"
lab val NR01-NR07 nr

gen NR07priorNR = (NR02==1 | NR03==1 | NR04==1 | NR05==1 | NR06==1 | NR07==1) if NR07<.
gen NR06priorNR = (NR02==1 | NR03==1 | NR04==1 | NR05==1 | NR06==1) if NR06<.
gen NR05priorNR = (NR02==1 | NR03==1 | NR04==1 | NR05==1) if NR05<.
gen NR04priorNR = (NR02==1 | NR03==1 | NR04==1) if NR04<.
gen NR03priorNR = (NR02==1 | NR03==1) if NR03<.
gen NR02priorNR = (NR02==1) if NR02<.

label var NR07priorNR "Non-response to any prior survey sweeps (i.e. s2-s7)"
label var NR06priorNR "Non-response to any prior survey sweeps (i.e. s2-s6)"
label var NR05priorNR "Non-response to any prior survey sweeps (i.e. s2-s5)"
label var NR04priorNR "Non-response to any prior survey sweeps (i.e. s2-s4)"
label var NR03priorNR "Non-response to any prior survey sweeps (i.e. s2-s3)"
label var NR02priorNR "Non-response to any prior survey sweeps (i.e. s2)"

label define prior 1 "Yes, prior non-response" 0 "No, no prior non-response", replace
foreach X of varlist NR07priorNR NR06priorNR NR05priorNR NR04priorNR NR03priorNR NR02priorNR {
label values  `X' prior
}

label var NR07 "Non-response to survey sweep 7"
label var NR06 "Non-response to survey sweep 6"
label var NR05 "Non-response to survey sweep 5"
label var NR04 "Non-response to survey sweep 4"
label var NR03 "Non-response to survey sweep 3"
label var NR02 "Non-response to survey sweep 2"
label var NR01 "Non-response to survey sweep 1"

keep MCSID WEIGHT2 PTTYPE2 NH2 SPTN00 AOVWT2 BOVWT2 COVWT2 DOVWT2 EOVWT2 FOVWT2 GOVWT2 NR01-NR07  NR03priorNR NR04priorNR NR05priorNR NR06priorNR   

drop if WEIGHT2==-1 

save "$derived\nonresponse_and_weights", replace




//Social class
*******************************************************************************
//Social class across sweep 1 (or sweep 2 for families entering in that sweep)
use "$rawdata\mcs1_parent_derived", clear
keep MCSID ARESP00 ADD05C00
keep if inrange(ARESP00,1,2)
fre ARESP00 //1=main 2=partner
fre ADD05C00 //social class

foreach X of varlist ADD05C00 {
replace `X'=. if `X'<0	
}

clonevar sesM_s1 = ADD05C00 if ARESP00==1
fre sesM_s1

clonevar sesP_s1 = ADD05C00 if ARESP00==2

keep MCSID ARESP00 sesM_s1 sesP_s1

reshape wide sesM_s1 sesP_s1, i(MCSID) j(ARESP00)

rename (sesM_s11 sesP_s12) (sesM_s1 sesP_s1)

//HH social class
clonevar sesH_s1=sesM_s1
replace sesH_s1=sesP_s1 if sesP_s1<sesH_s1 & sesP_s1!=. //replace with partner ses if higher than main ses, if there is a partner
replace sesH_s1=sesP_s1 if sesH_s1==. & sesP_s1!=. //replace with partner ses if main missing, if there is a partner
label var sesH_s1 "Highest social class in HH in sweep 1 (or sweep 2 for families entering in that sweep)"
rename sesH_s1 sesH

keep MCSID sesH
save "$derived\sesH.dta", replace




//W1 vars
*******************************************************************************

*** FILE 7
use "$rawdata\mcs_longitudinal_family_file.dta", clear
keep MCSID AAOUTC00
keep if AAOUTC00==2
fre AAOUTC00

merge 1:m MCSID using "$rawdata\mcs1_parent_cm_interview.dta", keepusing(AELIG00 ACNUM00 ACADMA00 ACBFEV00 ACBFEA00 ACBFED00 ACBFEW00 ACBFEM00 ACAGCM00 ACCMDA00 ACCMWK00 ACCMMT00) nogen

merge m:m MCSID using "$rawdata\mcs1_parent_interview.dta", keepusing(ACBAGE00) nogen
keep if AELIG00==1 //main parent interview
keep if ACNUM00==1 //keeping just child 1


***w1_breastfed_dv_cat
gen breastfed_dv=.
replace breastfed_dv=0 if ACBFEV00==2 //never breastfed
replace breastfed_dv=0 if ACBFEA00==1 //never took breastmilk
replace breastfed_dv=ACBFED00 if ACBFED00!=-1 //days
replace breastfed_dv=ACBFEW00*7 if ACBFEW00!=-1 //weeks
replace breastfed_dv=ACBFEM00*30 if ACBFEM00!=-1 //months
replace breastfed_dv=ACBAGE00*30 if ACBFEA00==6 & ACBAGE00!=-1 //months
label var breastfed_dv "Age in days when last breastfed (0=never breastfed)"

recode  breastfed_dv (0=0 "Never breastfed") (1/31=1 "Up to 1 month old") (32/92=2 "1-3 months old") (93/183=3 "3-6 months old") (184/275=4 "6-9 months old") (276/500=5 "9 months or older"), gen(breastfed_dv_r) 
fre breastfed_dv_r
drop breastfed_dv
rename breastfed_dv_r breastfed_dv
label var breastfed_dv "Age of baby when last breastfed"

rename breastfed_dv w1_breastfed_dv_cat



***w1_cowsmilk_dv_cat
gen cowsmilk_dv=.
replace cowsmilk_dv=0 if ACAGCM00==1 //never had 
//days
replace cowsmilk_dv=1 if inrange(ACCMDA00,1,30) //less than 6 months old
//weeks
replace cowsmilk_dv=1 if inrange(ACCMWK00,1,25) //less than 6 months old
replace cowsmilk_dv=2 if inrange(ACCMWK00,26,30) //6 months or older
//months
replace cowsmilk_dv=1 if inrange(ACCMMT00,1,5) //less than 6 months old
replace cowsmilk_dv=2 if inrange(ACCMMT00,6,20) //6 months or older

label def cowsmilk_dv 0 "Never had" 1 "Less than 6 months old" 2 "6 months or older", replace
label values cowsmilk_dv cowsmilk_dv
label var cowsmilk_dv "When child first had cows milk"

rename cowsmilk_dv w1_cowsmilk_dv_cat


***w1_ACADMA00_con
replace ACADMA00=. if ACADMA00 <0
rename ACADMA00 w1_ACADMA00_con

***w1_ACBAGE00_con
replace ACBAGE00=. if ACBAGE00<0
rename ACBAGE00 w1_ACBAGE00_con


keep MCSID w1_ACADMA00_con w1_ACBAGE00_con w1_breastfed_dv_cat w1_cowsmilk_dv_cat

save "$derived\W1_file7.dta", replace


*-----------------------------------------------------------------------------*
*** FILE 8
use "$rawdata\mcs_longitudinal_family_file.dta", clear
keep MCSID AAOUTC00
keep if AAOUTC00==2

merge 1:m MCSID using "$rawdata\mcs1_parent_derived.dta", keepusing(AELIG00 ADDAGB00 ADD06E00) nogen

keep if AELIG00==1 //main parent interview

***w1_ADDAGB00_con
replace ADDAGB00=. if ADDAGB00<0
rename ADDAGB00 w1_ADDAGB00_con

***w1_ADD06E00_cat 
fre ADD06E00
replace ADD06E00=. if ADD06E00<0
rename ADD06E00 w1_ADD06E00_cat

keep MCSID w1_ADD06E00_cat w1_ADDAGB00_con

save "$derived\W1_file8.dta", replace



*-----------------------------------------------------------------------------*
*** FILE 9
use "$rawdata\mcs_longitudinal_family_file.dta", clear
keep MCSID AAOUTC00
keep if AAOUTC00==2

merge 1:m MCSID using "$rawdata\mcs1_parent_interview.dta", keepusing(AELIG00 ACREBK00 ADWKST00 APBANK0A APLFTE00 APMOTY00 APREPA00 APSUPP0A APVOTE00 APPCRY00	APFPAT00 APSTIM00 APTALK00 APCUDL00	APANNO00 APTHNK00 APLEAV00	APCOMP00 APPATI00 APGIUP00) nogen

keep if AELIG00==1 //main parent interview

***attachment
foreach X of varlist APPCRY00	APFPAT00	APSTIM00	APTALK00	APCUDL00	APANNO00	APTHNK00	APLEAV00	APCOMP00	APPATI00	APGIUP00{
replace `X'=. if `X'<0	
}

foreach X of varlist APCOMP00 APPATI00 APGIUP00  {
replace `X'=. if `X'==5
}

foreach X of varlist APPCRY00	APFPAT00	APSTIM00	APTALK00	APCUDL00 APLEAV00 {
replace `X'=. if `X'==6	
}

foreach X of varlist APANNO00 APTHNK00 {
replace `X'=. if `X'==7
}

revrs APPCRY00	APFPAT00	APSTIM00	APTALK00	APCUDL00 APTHNK00 APLEAV00 

foreach X of varlist revAPPCRY00	revAPFPAT00	revAPSTIM00	revAPTALK00	revAPCUDL00 revAPLEAV00 {
recode `X' (1/2=1) (3=2) (4=3) (5=4), gen(`X'_r)
}

foreach X of varlist APANNO00 revAPTHNK00 {
recode `X' (1/3=1) (4=2) (5=3) (6=4), gen(`X'_r)
}

gen attachment_dv=revAPPCRY00_r +	revAPFPAT00_r +	revAPSTIM00_r +	revAPTALK00_r +	revAPCUDL00_r +	APANNO00_r +	revAPTHNK00_r +	revAPLEAV00_r +	APCOMP00 +	APPATI00 +	APGIUP00 
label var attachment_dv "Attachment to CM"

rename attachment_dv w1_attachment_dv_con


***w1_ACREBK00_bi
recode ACREBK00 (1=1 "Parent has Child Health Records") (2=0 "Parent doesn't have Child Health Record"), gen(w1_ACREBK00_bi)

***w1_ADWKST00_cat
replace ADWKST00=. if ADWKST00<0
rename ADWKST00 w1_ADWKST00_cat

recode w1_ADWKST00_cat (1/2=1 "Currently doing paid work or on leave ") (3=2 "Has worked in the past but no current paid job") (4=3 "Never had a paid job"), gen(w1_ADWKST00_cat_R)
drop w1_ADWKST00_cat
rename w1_ADWKST00_cat_R w1_ADWKST00_cat

***w1_APBANK0A_r_bi
replace APBANK0A=. if APBANK0A<0
replace APBANK0A=1 if APBANK0A==2
rename APBANK0A APBANK0A_r
rename APBANK0A_r w1_APBANK0A_r_bi

foreach X of varlist w1_APBANK0A_r_bi  {
replace `X'=0 if `X'==3
} 
label define w1_APBANK0A_r_bi 0 "No, no account" 1 "Yes, bank, building society, Post Office account, or other"
label val w1_APBANK0A_r_bi w1_APBANK0A_r_bi


***w1_APMOTY00_r_bi
replace APMOTY00=. if APMOTY00<0
recode APMOTY00 (1=1 "House or bungalow") (2/4=0 "Flat, maisonette, studio, rooms or room") (85=.), gen(APMOTY00_r)
rename APMOTY00_r w1_APMOTY00_r_bi

***w1_APREPA00_bi
replace APREPA00=. if APREPA00<0
replace APREPA00=0 if APREPA00==2
lab def yesno 1 "yes" 0 "no", replace
label val APREPA00 yesno
rename APREPA00 w1_APREPA00_bi

***w1_APSUPP0A_r_bi
recode APSUPP0A (6=0 "No none of these") (1/5=1 "Yes: GP, health visitor, or other") (-8/-1=.), gen(APSUPP0A_r)
rename APSUPP0A_r w1_APSUPP0A_r_bi

***w1_APVOTE00_bi
replace APVOTE00=. if APVOTE00<0
replace APVOTE00=0 if APVOTE00==2
lab def yesno 1 "yes" 0 "no", replace
label val APVOTE00 yesno
rename APVOTE00 w1_APVOTE00_bi

keep MCSID w1_attachment_dv_con w1_ACREBK00_bi w1_ADWKST00_cat w1_APBANK0A_r_bi w1_APMOTY00_r_bi w1_APREPA00_bi w1_APSUPP0A_r_bi w1_APVOTE00_bi

save "$derived\W1_file9.dta", replace




//W2 vars
*******************************************************************************

*** FILE 4
use "$rawdata\mcs2_cm_oral_fluid.dta", clear

drop if BCNUM00==2 //drop twins and triplets

*** w2_EBVPANEL_con
rename EBVPANEL w2_EBVPANEL_con

keep MCSID w2_EBVPANEL_con

save "$derived\W2_file4.dta", replace



*-----------------------------------------------------------------------------*
*** FILE 5
use "$rawdata\mcs2_family_derived.dta", clear

***w2_BDOEDE00_con
replace BDOEDE00=. if BDOEDE00<0
rename BDOEDE00 w2_BDOEDE00_con

keep MCSID w2_BDOEDE00_con


save "$derived\W2_file5.dta", replace



****************************************************************
**# Bookmark #1
*** FILE 11
use "$rawdata\mcs2_parent_derived.dta", clear
//N=28,413 //codebook MCSID 15,572

//MAIN PARENT
use "$rawdata\mcs_longitudinal_family_file.dta", clear
keep MCSID BAOUTC00
fre BAOUTC00
keep if BAOUTC00==1
fre BAOUTC00
//15,589

merge 1:m MCSID using "$rawdata\mcs2_parent_derived.dta"
//N=28,413 //codebook MCSID 15,589
drop _merge

keep if BELIG00==1 //main parent interview
//15,570
//37 variables

***w2_BDDRLG00_r2_cat
*recode
fre BDDRLG00 
cap drop BDDRLG00_r
recode BDDRLG00 (1=1 "Christian") (2=2 "Muslim") (3/7=4 "Other") (8=0 "No Religion") (-9/-1=.), gen(BDDRLG00_r)
fre BDDRLG00_r
rename BDDRLG00_r w2_BDDRLG00_r2_cat 

keep MCSID w2_BDDRLG00_r2_cat

save "$derived\W2_file11.dta", replace



//W3 vars
********************************************************************************

*-----------------------------------------------------------------------------*
*FILE 1
use "$rawdata\mcs3_cm_cognitive_assessment.dta", clear

keep if CCNUM00==1 //keeping just first child 

***w3_CCPCTSCORE_con
rename CCPCTSCORE w3_CCPCTSCORE_con

keep MCSID w3_CCPCTSCORE_con

save "$derived\W3_file1.dta", replace

	

*-----------------------------------------------------------------------------*
*FILE 3
use "$rawdata\mcs3_cm_interview.dta", clear

keep if CCNUM00==1 //keeping just first cohort child

***w3_CHCAGE00_con
fre CHCAGE00
replace CHCAGE00=. if CHCAGE00<0
rename CHCAGE00 w3_CHCAGE00_con

keep MCSID w3_CHCAGE00_con

save "$derived\W3_file3.dta", replace



*-----------------------------------------------------------------------------*
*FILE 10
use "$rawdata\mcs3_parent_cm_interview.dta", clear

fre CELIG00
keep if CELIG00==1

fre CCNUM00
keep if CCNUM00==1

***w3_CPFAPA00_cat
fre CPFAPA00
replace CPFAPA00=. if CPFAPA00<0
rename CPFAPA00 w3_CPFAPA00_cat

keep MCSID w3_CPFAPA00_cat
save "$derived\W3_file10.dta", replace


*-----------------------------------------------------------------------------*
*FILE 12
use "$rawdata\mcs3_parent_interview.dta", clear

keep if CELIG00==1 //main parent

***w3_CPROMA00_con
replace CPROMA00=. if CPROMA00<0
rename CPROMA00 w3_CPROMA00_con

***w3_CPVOTE00_bi
replace CPVOTE00=. if CPVOTE00<0
replace CPVOTE00=0 if CPVOTE00==2
lab def yesno 1 "yes" 0 "no", replace
label values CPVOTE00 yesno
rename CPVOTE00 w3_CPVOTE00_bi

keep MCSID w3_CPROMA00_con w3_CPVOTE00_bi

save "$derived\W3_file12.dta", replace



//W4 vars
*******************************************************************************

*-----------------------------------------------------------------------------*
*FILE 1
****mcs4_cm_aspirations
use "$rawdata\mcs4_cm_aspirations.dta", clear

keep if DCNUM00==1 //keeping just child 1

***w4_DCAEXT0A_cat
replace DCAEXT0A=. if DCAEXT0A<0
rename DCAEXT0A w4_DCAEXT0A_cat

keep MCSID w4_DCAEXT0A_cat

save "$derived\W4_file1.dta", replace





**# Bookmark #5
*FILE 5
***mcs4_cm_teacher_survey
use "$rawdata\mcs4_cm_teacher_survey.dta", clear

keep if DCNUM00==1

***w4_academ_dv_con
foreach X of varlist DQ2160 DQ2162 DQ2164 DQ2166 DQ2167 DQ2168 DQ2169 DQ2170 {
replace `X'=. if `X'<0|`X'==6 	
}

alpha DQ2160 DQ2162 DQ2164 DQ2166 DQ2167 DQ2168 DQ2169 DQ2170, generate(academ_dv) //alpha=.93
label var academ_dv "Academic performance - teacher reported"
fre academ_dv 
rename academ_dv w4_academ_dv_con

keep MCSID w4_academ_dv_con 

save "$derived\W4_file5.dta", replace



*-----------------------------------------------------------------------------*
*FILE 12
use "$rawdata\mcs4_parent_interview.dta", clear

keep if DELIG00==1 //main parent

***w4_pet_dog_dv_bi
egen pet_dog_dv = anymatch(DPPETH0A DPPETH0B DPPETH0C DPPETH0D DPPETH0E), values(1)
replace pet_dog_dv =0 if DPPETH0A==95
replace pet_dog_dv =. if DPPETH0A==.
label define pet_dog_dv 0 "no" 1 "yes", replace
label values pet_dog_dv pet_dog_dv
label var pet_dog_dv "Household dog owned"
rename pet_dog_dv w4_pet_dog_dv_bi

keep MCSID w4_pet_dog_dv_bi

save "$derived\W4_file12.dta", replace





*******************************************************************************
//W6 vars

*-----------------------------------------------------------------------------*
*FILE 4
use "$rawdata\mcs6_cm_interview.dta", clear

keep if FCNUM00==1

***w6_FCPLAB00_cat
replace FCPLAB00=. if FCPLAB00<0
rename FCPLAB00 w6_FCPLAB00_cat

keep MCSID w6_FCPLAB00_cat

save "$derived\W6_file4.dta", replace


*-----------------------------------------------------------------------------*
*FILE 9
use "$rawdata\mcs_longitudinal_family_file.dta", clear
keep MCSID FAOUTC00
keep if FAOUTC00==1

merge 1:m MCSID using "$rawdata\mcs6_parent_cm_interview.dta"
drop _merge

keep if FELIG00==1
keep if FCNUM00==1

***w6_schyear_dv_bi
gen schyear_dv=.
replace schyear_dv=0 if FPSTSC00==2 & (FPDIFY00==1|FPDIFY00==3) //Year 8/S2/Year 9 or other
replace schyear_dv=0 if FPSTSC00==1 //Year 9/ Third year (S3)/Year10  
replace schyear_dv=1 if FPSTSC00==2 & FPDIFY00==2 //Year 10/S4/Year 11
label def schyear_dv 0 "Year 8/S2/Year 9 or other OR Year 9/S3/Year10" 1 "Year 10/S4/Year 11", replace 
label values schyear_dv schyear_dv
label var schyear_dv "School year"
rename schyear_dv w6_schyear_dv_bi

keep MCSID w6_schyear_dv_bi

save "$derived\W6_file9.dta", replace




*-----------------------------------------------------------------------------*
*FILE 10
use "$rawdata\mcs_longitudinal_family_file.dta", clear
keep MCSID FAOUTC00
keep if FAOUTC00==1

merge 1:m MCSID using "$rawdata\mcs6_parent_derived.dta"
drop _merge

keep if FELIG00==1 //main parent

***w6_FDRLG00_r_cat
recode FDRLG00 (1=1 "Christian") (2=2 "Muslim") (3=3 "Hindu") (4/7=3 "Other") (8=0 "No Religion") (-1=.), gen(FDRLG00_r)
rename FDRLG00_r w6_FDRLG00_r_cat

keep MCSID w6_FDRLG00_r_cat

save "$derived\W6_file10.dta", replace





*******************************************************************************
***MERGING ALL FILES

use  "$derived\nonresponse_and_weights.dta", clear
merge 1:1 MCSID using "$derived\sesH.dta", nogen
merge 1:1 MCSID using "$derived\W1_file7.dta", nogen
merge 1:1 MCSID using "$derived\W1_file8.dta", nogen
merge 1:1 MCSID using "$derived\W1_file9.dta", nogen
merge 1:1 MCSID using "$derived\W2_file4.dta", nogen
merge 1:1 MCSID using "$derived\W2_file5.dta", nogen
merge 1:1 MCSID using "$derived\W2_file11.dta", nogen
merge 1:1 MCSID using "$derived\W3_file1.dta", nogen
merge 1:1 MCSID using "$derived\W3_file3.dta", nogen
merge 1:1 MCSID using "$derived\W3_file10.dta", nogen
merge 1:1 MCSID using "$derived\W3_file12.dta", nogen
merge 1:1 MCSID using "$derived\W4_file1.dta", nogen
merge 1:1 MCSID using "$derived\W4_file5.dta", nogen
merge 1:1 MCSID using "$derived\W4_file12.dta", nogen
merge 1:1 MCSID using "$derived\W6_file4.dta", nogen
merge 1:1 MCSID using "$derived\W6_file9.dta", nogen
merge 1:1 MCSID using "$derived\W6_file10.dta", nogen


drop PTTYPE2 SPTN00 NH2 WEIGHT2 AOVWT2 BOVWT2 COVWT2 DOVWT2 EOVWT2 FOVWT2 GOVWT2 NR01 NR02 NR03 NR04 NR05 NR06 NR07


save "$derived\MCS non-response predictors.dta", replace
use "$derived\MCS non-response predictors.dta", clear

*-----------------------------------------------------------------------------*
//erase all temporary files
erase  "$derived\nonresponse_and_weights.dta"
erase "$derived\sesH.dta"
erase "$derived\W1_file7.dta"
erase "$derived\W1_file8.dta"
erase "$derived\W1_file9.dta"
erase "$derived\W2_file4.dta"
erase "$derived\W2_file5.dta"
erase "$derived\W2_file11.dta"
erase "$derived\W3_file1.dta"
erase "$derived\W3_file3.dta"
erase "$derived\W3_file10.dta"
erase "$derived\W3_file12.dta"
erase "$derived\W4_file1.dta"
erase "$derived\W4_file5.dta"
erase "$derived\W4_file12.dta"
erase "$derived\W6_file4.dta"
erase "$derived\W6_file9.dta"
erase "$derived\W6_file10.dta"



sum NR06priorNR NR05priorNR NR04priorNR NR03priorNR sesH w1_ACADMA00_con w1_ACBAGE00_con w1_breastfed_dv_cat w1_cowsmilk_dv_cat w1_ADDAGB00_con w1_ADD06E00_cat w1_APREPA00_bi w1_APBANK0A_r_bi w1_APVOTE00_bi w1_attachment_dv_con w1_ACREBK00_bi w1_ADWKST00_cat w1_APMOTY00_r_bi w1_APSUPP0A_r_bi w2_EBVPANEL_con w2_BDOEDE00_con w2_BDDRLG00_r2_cat w3_CCPCTSCORE_con w3_CHCAGE00_con w3_CPFAPA00_cat w3_CPROMA00_con w3_CPVOTE00_bi w4_DCAEXT0A_cat w4_academ_dv_con w4_pet_dog_dv_bi w6_FCPLAB00_cat w6_schyear_dv_bi w6_FDRLG00_r_cat



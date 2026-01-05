

clear

global rawdata "insert here file path to folder with raw data" //location of folder with all raw data files downloaded from UK Data Service

global derived "insert here file path to folder for the final derived dataset" //location of folder for derived data


**# Bookmark #1
//response file
*********************************************************
use "$rawdata\bcs70_response_1970-2021.dta", clear

keep bcsid outcme01 outcme02 outcme03 outcme04 outcme05 outcme06 outcme07 outcme08 outcme09 outcme10 outcme11

fre outcme01 outcme02 outcme03 outcme04 outcme05 outcme06 outcme07 outcme08 outcme09 outcme10 outcme11


//first sweep CM's took part

//sweep 1 (birth)
fre outcme01
cap drop sweep1
gen sweep1=0
replace sweep1=1 if outcme01==1
fre sweep1

//sweep 2 (age 5)
fre outcme02
cap drop sweep2
gen sweep2=0
replace sweep2=1 if outcme01!=1 & outcme02==1
fre sweep2

//sweep 3 (age 10)
fre outcme03
cap drop sweep3
gen sweep3=0
replace sweep3=1 if outcme01!=1 & outcme02!=1 & outcme03==1
fre sweep3

//sweep 4 (age 16)
fre outcme04
cap drop sweep4
gen sweep4=0
replace sweep4=1 if outcme01!=1 & outcme02!=1 & outcme03!=1 & outcme04==1
fre sweep4

//sweep 5 (age 26)
fre outcme05
cap drop sweep5
gen sweep5=0
replace sweep5=1 if outcme01!=1 & outcme02!=1 & outcme03!=1 & outcme04!=1 & outcme05==1
fre sweep5

//sweep 6 (age 30) //last sweep with first entries
fre outcme06
cap drop sweep6
gen sweep6=0
replace sweep6=1 if outcme01!=1 & outcme02!=1 & outcme03!=1 & outcme04!=1 & outcme05!=1 & outcme06==1
fre sweep6

cap drop everpart //check those who evert took part
gen everpart=0
replace everpart=1 if sweep1==1|sweep2==1|sweep3==1|sweep4==1|sweep5==1|sweep6==1
fre everpart

//prior NR

fre outcme02 //NR02priorNR
cap drop NR02priorNR
gen NR02priorNR=0
replace NR02priorNR=1 if inrange(outcme02,2,8) & sweep1==1
fre NR02priorNR //4903 3841

fre outcme02 outcme03 //NR03priorNR
cap drop NR03priorNR
gen NR03priorNR=0
replace NR03priorNR=1 if (inrange(outcme02,2,8)|inrange(outcme03,2,8)) & (sweep1==1|sweep2==1)
fre NR03priorNR //5902 4840

fre outcme02 outcme03 outcme04 //NR04priorNR
cap drop NR04priorNR
gen NR04priorNR=0
replace NR04priorNR=1 if (inrange(outcme02,2,8)|inrange(outcme03,2,8)|inrange(outcme04,2,8)) & (sweep1==1|sweep2==1|sweep3==1)
fre NR04priorNR //8794 8500

fre outcme02 outcme03 outcme04 outcme05 //NR05priorNR
cap drop NR05priorNR
gen NR05priorNR=0
replace NR05priorNR=1 if (inrange(outcme02,2,8)|inrange(outcme03,2,8)|inrange(outcme04,2,8)|inrange(outcme05,2,8)) & (sweep1==1|sweep2==1|sweep3==1|sweep4==1)
fre NR05priorNR //12182 12055

fre outcme02 outcme03 outcme04 outcme05 outcme06 //NR06priorNR
cap drop NR06priorNR
gen NR06priorNR=0
replace NR06priorNR=1 if (inrange(outcme02,2,8)|inrange(outcme03,2,8)|inrange(outcme04,2,8)|inrange(outcme05,2,8)|inrange(outcme06,2,8)) & (sweep1==1|sweep2==1|sweep3==1|sweep4==1|sweep5==1)
fre NR06priorNR //12886 12832

fre outcme02 outcme03 outcme04 outcme05 outcme06 outcme07   //NR07priorNR
cap drop NR07priorNR
gen NR07priorNR=0
replace NR07priorNR=1 if (inrange(outcme02,2,8)|inrange(outcme03,2,8)|inrange(outcme04,2,8)|inrange(outcme05,2,8)|inrange(outcme06,2,8)|inrange(outcme07,2,8)) & (sweep1==1|sweep2==1|sweep3==1|sweep4==1|sweep5==1|sweep6==1)
fre NR07priorNR //13603 13595

fre outcme02 outcme03 outcme04 outcme05 outcme06 outcme07 outcme08 //NR08priorNR
cap drop NR08priorNR
gen NR08priorNR=0
replace NR08priorNR=1 if (inrange(outcme02,2,8)|inrange(outcme03,2,8)|inrange(outcme04,2,8)|inrange(outcme05,2,8)|inrange(outcme06,2,8)|inrange(outcme07,2,8)|inrange(outcme08,2,8)) & (sweep1==1|sweep2==1|sweep3==1|sweep4==1|sweep5==1|sweep6==1)
fre NR08priorNR //14191 14183

fre outcme02 outcme03 outcme04 outcme05 outcme06 outcme07 outcme08 outcme09 //NR09priorNR
cap drop NR09priorNR
gen NR09priorNR=0
replace NR09priorNR=1 if (inrange(outcme02,2,8)|inrange(outcme03,2,8)|inrange(outcme04,2,8)|inrange(outcme05,2,8)|inrange(outcme06,2,8)|inrange(outcme07,2,8)|inrange(outcme08,2,8)|inrange(outcme09,2,8)) & (sweep1==1|sweep2==1|sweep3==1|sweep4==1|sweep5==1|sweep6==1)
fre NR09priorNR //14452 14444


label var NR09priorNR "Non-response to any prior survey sweeps (i.e. s2-s9)"
label var NR08priorNR "Non-response to any prior survey sweeps (i.e. s2-s8)"
label var NR07priorNR "Non-response to any prior survey sweeps (i.e. s2-s7)"
label var NR06priorNR "Non-response to any prior survey sweeps (i.e. s2-s6)"
label var NR05priorNR "Non-response to any prior survey sweeps (i.e. s2-s5)"
label var NR04priorNR "Non-response to any prior survey sweeps (i.e. s2-s4)"
label var NR03priorNR "Non-response to any prior survey sweeps (i.e. s2-s3)"
label var NR02priorNR "Non-response to any prior survey sweeps (i.e. s2)"


label define prior 1 "Yes, prior non-response" 0 "No, no prior non-response", replace
foreach X of varlist NR02priorNR NR03priorNR NR04priorNR NR05priorNR NR06priorNR NR07priorNR NR08priorNR NR09priorNR {
label values  `X' prior
}

fre NR02priorNR NR03priorNR NR04priorNR NR05priorNR NR06priorNR NR07priorNR NR08priorNR NR09priorNR

keep bcsid NR02priorNR NR03priorNR NR04priorNR NR05priorNR NR06priorNR NR07priorNR NR08priorNR NR09priorNR everpart

save "$derived\NRprior.dta", replace



use "$rawdata\bcs70_response_1970-2021.dta", clear
// country of birth
fre cob
cap drop COB_new
recode cob (0=.) (1=1 "England") (2=2 "Wales") (3=3 "Scotland") (4/6=4 "Other"), gen(COB_new)
fre COB_new

fre sex
replace sex=0 if sex==2
replace sex=. if sex==3
label def sex 0 "female" 1 "male", replace
label val sex sex
rename sex SEX
fre SEX 

keep bcsid COB_new SEX
save "$derived\COB_SEX.dta", replace



**# Bookmark #2
// SWEEP 1
//birth

use "$rawdata\bcs7072a.dta", clear
merge 1:1 bcsid using "$rawdata\bcs7072b.dta", nogen
merge 1:1 bcsid using "$rawdata\f690.dta", nogen

//	Marital Status	a0012
fre a0012	
replace a0012=3 if a0012==4|a0012==5
replace a0012=. if a0012 <0
label def a0012 1 "Single" 2 "Married" 3 "Widowed/divorced/separated", replace
label val a0012 a0012
fre a0012

//	Parity (i.e. number of older siblings)	A0166_new
fre a0166
cap drop A0166_new
recode a0166 (-2=.) (0=0 "0") (1=1 "1") (2=2 "2") (3=3 "3") (4/20=4 "4 or more"), gen(A0166_new)
fre A0166_new


//	Father's social status	BD1BPOS_new
fre a0014 
cap drop BD1BPOS_new
clonevar BD1BPOS_new = a0014
replace BD1BPOS_new=. if BD1BPOS_new<0|inrange(BD1BPOS_new,7,8)
fre BD1BPOS_new

//	Father's age at completion of education	A0010_new
fre a0010
cap drop A0010_new
recode a0010 (-3/-2=.) (0/15=1 "≤15 year old") (16/18=2 "16-18 year old") (19/40=3 "≥19 years old") (97=0), gen(A0010_new) 
replace A0010_new=1 if A0010_new==0
fre A0010_new

//	Number of antenatal visits	a0190
fre a0190
replace a0190=. if a0190<0

//	Method of contraception	a0029b
fre a0029b
replace a0029b=. if a0029b<0

//	Age of mother at first birth	BD1AGEFB ///
fre a0005a //mothers age at delivery
replace a0005a=. if a0005a<0

cap drop matbirthy //deriving year mother was born 
gen matbirthy = 70-a0005a
fre matbirthy

fre a0052 //delivery year of first pregnancy
replace a0052=. if a0052<0
replace a0052 = 70 if a0052==.
fre a0052

cap drop BD1AGEFB
gen BD1AGEFB=a0052-matbirthy
fre BD1AGEFB
label var BD1AGEFB "Age of mother at first birth" 

//	Certainty of last menstrual period	a0196
fre a0196
replace a0196=. if a0196<0

//	Where was mother on day of birth	A357_new
fre a0357
cap drop A357_new
recode a0357 (-3=.) (1/2=1 "Consultant bed/ GP bed") (3=2 "NHS unit") (5=3 "Own home") (4=4 "Other") (6/9=4), gen(A357_new)
fre A357_new
		
//	Ever a teenager mother	BD1_TEENM
fre BD1AGEFB
cap drop BD1_TEENM
gen BD1_TEENM=.
replace BD1_TEENM=0 if inrange(BD1AGEFB,20,100)
replace BD1_TEENM=1 if inrange(BD1AGEFB,0,19)
label var BD1_TEENM "Ever a teenager mother"
label def BD1_TEENM 1 "Yes" 0 "No", replace
label val BD1_TEENM BD1_TEENM
fre BD1_TEENM

//	Was lactation attempted	a0297
fre a0297				
replace a0297=. if a0297<0
	
	
keep bcsid a0012 A0166_new BD1BPOS_new A0010_new a0190 a0029b BD1AGEFB a0196 A357_new BD1_TEENM a0297
	
save "$derived\S1_birth.dta", replace	
	
	
	
*** SWEEP 2		
//Sweep 2 (age 5)	
use "$rawdata\bcs2derived.dta", clear //BCSID
merge 1:1 BCSID using "$rawdata\bcs70_1975_developmental_history.dta", nogen
rename BCSID bcsid
merge 1:1 bcsid using "$rawdata\f699a.dta", nogen
merge 1:1 bcsid using "$rawdata\f699b.dta", nogen
merge 1:1 bcsid using "$rawdata\f699c.dta", nogen
//N=13,135

//	Ethnic group (mother)	E246a_new
fre e246a
cap drop E246a_new
recode e246a (-3/-1=.) (1/2=1 "European") (3/6=0 "Non-european") (7=.), gen(E246a_new)
fre E246a_new



//	Attitude to childhood independence	d124h
fre d124h

//	Tenure of accommodation	E220_new
fre e220
cap drop E220_new
clonevar E220_new = e220
replace E220_new =. if E220_new==-3
replace E220_new=7 if inrange(E220_new,4,6)
fre E220_new

//	Household moves (ordered)	E249_new
fre e249
cap drop E249_new
recode e249 (-3/-2=.) (0=0 "No moves") (6/100=5 "Five or more"), gen(E249_new)
fre E249_new

//	Type of accommodation	E218_new
fre e218
cap drop E218_new
recode e218 (-3=.) (1=1 "Detached") (2=2 "Semi-detached") (3=3 "Terrace") (4=4 "Flat-Maisonette") (5/6=5 "Rooms/Other"), gen(E218_new)
fre E218_new

//	Neighbourhood group	e267b
fre e267b
replace e267b=. if e267b<0

//	External score	Extern_score_5 
fre d025 d026 d027 d028 d032 d034 d038 d039 d042 d043 //rutter conduct and hyperactivity items
foreach X of varlist d025 d026 d027 d028 d032 d034 d038 d039 d042 d043 {
	replace `X'=. if `X'<0
}
cap drop Extern_score_5
gen Extern_score_5 = d025+d026+d027+d028+d032+d034+d038+d039+d042+d043
label var Extern_score_5 "External score"
fre Extern_score_5


//	Harris scoring method	f114	
fre f114
replace f114=. if f114<0

//	Number of household accessories	hhldstuf
fre e229 e230 e231 e232 e233 e234 e235
foreach X of varlist e229 e230 e231 e232 e233 e234 e235 {
replace `X'=. if `X'<0
replace `X'=0 if `X'==2	
}
cap drop hhldstuf
gen hhldstuf = e229+e230+e231+e232+e233+e234+e235
label var hhldstuf "Number of household accessories"
fre hhldstuf
	
//	Copying design score	f119
fre f119
replace f119=. if f119<0	


keep bcsid E246a_new d124h E220_new E249_new E218_new e267b Extern_score_5 f114 E249_new hhldstuf f119

save "$derived\S2_age5.dta", replace	
	
	
	
		
*** SWEEP 3
//Sweep 3 (age 10)
use "$rawdata\bcs3derived.dta", clear //BCSID //N19,103
use "$rawdata\sn3723.dta", clear //BCSID //14,870

use "$rawdata\bcs3derived.dta", clear //BCSID
duplicates report BCSID
duplicates drop BCSID, force
rename BCSID bcsid
merge 1:1 bcsid using "$rawdata\sn3723.dta"
keep if _merge==3


//	Accommodation occupied by family	D1_1_new
fre d1_1
cap drop D1_1_new
recode d1_1 (1/2=1 "Flat") (4=2 "House") (3=3 "Other") (5=3), gen(D1_1_new)
fre D1_1_new

//	Estimated reading age (in years)	bd3rdage
fre BD3RDAGE
cap drop bd3rdage
clonevar bd3rdage = BD3RDAGE
replace bd3rdage=. if bd3rdage<0
fre bd3rdage


//	British Ability Scales Matrix - Total score	BASmatrx
fre i3617 i3618 i3619 i3620 i3621 i3622 i3623 i3624 i3625 i3626 i3627 i3628 i3629 i3630 i3631 i3632 i3633 i3634 i3635 i3636 i3637 i3638 i3639 i3640 i3641 i3642 i3643 i3644
foreach X of varlist i3617 i3618 i3619 i3620 i3621 i3622 i3623 i3624 i3625 i3626 i3627 i3628 i3629 i3630 i3631 i3632 i3633 i3634 i3635 i3636 i3637  i3640 i3641 i3642 i3643 i3644 {
replace `X'=. if `X'<0
replace `X'=0 if `X'==2
replace `X'=0 if `X'==9	
}

foreach X of varlist i3638 i3639 {
replace `X'=. if `X'==-6
replace `X'=0 if `X'==2
replace `X'=0 if `X'==9	
replace `X'=0 if `X'==-3	
}

cap drop BASmatrx
gen BASmatrx = i3617+i3618+i3619+i3620+i3621+i3622+i3623+i3624+i3625+i3626+i3627+i3628+i3629+i3630+i3631+i3632+i3633+i3634+i3635+i3636+i3637+i3638+i3639+i3640+i3641+i3642+i3643+i3644
label var BASmatrx "British Ability Scales Matrix - Total score"
fre BASmatrx



//	Gross family income	grfaminc
fre BD3INC
replace BD3INC=. if BD3INC<0|BD3INC==8
rename BD3INC grfaminc
fre grfaminc

//	Teacher Rutter assessment	B3T_Rutt
sum j151 j163 j160 j122 j149 j159 j156 j171 j128 j146 j169 j172 j175 
foreach X of varlist j151 j163 j160 j122 j149 j159 j156 j171 j128 j146 j169 j172 j175  {
replace `X'=. if `X'<0	
}
cap drop B3T_Rutt
gen B3T_Rutt=j151+j163+j160+j149+j159+j156+j171+j128+j146+j169+j172+j175-j122+47
label var B3T_Rutt "Teacher Rutter assessment"
fre B3T_Rutt


//	Number of household accessories	b3hldstf
fre m291 m292 m293 m294 m295 m296 m297 m298 m299 m300 m301 m302
foreach X of varlist m291 m292 m293 m294 m295 m296 m297 m298 m299 m300 m301 m302 {
replace `X'=. if `X'==-7
replace `X'=0 if `X'==-3	
}
replace m302=1 if inrange(m302,2,100)
replace m301=0 if m301==2

cap drop b3hldstf
gen b3hldstf=m291+m292+m293+m294+m295+m296+m297+m298+m299+m300+m301+m302
label var b3hldstf "Number of household accessories"
fre b3hldstf

//	Maths Test Score	BD3MATHS
fre BD3MATHS
replace BD3MATHS=. if BD3MATHS<0


//	Accommodation	D2_new	
fre d2			
cap drop D2_new
recode d2 (1=1 "Owned outright") (2=2 "Being bought") (3=3 "Council rented") (4/5=4 "Other rented") (6=5 "Tied to occupation") (7=.), gen(D2_new)	
fre D2_new	

keep bcsid D1_1_new bd3rdage BASmatrx grfaminc B3T_Rutt b3hldstf BD3MATHS D2_new			
save "$derived\S3_age10.dta", replace	
		
	
	
*** SWEEP 4		
//Sweep 4 (age 16)	
use "$rawdata\bcs7016x.dta", clear //BCSID

//	Satisfaction with teen's school progress	Pb3_1w	
fre pb3_1
cap drop Pb3_1w
clonevar Pb3_1w=pb3_1
replace Pb3_1w=. if Pb3_1w<0|Pb3_1w==4
fre Pb3_1w

//	Maths 0 level or equivalent	T2c1_1
fre t2c1_1
cap drop T2c1_1
clonevar T2c1_1=t2c1_1
replace T2c1_1=. if T2c1_1<0
fre T2c1_1		

keep bcsid Pb3_1w T2c1_1		
save "$derived\S4_age16.dta", replace	
		

	
	
	
*** SWEEP 5
//Sweep 5 (age 26)
use "$rawdata\bcs96x.dta", clear //BCSID

//	How easy would you quit a job, if there	B960421_new
fre b960127
cap drop B960127_new
clonevar B960127_new=b960127
replace B960127_new=. if B960127_new==-8
fre B960127_new

//	N of accidents elsewhere	Aelse_new
fre aelse
cap drop Aelse_new
recode aelse (2/4=2 "Two or more"), gen(Aelse_new)
fre Aelse_new

//	Tenure of current address	B960421_new
fre b960421
cap drop B960421_new
recode b960421 (-8=.) (1=1 "Own/Parents(rent-free)") (7=1) (2=2 "Buying on a mortgage") (3/6=3 "Rent") (8=4 "Other"), gen(B960421_new)
fre B960421_new

//	Satisfaction about life (1-3) ordered	B960666_new	
fre b960666
cap drop B960666_new
recode b960666 (0/5=1 "0-5") (6/7=2 "6-7") (8/9=3 "8-9"), gen(B960666_new)
fre B960666_new

//	Age left education	B960132_new	
fre b960132
cap drop B960132_new
recode b960132 (-8=.) (12/16=1 "16 or younger") (17/18=2 "17-18") (19/30=3 "19 or older"), gen(B960132_new)
fre B960132_new

keep bcsid B960127_new Aelse_new B960421_new B960666_new B960132_new	
save "$derived\S5_age26.dta", replace	
		



*** SWEEP 6	
//Sweep 6 (age 30)	
use "$rawdata\bcs2000.dta", clear //BCSID

//	Does participant intend to move?	Wantmove_new	
fre wantmove
cap drop Wantmove_new
clonevar Wantmove_new=wantmove
replace Wantmove_new=. if inrange(Wantmove_new,8,9)
fre Wantmove_new

//	Did you vote in the 97 elections?	Vote97_new	
fre vote97
cap drop Vote97_new
clonevar Vote97_new=vote97
replace Vote97_new=. if inrange(Vote97_new,8,9)
fre Vote97_new

//	Do you like the area? (Units 1-5)	Likearea_new
fre likearea
cap drop Likearea_new
clonevar Likearea_new=likearea
replace Likearea_new=. if inrange(Likearea_new,8,9)
fre Likearea_new
	
//	Does participant intend to have more children infertlc_new
fre infertlc
cap drop infertlc_new
clonevar infertlc_new = infertlc
replace infertlc_new=. if infertlc_new==9
fre infertlc_new

//	Financial situation	Finnow_new
fre finnow
cap drop Finnow_new
clonevar Finnow_new=finnow
replace Finnow_new=. if inrange(Finnow_new,8,9)
fre Finnow_new

//	Had eczema or skin problems?	Othskin_new	
fre othskin
cap drop Othskin_new
clonevar Othskin_new=othskin
replace Othskin_new=. if inrange(Othskin_new,8,9)
fre Othskin_new	
	
keep bcsid Wantmove_new	Vote97_new Likearea_new infertlc_new Finnow_new Othskin_new	
save "$derived\S6_age30.dta", replace	
		
		
	
	
*** SWEEP 7			
//Sweep 7 (age 34)
use "$rawdata\bcs_2004_followup.dta", clear //BCSID

//	Work overtime?	b7otimny
fre b7otimny
replace b7otimny=. if b7otimny<0
fre b7otimny

//	Should everyone behave responsibly?	B7_resp
fre b7eresp6
cap drop B7_resp
clonevar B7_resp=b7eresp6
replace B7_resp=. if B7_resp<0
fre B7_resp

//	How many times have you been found guilty in a criminal court?	B7court_new	
fre b7court
cap drop B7court_new
recode b7court (-9/-1=.) (0=0 "None") (1/9=1 "Once or more"), gen(B7court_new)
fre B7court_new

//	Is this address participant's residence?	b7nrmal
fre b7nrmal		

keep bcsid b7otimny B7_resp B7court_new	b7nrmal
save "$derived\S7_age34.dta", replace	
		
	
	
*** SWEEP 8
//Sweep 8 (age 38)
use "$rawdata\bcs_2008_followup.dta", clear //BCSID
	
//	Participant willing to be contacted for parents' research project?	b8parent
fre b8parent
replace b8parent=. if b8parent<0

//	Any children aged 0-6	b8chd006
fre b8chd006
replace b8chd006=. if b8chd006<0

keep bcsid b8parent b8chd006	
save "$derived\S8_age38.dta", replace	

	
*** SWEEP 9
//Sweep 9 (age 42)	
use "$rawdata\bcs70_2012_flatfile.dta", clear //BCSID
fre B9VSCORE	
replace B9VSCORE=. if B9VSCORE<0

rename BCSID bcsid
keep bcsid B9VSCORE	
save "$derived\S9_age42.dta", replace	

***merge all data sets
use "$derived\NRprior.dta", clear //N=18,038
merge 1:1 bcsid using "$derived\COB_SEX.dta", nogen
merge 1:1 bcsid using "$derived\S1_birth.dta", nogen
merge 1:1 bcsid using "$derived\S2_age5.dta", nogen
merge 1:1 bcsid using "$derived\S3_age10.dta", nogen
merge 1:1 bcsid using "$derived\S4_age16.dta", nogen
merge 1:1 bcsid using "$derived\S5_age26.dta", nogen
merge 1:1 bcsid using "$derived\S6_age30.dta", nogen
merge 1:1 bcsid using "$derived\S7_age34.dta", nogen
merge 1:1 bcsid using "$derived\S8_age38.dta", nogen
merge 1:1 bcsid using "$derived\S9_age42.dta", nogen	

drop if everpart==.	
drop everpart

save "$derived\BCS non-response predictors.dta", replace		
	
//erase all temporary files	
erase "$derived\NRprior.dta"
erase"$derived\COB_SEX.dta"
erase"$derived\S1_birth.dta"
erase"$derived\S2_age5.dta"
erase"$derived\S3_age10.dta"
erase"$derived\S4_age16.dta"
erase"$derived\S5_age26.dta"
erase"$derived\S6_age30.dta"
erase"$derived\S7_age34.dta"
erase"$derived\S8_age38.dta"
erase"$derived\S9_age42.dta"	
	
	

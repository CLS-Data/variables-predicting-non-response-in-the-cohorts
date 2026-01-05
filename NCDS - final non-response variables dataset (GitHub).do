
clear

global rawdata "insert here file path to folder with raw data" //location of folder with all raw data files downloaded from UK Data Service

global derived "insert here file path to folder for the final derived dataset" //location of folder for derived data


**# Bookmark #3
//response file
*********************************************************
use "$rawdata\ncds_response.dta", clear
keep NCDSID OUTCME00 OUTCME01 OUTCME02 OUTCME03 OUTCME04 OUTCME05 OUTCME06 OUTCMEBM OUTCME07 OUTCME08

//first sweep CM's took part

//sweep 0 (birth)
fre OUTCME00
cap drop sweep0
gen sweep0=.
replace sweep0=1 if OUTCME00==1
replace sweep0=0 if OUTCME00!=1
fre sweep0

//sweep 1 (age 7)
fre OUTCME01
cap drop sweep1
gen sweep1=0
replace sweep1=1 if OUTCME00!=1 & OUTCME01==1
fre sweep1

//sweep 2 (age 11)
fre OUTCME02
cap drop sweep2
gen sweep2=0
replace sweep2=1 if OUTCME00!=1 & OUTCME01!=1 & OUTCME02==1
fre sweep2

//sweep 3 (age 16)
fre OUTCME03
cap drop sweep3
gen sweep3=0
replace sweep3=1 if OUTCME00!=1 & OUTCME01!=1 & OUTCME02!=1 &OUTCME03==1
fre sweep3

//sweep 4 (age 23)
fre OUTCME04
cap drop sweep4
gen sweep4=0
replace sweep4=1 if OUTCME00!=1 & OUTCME01!=1 & OUTCME02!=1 & OUTCME03!=1 & OUTCME04==1
fre sweep4

//sweep 5 (age 33) /last sweep with first time entries
fre OUTCME05
cap drop sweep5
gen sweep5=0
replace sweep5=1 if OUTCME00!=1 & OUTCME01!=1 & OUTCME02!=1 & OUTCME03!=1 & OUTCME04!=1 & OUTCME05==1
fre sweep5

cap drop everpart //check those who evert took part
gen everpart=0
replace everpart=1 if sweep0==1|sweep1==1|sweep2==1|sweep3==1|sweep4==1|sweep5==1
fre everpart

//prior NR
fre OUTCME01 //NR01priorNR
cap drop NR01priorNR
gen NR01priorNR=0
replace NR01priorNR=1 if inrange(OUTCME01,2,8) & sweep0==1 
fre NR01priorNR // N3133 N2527

fre OUTCME01 OUTCME02
cap drop NR02priorNR
gen NR02priorNR=0
replace NR02priorNR=1 if (inrange(OUTCME01,2,8)|inrange(OUTCME02,2,8)) & (sweep0==1|sweep1==1)
fre NR02priorNR // N4435 N3829


fre OUTCME01 OUTCME02 OUTCME03
cap drop NR03priorNR
gen NR03priorNR=0
replace NR03priorNR=1 if (inrange(OUTCME01,2,8)|inrange(OUTCME02,2,8)|inrange(OUTCME03,2,8)) & (sweep0==1|sweep1==1|sweep2==1)
fre NR03priorNR //N5994 N5685

fre OUTCME01 OUTCME02 OUTCME03 OUTCME04
cap drop NR04priorNR
gen NR04priorNR=0
replace NR04priorNR=1 if (inrange(OUTCME01,2,8)|inrange(OUTCME02,2,8)|inrange(OUTCME03,2,8)|inrange(OUTCME04,2,8)) & (sweep0==1|sweep1==1|sweep2==1|sweep3==1)
fre NR04priorNR //N8510 N8504

fre OUTCME01 OUTCME02 OUTCME03 OUTCME04 OUTCME05
cap drop NR05priorNR
gen NR05priorNR=0
//replace NR05priorNR=0 if OUTCME01==1 & OUTCME02==1 & OUTCME03==1 & OUTCME04==1 & OUTCME05==1
replace NR05priorNR=1 if (inrange(OUTCME01,2,8)|inrange(OUTCME02,2,8)|inrange(OUTCME03,2,8)|inrange(OUTCME04,2,8)|inrange(OUTCME05,2,8)) & (sweep0==1|sweep1==1|sweep2==1|sweep3==1|sweep4==1)
fre NR05priorNR //N10542 N10541

fre OUTCME01 OUTCME02 OUTCME03 OUTCME04 OUTCME05 OUTCME06
cap drop NR06priorNR
gen NR06priorNR=0
replace NR06priorNR=1 if (inrange(OUTCME01,2,8)|inrange(OUTCME02,2,8)|inrange(OUTCME03,2,8)|inrange(OUTCME04,2,8)|inrange(OUTCME05,2,8)|inrange(OUTCME06,2,8)) //& (sweep0==1|sweep1==1|sweep2==1|sweep3==1|sweep4==1|sweep5==1)
fre NR06priorNR //N11477 N11477

fre OUTCME01 OUTCME02 OUTCME03 OUTCME04 OUTCME05 OUTCME06 OUTCMEBM
cap drop NRBMpriorNR
gen NRBMpriorNR=0
replace NRBMpriorNR=1 if (inrange(OUTCME01,2,8)|inrange(OUTCME02,2,8)|inrange(OUTCME03,2,8)|inrange(OUTCME04,2,8)|inrange(OUTCME05,2,8)|inrange(OUTCME06,2,8)|inrange(OUTCMEBM,2,8))
fre NRBMpriorNR //N12589 

fre OUTCME01 OUTCME02 OUTCME03 OUTCME04 OUTCME05 OUTCME06 OUTCMEBM OUTCME07
cap drop NR07priorNR
gen NR07priorNR=0
replace NR07priorNR=1 if (inrange(OUTCME01,2,8)|inrange(OUTCME02,2,8)|inrange(OUTCME03,2,8)|inrange(OUTCME04,2,8)|inrange(OUTCME05,2,8)|inrange(OUTCME06,2,8)|inrange(OUTCMEBM,2,8)|inrange(OUTCME07,2,8)) & (sweep0==1|sweep1==1|sweep2==1|sweep3==1|sweep4==1|sweep5==1)
fre NR07priorNR //N13028

fre OUTCME01 OUTCME02 OUTCME03 OUTCME04 OUTCME05 OUTCME06 OUTCMEBM OUTCME07 OUTCME08
cap drop NR08priorNR
gen NR08priorNR=0
replace NR08priorNR=1 if inrange(OUTCME01,2,8)|inrange(OUTCME02,2,8)|inrange(OUTCME03,2,8)|inrange(OUTCME04,2,8)|inrange(OUTCME05,2,8)|inrange(OUTCME06,2,8)|inrange(OUTCMEBM,2,8)|inrange(OUTCME07,2,8)|inrange(OUTCME08,2,8)
fre NR08priorNR //N13483


label var NR08priorNR "Non-response to any prior survey sweeps (i.e. s1-s8)"
label var NR07priorNR "Non-response to any prior survey sweeps (i.e. s1-s7)"
label var NRBMpriorNR "Non-response to any prior survey sweeps (i.e. s1-biomed)"
label var NR06priorNR "Non-response to any prior survey sweeps (i.e. s1-s6)"
label var NR05priorNR "Non-response to any prior survey sweeps (i.e. s1-s5)"
label var NR04priorNR "Non-response to any prior survey sweeps (i.e. s1-s4)"
label var NR03priorNR "Non-response to any prior survey sweeps (i.e. s1-s3)"
label var NR02priorNR "Non-response to any prior survey sweeps (i.e. s1-s2)"
label var NR01priorNR "Non-response to any prior survey sweeps (i.e. s1)"


label define prior 1 "Yes, prior non-response" 0 "No, no prior non-response", replace
foreach X of varlist NR01priorNR NR02priorNR NR03priorNR NR04priorNR NR05priorNR NR06priorNR NRBMpriorNR NR07priorNR NR08priorNR {
label values  `X' prior
}

fre NR01priorNR NR02priorNR NR03priorNR NR04priorNR NR05priorNR NR06priorNR NRBMpriorNR NR07priorNR NR08priorNR

rename NCDSID ncdsid    

keep ncdsid OUTCME00 NR01priorNR NR02priorNR NR03priorNR NR04priorNR NR05priorNR NR06priorNR NRBMpriorNR NR07priorNR NR08priorNR

order ncdsid OUTCME00 NR01priorNR NR02priorNR NR03priorNR NR04priorNR NR05priorNR NR06priorNR NRBMpriorNR NR07priorNR NR08priorNR

save "$derived\NRprior.dta", replace





**# Bookmark #7
//W 0-3 vars (age 0-16)
*******************************************************************
use "$rawdata\ncds0123.dta", clear

keep ncdsid n0region n512 n236 n545 n622 n236 n522 n660 n553 n504 n99 n123 n124 n125 n126 n127 n128 n129 n130 n131 n246 n247 n248 n249 n250 n251 n252 n253 n254 n264 n265 n266 n90 n457 n1840 n92 n197 n198 n222 n95 n180 n314 n315 n316 n317 n318 n319 n320 n321 n322 n323 n324 n325 n326 n215 n216 n217 n218 n219 n220 n221 n263 n225 n226 n266 n279 n281 n362 n363 n367 n368 n369 n370 n421 n422 n423 n371 n424 n372 n425 n350 n354 n351 n345 n352 n342 n353 n259 n364 n194 n458 n337 n332 n334 n1434 n1150 n914 n917 n204 n205 n206 n207 n208 n209 n933 n934 n935 n936 n937 n938 n939 n940 n941 n942 n943 n944 n945 n946 n947 n948 n949 n950 n951 n952 n953 n954 n1436 n1176 n136 n140 n144 n146 n1450 n1454 n1458 n1460 n2492 n2825 n2826 n2827 n2828 n2829 n2830 n2831 n2832 n2833 n2834 n2835 n2836 n2837 n2838 n2839 n2840 n2841 n2843 n2844 n2845 n2842 n2846 n2847 n2848 n2849 n2850 n2851 n2852 n2853 n2854 n2855 n2856 n2857 n2858 n2859 n2860 n2861 n2862 n2863 n2504 n2506 n2509 n2519 n2520 n2524 n2529 n2533 n2299 n2300 n2304 n2310 n2314 n2315 n2320 n2321 n2888 n2930 n2864 n2865 n2866 n2867 n2868 n2869 n2870 n2871 n2021 n2102 n2741 n1721 n2250



//S0 (age 0)
fre n0region //acatnn0region
cap drop acatnn0region
clonevar acatnn0region = n0region
replace acatnn0region=. if acatnn0region==-2
recode acatnn0region (1/3=1) (4/5=2) (6/7=3) (8/9=4) (10=5) (11=6)

label def acatnn0region 1 "North" 2 "Midlands" 3 "East & South East" 4 "South & South West" 5 "Wales" 6 "Scotland", replace
label values acatnn0region acatnn0region

fre acatnn0region


fre n512 //aconnn512
cap drop aconnn512
clonevar aconnn512 = n512
replace aconnn512=. if aconnn512==-1
fre aconnn512

fre n236 //acatnn236
cap drop acatnn236
clonevar acatnn236 = n236
replace acatnn236=. if acatnn236==-1|acatnn236==1
fre acatnn236

fre n545 //abinnn545
cap drop abinnn545
recode n545 (-1=.) (1/2=0 "Unmarried / stable union / sep, div, widowed") (5=0) (3/4=1 "Married/Twice married"), gen(abinnn545)
fre abinnn545

fre n622 //bingender
cap drop bingender
clonevar bingender = n622
replace bingender=. if bingender==-1
replace bingender=0 if bingender==2
label def bingender 0 "Female" 1 "Male", replace
label val bingender bingender
fre bingender

fre n236 //acatnn236
cap drop acatnn236
clonevar acatnn236 = n236
replace acatnn236=. if acatnn236==-1
fre acatnn236

fre n522 //abinnn522
cap drop abinnn522
recode n522 (-1=.) (1=0 "No") (2/9=1 "Yes"), gen(abinnn522)
fre abinnn522

fre n660 //acatnn660
cap drop acatnn660
clonevar acatnn660 = n660
replace acatnn660=. if acatnn660==-1|acatnn660==1
fre acatnn660

fre n553 //aconnn553
cap drop aconnn553
clonevar aconnn553 = n553
replace aconnn553=. if aconnn553==-1|aconnn553==8
fre aconnn553

fre n504 //aconnn504
cap drop aconnn504
clonevar aconnn504 = n504
replace aconnn504=. if aconnn504==-1
fre aconnn504



//S1 (age 7)
fre n99 //bconnn99
cap drop bconnn99
clonevar bconnn99 = n99
replace bconnn99=. if bconnn99==-1
fre bconnn99

fre n123 n124 n125 n126 n127 n128 n129 n130 n131 //bconnage7dv1
cap drop bconnage7dv1
egen bconnage7dv1 = anycount(n123 n124 n125 n126 n127 n128 n129 n130 n131), values(2)
replace bconnage7dv1=. if (n123==-1|n123==1) |(n124==-1|n124==1) | (n125==-1|n125==1) | (n126==-1|n126==1) | (n127==-1|n127==1)| (n128==-1|n128==1)| (n129==-1|n129==1)| (n130==-1|n130==1)| (n131==-1|n131==1) |n123==. //aase
replace bconnage7dv1=. if n123==.
label var bconnage7dv1 "Child difficulties age 7"
fre bconnage7dv1

fre n246 n247 n248 n249 n251 n250 n252 n253 n254 //bconnage7dv5
cap drop bconnage7dv5
egen bconnage7dv5 = anycount(n246 n247 n248 n249 n250 n251 n252 n253 n254), values(2)
replace bconnage7dv5=. if (n246==-1|n246==1) |(n247==-1|n247==1) | (n248==-1|n248==1) | (n249==-1|n249==1) | (n250==-1|n250==1)| (n251==-1|n251==1)| (n252==-1|n252==1)| (n253==-1|n253==1)| (n254==-1|n254==1) |n246==.
label var bconnage7dv5 "Hospital admissions"
fre bconnage7dv5


fre n90 n457 n1840 n92 //CogAbil7
foreach X of varlist n90 n457 n1840 n92 {
replace `X'=. if `X'<0	
}
cap drop CogAbil7
alpha n90 n457 n1840 n92, generate(CogAbil7) std
label var CogAbil7 "Cognitive ability summary"
fre CogAbil7

fre n197 n198 //maw5
cap drop maw5
gen maw5=.
replace maw5=1 if n197==2|n197==3|n198==3
replace maw5=0 if n197==4|n198==4
label var maw5 "Mother worked birth to 5"
fre maw5

fre n222 //bfever
cap drop bfever
recode n222 (-1=.) (1=.) (2=0 "Never breastfed") (3/4=1 "Ever breastfed"), gen(bfever)
fre bfever

fre n95 //bcatnn95
cap drop bcatnn95
recode n95 (-1=.) (1=1) (2=2) (3=3) (4=4) (5/22=5 "5+"), gen(bcatnn95)
fre bcatnn95

fre n180 //DadNeverReads
cap drop DadNeverReads
recode n180 (-1=.) (1=.) (2/3=0 "Every week / occasionally") (4=1 "Hardly ever"),gen(DadNeverReads)
fre DadNeverReads


fre n314 n315 n316 n317 n318 n319 n320 n321 n322 n323 n324 n325 n326 // bconnage7dv10
cap drop bconnage7dv10
egen bconnage7dv10 = anycount(n314 n315 n316 n317 n318 n319 n320 n321 n322 n323 n324 n325 n326), values(2)
replace bconnage7dv10=. if (n314==-1|n314==1) |(n315==-1|n315==1) | (n316==-1|n316==1) | (n317==-1|n317==1) | (n318==-1|n318==1)| (n319==-1|n319==1)| (n320==-1|n320==1)| (n321==-1|n321==1)| (n322==-1|n322==1) | (n323==-1|n323==1)| (n324==-1|n324==1)| (n325==-1|n325==1)| (n326==-1|n326==1)|n314==. //aase
replace bconnage7dv10=. if n314==. 
label var bconnage7dv10 "Social problems (alcoholism etc.)"
fre bconnage7dv10


*MedExSum7
fre n215 n216 n217 n218 n219 n220 n221 n263 n225 n226 n266 n279 n281 n362 n363 n367 n368 n369 n370 n421 n422 n423 n371 n424 n372 n425 n350 n354 n351 n345 n352 n342 n353 n259 n364 //MedExSum7

replace n367=2 if inrange(n367,4,11)
replace n367=2 if n367==1

cap drop MedExSum7
egen MedExSum7 = anycount(n215 n216 n217 n218 n219 n220 n221 n263 n225 n226 n266 n279 n281 n362 n363 n367 n368 n369 n370 n421 n422 n423 n371 n424 n372 n425 n350 n354 n351 n345 n352 n342 n353 n259 n364), values(2)

cap drop MedExSum7_mis1
egen MedExSum7_mis1 = anycount(n215 n216 n217 n218 n219 n220 n221 n263 n225 n226 n266 n279 n281 n362 n363 n367 n368 n369 n370 n421 n422 n423 n371 n424 n372 n425 n350 n354 n351 n345 n352 n342 n353 n259 n364), values(-1 1)
fre MedExSum7_mis1

replace MedExSum7=. if MedExSum7_mis1!=0|n215==. //aase
label var MedExSum7 "Summary of medical conditions"
fre MedExSum7
drop MedExSum7_mis1 



fre n194 //bbinnn194
cap drop bbinnn194
gen bbinnn194=.
replace bbinnn194=1 if  n194==2
replace bbinnn194=0 if  n194==3
label def yesno 0 "no" 1 "yes", replace
label val bbinnn194 yesno
label var bbinnn194 "Dad stayed on at school after minimum age"
fre bbinnn194

fre n458 //bcatnn458
cap drop bcatnn458
recode n458 (-1=.) (1=1 "Good attendance") (2=2 "Frequent short absence") (3/5=3 "Long absences / malingerer etc / helps at home"), gen(bcatnn458)
label var bcatnn458 "Attendance"
fre bcatnn458

*
fre n337 n332 n334 //bmi7
replace n337=. if n337<1
replace n332=. if n332<1
replace n334=. if n334<11

replace n332 = n332*2.54 //converting inches to cm
replace n332=n334 if n332==. //filling in with cm measure
replace n332=n332/100 //converting cm to meters
fre n332

replace n337=n337/2.20462 //converting pounds to kg
fre n337

cap drop bmi7
gen bmi7=n337/(n332*n332)
label var bmi7 "Body mass index"
fre bmi7



//S2 (age 11)
fre n1434 //ccatnn1434
recode n1434 (-1=.)(1=1 "British Isles") (2=2 "Eire & Ulster") (3=3 "Europe incl USSR") (8=3) (4/7=4 "Outside Europe") (9=4), gen(ccatnn1434)
fre ccatnn1434

fre n1150 //ccatnn1150
cap drop ccatnn1150
recode n1150 (-1=.) (4/9=4 "4+"), gen(ccatnn1150)
fre ccatnn1150

fre n914 n917 //genability11
replace n914=. if n914<0
replace n917=. if n917<0
cap drop genability11
gen genability11= n914 + n917
label var genability11 "Cognitive ability summary"
fre genability11


*Amenities
fre n204 n205 n206 n207 n208 n209 //Amens
cap drop Amens
//egen Amens = anycount (n204 n205 n206 n207 n208 n209), values(2)
//cap drop Amens_mis1
//egen Amens_mis1 = anycount(n204 n205 n206 n207 n208 n209), values(-1 1)
//fre Amens_mis1

egen Amens = anycount (n204 n205 n206 n207 n208 n209), values(2)
cap drop Amens_mis1
egen Amens_mis1 = anycount(n204 n205 n206 n207 n208 n209), values(-1 1)
fre Amens_mis1

replace Amens=. if Amens_mis1!=0|n204==.
label var Amens "Number of household amenities"
fre Amens
drop Amens_mis1 


fre n933 n934 n935 n936 n937 n938 n939 n940 n941 n942 n943 n944 n945 n946 n947 n948 n949 n950 n951 n952 n953 n954 //cconnage11dv32
cap drop cconnage11dv32
egen cconnage11dv32 = anycount(n933 n934 n935 n936 n937 n938 n939 n940 n941 n942 n943 n944 n945 n946 n947 n948 n949 n950 n951 n952 n953 n954), values(1 2)
replace cconnage11dv32=. if n933==.
//replace 

foreach X of varlist n933 n934 n935 n936 n937 n938 n939 n940 n941 n942 n943 n944 n945 n946 n947 n948 n949 n950 {
replace `X'=. if `X'==-1	
}
cap drop nomiss //not incuding n951 n952 n953 n954 in this missingness mesure as it seems like these are somewhow routed so it will overestimate missingness
egen nomiss =  rownonmiss(n933 n934 n935 n936 n937 n938 n939 n940 n941 n942 n943 n944 n945 n946 n947 n948 n949 n950)
fre nomiss
replace cconnage11dv32=. if nomiss!=18 //aase

fre cconnage11dv32
label var cconnage11dv32 "Child's positive activities outside school"
fre cconnage11dv32


fre n1436 //ccatnn1436
recode n1436 (-1=.)(1=1 "British Isles") (2=2 "Eire & Ulster") (3=3 "Europe incl USSR") (8=3) (4/7=4 "Outside Europe") (9=4), gen(ccatnn1436)
fre ccatnn1436

fre n1176 //cbinnn1176
recode n1176 (-1=.) (1=1 "Employment") (2/7=0 "Other sources"), gen(cbinnn1176)
fre cbinnn1176


fre n1450 n1454 n1458 n1460 //Ext11Dec18

foreach X of varlist n1450 n1454 n1458 n1460 {
replace `X'=. if `X'==-1|`X'==4|`X'==9	
}
cap drop Ext11Dec18
alpha n1450 n1454 n1458 n1460, std gen(Ext11Dec18)
label var Ext11Dec18 "Conduct problems"
fre Ext11Dec18


//S3 (age 16)
fre n2492 //dconnn2492
rename n2492 dconnn2492
replace dconnn2492 =. if dconnn2492==-1
fre dconnn2492

*dconnage16dv46 
fre n2825 n2826 n2827 n2828 n2829 n2830 n2831 n2832 n2833 n2834 n2835 n2836 n2837 n2838 n2839 n2840 n2841 n2843 n2844 n2845 n2842 n2846 n2847 n2848 n2849 n2850 n2851 n2852 n2853 n2854 n2855 n2856 n2857 n2858 n2859 n2860 n2861 n2862 n2863 //dconnage16dv46
cap drop dconnage16dv46
egen dconnage16dv46 = anycount(n2825 n2826 n2827 n2828 n2829 n2830 n2831 n2832 n2833 n2834 n2835 n2836 n2837 n2838 n2839 n2840 n2841 n2843 n2844 n2845 n2842 n2846 n2847 n2848 n2849 n2850 n2851 n2852 n2853 n2854 n2855 n2856 n2857), values(1 2 3 4 5 6 7 8 9)
replace dconnage16dv46 =. if n2825==.
label var dconnage16dv46 "Sum of favourable learning environments/outcomes re sex educ etc)"
fre dconnage16dv46

cap drop extra
egen extra = anycount(n2858 n2859 n2860 n2861 n2862 n2863), values (2)
replace extra=. if n2858==.
fre extra 

replace dconnage16dv46= dconnage16dv46+extra
fre dconnage16dv46



//Ext16MTDec18
fre n2504 n2506 n2509 n2519 n2520 n2524 n2529 n2533 //parent
fre n2299 n2300 n2304 n2310 n2314 n2315 n2320 n2321 //teacher
foreach X of varlist n2504 n2506 n2509 n2519 n2520 n2524 n2529 n2533 n2299 n2300 n2304 n2310 n2314 n2315 n2320 n2321 {
replace `X'=. if `X'== -1		
}

cap drop Ext16MTDec18
alpha  n2504 n2506 n2509 n2519 n2520 n2524 n2529 n2533 n2299 n2300 n2304 n2310 n2314 n2315 n2320 n2321, std gen(Ext16MTDec18)
label var Ext16MTDec18 "Conduct problems"
fre Ext16MTDec18
sum Ext16MTDec18



fre n2888 //dcatnn2888
rename n2888 dcatnn2888
replace dcatnn2888=. if dcatnn2888==-1
replace dcatnn2888 =3 if inrange(dcatnn2888,4,5)
replace dcatnn2888=4 if dcatnn2888==6
replace dcatnn2888=5 if dcatnn2888==7
label def dcatnn2888 1 "Less than 1 week" 2 "2-4 weeks" 3 "5 or more weeks" 4 "Do not remember" 5 "Never had one", replace
label val dcatnn2888 dcatnn2888 
fre dcatnn2888

fre n2930 //dconnn2930
replace n2930=. if n2930==-1
rename n2930 dconnn2930
fre dconnn2930 


fre n2864 n2865 n2866 n2867 n2868 n2869 n2870 n2871 //dconnage16dv47
foreach X of varlist n2864 n2865 n2866 n2867 n2868 n2869 n2870 n2871 {
//replace `X'=. if `X'==-1 //aase
replace `X'=0 if `X'==-1 //richard
replace `X'=1 if `X'==2
replace `X'=0 if inrange(`X',3,4)	
}
cap drop dconnage16dv47
egen dconnage16dv47 = rowtotal(n2864 n2865 n2866 n2867 n2868 n2869 n2870 n2871), missing
label var dconnage16dv47 "Sum of good activities performed outside school"
fre dconnage16dv47


fre n2021 //dbinnn2021
cap drop dbinnn2021
recode n2021 (-1=.) (1=0 "No abnormality") (2/7=1 "Any condition or handicap"), gen(dbinnn2021)
fre dbinnn2021


fre n2102 //dcatnn2102
cap drop dcatnn2102
recode n2102 (-1=.) (1=1 "Comprehensive") (2=2 "Grammar") (3=3 "Secondary modern") (4/11=4 "Other"), gen(dcatnn2102)
fre dcatnn2102


fre n2741 //dcatnn2741
replace n2741=. if n2741==-1
rename n2741 dcatnn2741

fre n1721 //dconnn1721
replace n1721=. if n1721==-1
rename n1721 dconnn1721

fre n2250 //dbinnn2250
recode n2250 (-1=.) (1/3=1 "yes") (4=0 "No"), gen(dbinnn2250)
fre dbinnn2250

save "$derived\ncds0123.dta", replace




**# Bookmark #6
//S4 (age 23)
*******************************************************************
use "$rawdata\ncds4.dta", clear
keep ncdsid n5318 n5959 econstrg n5950 n5953 n5956 n5965 n5969 n5113 n5818 n5819 n5964 n5967

fre n5318 //ecatnn5318
recode n5318 (1=1 "House") (2=2 "Bungalow") (3=3 "PB Flat") (4=4 "SC flat") (5/7=5 "Other") (9=.), gen(ecatnn5318)
fre ecatnn5318

fre n5959 //ebinnn5960
replace n5959=. if n5959==8|n5959==9
rename n5959 ebinnn5960
recode ebinnn5960 (1=1) (2=0)
label def ebinnn5960 1 "yes" 0 "no"
label val ebinnn5960 ebinnn5960
fre ebinnn5960

fre econstrg //ecatneconstrg
replace econstrg=. if econstrg==0
rename econstrg ecatneconstrg
fre ecatneconstrg

fre n5950 n5953 n5956 n5965 n5969 //econndv5
fre n5964 n5967
recode n5950 n5953 n5956 (2/9=0)
recode n5965 (1/6=1) (7=0) (9=.)
replace n5965=0 if n5964==2 //code as 0 if never a member of a trade union

recode n5969 (1/3=1) (4=0)
replace n5969=0 if n5967==1 //coding a 0 if has no religion
cap drop econndv5=.
gen econndv5=n5950+n5953+n5956+n5965+n5969 
label var econndv5 "Number of voluntary activities (youth club, church etc.)"
fre econndv5


fre n5113 //ecatnn5113
recode n5113 (1=1 "Single") (2=2 "Legally married") (3/5=3 "Separated, divorced, widower"), gen(ecatnn5113)
fre ecatnn5113


fre n5818 n5819 //econnn5819
cap drop econnn5819
rename n5819 econnn5819
replace econnn5819=. if  econnn5819==98
replace econnn5819=0 if n5818 ==2
fre econnn5819

save "$derived\ncds4.dta", replace



**# Bookmark #5
//S5 (age 33)
*******************************************************************
use "$rawdata\ncds5cmi.dta", clear
keep ncdsid n502940 n504646 n509531 n509532 n509533 n509534 n509535 n509536 n509537 n509538 n509539 n509540 n509541 n509542 n509543 n509544 n509545 n509546 n509547 n509548 n509549 n509550 n509551 n509552 n509553 n509554 n509765 n509766 n509767 n509768 n509769 n509770 n509771 n509772 n509774 n501237 n504215 n504214 n504427 n504366 n504635 n502977 n504361 tenure91

fre n502940 //fcatnn502940_cat
recode n502940 (1=1 "Detached house") (2=2 "Semi house-bungalow") (3=3 "Terraced house") (4=4 "Flat/maisonette") (5/10=5 "Converted flat, rooms, caravan, miscell"), gen(fcatnn502940_cat)
fre fcatnn502940_cat

fre n504646 //fbinnn504646_bin
recode n504646 (1/2=1 "Yes") (3=0 "No"), gen(fbinnn504646_bin)
fre fbinnn504646_bin

fre n509531 n509532 n509533 n509534 n509535 n509536 n509537 n509538 n509539 n509540 n509541 n509542 n509543 n509544 n509545 n509546 n509547 n509548 n509549 n509550 n509551 n509552 n509553 n509554 //fconndvsoccapital_cont
cap drop fconndvsoccapital_cont
egen fconndvsoccapital_cont = anycount(n509531 n509532 n509533 n509534 n509535 n509536 n509537 n509538 n509539 n509540 n509541 n509542 n509543 n509544 n509545 n509546 n509547 n509548 n509549 n509550 n509551 n509552 n509553 n509554), values(1 2 3 4 5 6 7 8)
label var fconndvsoccapital_cont "Social capital score (people turn to for advice, support)"
fre fconndvsoccapital_cont


fre n509765 n509766 n509767 n509768 n509769 n509770 n509771 n509772 n509774 //fconndvcontentmnt_cont
recode n509765 n509766 (1/2=1) (3/4=0) // very or fairly vs not very or at all happy  
recode n509767 n509770 n509771 (2=0)
recode n509768 n509769 (2=1) (1=0)
recode n509772 n509774 (0/6=0) (7/10=1) 
cap drop fconndvcontentmnt_cont
gen fconndvcontentmnt_cont=n509765+n509766+n509767+n509768+n509769+n509770+n509771+n509772 +n509774
label var fconndvcontentmnt_cont "Life contentment score"
fre fconndvcontentmnt_cont



fre n501237 //fbinn501237
rename n501237 fbinn501237
recode fbinn501237 (1=1) (2=0)
label define fbinn501237 1 "Yes" 0 "No", replace
label val fbinn501237 fbinn501237
fre fbinn501237

fre n504215 n504214 //fconnn504215_cont
rename n504215 fconnn504215_cont
replace fconnn504215_cont=0 if n504214==2
fre fconnn504215_cont


fre n504427 n504366 //fcatnn504427_cat
rename n504427 fcatnn504427_cat
replace fcatnn504427_cat=3 if n504366==2
fre fcatnn504427_cat
label def fcatnn504427_cat 1 "yes" 2 "no" 3 "doesn't drive", replace
label val fcatnn504427_cat fcatnn504427_cat
fre fcatnn504427_cat

fre n504635 //fbinnn504636_bin
rename n504635 fbinnn504636_bin
recode fbinnn504636_bin (2=0) (1=1)
label def fbinnn504636_bin 1 "yes" 0 "no", replace
label val fbinnn504636_bin fbinnn504636_bin
fre fbinnn504636_bin 

fre n502977 //fbinn502977
rename n502977 fbinn502977
recode fbinn502977 (1=1) (2=0)
label def fbinn502977 1 "yes" 0 "no", replace
label val fbinn502977 fbinn502977
fre fbinn502977

fre n504361 //fconnn504361_cont
rename n504361 fconnn504361_cont
replace fconnn504361_cont=. if fconnn504361_cont==8|fconnn504361_cont==9
fre fconnn504361_cont


fre tenure91 //fbinntenure91_bin
rename tenure91 fbinntenure91_bin
recode fbinntenure91_bin (1/2=1) (3/5=0) (99=.)
label def fbinntenure91_bin 1 "Owns home" 0 "Doesn't own home", replace
label val fbinntenure91_bin fbinntenure91_bin
fre fbinntenure91_bin

save "$derived\ncds5cmi.dta", replace




**# Bookmark #4
//S6 (age 42)
*******************************************************************
use "$rawdata\ncds6.dta", clear
keep ncdsid caracces dmpart wantmove pchome orgfreq orgfreq2 orgfreq3 orgever1 orgfreq4 orgfreq5 orgfreq6 orgfreq7 cakes tenure2 mthimp 

fre caracces //gcatncaracces
rename caracces gcatncaracces
replace gcatncaracces=. if gcatncaracces==8|gcatncaracces==9
fre gcatncaracces

fre dmpart //gbindmpart
rename dmpart gbindmpart
recode gbindmpart (1=1) (2=0)
label def gbindmpart 1 "yes" 0 "no", replace
label val gbindmpart gbindmpart
fre gbindmpart

fre wantmove //gbinwantmove
rename wantmove gbinwantmove
replace gbinwantmove=. if gbinwantmove==8|gbinwantmove==9
recode gbinwantmove (1=1) (2=0)
label def gbinwantmove 1 "yes" 0 "no", replace
label val gbinwantmove gbinwantmove
fre gbinwantmove

fre pchome //gbinpchome
rename pchome gbinpchome
replace gbinpchome=. if gbinpchome==8|gbinpchome==9
recode gbinpchome (1=1) (2=0)
label def gbinpchome 1 "yes" 0 "no", replace
label val gbinpchome gbinpchome
fre gbinpchome

fre orgever1 //Org42
cap drop Org42
rename orgever1 Org42
recode Org42 (1/7=1) (8=0) (98/99=.)
label def Org42 1 "yes" 0 "no", replace
label val Org42 Org42
fre Org42

fre cakes //gconncakes
rename cakes gconncakes
replace gconncakes=. if gconncakes==8|gconncakes==9
fre gconncakes

fre tenure2 //gbinntenure2
rename tenure2 gbinntenure2
recode gbinntenure2 (1/2=1) (3/7=0) (9=.)
label def gbinntenure2 1 "Own home" 0 "Don't own home", replace
label val gbinntenure2 gbinntenure2
fre gbinntenure2

fre mthimp //gbinmthimp
rename mthimp gbinmthimp
replace gbinmthimp=. if gbinmthimp==9
recode gbinmthimp (1=1) (2=0)
label def gbinmthimp 1 "yes" 0 "no", replace
label val gbinmthimp gbinmthimp
fre gbinmthimp

save "$derived\ncds6.dta", replace



**# Bookmark #8
//Biomed (age 44)
*******************************************************************
use "$rawdata\ncds42-4_biomedical_eul.dta", clear
keep ncdsid marital ownhome nhsok childnow childnum genhlth 

fre marital //mcatnmarital
rename marital mcatnmarital
recode mcatnmarital (-9/-2=.) (1=1) (2=2) (3=3) (4/6=4)
label def mcatnmarital 1 "Single never married" 2 "Married - first and only marriage" 3 "Remarried - this is your second or later marriage" 4 "Separated/divorced/widowed"
label val mcatnmarital mcatnmarital
fre mcatnmarital

fre ownhome //OwnBM
rename ownhome OwnBM
recode OwnBM (-9/-2=.) (1/2=1) (3/8=0)
label def OwnBM 1 "Own home" 0 "Don't own home", replace
label val OwnBM OwnBM
fre OwnBM

fre nhsok //mbinnhsok
rename nhsok mbinnhsok
recode mbinnhsok (1=1) (2=0)
label def mbinnhsok 1 "yes" 0 "no", replace
label val mbinnhsok mbinnhsok
fre mbinnhsok

fre childnow //mconnchildnow
rename childnow mconnchildnow
recode mconnchildnow (-9/-2=.)
recode mconnchildnow (-1=0)
replace mconnchildnow=4 if mconnchildnow>4 & mconnchildnow !=.
label define mconnchildnow 4 "4 or more", replace
label val mconnchildnow mconnchildnow
fre mconnchildnow

fre childnum //mconnchildnum
rename childnum mconnchildnum
recode mconnchildnum (-9/-2=.)
replace mconnchildnum=4 if mconnchildnum>5 & mconnchildnum !=.
label define mconnchildnum 5 "5 or more", replace
label val mconnchildnum mconnchildnum
fre mconnchildnum


fre genhlth //mconngenhlth
rename genhlth mconngenhlth
recode mconngenhlth (-9/-2=.)
fre mconngenhlth

save "$derived\ncds42-4_biomedical_eul.dta", replace



**# Bookmark #9
//S7 (age 46)
*******************************************************************
use "$rawdata\ncds7.dta", clear
keep ncdsid nd7ms

fre nd7ms //hcatnnd7ms_cat
rename nd7ms hcatnnd7ms_cat
recode hcatnnd7ms_cat (-7/-6=.) (1=1) (2=2) (3=3) (4/6=4)
label def hcatnnd7ms_cat 1 "Married" 2 "Cohabiting (living as a couple)" 3 "Single (never married)" 4 "Separated/divorced/widowed", replace
label val hcatnnd7ms_cat hcatnnd7ms_cat
fre hcatnnd7ms_cat

save "$derived\ncds7.dta", replace



**# Bookmark #10
//S8 (age 50)
*******************************************************************
use "$rawdata\ncds_2008_followup.dta", clear
keep NCDSID ND8NCHTT N8J2101

fre ND8NCHTT //iconnnd8nchtt_cont
rename ND8NCHTT iconnnd8nchtt_cont
replace iconnnd8nchtt_cont=. if iconnnd8nchtt_cont==-6
fre iconnnd8nchtt_cont

fre N8J2101 //ibinn8j2101
rename N8J2101 ibinn8j2101
replace ibinn8j2101=. if ibinn8j2101<0
fre ibinn8j2101

save "$derived\ncds_2008_followup.dta", replace




**# Bookmark #11
**** MERGING
*******************************************************************
use "$derived\NRprior.dta", clear
merge 1:1 ncdsid using "$derived\ncds0123.dta", nogen
merge 1:1 ncdsid using "$derived\ncds4.dta", nogen
merge 1:1 ncdsid using "$derived\ncds5cmi.dta", nogen
merge 1:1 ncdsid using "$derived\ncds6.dta", nogen
merge 1:1 ncdsid using "$derived\ncds42-4_biomedical_eul.dta", nogen
merge 1:1 ncdsid using "$derived\ncds7.dta", nogen
rename ncdsid NCDSID
merge 1:1 NCDSID using "$derived\ncds_2008_followup.dta", nogen
rename NCDSID ncdsid

keep ncdsid bingender aconnn553 abinnn545 aconnn512 aconnn504 abinnn522 acatnn236 bcatnn95 bconnn99 bbinnn194 bcatnn458 bconnage7dv1 bconnage7dv5 bconnage7dv10 ccatnn1434 ccatnn1436 ccatnn1150 cbinnn1176 cconnage11dv32 dconnn2492 dbinnn2021 dcatnn2102 dbinnn2250 dconnn1721 dcatnn2741 dconnn2930 dconnage16dv46 dconnage16dv47 ecatnn5113 ecatnn5318 econnn5819 ebinnn5960 ecatneconstrg econndv5 fbinn501237 fbinn502977 fconnn504215_cont fconnn504361_cont fcatnn504427_cat fbinnn504636_bin fbinnn504646_bin fbinntenure91_bin fconndvsoccapital_cont fconndvcontentmnt_cont gconncakes gcatncaracces gbinntenure2 gbindmpart gbinwantmove gbinpchome gbinmthimp mbinnhsok mconngenhlth mconnchildnow mconnchildnum mcatnmarital iconnnd8nchtt_cont ibinn8j2101 bfever maw5 CogAbil7 MedExSum7 DadNeverReads genability11 Amens Ext11Dec18 Ext16MTDec18 Org42 OwnBM bmi7 acatnn0region acatnn660 dcatnn2888 fcatnn502940_cat hcatnnd7ms_cat NR01priorNR NR02priorNR NR03priorNR NR04priorNR NR05priorNR NR06priorNR NRBMpriorNR NR07priorNR NR08priorNR

//N=18,558
save "$derived\NCDS non-response predictors.dta", replace


*-----------------------------------------------------------------------------*
//erase all temporary files
erase "$derived\NRprior.dta"
erase"$derived\ncds0123.dta"
erase"$derived\ncds4.dta"
erase"$derived\ncds5cmi.dta"
erase"$derived\ncds6.dta"
erase"$derived\ncds42-4_biomedical_eul.dta"
erase"$derived\ncds7.dta"
erase"$derived\ncds_2008_followup.dta"

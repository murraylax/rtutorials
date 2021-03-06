/*
   NOTE: You need to edit the `libname` command to specify the path to the directory
   where the data file is located. For example: "C:\ipums_directory".
   Edit the `filename` command similarly to include the full path (the directory and the data file name).
*/

libname IPUMS ".";
filename ASCIIDAT "cps_00010.dat";

proc format cntlout = IPUMS.cps_00010_f;

value ASECFLAG_f
  1 = "ASEC"
  2 = "March Basic"
;

value MONTH_f
  01 = "January"
  02 = "February"
  03 = "March"
  04 = "April"
  05 = "May"
  06 = "June"
  07 = "July"
  08 = "August"
  09 = "September"
  10 = "October"
  11 = "November"
  12 = "December"
;

value RELATE_f
  0101 = "Head/householder"
  0201 = "Spouse"
  0301 = "Child"
  0303 = "Stepchild"
  0501 = "Parent"
  0701 = "Sibling"
  0901 = "Grandchild"
  1001 = "Other relatives, n.s."
  1113 = "Partner/roommate"
  1114 = "Unmarried partner"
  1115 = "Housemate/roomate"
  1241 = "Roomer/boarder/lodger"
  1242 = "Foster children"
  1260 = "Other nonrelatives"
  9100 = "Armed Forces, relationship unknown"
  9200 = "Age under 14, relationship unknown"
  9900 = "Relationship unknown"
  9999 = "NIU"
;

value AGE_f
  00 = "Under 1 year"
  01 = "1"
  02 = "2"
  03 = "3"
  04 = "4"
  05 = "5"
  06 = "6"
  07 = "7"
  08 = "8"
  09 = "9"
  10 = "10"
  11 = "11"
  12 = "12"
  13 = "13"
  14 = "14"
  15 = "15"
  16 = "16"
  17 = "17"
  18 = "18"
  19 = "19"
  20 = "20"
  21 = "21"
  22 = "22"
  23 = "23"
  24 = "24"
  25 = "25"
  26 = "26"
  27 = "27"
  28 = "28"
  29 = "29"
  30 = "30"
  31 = "31"
  32 = "32"
  33 = "33"
  34 = "34"
  35 = "35"
  36 = "36"
  37 = "37"
  38 = "38"
  39 = "39"
  40 = "40"
  41 = "41"
  42 = "42"
  43 = "43"
  44 = "44"
  45 = "45"
  46 = "46"
  47 = "47"
  48 = "48"
  49 = "49"
  50 = "50"
  51 = "51"
  52 = "52"
  53 = "53"
  54 = "54"
  55 = "55"
  56 = "56"
  57 = "57"
  58 = "58"
  59 = "59"
  60 = "60"
  61 = "61"
  62 = "62"
  63 = "63"
  64 = "64"
  65 = "65"
  66 = "66"
  67 = "67"
  68 = "68"
  69 = "69"
  70 = "70"
  71 = "71"
  72 = "72"
  73 = "73"
  74 = "74"
  75 = "75"
  76 = "76"
  77 = "77"
  78 = "78"
  79 = "79"
  80 = "80"
  81 = "81"
  82 = "82"
  83 = "83"
  84 = "84"
  85 = "85"
  86 = "86"
  87 = "87"
  88 = "88"
  89 = "89"
  90 = "90 (90+, 1988-2002)"
  91 = "91"
  92 = "92"
  93 = "93"
  94 = "94"
  95 = "95"
  96 = "96"
  97 = "97"
  98 = "98"
  99 = "99+"
;

value SEX_f
  1 = "Male"
  2 = "Female"
  9 = "NIU"
;

value RACE_f
  100 = "White"
  200 = "Black/Negro"
  300 = "American Indian/Aleut/Eskimo"
  650 = "Asian or Pacific Islander"
  651 = "Asian only"
  652 = "Hawaiian/Pacific Islander only"
  700 = "Other (single) race, n.e.c."
  801 = "White-Black"
  802 = "White-American Indian"
  803 = "White-Asian"
  804 = "White-Hawaiian/Pacific Islander"
  805 = "Black-American Indian"
  806 = "Black-Asian"
  807 = "Black-Hawaiian/Pacific Islander"
  808 = "American Indian-Asian"
  809 = "Asian-Hawaiian/Pacific Islander"
  810 = "White-Black-American Indian"
  811 = "White-Black-Asian"
  812 = "White-American Indian-Asian"
  813 = "White-Asian-Hawaiian/Pacific Islander"
  814 = "White-Black-American Indian-Asian"
  815 = "American Indian-Hawaiian/Pacific Islander"
  816 = "White-Black--Hawaiian/Pacific Islander"
  817 = "White-American Indian-Hawaiian/Pacific Islander"
  818 = "Black-American Indian-Asian"
  819 = "White-American Indian-Asian-Hawaiian/Pacific Islander"
  820 = "Two or three races, unspecified"
  830 = "Four or five races, unspecified"
  999 = "Blank"
;

value EDUC_f
  000 = "NIU or no schooling"
  001 = "NIU or blank"
  002 = "None or preschool"
  010 = "Grades 1, 2, 3, or 4"
  011 = "Grade 1"
  012 = "Grade 2"
  013 = "Grade 3"
  014 = "Grade 4"
  020 = "Grades 5 or 6"
  021 = "Grade 5"
  022 = "Grade 6"
  030 = "Grades 7 or 8"
  031 = "Grade 7"
  032 = "Grade 8"
  040 = "Grade 9"
  050 = "Grade 10"
  060 = "Grade 11"
  070 = "Grade 12"
  071 = "12th grade, no diploma"
  072 = "12th grade, diploma unclear"
  073 = "High school diploma or equivalent"
  080 = "1 year of college"
  081 = "Some college but no degree"
  090 = "2 years of college"
  091 = "Associate's degree, occupational/vocational program"
  092 = "Associate's degree, academic program"
  100 = "3 years of college"
  110 = "4 years of college"
  111 = "Bachelor's degree"
  120 = "5+ years of college"
  121 = "5 years of college"
  122 = "6+ years of college"
  123 = "Master's degree"
  124 = "Professional school degree"
  125 = "Doctorate degree"
  999 = "Missing/Unknown"
;

value EMPSTAT_f
  00 = "NIU"
  01 = "Armed Forces"
  10 = "At work"
  12 = "Has job, not at work last week"
  20 = "Unemployed"
  21 = "Unemployed, experienced worker"
  22 = "Unemployed, new worker"
  30 = "Not in labor force"
  31 = "NILF, housework"
  32 = "NILF, unable to work"
  33 = "NILF, school"
  34 = "NILF, other"
  35 = "NILF, unpaid, lt 15 hours"
  36 = "NILF, retired"
;

value IND1950_f
  000 = "NIU"
  105 = "Agriculture"
  116 = "Forestry"
  126 = "Fisheries"
  206 = "Metal mining"
  216 = "Coal mining"
  226 = "Crude petroleum and natural gas extraction"
  236 = "Nonmetallic mining and quarrying, except fuel"
  246 = "Construction"
  306 = "Logging"
  307 = "Sawmills, planing mills, and millwork"
  308 = "Misc wood products"
  309 = "Furniture and fixtures"
  316 = "Glass and glass products"
  317 = "Cement, concrete, gypsum and plaster products"
  318 = "Structural clay products"
  319 = "Pottery and related products"
  326 = "Miscellaneous nonmetallic mineral and stone products"
  336 = "Blast furnaces, steel works, and rolling mills"
  337 = "Other primary iron and steel industries"
  338 = "Primary nonferrous industries"
  346 = "Fabricated steel products"
  347 = "Fabricated nonferrous metal products"
  348 = "Not specified metal industries"
  356 = "Agricultural machinery and tractors"
  357 = "Office and store machines and devices"
  358 = "Miscellaneous machinery"
  367 = "Electrical machinery, equipment, and supplies"
  376 = "Motor vehicles and motor vehicle equipment"
  377 = "Aircraft and parts"
  378 = "Ship and boat building and repairing"
  379 = "Railroad and miscellaneous transportation equipment"
  386 = "Professional equipment and supplies"
  387 = "Photographic equipment and supplies"
  388 = "Watches, clocks, and clockwork-operated devices"
  399 = "Miscellaneous manufacturing industries"
  406 = "Meat products"
  407 = "Dairy products"
  408 = "Canning and preserving fruits, vegetables, and seafoods"
  409 = "Grain-mill products"
  416 = "Bakery products"
  417 = "Confectionery and related products"
  418 = "Beverage industries"
  419 = "Miscellaneous food preparations and kindred products"
  426 = "Not specified food industries"
  429 = "Tobacco manufactures"
  436 = "Knitting mills"
  437 = "Dyeing and finishing textiles, except knit goods"
  438 = "Carpets, rugs, and other floor coverings"
  439 = "Yarn, thread, and fabric mills"
  446 = "Miscellaneous textile mill products"
  448 = "Apparel and accessories"
  449 = "Miscellaneous fabricated textile products"
  456 = "Pulp, paper, and paperboard mills"
  457 = "Paperboard containers and boxes"
  458 = "Miscellaneous paper and pulp products"
  459 = "Printing, publishing, and allied industries"
  466 = "Synthetic fibers"
  467 = "Drugs and medicines"
  468 = "Paints, varnishes, and related products"
  469 = "Miscellaneous chemicals and allied products"
  476 = "Petroleum refining"
  477 = "Miscellaneous petroleum and coal products"
  478 = "Rubber products"
  487 = "Leather: tanned, curried, and finished"
  488 = "Footwear, except rubber"
  489 = "Leather products, except footwear"
  499 = "Not specified manufacturing industries"
  506 = "Railroads and railway express service"
  516 = "Street railways and bus lines"
  526 = "Trucking service"
  527 = "Warehousing and storage"
  536 = "Taxicab service"
  546 = "Water transportation"
  556 = "Air transportation"
  567 = "Petroleum and gasoline pipe lines"
  568 = "Services incidental to transportation"
  578 = "Telephone"
  579 = "Telegraph"
  586 = "Electric light and power"
  587 = "Gas and steam supply systems"
  588 = "Electric-gas utilities"
  596 = "Water supply"
  597 = "Sanitary services"
  598 = "Other and not specified utilities"
  606 = "Motor vehicles and equipment"
  607 = "Drugs, chemicals, and allied products"
  608 = "Dry goods apparel"
  609 = "Food and related products"
  616 = "Electrical goods, hardware, and plumbing equipment"
  617 = "Machinery, equipment, and supplies"
  618 = "Petroleum products"
  619 = "Farm products--raw materials"
  626 = "Miscellaneous wholesale trade"
  627 = "Not specified wholesale trade"
  636 = "Food stores, except dairy products"
  637 = "Dairy products stores and milk retailing"
  646 = "General merchandise stores"
  647 = "Five and ten cent stores"
  656 = "Apparel and accessories stores, except shoe"
  657 = "Shoe stores"
  658 = "Furniture and house furnishing stores"
  659 = "Household appliance and radio stores"
  667 = "Motor vehicles and accessories retailing"
  668 = "Gasoline service stations"
  669 = "Drug stores"
  679 = "Eating and drinking places"
  686 = "Hardware and farm implement stores"
  687 = "Lumber and building material retailing"
  688 = "Liquor stores"
  689 = "Retail florists"
  696 = "Jewelry stores"
  697 = "Fuel and ice retailing"
  698 = "Miscellaneous retail stores"
  699 = "Not specified retail trade"
  716 = "Banking and credit agencies"
  726 = "Security and commodity brokerage and investment companies"
  736 = "Insurance"
  746 = "Real estate"
  806 = "Advertising"
  807 = "Accounting, auditing, and bookkeeping services"
  808 = "Miscellaneous business services"
  816 = "Auto repair services and garages"
  817 = "Miscellaneous repair services"
  826 = "Private households"
  836 = "Hotels and lodging places"
  846 = "Laundering, cleaning, and dyeing services"
  847 = "Dressmaking shops"
  848 = "Shoe repair shops"
  849 = "Miscellaneous personal services"
  856 = "Radio broadcasting and television"
  857 = "Theaters and motion pictures"
  858 = "Bowling alleys, and billiard and pool parlors"
  859 = "Miscellaneous entertainment and recreation services"
  868 = "Medical and other health services, except hospitals"
  869 = "Hospitals"
  879 = "Legal services"
  888 = "Educational services"
  896 = "Welfare and religious services"
  897 = "Nonprofit membership organizations"
  898 = "Engineering and architectural services"
  899 = "Miscellaneous professional and related services"
  906 = "Postal service"
  916 = "Federal public administration"
  926 = "State public administration"
  936 = "Local public administration"
  997 = "Nonclassifiable"
  998 = "Industry not reported"
;

value UHRSWORKT_f
  997 = "Hours vary"
  999 = "NIU"
;

value WHYUNEMP_f
  0 = "NIU"
  1 = "Job loser - on layoff"
  2 = "Other job loser"
  3 = "Temporary job ended"
  4 = "Job leaver"
  5 = "Re-entrant"
  6 = "New entrant"
;

value VETSTAT_f
  0 = "NIU"
  1 = "No service"
  2 = "Yes"
  9 = "Unknown"
;

run;

data IPUMS.cps_00010;
infile ASCIIDAT pad missover lrecl=106;

input
  YEAR        1-4
  SERIAL      5-9
  HWTSUPP     10-19 .4
  CPSID       20-33
  ASECFLAG    34-34
  MONTH       35-36
  PERNUM      37-38
  CPSIDP      39-52
  WTSUPP      53-62 .4
  RELATE      63-66
  AGE         67-68
  SEX         69-69
  RACE        70-72
  EDUC        73-75
  EMPSTAT     76-77
  IND1950     78-80
  UHRSWORKT   81-83
  WHYUNEMP    84-84
  INCWAGE     85-91
  VETSTAT     92-92
  MOOP        93-99
  HIPVAL      100-106
;

label
  YEAR      = "Survey year"
  SERIAL    = "Household serial number"
  HWTSUPP   = "Household weight, Supplement"
  CPSID     = "CPSID, household record"
  ASECFLAG  = "Flag for ASEC"
  MONTH     = "Month"
  PERNUM    = "Person number in sample unit"
  CPSIDP    = "CPSID, person record"
  WTSUPP    = "Supplement Weight"
  RELATE    = "Relationship to household head"
  AGE       = "Age"
  SEX       = "Sex"
  RACE      = "Race"
  EDUC      = "Educational attainment recode"
  EMPSTAT   = "Employment status"
  IND1950   = "Industry, 1950 basis"
  UHRSWORKT = "Hours usually worked per week at all jobs"
  WHYUNEMP  = "Reason for unemployment"
  INCWAGE   = "Wage and salary income"
  VETSTAT   = "Veteran status"
  MOOP      = "Total family (primary family including related subfamilies) medical out of pocket payments (in dolla"
              "rs)"
  HIPVAL    = "Total family (primary family including related subfamilies) payments (in dollars) for health insuran"
              "ce premiums"
;

format
  ASECFLAG   ASECFLAG_f.
  MONTH      MONTH_f.
  RELATE     RELATE_f.
  AGE        AGE_f.
  SEX        SEX_f.
  RACE       RACE_f.
  EDUC       EDUC_f.
  EMPSTAT    EMPSTAT_f.
  IND1950    IND1950_f.
  UHRSWORKT  UHRSWORKT_f.
  WHYUNEMP   WHYUNEMP_f.
  VETSTAT    VETSTAT_f.
;

format
  HWTSUPP    11.4
  CPSID      14.
  CPSIDP     14.
  WTSUPP     11.4
;

run;


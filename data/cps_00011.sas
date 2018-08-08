/*
   NOTE: You need to edit the `libname` command to specify the path to the directory
   where the data file is located. For example: "C:\ipums_directory".
   Edit the `filename` command similarly to include the full path (the directory and the data file name).
*/

libname IPUMS ".";
filename ASCIIDAT "cps_00011.dat";

proc format cntlout = IPUMS.cps_00011_f;

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

value CLASSWKR_f
  00 = "NIU"
  10 = "Self-employed"
  13 = "Self-employed, not incorporated"
  14 = "Self-employed, incorporated"
  20 = "Works for wages or salary"
  21 = "Wage/salary, private"
  22 = "Private, for profit"
  23 = "Private, nonprofit"
  24 = "Wage/salary, government"
  25 = "Federal government employee"
  26 = "Armed forces"
  27 = "State government employee"
  28 = "Local government employee"
  29 = "Unpaid family worker"
  99 = "Missing/Unknown"
;

value UHRSWORKT_f
  997 = "Hours vary"
  999 = "NIU"
;

value PAIDHOUR_f
  0 = "NIU"
  1 = "No"
  2 = "Yes"
  6 = "Refused"
  7 = "Don't Know"
;

value UNION_f
  0 = "NIU"
  1 = "No union coverage"
  2 = "Member of labor union"
  3 = "Covered by union but not a member"
;

value INCLUGH_f
  0 = "NIU"
  1 = "No"
  2 = "Yes"
;

value HIMCAID_f
  1 = "No"
  2 = "Yes"
;

value HIMCARE_f
  0 = "NIU"
  1 = "No"
  2 = "Yes"
;

value HICHAMP_f
  1 = "No"
  2 = "Yes"
;

value PHINSUR_f
  0 = "NIU"
  1 = "No"
  2 = "Yes"
;

run;

data IPUMS.cps_00011;
infile ASCIIDAT pad missover lrecl=85;

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
  EDUC        63-65
  CLASSWKR    66-67
  UHRSWORKT   68-70
  PAIDHOUR    71-71
  UNION       72-72
  EARNWEEK    73-80 .2
  INCLUGH     81-81
  HIMCAID     82-82
  HIMCARE     83-83
  HICHAMP     84-84
  PHINSUR     85-85
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
  EDUC      = "Educational attainment recode"
  CLASSWKR  = "Class of worker"
  UHRSWORKT = "Hours usually worked per week at all jobs"
  PAIDHOUR  = "Paid by the hour"
  UNION     = "Union membership"
  EARNWEEK  = "Weekly earnings"
  INCLUGH   = "Included in employer group health plan  last year"
  HIMCAID   = "Covered by Medicaid last year"
  HIMCARE   = "Covered by Medicare last year"
  HICHAMP   = "Covered by military health insurance last year"
  PHINSUR   = "Reported covered by private health insurance last year"
;

format
  ASECFLAG   ASECFLAG_f.
  MONTH      MONTH_f.
  EDUC       EDUC_f.
  CLASSWKR   CLASSWKR_f.
  UHRSWORKT  UHRSWORKT_f.
  PAIDHOUR   PAIDHOUR_f.
  UNION      UNION_f.
  INCLUGH    INCLUGH_f.
  HIMCAID    HIMCAID_f.
  HIMCARE    HIMCARE_f.
  HICHAMP    HICHAMP_f.
  PHINSUR    PHINSUR_f.
;

format
  HWTSUPP    11.4
  CPSID      14.
  CPSIDP     14.
  WTSUPP     11.4
;

run;


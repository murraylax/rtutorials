/*
   NOTE: You need to edit the `libname` command to specify the path to the directory
   where the data file is located. For example: "C:\ipums_directory".
   Edit the `filename` command similarly to include the full path (the directory and the data file name).
*/

libname IPUMS ".";
filename ASCIIDAT "cps_00013.dat";

proc format cntlout = IPUMS.cps_00013_f;

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

run;

data IPUMS.cps_00013;
infile ASCIIDAT pad missover lrecl=20;

input
  YEAR        1-4
  EDUC        5-7
  CLASSWKR    8-9
  UHRSWORKT   10-12
  EARNWEEK    13-20 .2
;

label
  YEAR      = "Survey year"
  EDUC      = "Educational attainment recode"
  CLASSWKR  = "Class of worker"
  UHRSWORKT = "Hours usually worked per week at all jobs"
  EARNWEEK  = "Weekly earnings"
;

format
  EDUC       EDUC_f.
  CLASSWKR   CLASSWKR_f.
  UHRSWORKT  UHRSWORKT_f.
;

run;


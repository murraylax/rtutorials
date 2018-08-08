# Script to open IPUMS CPS data set on earnings, employment status, and demographics
library("SAScii")
library("dplyr")
library("ggplot2")
#dat.raw <- read.SAScii(fn="cps_00010.dat.gz", sas_ri="cps_00010.sas")
load(file="cpsdata_raw.RData")
dat <- dat.raw

# Missing value codes
dat$incwage <- dat$INCWAGE
dat$incwage[dat$INCWAGE>=9999998] <- NA

# Construct descriptive factor for sex
dat$sex[dat$SEX==1] <- "Male"
dat$sex[dat$SEX==2] <- "Female"
dat$sex <- factor(dat$sex)

# Just copy age, it doesn't need cleaning
dat$age <- dat$AGE

# Construct descriptive factor for race
dat$race[dat$RACE==100] <- "White"
dat$race[dat$RACE==200] <- "Black"
dat$race[dat$RACE==300] <- "Native American"
dat$race[dat$RACE==650 | dat$RACE==651 | dat$RACE==652] <- "Asian/Pacific Islander"
dat$race[dat$RACE>=700 & dat$RACE<999] <- "Other"
dat$race[dat$RACE==999] <- NA # Missing value code
dat$race <- factor(dat$race)

# Construct descriptive factor for employment status
dat$empstat[ dat$EMPSTAT == 0 ] <- NA # Missing value code
dat$empstat[ dat$EMPSTAT == 1 ] <- "Armed Forces"
dat$empstat[ dat$EMPSTAT == 10 | dat$EMPSTAT == 12] <- "Working"
dat$empstat[ dat$EMPSTAT>=20 & dat$EMPSTAT <=22] <- "Unemployed"
dat$empstat[ dat$EMPSTAT>=30 ] <- "Not in Labor Force"
dat$empstat <- factor(dat$empstat)

# Construct a dummy variable for whether a *civilian* is in the labor force
dat$inlf[ dat$EMPSTAT == 0] <- NA # Missing value, set to NA
dat$inlf[ dat$EMPSTAT == 1] <- NA # Armed forces set to NA
dat$inlf[ dat$EMPSTAT>1 & dat$EMPSTAT<30] <- 1 # In labor force
dat$inlf[ dat$EMPSTAT>=30] <- 0 # Not in labor force

# Construct a dummy variable for unemployed, equals a missing value for anyone not in labor force
dat$unempl[ dat$inlf==0 ] <- NA # Not in labor force
dat$unempl[ dat$EMPSTAT>=20 & dat$EMPSTAT <=22] <- 1 # Unemployed
dat$unempl[ dat$EMPSTAT==10 | dat$EMPSTAT ==12] <- 0 # Employed

# Construct a descriptive variable for industry
# See https://cps.ipums.org/cps-action/variables/IND1950#codes_section for codes
dat$industry[ dat$IND1950 == 0] <- NA
dat$industry[ dat$IND1950>= 997] <- NA
dat$industry[ dat$IND1950>=100 & dat$IND1950<200] <- "Agriculture, Forestry, and Fishing"
dat$industry[ dat$IND1950>=200 & dat$IND1950<500] <- "Manufacturing"
dat$industry[ dat$IND1950>=500 & dat$IND1950<600] <- "Transportation, Communication, and Other Utilities"
dat$industry[ dat$IND1950>=600 & dat$IND1950<700] <- "Wholesale and Retail Trade"
dat$industry[ dat$IND1950>=700 & dat$IND1950<800] <- "Finance, Insurance, and Real Estate"
dat$industry[ dat$IND1950>=800 & dat$IND1950<900] <- "Services"
dat$industry[ dat$IND1950>=900 & dat$IND1950<=936] <- "Public Administration"
dat$industry <- factor(dat$industry)

# Clean up usual hours worked, moving hours vary and NIU to missing values
# See https://cps.ipums.org/cps-action/variables/UHRSWORKT#codes_section for codes
dat$usualhrs <- dat$UHRSWORKT
dat$usualhrs[ dat$UHRSWORKT>=997 ] <- NA

# Construct a descriptive variable for reason for unemployed, including only unemployed people, missing values for others
# See https://cps.ipums.org/cps-action/variables/WHYUNEMP#codes_section
dat$ureason[ dat$WHYUNEMP==0 ] <- NA
dat$ureason[ dat$WHYUNEMP==1 | dat$WHYUNEMP ==2 ] <- "Job Loser"
dat$ureason[ dat$WHYUNEMP==3] <- "Temporary Job Ended"
dat$ureason[ dat$WHYUNEMP==4] <- "Job Leaver"
dat$ureason[ dat$WHYUNEMP==5 | dat$WHYUNEMP==6] <- "Labor Force Entrant"
dat$ureason <- factor(dat$ureason)

# Construct a dummy variable for veteran status
# See https://cps.ipums.org/cps-action/variables/VETSTAT#codes_section
dat$veteran[ dat$VETSTAT==0] <- NA
dat$veteran[ dat$VETSTAT==1] <- 0
dat$veteran[ dat$VETSTAT==2] <- 1

# Construct a usual hourly earnings = (Weekly Avg of Wage and Salary Income) / (Usual weekly hours)
weeksinyear <- 365/7
dat$usualhrearn <- (dat$incwage/weeksinyear) / (dat$usualhrs)
dat$usualhrearn[ dat$usualhrs<=0 ] <- NA
dat$usualhrearn[ dat$incwage<=0 ] <- NA 

# Construct descriptive education factor
# See https://cps.ipums.org/cps-action/variables/EDUC#codes_section
dat$edu[dat$EDUC < 10] <- NA
dat$edu[dat$EDUC>10 & dat$EDUC<73] <- "Less than high school"
dat$edu[dat$EDUC==73] <- "High school diploma"
dat$edu[dat$EDUC>73 & dat$EDUC<=110] <- "Some college"
dat$edu[dat$EDUC==111] <- "Baccalaureate degree"
dat$edu[dat$EDUC>=123] <- "Advanced degree"
dat$edu <- ordered(x=dat$edu, levels=c("Less than high school", "High school diploma","Some college","Baccalaureate degree","Advanced degree") )

# Compute Dummy for College Degree
dat$college <- as.numeric( dat$EDUC>=111  )

# Just copy MOOP (total family medical out of pocket expenses) - It doesn't need cleaning
# See https://cps.ipums.org/cps-action/variables/MOOP#codes_section
dat$medoop <- dat$MOOP

# Just copy HIPVAL (total family insurance premiums paid)
dat$insprem <- dat$HIPVAL

# Compute total medical expenses
dat$totmed <- dat$medoop + dat$insprem


# Take a sample of size 5000 
set.seed(100)
dat.sample <- sample_n(tbl=dat, size=5000)

# Save data
save(dat.raw, file="cpsdata_raw.RData")
save(dat, file="cpscleaned.RData")
save(dat.sample, file="cpssample.RData")

# Select "complete cases" from 2016 that includes information on industry, education, employment status, sex, and total medical expenses
compl.idx <- complete.cases(cbind(dat.sample$industry, dat.sample$edu, dat.sample$empstat, dat.sample$sex, dat.sample$totmed))
vars <- c("age", "incwage", "sex", "race", "empstat", "inlf", "unempl", "industry",
          "usualhrs", "ureason", "veteran", "usualhrearn", "edu", "medoop", "insprem", "totmed", "college")
df <- dat.sample[compl.idx & dat.sample$YEAR==2016, vars]

df.desc <- data.frame(Variable=vars, 
                      Description=c("Age of respondent (integer, numeric)", "Annual wage and salary income (numerical)",
                             "Male or female (string, factor)",
                             "Race (string, factor)", 
                             "Employment status including information on labor force participation and employment (string, factor)",
                             "In labor force: Dummy variable for whether person is in the labor force", 
                             "Unemployed: Dummy variable for whether person is unemployed",
                             "Industry of worker (string, factor)",
                             "Usual number of hours worked per week (numerical)",
                             "For those that are unemployed, the reason (string, factor)",
                             "Dummy variable for whether person is a veteran",
                             "Usual hourly earnings (numerical)",
                             "Level of education (string, ordered)",
                             "Total family medical out of pocket expenses (dollars, numerical)",
                             "Total family medical insurance premiums (dollars, numerical)",
                             "Total family medical expenses (dollars, numerical)",
                             "Dummy variable =1 if Baccalaureate degree or higher")
)

save(df, df.desc, file="cps2016.RData")

dat.plot <- df

posn.j <- position_jitter(width=0.3)
posn.d <- position_dodge(width=0.2)

base.p <- ggplot(data=dat.plot, mapping=aes(x=industry, y=usualhrearn, col=sex))
dot.p <- base.p + 
  geom_point(position=posn.j, alpha=0.3, size=0.75) +
  theme(axis.text.x=element_text(angle=60, vjust=1, hjust=1))

dot.p <- dot.p + 
  stat_summary(fun.data=mean_sdl, geom="point", position=posn.d, size=1) + 
  stat_summary(fun.data=mean_cl_boot, geom="errorbar", position=posn.d, size=1) 
dot.p <- dot.p + coord_cartesian(ylim=c(0,100)) # Zoom in where most of the data is
dot.p

bar.p <- base.p +
  stat_summary(fun.data=mean_sdl, geom="bar", position="dodge", mapping=aes(col=sex,fill=sex), alpha=0.6) +
  theme(axis.text.x=element_text(angle=60, vjust=1, hjust=1))
bar.error.p <- bar.p +
  stat_summary(fun.data=mean_cl_boot, geom="errorbar", position="dodge")
bar.error.p

# Scatter plot
scatter.base.p <- ggplot(data=dat.plot, mapping=aes(x=incwage, y=totmed))
scatter.p <- scatter.base.p + geom_point()
scatter.p

# Address overplotting
scatter.p <- scatter.base.p + geom_point(alpha=0.3, size=1) 
scatter.p

# Zoom in
scatter.p <- scatter.base.p + geom_point(alpha=0.3, size=1) + coord_cartesian(xlim=c(0,150000))
scatter.p

posn.j <- position_jitter(width=500,height=0)
scatter.p <- scatter.base.p + geom_point(alpha=0.3, size=1, position=posn.j) + coord_cartesian(xlim=c(0,150000))
scatter.p


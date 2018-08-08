#library("SAScii")
#df.big <- read.SAScii("cps_00011.dat.gz", "cps_00011.sas")
library("stringr")
set.seed(12345)
df <- sample_n(df.big,size=20000,replace=FALSE)

edulevels = c("Less than high school",
              "High school degree or equivalent",
              "Some College",
              "Four Year College Degree",
              "Advanced College Degree")

df$edu <- NA
df$edu[ df$EDUC<73 ] <- edulevels[1]
df$edu[ df$EDUC==73 ] <- edulevels[2]
df$edu[ df$EDUC>73 & df$EDUC<111] <- edulevels[3]
df$edu[ df$EDUC>=111 & df$EDUC<123] <- edulevels[4]
df$edu[ df$EDUC>=123] <- edulevels[5]

df$edu <- factor(df$edu, levels=edulevels, ordered=TRUE)
levels(df$edu)

df$class <- NA
df$class[ df$CLASSWKR<20 & df$CLASSWKR>0 ] <- "Self-employed"
df$class[ df$CLASSWKR==21 ] <- "Employed by private company"
df$class[ df$CLASSWKR>=27 & df$CLASSWKR<29] <- "Employed by State/Local Government"
df$class[ df$CLASSWKR==26] <- "Employed by Armed Forces"
df$class[ df$CLASSWKR==25] <- "Employed by Federal Government"
df$class <- factor(df$class)

df$UsualWeeklyHours <- df$UHRSWORKT
df$UsualWeeklyHours[df$UHRSWORKT==0] <- NA
df$UsualWeeklyHours[df$UHRSWORKT>=997] <- NA

df$PaidByHour <- NA
df$PaidByHour[ df$PAIDHOUR==2 ] <- 1
df$PaidByHour[ df$PAIDHOUR==1 ] <- 0
df$PaidByHour[ df$class == "Self-employed"] <- 0

df$Union <- NA
df$Union[ df$UNION==1 ] <- "No union coverage"
df$Union[ df$UNION==2 ] <- "Union member"
df$Union[ df$UNION==3 ] <- "Union coverage but not a member"
df$Union <- as.factor(df$Union)

df$UnionBin <- NA
df$UnionBin[ df$UNION==1 | df$UNION==3 ] <- 0
df$UnionBin[ df$UNION==2] <- 1

df$WeeklyEarnings <- df$EARNWEEK
df$WeeklyEarnings[ df$EARNWEEK==9999.99 ] <- NA
df$WeeklyEarnings[ df$EARNWEEK==0 ] <- NA

df$UsualHourEarnings <- df$WeeklyEarnings / df$UsualWeeklyHours

df$HealthInsurance <- NA
df$HealthInsurance[ df$HICHAMP == 2] <- "Military Health Insurance"
df$HealthInsurance[ df$HIMCAID == 2] <- "Medicaid"
df$HealthInsurance[ df$HIMCARE == 2] <- "Medicare"
df$HealthInsurance[ df$PHINSUR == 2] <- "Private Insurance"
df$HealthInsurance[ df$INCLUGH == 2] <- "Employer Insurance"
df$HealthInsurance[ df$HICHAMP==1 & df$HIMCAID==1 & df$HIMCARE==1 & df$PHINSUR==1 & df$INCLUGH<=1] <- "Not covered by insurance"
df$HealthInsurance <- as.factor(df$HealthInsurance)

df.new <- select(df, edu, class, UsualWeeklyHours, PaidByHour, Union, UnionBin, WeeklyEarnings, UsualHourEarnings, HealthInsurance )
df.new <- drop_na(df.new)
df.new <- droplevels(df.new)
row.names(df.new) <- 1:nrow(df.new)
df <- df.new
save(df, file="cps2017.RData")

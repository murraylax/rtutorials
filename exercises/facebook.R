library("readODS")
library("haven")
library("xlsx")
df <- read_ods("fbdata.ods")
names(df) <- c("Type", "Month", "Weekday", "Hour", "Paid", "Reach", "Impressions", "EngagedUsers", "Comments", "Likes", "Shares", "Interactions")

# Change Type to factor
df$Type <- as.factor(df$Type)

# Change Weekday to descriptive factor
df$Weekday.Int <- df$Weekday
df$Weekday <- factor(x=df$Weekday,ordered = TRUE)
levels(df$Weekday) <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")

# Change Month to a descriptive factor
df$Month.Int <- df$Month
df$Month <- factor(df$Month, ordered = TRUE)
levels(df$Month) <- c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")

save(df, file="facebook.RData")
# Other formats
write_sav(df, "facebook.sav")
write.table(df, file = "facebook.csv", row.names = F, col.names = T, sep=",")
write.xlsx(df, file="facebook.xlsx", row.names=F)
write_ods(df, path="facebook.ods")

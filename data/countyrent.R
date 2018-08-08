library("readODS")
library("tidyverse")
rent.df <- read_ods("county-rent.ods", sheet=1, col_names=TRUE)
countycat.df <- read_ods("county-characteristics.ods", sheet=1, col_names=TRUE)
econ.df <- read_ods("county-econ.ods", sheet=1, col_names=TRUE)

rent.df$FIPS <- paste(formatC(rent.df$StateCodeFIPS, width=2, flag="0"), formatC(rent.df$MunicipalCodeFIPS, width=3, flag="0"), sep='')

rent.df <- rent.df[,c("RegionName", "State", "FIPS", "MedianRent")]
countycat.df <- countycat.df[,c("FIPS","UrbanInfluence", "EconTopology")]
econ.df <- econ.df[,c("FIPS","PovertyPerc","MedianIncome")]

countyrent.df <- merge(rent.df, countycat.df, by="FIPS")
countyrent.df <- merge(countyrent.df, econ.df, by="FIPS")

varlabels <- c("Federal Information Processing Standards (FIPS) code uniquely identifying county", 
               "County name", "State two letter code", "Median rent (all rentals) in US$ in 2015", 
               "Degree of urban influence on county", 
               "Community specialization in economic output or employment", 
               "Percentage of population in 2015 with income below the poverty level", 
               "Median income in 2015")
attributes(countyrent.df)$variable.labels <- varlabels

# Define Urban Influence Factor
urbanlabels <- c("In large metro area of 1+ million residents",
                 "In small metro area of less than 1 million residents",
                 "Micropolitan area adjacent to large metro area",
                 "Noncore adjacent to large metro area",
                 "Micropolitan area adjacent to small metro area",
                 "Noncore adjacent to small metro area and contains a town of at least 2,500 residents",
                 "Noncore adjacent to small metro area and does not contain a town of at least 2,500 residents",
                 "Micropolitan area not adjacent to a metro area",
                 "Noncore adjacent to micro area and contains a town of at least 2,500 residents",
                 "Noncore adjacent to micro area and does not contain a town of at least 2,500 residents",
                 "Noncore not adjacent to metro or micro area and contains a town of at least 2,500 residents",
                 "Noncore not adjacent to metro or micro area and does not contain a town of at least 2,500 residents")

urbanlabels <- urbanlabels[sort(unique(countyrent.df$UrbanInfluence))]

countyrent.df$UrbanInfluence <- factor(countyrent.df$UrbanInfluence,ordered=TRUE, labels=urbanlabels)

econtoplabels <- c("Nonspecialized","Farm dependent","Mining dependent","Manufacturing dependent","Federal/State Gov dependent","Recreation")
econtoplabels <- econtoplabels[sort(unique(countyrent.df$EconTopology))+1]
countyrent.df$EconTopology <- factor(countyrent.df$EconTopology, ordered=FALSE, labels=econtoplabels)

# Rent is numeric
countyrent.df$MedianRent <- as.numeric(countyrent.df$MedianRent)

countyrent.df <- countyrent.df[complete.cases(countyrent.df),]
save(countyrent.df, file="countyrent.RData")


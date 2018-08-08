
attr.comb <- function(obj, attribs) {
  if(length(attribs)>1) {
    str <- attribs[1]
    att <- cbind(attributes(obj)[[str]])
    
    for (i in 2:length(attribs)) {
      str <- attribs[i]
      att <- cbind(att, attributes(obj)[[str]])
    }
    att <- as.matrix(att)
    colnames(att) <- as.vector(attribs)
  }
  else {
    att <- attributes(obj)[[attribs]]
  }
  return(att)
}

library("tidyverse")
library("stringr")
load("countyrent.RData")

# View the data frame in RStudio
View(countyrent.df)

# View the variable names and first few observations
head(countyrent.df)

# View the variable names and the *last* few observations
tail(countyrent.df)

# Want to see just the variable names
names(countyrent.df)
# There is another way
attr(countyrent.df, "names")

# Want to see a description of these variables.  Not all R datasets include this information, but this one does.
attr(countyrent.df, "variable.labels")

# I created a procedure to combine the output of these
attr.comb(countyrent.df, c("names","variable.labels"))

# MedianRent is a *ratio* variable, therefore is stored as a numeric variable in R
class(countyrent.df$MedianRent)

# UrbanInfluence is an *ordinal* variable, therefore is stored as a factor (categorical variable) that is ordered.
class(countyrent.df$UrbanInfluence)
# Want to see the levels of UrbanInfluence
levels(countyrent.df$UrbanInfluence)

# EconTopology is a *nominal* variable, therefore is stored as a factor (categorical variable) and is not ordered.
class(countyrent.df$EconTopology)
# Want to see the levels of EconTopology
levels(countyrent.df$EconTopology)

# Compute the mean of a numeric variable
mean(countyrent.df$MedianRent, na.rm=TRUE)

# Variance
var(countyrent.df$MedianRent, na.rm=TRUE)

# Summarize the mean over different levels of a categorical variable
countyrent.df %>%
  group_by(EconTopology) %>%
  summarize(MeanRent = mean(MedianRent)) ->
  mean.by.econ

# Look at the relationship between the categorical variable 'EconTopology' and the ratio variable 'MeanRent'
ggplot(data=mean.by.econ, mapping=aes(x=EconTopology, y=MeanRent)) + 
  geom_bar(stat="identity")

# Examine those levels that overlap each other
levels(mean.by.econ$EconTopology)

# Put labels at an angle
ggplot(data=mean.by.econ, mapping=aes(x=EconTopology, y=MeanRent)) + 
  geom_bar(stat="identity") + theme(axis.text.x = element_text(angle=45, hjust=1))

# Rewrite those levels with word-wrap
levels(mean.by.econ$EconTopology) <- str_wrap( levels(mean.by.econ$EconTopology), width=15 )

# Redraw the plot
ggplot(data=mean.by.econ, mapping=aes(x=EconTopology, y=MeanRent)) + 
  geom_bar(stat="identity")

# Examine the correlation between two ratio variables
cor(countyrent.df$MedianRent, countyrent.df$PovertyPerc)

# Is that statistically significant?
cor.test(countyrent.df$MedianRent, countyrent.df$PovertyPerc)

# Plot the relationship
ggplot(data=countyrent.df, mapping=aes(x=PovertyPerc, y=MedianRent)) + geom_point()

# Is that a positive or negatve relationship?
ggplot(data=countyrent.df, mapping=aes(x=PovertyPerc, y=MedianRent)) + geom_point() + geom_smooth()

# Is that a positive or negatve relationship? If we force a line
ggplot(data=countyrent.df, mapping=aes(x=PovertyPerc, y=MedianRent)) + geom_point() + geom_smooth(method="lm")



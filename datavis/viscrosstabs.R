library(tidyverse)
library(stringr)
library(scales)
load(url("http://murraylax.org/datasets/findata.RData"))

# Cross Table
tb <- table(df$Edu, df$FinDifficulty)
tb

# Cross table with proportions, proportions for each level of education
tb.prop <- prop.table(tb, 1) # 1 means to compute proportions over the first dimension, i.e. for each row
tb.prop

chtest<- chisq.test(df$Edu, df$FinDifficulty)
chtest

# Convert this to a data frame
tb.df <- as.data.frame(tb.prop)
tb.df

# Restore my variable names
names(tb.df) <- c("Edu", "FinDifficulty", "Freq")

# Super ugly useless plot
ggplot(tb.df, aes(x=Edu, y=Freq, fill=FinDifficulty)) + geom_col(position="dodge")

# Fix the labels
levels(tb.df$Edu) <- str_wrap(levels(tb.df$Edu), 10)

# Line plot is better
ggplot(tb.df, aes(x=Edu, y=Freq, color=FinDifficulty, group=FinDifficulty)) + 
  geom_line() 

# Pretty it up
ggplot(tb.df, aes(x=Edu, y=Freq, color=FinDifficulty, group=FinDifficulty)) + 
  geom_line(size=1.5) +
  theme_light() +
  scale_y_continuous(labels=percent) +
  theme(text = element_text(size=12)) +
  theme(axis.text = element_text(size=12)) +
  labs(title="Financial Difficulty Frequencies by Education", x="", y="") +
  labs(subtitle="Chi-Square Test Statistic = 338.47, P-value = 0.000") +
  scale_color_manual(values=c("firebrick3", "darkorchid3", "dodgerblue3"))

# Get rid of the legend
# Put the labels on the graph
tb.df.bs <- tb.df %>% filter(Edu=="Graduate\ndegree")

ggplot(tb.df, aes(x=Edu, y=Freq, color=FinDifficulty, group=FinDifficulty)) + 
  geom_line(size=1.5) +
  theme_light() +
  scale_y_continuous(labels=percent) +
  theme(title = element_text(size=14)) +
  theme(axis.text = element_text(size=12)) +
  labs(title="Financial Difficulty Frequencies by Education", x="", y="") +
  scale_color_manual(values=c("firebrick3", "darkorchid3", "dodgerblue3")) +
  theme(legend.position = "none") +
  geom_text(data=tb.df.bs, aes(x=Edu, y=Freq, label=FinDifficulty), hjust=0, nudge_x=0.1, size=5) +
  expand_limits(x=7.7)

subchisq <- sprintf("Chi-Square Test Statistic = %.1f, P-value = %.3f", 
                    chtest$statistic, chtest$p.value)
subchisq

ggplot(tb.df, aes(x=Edu, y=Freq, color=FinDifficulty, group=FinDifficulty)) + 
  geom_line(size=1.5) +
  theme_bw() +
  scale_y_continuous(labels=percent) +
  theme(title = element_text(size=14)) +
  theme(axis.text = element_text(size=12)) +
  labs(title="Financial Difficulty Frequencies by Education", x="", y="") +
  scale_color_manual(values=c("firebrick3", "darkorchid3", "dodgerblue3")) +
  theme(legend.position = "none") +
  geom_text(data=tb.df.bs, aes(x=Edu, y=Freq, label=FinDifficulty), hjust=0, nudge_x=0.1, size=5) +
  expand_limits(x=7.7) +
  labs(subtitle=subchisq)


library(tidyverse)
load(url("https://murraylax.org/datasets/cps2016.RData"))

df %>% 
  select(sex,age,usualhrearn) %>% 
  na.omit() ->
  dfplot

ggplot(dfplot, aes(x=age, y=usualhrearn)) +
  geom_point(alpha=0.7, color="darkgreen") +
  coord_cartesian(ylim=c(0,75), xlim=c(18,80)) +
  stat_smooth(method = "loess", col="black", fill="grey") +
  theme_bw()

ggplot(dfplot, aes(x=age, y=usualhrearn)) +
  geom_point(alpha=0.7, color="darkgreen") +
  coord_cartesian(ylim=c(0,75), xlim=c(18,80)) +
  stat_smooth(method = "lm", col="black", fill="grey") +
  theme_bw()


sexcols <- c("red", "dodgerblue4")
ggplot(dfplot, aes(x=age, y=usualhrearn, color=sex, fill=sex)) +
  geom_point(alpha=0.7) +
  coord_cartesian(ylim=c(0,75), xlim=c(18,80)) +
  stat_smooth(method = "lm", alpha=0.2) +
  scale_color_manual(values=sexcols) +
  scale_fill_manual(values=sexcols) +
  theme_bw()

dfplot %>% 
  group_by(sex) %>%
  summarise(correlation = cor(age,usualhrearn))


# Run a regression
lmsex <- lm(usualhrearn ~ age, data=df)
lmsex$coefficients[1]
lmsex$coefficients[2]





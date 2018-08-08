library("tidyverse")
library("ggthemes")
library("scales")
load(url("http://murraylax.org/datasets/cps2016.RData"))

df$degree[ df$college==1 ] <- "Baccalaureate or advanced degree"
df$degree[ df$college==0 ] <- "Less than college degree"
df$degree <- as.factor(df$degree)

theme.nice <- theme_tufte()+
              theme(plot.background=element_blank(), 
                legend.background = element_blank(), 
                panel.background = element_blank(),
                legend.key = element_blank()) +
              theme(legend.text=element_text(size=14)) +
              theme(axis.text = element_text(size=14)) +
              theme(text = element_text(size=18)) +
              theme(plot.title = element_text(size=20, face = "bold")) +
              theme(panel.grid=element_line(size=0.5, color="grey"))

scatter.p <- ggplot(data=df, mapping=aes(x=usualhrearn, y=totmed, col=as.factor(edu))) + 
  geom_point(alpha=0.5, size=1.5) +
  coord_cartesian(xlim=c(0,60), ylim=c(0,10000)) +
  stat_smooth(method="lm", se=F) +
  labs(x="Average Hourly Earnings", y="Medical Expenditures",
       title="Distribution of Labor Income and Medical Expenditures",
       legend="College Degree") +
  scale_color_brewer(palette="Set1", name="") +
  scale_x_continuous(labels=dollar) + scale_y_continuous(labels=dollar) +
  theme.nice
scatter.p

legend.loc <- data.frame(edu=levels(df$edu), x=c(43, 43, 10, 43, 43), y=c(2000, 5300, 8200, 6800, 8900))
scatter.p <- scatter.p + 
  geom_text(data=legend.loc, mapping=aes(label=edu, x=x, y=y), size=5, show.legend=FALSE) +
  theme(legend.position="none")
scatter.p
ggsave(scatter.p, file="plot1.png")

scatter.p <- ggplot(data=df, mapping=aes(x=usualhrearn, y=totmed, col=as.factor(degree))) + 
  geom_point(alpha=0.5, size=1.5) +
  coord_cartesian(xlim=c(0,60), ylim=c(0,10000)) +
  stat_smooth(method="lm", se=T) +
  labs(x="Average Hourly Earnings", y="Medical Expenditures",
       title="Distribution of Labor Income and Medical Expenditures",
       legend="College Degree") +
  scale_color_brewer(palette="Set1", name="") +
  scale_x_continuous(labels=dollar) + scale_y_continuous(labels=dollar) +
  theme.nice
scatter.p

legend.loc <- data.frame(degree=levels(df$degree), x=c(43, 45), y=c(9400, 6000))
scatter.p <- scatter.p + 
  geom_text(data=legend.loc, mapping=aes(label=degree, x=x, y=y), size=5, show.legend=FALSE, fontface="bold") +
  theme(legend.position="none")
scatter.p
ggsave(scatter.p, file="plot2.png")

df.nocollege <- filter(df, college==0)
cor.test(df.nocollege$usualhrearn, df$totmed, use="pairwise")

df %>% 
  group_by(degree) %>% 
  summarise(correl=cor(usualhrearn,totmed,use="pairwise")) 

correl.text <- data.frame(correlations=c("(Cor = 0.235)", "(Cor = 0.017)"),
                          x=c(43,45), y=c(9000,5600), degree=levels(df$degree))

scatter.p + geom_text(data=correl.text, mapping=aes(label=correlations, x=x, y=y), size=5, show.legend=FALSE, fontface="bold")
scatter.p

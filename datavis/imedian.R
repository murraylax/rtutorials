require(tidyverse)
require(Hmisc)
require(scales)
require(stringr)
require(psych)

interp.median.bs.CI <- function(x, w=1, na.rm=TRUE, conf.level=0.95, bootn=1000) {
  bootmed = apply(X=matrix(sample(x, rep=TRUE, bootn*length(x)), nrow=bootn), MARGIN = 1, FUN = interp.median, w=w, na.rm=TRUE);
  CI <- quantile(bootmed, c((1-conf.level)/2, conf.level+(1-conf.level)/2));
  interpmed <- interp.median(x=x, w=w, na.rm=na.rm);
  return(list("Confidence.Interval"=CI, "Confidence.Level"=conf.level, "Interpolated.Median"=interpmed));
}

simedian.cl.boot <- function(x, w=1, conf.int=0.95, B=1000)
{
  imed <- interp.median.bs.CI(x, w=w, na.rm=TRUE, conf.level=conf.int, bootn=B)
  return(list(Median=imed$Interpolated.Median, Lower=as.numeric(imed$Confidence.Interval[1]), Upper=as.numeric(imed$Confidence.Interval[2])))
}

imedian_cl_boot <- function(x, w=1, conf.int=0.95, B=1000)
{
  sib <- simedian.cl.boot(as.numeric(x),w,conf.int,B)
  d <- as.data.frame(sib)
  names(d) <- c("y", "ymin", "ymax")
  return(d)
}

imedian <- function(x,w=1) {
  y = interp.median(as.numeric(x),w)
  return(as.data.frame(list(y=y)))
}

imedian_sdl <- function(x,w=1) {
  y = interp.median(as.numeric(x),w)
  return(as.data.frame(list(y=y, ymin=0, ymax=y)))
}

scale_y_orderedfactor <- function(fct) {
  if(all(class(fct)==c("ordered", "factor"))) {
    levs <- levels(fct)
  }
  else {
    levs <- fct
  }
  sc <- scale_y_continuous(breaks=1:length(levs), labels=levs)
}


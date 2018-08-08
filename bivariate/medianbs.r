library("psych");
interp.median.bs.CI <- function(x, w=1, na.rm=TRUE, conf.level=0.95, bootn=10000) {
  bootmed = apply(X=matrix(sample(x, rep=TRUE, bootn*length(x)), nrow=bootn), MARGIN = 1, FUN = interp.median, w=w, na.rm=TRUE);
  CI <- quantile(bootmed, c((1-conf.level)/2, conf.level+(1-conf.level)/2));
  interpmed <- interp.median(x=x, w=w, na.rm=na.rm);
  return(list("Confidence.Interval"=CI, "Confidence.Level"=conf.level, "Interpolated.Median"=interpmed));
}

median.bs.CI <- function(x, na.rm=TRUE, conf.level=0.95, bootn=10000) {
  bootmed = apply(X=matrix(sample(x, rep=TRUE, bootn*length(x)), nrow=bootn), MARGIN=1, FUN=median, na.rm=TRUE);
  CI <- quantile(bootmed, c((1-conf.level)/2, conf.level+(1-conf.level)/2));
  med <- median(x=x, na.rm=na.rm);
  return(list("Confidence.Interval"=CI, "Confidence.Level"=conf.level, "Median"=med));
}

median.bs <- function(x, w=1, na.rm=TRUE, conf.level=0.95, bootn=10000) {
  ici <- interp.median.bs.CI(x,w,na.rm,conf.level,bootn);
  ci <- median.bs.CI(x,na.rm,conf.level,bootn);
  return(list("Confidence.Level"=conf.level, "Median.Confidence.Interval"=ci$Confidence.Interval, "Interpolated.Median.Confidence.Interval"=ici$Confidence.Interval, "Median"=ci$Median, "Interpolated.Median"=ici$Interpolated.Median));
}
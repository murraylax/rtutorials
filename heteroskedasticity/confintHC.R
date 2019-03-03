confintHC <- function(lmobject, type="HC3", conf.level=0.95, omega=NULL) {
  alpha <- 1-conf.level
  p <- 1 - 0.5*alpha
  cf <- lmobject$coefficients
  tcrit <- qt(p=p, df=lmobject$df.residual)
  if(is.null(omega)) {
    omega=vcovHC(lmobject, type=type)
  }
  stderr_coef <- tcrit * sqrt(diag(omega))
  
  lower_label <- sprintf("%.1f%% Limit", 100*alpha/2)  
  upper_label <- sprintf("%.1f%% Limit", 100*p)  
  coefsummary <- data.frame(coefficient=cf,  lowerlimit=cf - stderr_coef, upperlimit=cf + stderr_coef)
  names(coefsummary) <- c("Coefficient", lower_label, upper_label)
  
  return(coefsummary)
}
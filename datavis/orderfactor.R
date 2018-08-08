order.factor.by <- function(v.factor, v.num, FUN=mean, data=NULL) 
{
  if(is.null(data)==FALSE) {
    v.factor.str <- deparse(substitute(v.factor))
    v.num.str <- deparse(substitute(v.num))
    v.factor <- data[[v.factor.str]]
    v.num <- data[[v.num.str]]
  }

  levelstats <- aggregate(v.num ~ v.factor, FUN=FUN, data=NULL)
  ordstats <- reorder(levelstats$v.factor, levelstats$v.num)
  v.factor.ord <- factor(data[[v.factor.str]], levels=levels(ordstats))
  return(v.factor.ord)
}


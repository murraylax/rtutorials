library(tidyverse)
library(readxl)
library(xts)
library(fpp2)

df <- read_excel("ECO307_Monthly_Forecasting.xls", sheet = 2)
names(df) <- c("Date",
                "Inflation",
                "FedFunds",
                "IndProd",
                "IndProdCons",
                "UnRate")
df <- drop_na(df)

# Convert to xts, ts
df.xts <- as.xts(df, order.by = df$Date)

# Monthly
monthly = 12

# Let's forecast industrial production (IndProd)
IndProd <- ts(df$IndProd, 
              start = c(1954,7), 
              end = c(2019,2), 
              frequency = monthly)


# Naive forecast (aka Random walk estimator) - The forecast for the future is the last observation
fs.n <- naive(IndProd, 48)
autoplot(fs.n)

# Seasonal naive forecast (Seasonal random-walk) - The forecast for the future is the most recent same month
fs.sn <- snaive(IndProd, 48)
autoplot(fs.sn)

# Naive with drift (aka Random walk with drift) - Estimates a constant rate of increase/decrease along with random walk
fs.nd <- rwf(IndProd, 48, drift=TRUE)
autoplot(fs.nd)

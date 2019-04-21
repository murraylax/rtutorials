library(fpp2)
library(quantmod)
library(scales)

# Load the monthly unemployment rate - not seasonally adjusted
getSymbols("UNRATENSA", src="FRED")

# Convenenient to look at percentages as decimals
# Set frequency
unrate <- ts(UNRATENSA/100, start=c(1948,1), frequency = 12)

# Make a quick plot
autoplot(unrate)

# Make a nice plot
autoplot(unrate) +
  theme_bw() +
  labs(title="Unemployment Rate", x="", y="") +
  scale_y_continuous(label=percent) +
  theme(text = element_text(size=15))

# Forecast over the next 24 months
horizon = 24

# Naive forecast
# Best forecast for a random walk model (rwf)
# x_t = x_{t-1} + e_t
fnaive <- naive(unrate, h=horizon)
fnaive

# Quick plot the naive forecast
autoplot(fnaive)

# Prettier
autoplot(fnaive) +
  theme_bw() +
  scale_y_continuous(labels=percent) +
  scale_x_continuous(limits=c(2005,2021)) +
  theme(text = element_text(size=15)) +
  labs(title="Unemployment Rate Forecasts (Naive Method)", 
       x="", y="",
       fill="Confidence Intervals") +
  theme(legend.position = "bottom")

# Seasonal naive forecast
# Need to set frequency in the unemployment rate data if not already set
fsnaive <- snaive(unrate, h=horizon)
autoplot(fsnaive)

# Prettier
autoplot(fsnaive) +
  theme_bw() +
  scale_y_continuous(labels=percent) +
  scale_x_continuous(limits=c(2005,2021)) +
  theme(text = element_text(size=15)) +
  labs(title="Unemployment Rate Forecasts (Seasonal Naive Method)", 
       x="", y="",
       fill="Confidence Intervals") +
  theme(legend.position = "bottom")

# Test Forecast Accuracy
# Make a training set
trainset <- window(unrate, start=c(1948,1), end=c(2009,12))
testset <- window(unrate, start=c(2010,1))
autoplot(trainset)
autoplot(testset)

# Create forecasts based on training set
fnaive <- naive(trainset, h=horizon)
fsnaive <- snaive(trainset, h=horizon)
# Compare accuracy on test set
accuracy(fnaive, testset)
accuracy(fsnaive, testset)


# Autogression AR(1)
# x_t = a x_{t-1} + e_t
armodel <- Arima(unrate, order=c(1,0,0))
far <- forecast(armodel, h=horizon)
autoplot(far) + 
  theme_bw() +
  scale_y_continuous(labels=percent) +
  scale_x_continuous(limits=c(2005,2021)) +
  theme(text = element_text(size=15)) +
  labs(title="Unemployment Rate AR(1) Forecasts", 
       x="", y="",
       fill="Confidence Intervals") +
  theme(legend.position = "bottom")

# Seasonal Autogression AR(1)
# x_t = a x_{t-1} + b x_{t-12} + e_{t}

sarmodel <- Arima(unrate, order=c(1,0,0), 
                  seasonal=list(order=c(1,0,0),period=12))
fsar <- forecast(sarmodel, h=horizon)
autoplot(fsar) + 
  theme_bw() +
  scale_y_continuous(labels=percent) +
  scale_x_continuous(limits=c(2005,2021)) +
  theme(text = element_text(size=15)) +
  labs(title="Unemployment Rate Seasonal AR(1) Forecasts", 
       x="", y="",
       fill="Confidence Intervals") +
  theme(legend.position = "bottom")

# Autocorrelation Function
ggAcf(unrate, lag.max = 36)

# Partial autocorrelation function
ggPacf(unrate, lag.max = 36)

sarmodel <- Arima(unrate, order=c(2,0,0), 
                  seasonal=list(order=c(2,0,0),period=12))
fsar <- forecast(sarmodel, h=horizon)
autoplot(fsar) + 
  theme_bw() +
  scale_y_continuous(labels=percent) +
  scale_x_continuous(limits=c(2005,2021)) +
  theme(text = element_text(size=15)) +
  labs(title="Unemployment Rate Seasonal AR(1) Forecasts", 
       x="", y="",
       fill="Confidence Intervals") +
  theme(legend.position = "bottom")

# Get treasury interest rate spread
# 10 year rate
getSymbols("GS10", src="FRED")
# 3 month rate
getSymbols("TB3MS", src="FRED")

# Create time series for spread
head(cbind(GS10, TB3MS))
tail(cbind(GS10, TB3MS))
spread <- ts((GS10-TB3MS)/100, start=c(1934,1), frequency=12)
autoplot(spread)

datats <- cbind(unrate, spread)

ecotlm <- dynlm(unrate ~ L(unrate) + L(unrate,2) + spread + L(spread,1) + L(spread,2), data=datats)

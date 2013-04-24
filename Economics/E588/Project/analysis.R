setwd('~/School/BYU/byuclasses/Economics/E588/Project')

# library('tseries')
# library('FinTS')  # for ArchTest function

db <- read.csv(file='the_data.csv', sep=',', head=TRUE)

# Pull out columns and make ts (time series) objects
sp500 <- ts(db$SP500)
vix <- ts(db$VIX)
dgs10 <- ts(db$DGS10)
dgs3mo <- ts(db$DGS3MO)

cols <- colnames(db)[-1]

# # Generate ACF and PACF for VIX and SP500
# par(mfrow=c(2,2))
# acf(vix, main="ACF of VIX")
# acf(sp500, main="ACF of SP500")
# pacf(vix, main="PACF of VIX")
# pacf(sp500, main="PACF of SP500")

# dev.new()  # New plot window

# # Generate ACF and PACF for DGS10
# par(mfrow=c(2,2))
# acf(dgs10, main="ACF of DGS10")
# acf(dgs3mo, main="ACF of DGS3MO")
# pacf(dgs10, main="PACF of DGS10")
# pacf(dgs3mo, main="PACF of DGS3MO")

# To get augmented dickey fuller test use adf.test(ts)
# NOTE: h0 is unit root (This is bad. Non-stationary). Critical value
#       at 0.95 level is about -3.5. Any more negative than this leads
#       us to reject the null in favor of the alternative (stationary)

# TODO: Figure out how to store test results in a list. This doesn't work
# dftests = list()
# for (i in cols){
#     temp <- db[,which(names(db)==i)]
#     t1 <- adf.test(temp)
#     t2 <- adf.test(diff(temp, 1))
#     dftests <- c(dftests, t1)
#     dftests <- c(dftests, t2)
#     print(t1)
#     print(t2)
# }

### GARCH Stuff
# library(TSA)
# garch.g01 <- garch.sim(alpha=c(.1, .9), n=400)
# garch.g11 <- garch.sim(alpha=c(.1, .4), beta=c(.09), n=400)

# libraray(rugarch)
# gen_garch <- ugarchspec(variance.model=list(model='sGARCH', garchOrder=c(1, 1)),
#                        mean.model=list(armaOrder=c(0, 0)))

# dgs10_garch <- ugarchfit(spec=gen_garch, data=dgs10, out.sample=500)

### ARIMA Stuff
library(forecast)
sp_arima <- Arima(sp500, order=c(1, 1, 0), include.drift=TRUE)
vix_arima <- Arima(vix, order=c(1, 1, 0), include.drift=TRUE)
d10_arima <- Arima(dgs10, order=c(1, 1, 0), include.drift=TRUE)
dg3_arima <- Arima(dgs3mo, order=c(1, 1, 0), include.drift=TRUE)


sp_arima.forecast <- forecast(sp_arima, h=1500)
vix_arima.forecast <- forecast(vix_arima, h=1500)
d10_arima.forecast <- forecast(d10_arima, h=1500)
dg3_arima.forecast <- forecast(dg3_arima, h=1500)


write.csv(sp_arima.forecast, 'sp_arima_forecast.csv')
write.csv(vix_arima.forecast, 'vix_arima_forecast.csv')
write.csv(d10_arima.forecast, 'd10_arima_forecast.csv')
write.csv(dg3_arima.forecast, 'dg3_arima_forecast.csv')

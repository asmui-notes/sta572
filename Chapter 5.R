library(tseries)
library(forecast)
library(readxl)

snp <- read.csv("SNP500.csv", header=T)
snp_ts <- ts(snp[,2], frequency=1)
plot(snp_ts, ylab="Price")

train_ts <- head(snp_ts, 0.8*length(snp_ts))
test_ts <- tail(snp_ts, 0.2*length(snp_ts))

# model identification based on training data
par(mfrow=c(1,1))
acf(train_ts)
pacf(train_ts)

adf.test(train_ts)

diff_ts <- diff(train_ts)
plot(diff_ts, main="", ylab="return")
adf.test(diff_ts)

acf(diff_ts)
pacf(diff_ts)

# Use Accident Casualties Example

CPI_Annual <- read_excel("CPI Annual.xls")
cpi_ts <- ts(CPI_Annual[,2], frequency=1)
plot(cpi_ts)
train_cpi <- head(cpi_ts, 0.8*length(cpi_ts))
test_cpi <- tail(cpi_ts, 0.2*length(cpi_ts))

acf(train_cpi)
pacf(train_cpi)

adf.test(train_cpi)

diff_ts <- diff(train_cpi)
plot(diff_ts)
adf.test(diff_ts)

diff_ts2 <- diff(train_cpi, differences = 3)
plot(diff_ts2)
adf.test(diff_ts2)

auto.arima(train_casualty)

?diff




# Potential model
# ARIMA (1,1,1)
# ARIMA (0,1,1)
# ARIMA (1,1,0)

model1 <- arima(train_ts, c(1,1,1))
model1 <- Arima(train_ts, order=c(1,1,1))
model2<- Arima(train_ts, order=c(0,1,1))
model3 <- Arima(train_ts, order=c(1,1,0))
?Arima
summary(model1)
summary(model2)
summary(model3)

Box.test(model1$residuals, lag=10, type="Ljung-Box")
forecast(model1, h=5, level=95)

plot(forecast(model1, h=5, level=95))


# Seasonal ARIMA

library(readr)
mining <- read_csv("ipi_1d.csv")

mining <- read.csv("ipi_1d.csv")
mining_ts <- ts(mining[1:111,4], frequency=12, 
                start=c(2015,1))
plot(mining_ts)

Acf(mining_ts, lag.max=48, main="")
acf(as.numeric(mining_ts), lag.max = 48)

adf.test(mining_ts)
?diff
diffmining <- diff(mining_ts, lag=12)
plot(diffmining)
Acf(diffmining)
adf.test(diffmining)


firstdiffmining <- diff(diffmining, lag=1)
plot(firstdiffmining)
adf.test(firstdiffmining)

par(mfrow=c(1,2))
Acf(firstdiffmining, main="ACF")
Pacf(firstdiffmining, main="PACF")


ts_est<-head(mining_ts, 0.6*length(mining_ts))
ts_eva<-tail(mining_ts, 0.4*length(mining_ts))


model1<-Arima(ts_est, order = c(1,1,1),
              seasonal = c(2,1,1))
summary(model1)
model2<-Arima(ts_est, order = c(1,1,1),
              seasonal = c(1,1,1))
summary(model2)

model3<-arima(ts_est, order = c(2,1,1),
              seasonal = c(2,1,1), optim.method="SANN")
summary(model3)

Box.test(model1$residuals, lag=10, type="Ljung-Box")
Box.test(model2$residuals, lag=10, type="Ljung-Box")
Box.test(model3$residuals, lag=10, type="Ljung-Box")

forecastmining <- forecast(arima(mining_ts, order=c(1,1,1), 
                                 seasonal=c(1,1,1)), h=12, level=95)
autoplot(forecastmining)

?autoplot
?autoplot

?Arima
?arima

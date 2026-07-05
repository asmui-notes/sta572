library(tseries)
library(forecast)

# Example 1: Stationary process (White Noise)
set.seed(123)
stationary_series <- rnorm(200, mean = 0, sd = 1)

# Example 2: Non-stationary process (Random Walk)
random_walk <- cumsum(rnorm(200))

# Example 3: Trend + Seasonality
time <- 1:200
trend_seasonal <- 0.05 * time + 5 * sin(2 * pi * time / 12) + rnorm(200)

# Plot comparison
par(mfrow = c(1, 1))
plot(stationary_series, type = "l", main = "Stationary: White Noise",
     ylab = "Value", xlab = "Time")
abline(h = mean(stationary_series), col = "red", lty = 2)

plot(random_walk, type = "l", main = "Non-Stationary: Random Walk",
     ylab = "Value", xlab = "Time", col = "darkred")

plot(trend_seasonal, type = "l", main = "Non-Stationary: Trend + Seasonal",
     ylab = "Value", xlab = "Time", col = "darkgreen")


# Linear Trend Analysis for CPI Malaysia Data
# Comparing Linear and Quadratic Models

# Clear workspace
rm(list = ls())

# Load required libraries
library(ggplot2)
library(forecast)

# Read the data
cpi <- read.csv("/Users/asmuie/demo_class/CPI Malaysia.csv",
                stringsAsFactors = FALSE,
                strip.white = TRUE)

# Clean column names (remove spaces)
colnames(cpi) <- c("Year", "CPI")

# Remove any empty rows
cpi <- cpi[complete.cases(cpi), ]

# Display data structure
cat("Data Structure:\n")
print(head(cpi))
cat("\nTotal observations:", nrow(cpi), "\n\n")

# Create time series object
cpits <- ts(cpi$CPI, start = min(cpi$Year), frequency = 1)

# Split data: first 50 observations for estimation, rest for evaluation
n <- length(cpits)
n_train <- 50
n_test <- n - n_train

train_data <- window(cpits, end = time(cpits)[n_train])
test_data <- window(cpits, start = time(cpits)[n_train + 1])

cat("Training observations:", n_train, "\n")
cat("Testing observations:", n_test, "\n\n")

# Create time variable for modeling
time_train <- 1:n_train
time_test <- (n_train + 1):n
time_all <- 1:n

# ===== Model 1: Linear Model =====
cat("========================================\n")
cat("MODEL 1: LINEAR TREND MODEL (y = a + b*t)\n")
cat("========================================\n")

# Fit linear model
model1 <- lm(train_data ~ time_train)
cat("\nLinear Model Summary:\n")
print(summary(model1))

# Predictions on test set
pred1_test <- predict(model1, newdata = data.frame(time_train = time_test))

# Calculate error metrics for Model 1
actual <- as.numeric(test_data)
forecast1 <- as.numeric(pred1_test)

# Mean Squared Error (MSE)
mse1 <- mean((actual - forecast1)^2)

# Mean Absolute Error (MAE)
mae1 <- mean(abs(actual - forecast1))

# Mean Absolute Percentage Error (MAPE)
mape1 <- mean(abs((actual - forecast1) / actual)) * 100

cat("\n--- Model 1 Evaluation Metrics ---\n")
cat("MSE (Mean Squared Error):", round(mse1, 4), "\n")
cat("MAE (Mean Absolute Error):", round(mae1, 4), "\n")
cat("MAPE (Mean Absolute Percentage Error):", round(mape1, 4), "%\n\n")

# ===== Model 2: Quadratic Model =====
cat("========================================\n")
cat("MODEL 2: QUADRATIC TREND MODEL (y = a + b*t + c*t^2)\n")
cat("========================================\n")

# Fit quadratic model
model2 <- lm(train_data ~ time_train + I(time_train^2))
cat("\nQuadratic Model Summary:\n")
print(summary(model2))

# Predictions on test set
pred2_test <- predict(model2, newdata = data.frame(time_train = time_test))

# Calculate error metrics for Model 2
forecast2 <- as.numeric(pred2_test)

# Mean Squared Error (MSE)
mse2 <- mean((actual - forecast2)^2)

# Mean Absolute Error (MAE)
mae2 <- mean(abs(actual - forecast2))

# Mean Absolute Percentage Error (MAPE)
mape2 <- mean(abs((actual - forecast2) / actual)) * 100

cat("\n--- Model 2 Evaluation Metrics ---\n")
cat("MSE (Mean Squared Error):", round(mse2, 4), "\n")
cat("MAE (Mean Absolute Error):", round(mae2, 4), "\n")
cat("MAPE (Mean Absolute Percentage Error):", round(mape2, 4), "%\n\n")

# ===== Compare Models and Select Best =====
cat("========================================\n")
cat("MODEL COMPARISON\n")
cat("========================================\n")
cat("Model 1 (Linear)    - MSE:", round(mse1, 4), "| MAE:", round(mae1, 4), "| MAPE:", round(mape1, 4), "%\n")
cat("Model 2 (Quadratic) - MSE:", round(mse2, 4), "| MAE:", round(mae2, 4), "| MAPE:", round(mape2, 4), "%\n\n")

# Select best model based on lowest MSE
if (mse1 < mse2) {
  best_model <- model1
  best_model_name <- "Linear Model"
  model_type <- "linear"
  cat("BEST MODEL: Linear Model (lowest MSE)\n\n")
} else {
  best_model <- model2
  best_model_name <- "Quadratic Model"
  model_type <- "quadratic"
  cat("BEST MODEL: Quadratic Model (lowest MSE)\n\n")
}

# ===== Generate 4-Year Forecast =====
cat("========================================\n")
cat("4-YEAR FORECAST USING BEST MODEL\n")
cat("========================================\n")

# Refit best model on full dataset
time_full <- 1:n

if (model_type == "linear") {
  final_model <- lm(cpits ~ time_full)
} else {
  final_model <- lm(cpits ~ time_full + I(time_full^2))
}

# Forecast 4 years ahead
h <- 4
time_forecast <- (n + 1):(n + h)

if (model_type == "linear") {
  forecast_values <- predict(final_model,
                             newdata = data.frame(time_full = time_forecast),
                             interval = "prediction")
} else {
  forecast_values <- predict(final_model,
                             newdata = data.frame(time_full = time_forecast),
                             interval = "prediction")
}

# Create forecast dataframe
last_year <- max(cpi$Year)
forecast_years <- (last_year + 1):(last_year + h)

forecast_df <- data.frame(
  Year = forecast_years,
  Forecast = forecast_values[, "fit"],
  Lower_CI = forecast_values[, "lwr"],
  Upper_CI = forecast_values[, "upr"]
)

cat("\n4-Year Forecast:\n")
print(forecast_df)

# ===== Create Visualization =====
cat("\n========================================\n")
cat("CREATING PLOT\n")
cat("========================================\n")

# Prepare data for plotting
plot_data <- data.frame(
  Year = cpi$Year,
  CPI = as.numeric(cpits),
  Type = "Observed"
)

forecast_plot_data <- data.frame(
  Year = forecast_years,
  CPI = forecast_values[, "fit"],
  Type = "Forecast"
)

combined_data <- rbind(plot_data, forecast_plot_data)

# Create confidence interval data
ci_data <- data.frame(
  Year = forecast_years,
  Lower = forecast_values[, "lwr"],
  Upper = forecast_values[, "upr"]
)

# Create the plot
p <- ggplot() +
  # Original data
  geom_line(data = plot_data, aes(x = Year, y = CPI, color = "Observed"),
            size = 1) +
  geom_point(data = plot_data, aes(x = Year, y = CPI, color = "Observed"),
             size = 2) +
  # Forecast
  geom_line(data = forecast_plot_data, aes(x = Year, y = CPI, color = "Forecast"),
            size = 1, linetype = "dashed") +
  geom_point(data = forecast_plot_data, aes(x = Year, y = CPI, color = "Forecast"),
             size = 3, shape = 17) +
  # Confidence interval
  geom_ribbon(data = ci_data, aes(x = Year, ymin = Lower, ymax = Upper),
              alpha = 0.2, fill = "blue") +
  # Styling
  scale_color_manual(values = c("Observed" = "black", "Forecast" = "red")) +
  labs(
    title = paste("CPI Malaysia: Observed Data and 4-Year Forecast"),
    subtitle = paste("Best Model:", best_model_name),
    x = "Year",
    y = "Consumer Price Index (2010 = 100)",
    color = "Series"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    plot.subtitle = element_text(size = 11),
    legend.position = "bottom",
    panel.grid.minor = element_blank()
  )

# Save the plot
ggsave("/Users/asmuie/demo_class/R linear trend/cpi_forecast_plot.png",
       plot = p, width = 10, height = 6, dpi = 300)

# Display the plot
print(p)

cat("\nPlot saved as: /Users/asmuie/demo_class/R linear trend/cpi_forecast_plot.png\n")
cat("\nAnalysis completed successfully!\n")

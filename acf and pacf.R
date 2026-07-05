# ACF and PACF Correlogram from Table Values
# n = 100 observations, Lags 1-7

# ── Given values from table ──────────────────────────────────────────────
lags <- 1:7
acf_vals  <- c(0.62, 0.45, 0.30, 0.18, 0.10, 0.05, 0.02)
pacf_vals <- c(0.62, 0.14, -0.18, -0.10, 0.05, 0.02, -0.01)

n <- 100
ci <- qnorm(0.975) / sqrt(n)   # 95% confidence band ≈ ±0.196

# ── Plot layout: ACF (top) | PACF (bottom) ───────────────────────────────
par(mfrow = c(2, 1),
    mar   = c(4, 4.5, 3, 2),
    bg    = "white")

# helper to draw one correlogram panel
draw_corr <- function(vals, title, ylab) {
  plot(lags, vals,
       type = "h",
       lwd  = 3,
       col  = ifelse(abs(vals) > ci, "steelblue", "gray60"),
       ylim = c(-0.4, 0.8),
       xlab = "Lag",
       ylab = ylab,
       main = title,
       xaxt = "n")
  
  axis(1, at = lags)                          # integer x-axis
  abline(h = 0)                               # centre line
  abline(h =  ci, lty = 2, col = "red")       # upper CI
  abline(h = -ci, lty = 2, col = "red")       # lower CI
  points(lags, vals, pch = 16,
         col = ifelse(abs(vals) > ci, "steelblue", "gray60"))
  
  # annotate values above/below each bar
  text(lags, vals + 0.05 * sign(vals),
       labels = vals, cex = 0.8, col = "black")
  
  legend("topright",
         legend = c("Significant", "Non-significant", "95% CI"),
         col    = c("steelblue", "gray60", "red"),
         lty    = c(1, 1, 2), lwd = c(3, 3, 1),
         cex    = 0.75, bty = "n")
}

draw_corr(acf_vals,  "Autocorrelation Function (ACF)",
          "ACF")
draw_corr(pacf_vals, "Partial Autocorrelation Function (PACF)",
          "PACF")

mtext("Correlogram  |  n = 100", outer = TRUE, line = -1.2,
      cex = 1.1, font = 2)


plot(Max_Power ~ Process, gpu_clean,
  xlab = "Process (nm)",
  ylab = "Max Power (Watts)",
  main = "Process vs Max Power",
  col = "black",
  pch = 20
)

model <- lm(Max_Power ~ Process, data = gpu_clean)
abline(model, col = "red", lwd = 2)
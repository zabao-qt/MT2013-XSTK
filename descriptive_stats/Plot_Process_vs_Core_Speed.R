plot(Core_Speed ~ Process, gpu_clean,
  xlab = "Process (nm)",
  ylab = "Core_Speed (MHz)",
  main = "Process vs Core_Speed",
  col = "black",
  pch = 20
)

model <- lm(Core_Speed ~ Process, data = gpu_clean)
abline(model, col = "red", lwd = 2)
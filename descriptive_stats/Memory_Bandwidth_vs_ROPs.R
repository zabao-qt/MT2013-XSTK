plot(ROPs ~ Memory_Bandwidth, gpu_clean,
  xlab = "Memory_Bandwidth",
  ylab = "ROPs",
  main = "ROPs vs Memory_Bandwidth",
  col = "black",
  pch = 20
)

model <- lm(ROPs ~ Memory_Bandwidth, data = gpu_clean)
abline(model, col = "red", lwd = 2)
source("data_preprocessing.R")
library(ggplot2)

# PHAN 4 Thong ke ta
# Du lieu dinh tinh
data1 <- gpu_clean[, c("Manufacturer"), drop = FALSE]
barplot(
  table(data1$Manufacturer),
  xlab = "Manufacturer",
  ylab = "Frequency",
  main = "Bar Plot of GPU Manufacturer",
  ylim = c(0, 2000),
  col = "gray",
  border = "black"
)

# Du lieu dinh luong
data2 <- gpu_clean[, c("Core_Speed", "Memory", "Memory_Bandwidth",
                        "Memory_Speed", "Memory_Bus", "Process",
                        "Max_Power", "TMUs", "ROPs"), drop = FALSE]
hist(data2$Core_Speed,
     main = "Histogram of Core_Speed",
     xlab = "Core_Speed",
     ylab = "Frequency",
     xlim = c(0, 2000),
     ylim = c(0, 1500),
     border = "black")

plot(Max_Power ~ Process, data = data2,
     xlab = "Process (nm)",
     ylab = "Max_Power (Watts)",
     main = "Max_Power vs Process",
     pch = 16,
     cex = 2,
     xlim = c(0, 160),
     ylim = c(0, 900),
     col = "gray30")

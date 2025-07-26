source("data_preprocessing.R")
library(ggplot2)

# PHAN 4 Thong ke ta
# Du lieu dinh tinh
data1 <- gpu_clean[, c("Manufacturer"), drop = FALSE]
barplot(
  table(gpu_clean$Manufacturer),
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
hist(gpu_clean$Max_Power,
     main = "Histogram of Max_Power",
     xlab = "Max_Power (Watts)",
     ylab = "Frequency",
     xlim = c(0, 900),
     ylim = c(0, 1300),
     border = "black")

hist(gpu_clean$Memory_Speed,
     main = "Histogram of Memory_Speed",
     xlab = "Memory_Speed",
     ylab = "Frequency",
     xlim = c(0, 2500),
     ylim = c(0, 600),
     border = "black")

# Tinh thong ke mo ta cho bien Core_Speed theo Manufacturer
CPManu <- data.frame( 
     Mean = tapply(gpu_clean$Core_Speed, gpu_clean$Manufacturer, mean, na.rm = TRUE),
     Var = tapply(gpu_clean$Core_Speed, gpu_clean$Manufacturer, var, na.rm = TRUE),
     Sd = tapply(gpu_clean$Core_Speed, gpu_clean$Manufacturer, sd, na.rm = TRUE),
     Min = tapply(gpu_clean$Core_Speed, gpu_clean$Manufacturer, min, na.rm = TRUE),
     Max = tapply(gpu_clean$Core_Speed, gpu_clean$Manufacturer, max, na.rm = TRUE),
     Q1 = tapply(gpu_clean$Core_Speed, gpu_clean$Manufacturer, quantile, probs = 0.25, na.rm = TRUE),
     Q2 = tapply(gpu_clean$Core_Speed, gpu_clean$Manufacturer, quantile, probs = 0.50, na.rm = TRUE),
     Q3 = tapply(gpu_clean$Core_Speed, gpu_clean$Manufacturer, quantile, probs = 0.75, na.rm = TRUE)
)
CPManu
# Bieu do boxplot cua Core_Speed theo Manufacturer
boxplot(Core_Speed ~ Manufacturer, gpu_clean,
     main = "Boxplot of Core_Speed by Manufacturer",
     pch = 16)

# Thong ke mo ta cho bien Max_Power theo Process
MPProcess <- data.frame(
     Mean = tapply(gpu_clean$Max_Power, gpu_clean$Process, mean, na.rm = TRUE),
     Var = tapply(gpu_clean$Max_Power, gpu_clean$Process, var, na.rm = TRUE),
     Sd = tapply(gpu_clean$Max_Power, gpu_clean$Process, sd, na.rm = TRUE),
     Min = tapply(gpu_clean$Max_Power, gpu_clean$Process, min, na.rm = TRUE),
     Max = tapply(gpu_clean$Max_Power, gpu_clean$Process, max, na.rm = TRUE),
     Q1 = tapply(gpu_clean$Max_Power, gpu_clean$Process, quantile, probs = 0.25, na.rm = TRUE),
     Q2 = tapply(gpu_clean$Max_Power, gpu_clean$Process, quantile, probs = 0.50, na.rm = TRUE),
     Q3 = tapply(gpu_clean$Max_Power, gpu_clean$Process, quantile, probs = 0.75, na.rm = TRUE)
)
MPProcess

boxplot(Max_Power ~ Process, gpu_clean,
     xlab = "Process (nm)",
     ylab = "Max_Power (Watts)", 
     main = "Max Power vs Process",
     pch = 16)

# install.packages("GGally")
library(GGally)

ggpairs(gpu_clean[, c("Core_Speed", "Memory",
                      "Process",  "Max_Power", "TMUs", "ROPs")],
        title = "Scatterplot Matrix of GPU Variables with Pixel Rate")
source("data_preprocessing.R")
# install.packages("GGally") # nolint
library(GGally)
library(ggplot2)

# PHẦN 4. THỐNG KÊ MÔ TẢ
# Chia dữ liệu dưới dạng định lượng, định tính
qualitative_data  <- gpu_clean[, c("Manufacturer"), drop = FALSE]
quantitative_data <- gpu_clean[, c("Core_Speed", "Memory", "Memory_Bandwidth", "Memory_Speed", "Memory_Bus", "Process", "Max_Power", "TMUs", "ROPs"), drop = FALSE]

# Các đặc trưng của mẫu
Mean <- apply(quantitative_data, 2, mean, na.rm = TRUE)
Var  <- apply(quantitative_data, 2, var, na.rm = TRUE)
Sd   <- apply(quantitative_data, 2, sd, na.rm = TRUE)
Min  <- apply(quantitative_data, 2, min, na.rm = TRUE)
Max  <- apply(quantitative_data, 2, max, na.rm = TRUE)
Q1   <- apply(quantitative_data, 2, quantile, probs = 0.25, na.rm = TRUE)
Q2   <- apply(quantitative_data, 2, quantile, probs = 0.5, na.rm = TRUE)
Q3   <- apply(quantitative_data, 2, quantile, probs = 0.75, na.rm = TRUE)
DTM <- data.frame(Mean, Var, Sd, Min, Max, Q1, Q2, Q3)
View(DTM)

# Biểu đồ biến định tính

chart <- barplot(table(qualitative_data$Manufacturer),
    main = "Manufacturer Histogram",
    xlab = "Manufacturer",
    ylab = "Frequency",
    ylim = c(0, 2000),
    col = "gray",
    border = "black"
)

# Biểu đồ biến định lượng

# Histogram of Core Speed
chart <- hist(gpu_clean$Core_Speed,
    main = "Core Speed Histogram",
    xlab = "Core Speed (MHz)",
    ylab = "Frequency",
    xlim = c(0, 2000),
    ylim = c(0, 1400),
    col = "gray",
    border = "black"
)
text(x = chart$mids, y = chart$counts, labels = chart$counts, pos = 3, cex = 0.8, col = "black")


# Du lieu dinh tinh
# data1 <- gpu_clean[, c("Manufacturer"), drop = FALSE]
# barplot(
#   table(gpu_clean$Manufacturer),
#   xlab = "Manufacturer",
#   ylab = "Frequency",
#   main = "Bar Plot of GPU Manufacturer",
#   ylim = c(0, 2000),
#   col = "gray",
#   border = "black"
# )

# # Du lieu dinh luong
# data2 <- gpu_clean[, c("Core_Speed", "Memory", "Memory_Bandwidth",
#                        "Memory_Speed", "Memory_Bus", "Process",
#                        "Max_Power", "TMUs", "ROPs"), drop = FALSE]
# hist(gpu_clean$Max_Power,
#      main = "Histogram of Max Power",
#      xlab = "Max Power (Watts)",
#      ylab = "Frequency",
#      xlim = c(0, 900),
#      ylim = c(0, 1300),
#      border = "black")

# hist(gpu_clean$Memory_Speed,
#      main = "Histogram of Memory Speed",
#      xlab = "Memory Speed (MHz)",
#      ylab = "Frequency",
#      xlim = c(0, 2500),
#      ylim = c(0, 600),
#      border = "black")

# # Tinh thong ke mo ta cho bien Core_Speed theo Manufacturer
# CPManu <- data.frame( 
#      Mean = tapply(gpu_clean$Core_Speed, gpu_clean$Manufacturer, mean, na.rm = TRUE),
#      Var = tapply(gpu_clean$Core_Speed, gpu_clean$Manufacturer, var, na.rm = TRUE),
#      Sd = tapply(gpu_clean$Core_Speed, gpu_clean$Manufacturer, sd, na.rm = TRUE),
#      Min = tapply(gpu_clean$Core_Speed, gpu_clean$Manufacturer, min, na.rm = TRUE),
#      Max = tapply(gpu_clean$Core_Speed, gpu_clean$Manufacturer, max, na.rm = TRUE),
#      Q1 = tapply(gpu_clean$Core_Speed, gpu_clean$Manufacturer, quantile, probs = 0.25, na.rm = TRUE),
#      Q2 = tapply(gpu_clean$Core_Speed, gpu_clean$Manufacturer, quantile, probs = 0.50, na.rm = TRUE),
#      Q3 = tapply(gpu_clean$Core_Speed, gpu_clean$Manufacturer, quantile, probs = 0.75, na.rm = TRUE)
# )
# CPManu
# # Bieu do boxplot cua Core_Speed theo Manufacturer
# boxplot(Core_Speed ~ Manufacturer, gpu_clean,
#         ylab = "Core Speed (MHz)",
#         main = "Boxplot of Core Speed by Manufacturer",
#         pch = 16)

# # Thong ke mo ta cho bien Max_Power theo Process
# MPProcess <- data.frame(
#      Mean = tapply(gpu_clean$Max_Power, gpu_clean$Process, mean, na.rm = TRUE),
#      Var = tapply(gpu_clean$Max_Power, gpu_clean$Process, var, na.rm = TRUE),
#      Sd = tapply(gpu_clean$Max_Power, gpu_clean$Process, sd, na.rm = TRUE),
#      Min = tapply(gpu_clean$Max_Power, gpu_clean$Process, min, na.rm = TRUE),
#      Max = tapply(gpu_clean$Max_Power, gpu_clean$Process, max, na.rm = TRUE),
#      Q1 = tapply(gpu_clean$Max_Power, gpu_clean$Process, quantile, probs = 0.25, na.rm = TRUE),
#      Q2 = tapply(gpu_clean$Max_Power, gpu_clean$Process, quantile, probs = 0.50, na.rm = TRUE),
#      Q3 = tapply(gpu_clean$Max_Power, gpu_clean$Process, quantile, probs = 0.75, na.rm = TRUE)
# )
# MPProcess

# boxplot(Max_Power ~ Process, gpu_clean,
#      xlab = "Process (nm)",
#      ylab = "Max Power (Watts)",
#      main = "Max Power vs Process",
#      pch = 16)

# ggpairs(gpu_clean[, c("Core_Speed", "Memory",
#                       "Process",  "Max_Power", "TMUs", "ROPs")],
#         title = "Scatterplot Matrix of GPU Variables with Pixel Rate")
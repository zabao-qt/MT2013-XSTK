source("data_preprocessing.R")
# install.packages("GGally") # nolint
library(GGally)
library(ggplot2)

# PHẦN 4. THỐNG KÊ MÔ TẢ
# Chia dữ liệu dưới dạng định lượng, định tính
qualitative_data  <- gpu_clean[, c("Manufacturer"), drop = FALSE]
quantitative_data <- gpu_clean[, c("Core_Speed", "Memory", "Memory_Bandwidth", "Memory_Speed", "Memory_Bus", "Process", "Max_Power", "TMUs", "ROPs"), drop = FALSE]

### Các đặc trưng của mẫu
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

### Biểu đồ biến định tính
# Barplot of Manufacturer
chart <- barplot(table(qualitative_data$Manufacturer),
    main = "Manufacturer Histogram",
    xlab = "Manufacturer",
    ylab = "Frequency",
    ylim = c(0, 2000),
    col = "gray",
    border = "black"
)

### Biểu đồ biến định lượng
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

# Histogram of Memory
chart <- hist(gpu_clean$Memory,
    main = "Memory Histogram",
    xlab = "Memory (MB)",
    ylab = "Frequency",
    xlim = c(0, 35000),
    ylim = c(0, 2000),
    col = "gray",
    border = "black"
)
text(x = chart$mids, y = chart$counts, labels = chart$counts, pos = 3, cex = 0.8, col = "black")

# Histogram of Memory Bandwidth
chart <- hist(gpu_clean$Memory_Bandwidth,
              main = "Memory Bandwidth Histogram",
              xlab = "Memory Bandwidth (GB/sec)",
              ylab = "Frequency",
              xlim = c(0, 1500),
              ylim = c(0, 2000),
              col = "gray",
              border = "black"
)
text(x = chart$mids, y = chart$counts, labels = chart$counts, pos = 3, cex = 0.8, col = "black")

# Histogram of Memory_Speed
chart <- hist(gpu_clean$Memory_Speed,
              main = "Memory Speed Histogram",
              xlab = "Memory Speed (MHz)",
              ylab = "Frequency",
              xlim = c(0, 2500),
              ylim = c(0, 600),
              col = "gray",
              border = "black"
)
text(x = chart$mids, y = chart$counts, labels = chart$counts, pos = 3, cex = 0.8, col = "black")

# Histogram of Memory_Bus
chart <- hist(gpu_clean$Memory_Bus,
              main = "Memory Bus Histogram",
              xlab = "Memory Bus (Bit)",
              ylab = "Frequency",
              xlim = c(0, 10000),
              ylim = c(0, 4000),
              col = "gray",
              border = "black"
)
text(x = chart$mids, y = chart$counts, labels = chart$counts, pos = 3, cex = 0.8, col = "black")

# Histogram of Process
chart <- hist(gpu_clean$Process,
              main = "Process Histogram",
              xlab = "Process (nm)",
              ylab = "Frequency",
              xlim = c(0, 200),
              ylim = c(0, 2000),
              col = "gray",
              border = "black"
)
text(x = chart$mids, y = chart$counts, labels = chart$counts, pos = 3, cex = 0.8, col = "black")

# Histogram of Max Power
chart <- hist(gpu_clean$Max_Power,
              main = "Max Power Histogram",
              xlab = "Max Power (Watts)",
              ylab = "Frequency",
              xlim = c(0, 800),
              ylim = c(0, 1500),
              col = "gray",
              border = "black"
)
text(x = chart$mids, y = chart$counts, labels = chart$counts, pos = 3, cex = 0.8, col = "black")

# Histogram of TMUs
chart <- hist(gpu_clean$TMUs,
              main = "TMUs Histogram",
              xlab = "TMUs",
              ylab = "Frequency",
              xlim = c(0, 500),
              ylim = c(0, 1500),
              col = "gray",
              border = "black"
)
text(x = chart$mids, y = chart$counts, labels = chart$counts, pos = 3, cex = 0.8, col = "black")

# Histogram of ROPs
chart <- hist(gpu_clean$ROPs,
              main = "ROPs Histogram",
              xlab = "ROPs",
              ylab = "Frequency",
              xlim = c(0, 200),
              ylim = c(0, 1500),
              col = "gray",
              border = "black"
)
text(x = chart$mids, y = chart$counts, labels = chart$counts, pos = 3, cex = 0.8, col = "black")

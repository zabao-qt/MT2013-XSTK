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
#View(DTM)

pdf("ggplots.pdf", width = 8, height = 6)
# ==== DỮ LIỆU ĐỊNH TÍNH ====
counts <- table(gpu_clean$Manufacturer)
bar_positions <- barplot(
  table(gpu_clean$Manufacturer),
  xlab = "Manufacturer",
  ylab = "Amount",
  main = "Bar Plot of GPU Manufacturer",
  ylim = c(0, 2000),
  col = "skyblue",
  border = "black"
)
text(
  x = bar_positions,
  y = counts,
  labels = counts,
  pos = 3,          # vị trí phía trên cột
  cex = 0.8,        # cỡ chữ
  col = "black"     # màu chữ
)

# ==== DỮ LIỆU ĐỊNH LƯỢNG ====
# Histogram of Core Speed

hist_data <- hist(
  gpu_clean$Core_Speed,
  breaks = seq(0, 1800, by = 200),
  main = "Histogram of Core Speed",
  xlab = "Core Speed (MHz)",
  ylab = "Amount",
  xlim = c(0, 1800),
  ylim = c(0, 2000),   # mở rộng đủ để có các mốc 500, 1000, 1500, 2000
  col = "skyblue",
  border = "black",
  xaxt = "n",  # tắt trục X mặc định
  yaxt = "n"   # tắt trục Y mặc định
)

# Vẽ lại trục X: mỗi 200 MHz
axis(
  side = 1,
  at = seq(0, 1800, by = 200),
  labels = seq(0, 1800, by = 200),
  cex.axis = 0.8
)

# Vẽ lại trục Y: mỗi 500 đơn vị
axis(
  side = 2,
  at = seq(0, 2000, by = 500),
  labels = seq(0, 2000, by = 500),
  cex.axis = 0.8
)

# Hiển thị số lượng trên đỉnh các cột
text(
  x = hist_data$mids,
  y = hist_data$counts + 30,
  labels = hist_data$counts,
  cex = 0.7
)

# Histogram of Memory Bandwidth
hist_data <- hist(
  gpu_clean$Memory_Bandwidth,
  breaks = seq(0, 1400, by = 200),  # mỗi cột rộng 100 GB/s
  main = "Histogram of Memory Bandwidth",
  xlab = "Memory Bandwidth (GB/s)",
  ylab = "Amount",
  xlim = c(0, 1400),
  ylim = c(0, 2500),
  col = "skyblue",
  border = "black",
  xaxt = "n",
  yaxt = "n"
)

# Trục X cách 200
axis(side = 1,
     at = seq(0, 1400, by = 200),
     labels = seq(0, 1400, by = 200),
     cex.axis = 0.8)

# Trục Y cách 500
axis(side = 2,
     at = seq(0, 2500, by = 500),
     labels = seq(0, 2500, by = 500),
     cex.axis = 0.8)

# Ghi số lượng lên đỉnh cột
text(
  x = hist_data$mids,
  y = hist_data$counts + 50,
  labels = hist_data$counts,
  cex = 0.7
)
# Histogram of Memory_Speed
hist_data <- hist(
  gpu_clean$Memory_Speed,
  breaks = seq(0, 2200, by = 220),  # mỗi cột rộng 100 GB/s
  main = "Memory Speed Histogram",
  xlab = "Memory Speed (MHz)",
  ylab = "Amount",
  xlim = c(0, 2200),
  ylim = c(0, 1000),
  col = "skyblue",
  border = "black",
  xaxt = "n",
  yaxt = "n"
)

# Trục X cách 200
axis(side = 1,
     at = seq(0, 2200, by = 220),
     labels = seq(0, 2200, by = 220),
     cex.axis = 0.8)

# Trục Y cách 500
axis(side = 2,
     at = seq(0, 1000, by = 200),
     labels = seq(0, 1000, by = 200),
     cex.axis = 0.8)

# Ghi số lượng lên đỉnh cột
text(
  x = hist_data$mids,
  y = hist_data$counts + 30,
  labels = hist_data$counts,
  cex = 0.7
)


# Histogram of Memory_Bus
hist_data <- hist(
  gpu_clean$Memory_Bus,
  breaks = seq(0, 9000, by = 1000),  # mỗi cột rộng 100 GB/s
  main = "Memory Bus Histogram",
  xlab = "Memory Bus (Bit)",
  ylab = "Amount",
  xlim = c(0, 9000),
  ylim = c(0, 4000),
  col = "skyblue",
  border = "black",
  xaxt = "n",
  yaxt = "n"
)

# Trục X cách 200
axis(side = 1,
     at = seq(0, 9000, by = 1000),
     labels = seq(0, 9000, by = 1000),
     cex.axis = 0.8)

# Trục Y cách 500
axis(side = 2,
     at = seq(0, 4000, by = 1000),
     labels = seq(0, 4000, by = 1000),
     cex.axis = 0.8)

# Ghi số lượng lên đỉnh cột
text(
  x = hist_data$mids,
  y = hist_data$counts + 50,
  labels = hist_data$counts,
  cex = 0.7
)

# Histogram of Process
hist_data <- hist(
  gpu_clean$Process,
  breaks = seq(0, 150, by = 30),  # mỗi cột rộng 100 GB/s
  main = "Process Histogram",
  xlab = "Process (nm)",
  ylab = "Amount",
  xlim = c(0, 150),
  ylim = c(0, 3000),
  col = "skyblue",
  border = "black",
  xaxt = "n",
  yaxt = "n"
)

# Trục X cách 200
axis(side = 1,
     at = seq(0, 150, by = 30),
     labels = seq(0, 150, by = 30),
     cex.axis = 0.8)

# Trục Y cách 500
axis(side = 2,
     at = seq(0, 3000, by = 500),
     labels = seq(0, 3000, by = 500),
     cex.axis = 0.8)

# Ghi số lượng lên đỉnh cột
text(
  x = hist_data$mids,
  y = hist_data$counts + 50,
  labels = hist_data$counts,
  cex = 0.7
)

# Histogram of Max Power
hist_data <- hist(
  gpu_clean$Max_Power,
  breaks = seq(0, 800, by = 100),  # mỗi cột rộng 100 GB/s
  main = "Process Histogram",
  xlab = "Process (nm)",
  ylab = "Amount",
  xlim = c(0, 800),
  ylim = c(0, 2000),
  col = "skyblue",
  border = "black",
  xaxt = "n",
  yaxt = "n"
)

# Trục X cách 200
axis(side = 1,
     at = seq(0, 800, by = 100),
     labels = seq(0, 800, by = 100),
     cex.axis = 0.8)

# Trục Y cách 500
axis(side = 2,
     at = seq(0, 2000, by = 500),
     labels = seq(0, 2000, by = 500),
     cex.axis = 0.8)

# Ghi số lượng lên đỉnh cột
text(
  x = hist_data$mids,
  y = hist_data$counts + 50,
  labels = hist_data$counts,
  cex = 0.7
)


# Histogram of TMUs
hist_data <- hist(
  gpu_clean$TMUs,
  breaks = seq(0, 400, by = 50),  # mỗi cột rộng 100 GB/s
  main = "TMUs Histogram",
  xlab = "TMUs",
  ylab = "Amount",
  xlim = c(0, 400),
  ylim = c(0, 2000),
  col = "skyblue",
  border = "black",
  xaxt = "n",
  yaxt = "n"
)

# Trục X cách 200
axis(side = 1,
     at = seq(0, 400, by = 50),
     labels = seq(0, 400, by = 50),
     cex.axis = 0.8)

# Trục Y cách 500
axis(side = 2,
     at = seq(0, 2000, by = 500),
     labels = seq(0, 2000, by = 500),
     cex.axis = 0.8)

# Ghi số lượng lên đỉnh cột
text(
  x = hist_data$mids,
  y = hist_data$counts + 50,
  labels = hist_data$counts,
  cex = 0.7
)

# Histogram of ROPs
hist_data <- hist(
  gpu_clean$ROPs,
  breaks = seq(0, 200, by = 20),  # mỗi cột rộng 100 GB/s
  main = "ROPs Histogram",
  xlab = "ROPs",
  ylab = "Amount",
  xlim = c(0, 200),
  ylim = c(0, 2000),
  col = "skyblue",
  border = "black",
  xaxt = "n",
  yaxt = "n"
)

# Trục X cách 200
axis(side = 1,
     at = seq(0, 200, by = 20),
     labels = seq(0, 200, by = 20),
     cex.axis = 0.8)

# Trục Y cách 500
axis(side = 2,
     at = seq(0, 2000, by = 500),
     labels = seq(0, 2000, by = 500),
     cex.axis = 0.8)

# Ghi số lượng lên đỉnh cột
text(
  x = hist_data$mids,
  y = hist_data$counts + 50,
  labels = hist_data$counts,
  cex = 0.7
)

# Biểu đồ Scatter plots
pairs(quantitative_data, main = "Pairs Plot of Numeric Data", pch = 16, col = "blue",)

### Biểu đồ tương quan giữa 2 biến
# Biểu đồ Process vs Max Power
plot(Max_Power ~ Process, gpu_clean,
     xlab = "Process (nm)",
     ylab = "Max Power (Watts)",
     main = "Process vs Max Power",
     col = "blue",
     pch = 16
)

# Biểu đồ Process vs Core Speed
plot(Core_Speed ~ Process, gpu_clean,
     xlab = "Process (nm)",
     ylab = "Core_Speed (MHz)",
     main = "Process vs Core_Speed",
     col = "blue",
     pch = 16
)

dev.off()



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
  cex.axis = 0.8
)

# Trục Y cách 500
axis(side = 2,
  at = seq(0, 2000, by = 500),
  labels = seq(0, 2000, by = 500),
  cex.axis = 0.8
)

# Ghi số lượng lên đỉnh cột
text(
  x = hist_data$mids,
  y = hist_data$counts + 50,
  labels = hist_data$counts,
  cex = 0.7
)

# Vẽ biểu đồ
hist_data <- hist(
  gpu_clean$ROPs,
  breaks = seq(0, 192, by = 12),
  main = "Histogram of ROPs",
  xlab = "ROPs",
  ylab = "Frequency",
  xlim = c(0, 192),
  ylim = c(0, 1500),
  col = "skyblue",
  border = "black",
  xaxt = "n",  # tắt trục X mặc định
  yaxt = "n"   # tắt trục Y mặc định
)

# Hiển thị số lượng trên đỉnh các cột
text(x = hist_data$mids, y = hist_data$counts + 50, labels = hist_data$counts, cex = 0.6)
# Vẽ lại trục X
axis(side = 1, at = seq(0, 192, by = 12), labels = seq(0, 192, by = 12), cex.axis = 0.6)
# Vẽ lại trục Y
axis(side = 2, at = seq(0, 1500, by = 300), labels = seq(0, 1500, by = 300), cex.axis = 0.8)
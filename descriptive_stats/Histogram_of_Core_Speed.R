# Vẽ biểu đồ
hist_data <- hist(
  gpu_clean$Core_Speed,
  breaks = seq(100, 1800, by = 100),
  main = "Histogram of Core Speed",
  xlab = "Core Speed (MHz)",
  ylab = "Frequency",
  xlim = c(100, 1800),
  ylim = c(0, 1500),
  col = "skyblue",
  border = "black",
  xaxt = "n",  # tắt trục X mặc định
  yaxt = "n"   # tắt trục Y mặc định
)

# Hiển thị số lượng trên đỉnh các cột
text(x = hist_data$mids, y = hist_data$counts + 30, labels = hist_data$counts, cex = 0.6)
# Vẽ lại trục X: mỗi 100 MHz
axis(side = 1, at = seq(100, 1800, by = 100), labels = seq(100, 1800, by = 100), cex.axis = 0.6)
# Vẽ lại trục Y: mỗi 500 đơn vị
axis(side = 2, at = seq(0, 1500, by = 150), labels = seq(0, 1500, by = 150), cex.axis = 0.7)
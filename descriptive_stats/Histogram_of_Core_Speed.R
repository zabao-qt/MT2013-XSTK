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
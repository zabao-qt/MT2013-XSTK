# Vẽ biểu đồ
hist_data <- hist(
  gpu_clean$Memory_Speed,
  breaks = seq(100, 2200, by = 150),
  main = "Histogram of Memory Speed",
  xlab = "Memory_Speed (MHz)",
  ylab = "Frequency",
  xlim = c(100, 2200),
  ylim = c(0, 500),
  col = "skyblue",
  border = "black",
  xaxt = "n",  # tắt trục X mặc định
  yaxt = "n"   # tắt trục Y mặc định
)

# Hiển thị số lượng trên đỉnh các cột
text(x = hist_data$mids, y = hist_data$counts + 30, labels = hist_data$counts, cex = 0.6)
# Vẽ lại trục X
axis(side = 1, at = seq(100, 2200, by = 150), labels = seq(100, 2200, by = 150), cex.axis = 0.6)
# Vẽ lại trục Y
axis(side = 2, at = seq(0, 500, by = 100), labels = seq(0, 500, by = 100), cex.axis = 0.8)
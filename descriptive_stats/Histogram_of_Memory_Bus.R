# Vẽ biểu đồ
hist_data <- hist(
  gpu_clean$Memory_Bus,
  breaks = seq(32, 8192, by = 544),
  main = "Histogram of Memory Bus",
  xlab = "Memory_Bus (Bit)",
  ylab = "Frequency",
  xlim = c(32, 8192),
  ylim = c(0, 3300),
  col = "skyblue",
  border = "black",
  xaxt = "n",  # tắt trục X mặc định
  yaxt = "n"   # tắt trục Y mặc định
)

# Hiển thị số lượng trên đỉnh các cột
text(x = hist_data$mids, y = hist_data$counts + 50, labels = hist_data$counts, cex = 0.6)
# Vẽ lại trục X
axis(side = 1, at = seq(32, 8192, by = 544), labels = seq(32, 8192, by = 544), cex.axis = 0.6)
# Vẽ lại trục Y
axis(side = 2, at = seq(0, 3300, by = 300), labels = seq(0, 3300, by = 300), cex.axis = 0.8)
# Vẽ biểu đồ
hist_data <- hist(
  gpu_clean$Process,
  breaks = seq(14, 150, by = 8),
  main = "Histogram of Process",
  xlab = "Process (nm)",
  ylab = "Frequency",
  xlim = c(14, 150),
  ylim = c(0, 2000),
  col = "skyblue",
  border = "black",
  xaxt = "n",  # tắt trục X mặc định
  yaxt = "n"   # tắt trục Y mặc định
)

# Hiển thị số lượng trên đỉnh các cột
text(x = hist_data$mids, y = hist_data$counts + 50, labels = hist_data$counts, cex = 0.6)
# Vẽ lại trục X
axis(side = 1, at = seq(14, 150, by = 8), labels = seq(14, 150, by = 8), cex.axis = 0.6)
# Vẽ lại trục Y
axis(side = 2, at = seq(0, 2000, by = 400), labels = seq(0, 2000, by = 400), cex.axis = 0.8)
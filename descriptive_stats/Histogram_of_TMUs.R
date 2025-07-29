# Vẽ biểu đồ
hist_data <- hist(
  gpu_clean$TMUs,
  breaks = seq(0, 384, by = 24),
  main = "Histogram of TMUs",
  xlab = "TMUs",
  ylab = "Frequency",
  xlim = c(0, 384),
  ylim = c(0, 1200),
  col = "skyblue",
  border = "black",
  xaxt = "n",  # tắt trục X mặc định
  yaxt = "n"   # tắt trục Y mặc định
)

# Hiển thị số lượng trên đỉnh các cột
text(x = hist_data$mids, y = hist_data$counts + 50, labels = hist_data$counts, cex = 0.6)
# Vẽ lại trục X
axis(side = 1, at = seq(0, 384, by = 24), labels = seq(0, 384, by = 24), cex.axis = 0.6)
# Vẽ lại trục Y
axis(side = 2, at = seq(0, 1200, by = 300), labels = seq(0, 1200, by = 300), cex.axis = 0.8)
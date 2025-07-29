# Vẽ biểu đồ
hist_data <- hist(
  gpu_clean$Max_Power,
  breaks = seq(0, 780, by = 60),
  main = "Histogram of Max Power",
  xlab = "Max Power (Watts)",
  ylab = "Frequency",
  xlim = c(0, 780),
  ylim = c(0, 1500),
  col = "skyblue",
  border = "black",
  xaxt = "n",  # tắt trục X mặc định
  yaxt = "n"   # tắt trục Y mặc định
)

# Hiển thị số lượng trên đỉnh các cột
text(x = hist_data$mids, y = hist_data$counts + 50, labels = hist_data$counts, cex = 0.6)
# Vẽ lại trục X
axis(side = 1, at = seq(0, 780, by = 60), labels = seq(0, 780, by = 60), cex.axis = 0.6)
# Vẽ lại trục Y
axis(side = 2, at = seq(0, 1500, by = 300), labels = seq(0, 1500, by = 300), cex.axis = 0.8)
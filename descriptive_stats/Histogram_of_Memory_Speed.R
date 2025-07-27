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
  cex.axis = 0.8
)

# Trục Y cách 500
axis(side = 2,
  at = seq(0, 1000, by = 200),
  labels = seq(0, 1000, by = 200),
  cex.axis = 0.8
)

# Ghi số lượng lên đỉnh cột
text(
  x = hist_data$mids,
  y = hist_data$counts + 30,
  labels = hist_data$counts,
  cex = 0.7
)
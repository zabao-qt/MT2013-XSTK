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
  cex.axis = 0.8
)

# Trục Y cách 500
axis(side = 2,
  at = seq(0, 4000, by = 1000),
  labels = seq(0, 4000, by = 1000),
  cex.axis = 0.8
)

# Ghi số lượng lên đỉnh cột
text(
  x = hist_data$mids,
  y = hist_data$counts + 50,
  labels = hist_data$counts,
  cex = 0.7
)
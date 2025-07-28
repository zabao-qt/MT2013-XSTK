hist_data <- hist(
  gpu_clean$Process,
  breaks = seq(0, 150, by = 30),  # mỗi cột rộng 100 GB/s
  main = "Process Histogram",
  xlab = "Process (nm)",
  ylab = "Amount",
  xlim = c(0, 150),
  ylim = c(0, 3000),
  col = "skyblue",
  border = "black",
  xaxt = "n",
  yaxt = "n"
)

# Trục X cách 200
axis(side = 1,
  at = seq(0, 150, by = 30),
  labels = seq(0, 150, by = 30),
  cex.axis = 0.8
)

# Trục Y cách 500
axis(side = 2,
  at = seq(0, 3000, by = 500),
  labels = seq(0, 3000, by = 500),
  cex.axis = 0.8
)

# Ghi số lượng lên đỉnh cột
text(
  x = hist_data$mids,
  y = hist_data$counts + 50,
  labels = hist_data$counts,
  cex = 0.7
)
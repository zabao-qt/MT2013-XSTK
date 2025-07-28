hist_data <- hist(
  gpu_clean$TMUs,
  breaks = seq(0, 400, by = 50),  # mỗi cột rộng 100 GB/s
  main = "TMUs Histogram",
  xlab = "TMUs",
  ylab = "Amount",
  xlim = c(0, 400),
  ylim = c(0, 2000),
  col = "skyblue",
  border = "black",
  xaxt = "n",
  yaxt = "n"
)

# Trục X cách 200
axis(side = 1,
  at = seq(0, 400, by = 50),
  labels = seq(0, 400, by = 50),
  cex.axis = 0.8
)

# Trục Y cách 500
axis(side = 2,
  at = seq(0, 2000, by = 500),
  labels = seq(0, 2000, by = 500),
  cex.axis = 0.8
)

# Ghi số lượng lên đỉnh cột
text(
  x = hist_data$mids,
  y = hist_data$counts + 50,
  labels = hist_data$counts,
  cex = 0.7
)
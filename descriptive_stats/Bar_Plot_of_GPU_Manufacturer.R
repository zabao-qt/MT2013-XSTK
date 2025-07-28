counts <- table(gpu_clean$Manufacturer)
bar_positions <- barplot(
  table(gpu_clean$Manufacturer),
  xlab = "Manufacturer",
  ylab = "Amount",
  main = "Bar Plot of GPU Manufacturer",
  ylim = c(0, 2000),
  col = "skyblue",
  border = "black"
)
text(
  x = bar_positions,
  y = counts,
  labels = counts,
  pos = 3,          # vị trí phía trên cột
  cex = 0.8,        # cỡ chữ
  col = "black"     # màu chữ
)
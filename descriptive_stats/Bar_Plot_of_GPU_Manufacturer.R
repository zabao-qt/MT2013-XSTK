counts <- table(gpu_clean$Manufacturer)
bar_positions <- barplot(
  table(gpu_clean$Manufacturer),
  xlab = "Manufacturer",
  ylab = "Frequency",
  main = "Bar Plot of GPU Manufacturer",
  ylim = c(0, 1800),
  col = "skyblue",
  border = "black",
  yaxt = "n"
)

# Thêm số lượng cho từng cột
text(x = bar_positions, y = counts, labels = counts, pos = 3, cex = 0.8, col = "black")
# Vẽ lại trục Y
axis(side = 2, at = seq(0, 1800, by = 300), labels = seq(0, 1800, by = 300), cex.axis = 0.8)
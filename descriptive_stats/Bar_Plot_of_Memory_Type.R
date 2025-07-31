counts <- table(gpu_clean$Memory_Type)
memory_bar_positions <- barplot(
  counts,
  xlab = "Memory Type",
  ylab = "Amount",
  main = "Bar Plot of Memory Type",
  ylim = c(0, 2100),
  col = "yellow",  # Màu nền của cột
  border = "black"
)

text(
  x = memory_bar_positions,
  y = counts,
  labels = counts,
  pos = 3,
  cex = 0.8,
  col = "black"
)
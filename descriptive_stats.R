library(ggplot2)

# PHAN 4 Thong ke ta

# Du lieu dinh tinh
barplot(
  table(gpu_clean$Manufacturer),
  xlab = "Manufacturer",
  ylab = "Frequency",
  main = "Bar Plot of GPU Manufacturer",
  col = "steelblue",
  border = "black"
)

# Du lieu dinh luong
boxplot(Max_Power ~ Manufacturer,
        data = gpu_clean,
        xlab = "Manufacturer",
        ylab = "Max_Power",
        main = "Manufacturer vs TMUs",
        pch = 20,
        cex = 1.5,
        col = "lightgreen",
        border = "black")


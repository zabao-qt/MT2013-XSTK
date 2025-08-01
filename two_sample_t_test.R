# ==========================================
# BÀI TOÁN KIỂM ĐỊNH 2 MẪU
# So sánh Memory_Bandwidth giữa Nvidia và AMD
# ==========================================

# Load thư viện cần thiết
library(dplyr)
library(ggplot2)

# Đọc dữ liệu đã được xử lý từ file data_preprocessing.R
source("c:/project/MT2013-XSTK/data_preprocessing.R")

# ==========================================
# BƯỚC 1: CHUẨN BỊ DỮ LIỆU
# ==========================================

# Lọc dữ liệu Nvidia và AMD, loại bỏ giá trị NA
nvidia_GPU <- gpu_clean %>%
  filter(Manufacturer == "Nvidia", !is.na(Memory_Bandwidth))

amd_GPU <- gpu_clean %>%
  filter(Manufacturer == "AMD", !is.na(Memory_Bandwidth))

# Trích xuất Memory_Bandwidth cho từng nhóm
nvidia_memory_bandwidth <- nvidia_GPU$Memory_Bandwidth
amd_memory_bandwidth <- amd_GPU$Memory_Bandwidth

cat("Số lượng GPU Nvidia:", length(nvidia_memory_bandwidth), "\n")
cat("Số lượng GPU AMD:", length(amd_memory_bandwidth), "\n")

# ==========================================
# BƯỚC 2: THỐNG KÊ MÔ TẢ
# ==========================================

cat("\n=== THỐNG KÊ MÔ TẢ ===\n")
cat("Nvidia Memory Bandwidth:\n")
cat("  Mean:", mean(nvidia_memory_bandwidth), "\n")
cat("  SD:", sd(nvidia_memory_bandwidth), "\n")
cat("  Min:", min(nvidia_memory_bandwidth), "\n")
cat("  Max:", max(nvidia_memory_bandwidth), "\n")

cat("\nAMD Memory Bandwidth:\n")
cat("  Mean:", mean(amd_memory_bandwidth), "\n")
cat("  SD:", sd(amd_memory_bandwidth), "\n")
cat("  Min:", min(amd_memory_bandwidth), "\n")
cat("  Max:", max(amd_memory_bandwidth), "\n")

# ==========================================
# PHÂN TÍCH OUTLIERS CHI TIẾT
# ==========================================

cat("\n=== PHÂN TÍCH OUTLIERS ===\n")

# Hàm tính outliers
analyze_outliers <- function(data, name) {
  Q1 <- quantile(data, 0.25)
  Q3 <- quantile(data, 0.75)
  IQR_val <- Q3 - Q1
  
  # Ngưỡng outliers
  lower_bound <- Q1 - 1.5 * IQR_val
  upper_bound <- Q3 + 1.5 * IQR_val
  
  # Ngưỡng extreme outliers  
  extreme_lower <- Q1 - 3.0 * IQR_val
  extreme_upper <- Q3 + 3.0 * IQR_val
  
  # Phân loại
  outliers <- data[data < lower_bound | data > upper_bound]
  extreme_outliers <- data[data < extreme_lower | data > extreme_upper]
  mild_outliers <- outliers[!(outliers %in% extreme_outliers)]
  
  cat(paste("\n", name, "Outlier Analysis:\n"))
  cat("  Q1:", round(Q1, 1), "GB/sec\n")
  cat("  Q3:", round(Q3, 1), "GB/sec\n") 
  cat("  IQR:", round(IQR_val, 1), "GB/sec\n")
  cat("  Outlier threshold: >", round(upper_bound, 1), "GB/sec\n")
  cat("  Extreme threshold: >", round(extreme_upper, 1), "GB/sec\n")
  cat("  Total outliers:", length(outliers), "/", length(data), 
      "(", round(100*length(outliers)/length(data), 1), "%)\n")
  cat("  Mild outliers:", length(mild_outliers), "\n")
  cat("  Extreme outliers:", length(extreme_outliers), "\n")
  
  if(length(outliers) > 0) {
    cat("  Outlier values:", paste(round(sort(outliers), 1), collapse=", "), "\n")
  }
  
  return(list(outliers = outliers, threshold = upper_bound))
}

# Phân tích cho cả 2 nhóm
nvidia_outliers <- analyze_outliers(nvidia_memory_bandwidth, "NVIDIA")
amd_outliers <- analyze_outliers(amd_memory_bandwidth, "AMD")

# So sánh outliers
cat("\n=== SO SÁNH OUTLIERS ===\n")
cat("Nvidia có", length(nvidia_outliers$outliers), "outliers\n")
cat("AMD có", length(amd_outliers$outliers), "outliers\n")

if(length(nvidia_outliers$outliers) > 0 && length(amd_outliers$outliers) > 0) {
  cat("Outlier cao nhất - Nvidia:", round(max(nvidia_outliers$outliers), 1), "GB/sec\n")
  cat("Outlier cao nhất - AMD:", round(max(amd_outliers$outliers), 1), "GB/sec\n")
}

# ==========================================
# BƯỚC 3: KIỂM TRA PHÂN PHỐI CHUẨN
# ==========================================

cat("\n=== KIỂM TRA PHÂN PHỐI CHUẨN ===\n")

# Reset plot layout trước khi vẽ
dev.off()  # Clear any existing plots
par(mfrow = c(1, 1))  # Reset to single plot

# Q-Q Plot cho Nvidia
cat("Vẽ Q-Q Plot cho Nvidia...\n")
qqnorm(nvidia_memory_bandwidth, main = "Q-Q Plot: Nvidia Memory Bandwidth")
qqline(nvidia_memory_bandwidth)

# Pause để xem biểu đồ
readline(prompt = "Nhấn Enter để tiếp tục với Q-Q Plot AMD...")

# Q-Q Plot cho AMD
cat("Vẽ Q-Q Plot cho AMD...\n")
qqnorm(amd_memory_bandwidth, main = "Q-Q Plot: AMD Memory Bandwidth")
qqline(amd_memory_bandwidth)

# Shapiro-Wilk test cho Nvidia
shapiro_nvidia <- shapiro.test(nvidia_memory_bandwidth)
cat("Shapiro-Wilk test cho Nvidia:\n")
print(shapiro_nvidia)

# Shapiro-Wilk test cho AMD
shapiro_amd <- shapiro.test(amd_memory_bandwidth)
cat("\nShapiro-Wilk test cho AMD:\n")
print(shapiro_amd)

# ==========================================
# BƯỚC 4: KIỂM ĐỊNH BẰNG NHAU CỦA PHƯƠNG SAI
# ==========================================

cat("\n=== KIỂM ĐỊNH BẰNG NHAU CỦA PHƯƠNG SAI ===\n")
var_test <- var.test(nvidia_memory_bandwidth, amd_memory_bandwidth)
print(var_test)

# ==========================================
# BƯỚC 5: KIỂM ĐỊNH 2 MẪU (T-TEST)
# ==========================================

cat("\n=== KIỂM ĐỊNH 2 MẪU ===\n")

# Đặt giả thiết:
# H0: μ1 ≤ μ2 (Memory Bandwidth trung bình của Nvidia không lớn hơn AMD)
# H1: μ1 > μ2 (Memory Bandwidth trung bình của Nvidia lớn hơn AMD)

# Thực hiện kiểm định 2 mẫu (one-sided test)
if (var_test$p.value > 0.05) {
  # Phương sai bằng nhau
  t_test_result <- t.test(nvidia_memory_bandwidth, amd_memory_bandwidth, 
                         alternative = "greater", 
                         var.equal = TRUE,
                         conf.level = 0.95)
  cat("Sử dụng t-test với phương sai bằng nhau\n")
} else {
  # Phương sai không bằng nhau (Welch's t-test)
  t_test_result <- t.test(nvidia_memory_bandwidth, amd_memory_bandwidth, 
                         alternative = "greater", 
                         var.equal = FALSE,
                         conf.level = 0.95)
  cat("Sử dụng Welch's t-test (phương sai không bằng nhau)\n")
}

print(t_test_result)

# ==========================================
# BƯỚC 6: TÍNH TOÁN THỦ CÔNG 
# ==========================================

cat("\n=== TÍNH TOÁN THỦ CÔNG ===\n")

# Tính các thống kê mẫu
n1 <- length(nvidia_memory_bandwidth)
n2 <- length(amd_memory_bandwidth)
x_bar1 <- mean(nvidia_memory_bandwidth)
x_bar2 <- mean(amd_memory_bandwidth)
s1 <- sd(nvidia_memory_bandwidth)
s2 <- sd(amd_memory_bandwidth)

# Hiển thị kết quả
stats_summary <- data.frame(
  Group = c("Nvidia", "AMD"),
  n = c(n1, n2),
  mean = c(x_bar1, x_bar2),
  sd = c(s1, s2)
)
print(stats_summary)

# Tính statistic z0 (theo công thức trong tài liệu)
z0 <- (x_bar1 - x_bar2) / sqrt((s1^2/n1) + (s2^2/n2))
z_alpha <- qnorm(0.95, lower.tail = TRUE)  # α = 0.05

cat("\nKết quả tính toán:\n")
cat("z0 =", z0, "\n")
cat("z_alpha =", z_alpha, "\n")

result_manual <- data.frame(z0 = z0, z_alpha = z_alpha)
print(result_manual)

# ==========================================
# BƯỚC 7: KẾT LUẬN
# ==========================================

cat("\n=== KẾT LUẬN ===\n")
if (z0 > z_alpha) {
  cat("z0 =", z0, "> z_alpha =", z_alpha, "\n")
  cat("BÁC BỎ H0: Có bằng chứng thống kê cho thấy Memory Bandwidth trung bình của Nvidia lớn hơn AMD\n")
} else {
  cat("z0 =", z0, "≤ z_alpha =", z_alpha, "\n")
  cat("KHÔNG BÁC BỎ H0: Không có đủ bằng chứng để kết luận Memory Bandwidth của Nvidia lớn hơn AMD\n")
}

cat("\nP-value từ t-test:", t_test_result$p.value, "\n")
if (t_test_result$p.value < 0.05) {
  cat("P-value < 0.05: Bác bỏ H0 ở mức ý nghĩa 5%\n")
} else {
  cat("P-value ≥ 0.05: Không bác bỏ H0 ở mức ý nghĩa 5%\n")
}

# ==========================================
# BƯỚC 8: VISUALIZATION
# ==========================================
# 

# Reset plot layout
par(mfrow = c(1, 1))

# Boxplot so sánh - QUAN TRỌNG để thấy sự khác biệt
cat("Vẽ Boxplot so sánh...\n")
boxplot(nvidia_memory_bandwidth, amd_memory_bandwidth,
        names = c("Nvidia", "AMD"),
        main = "So sánh Memory Bandwidth",
        ylab = "Memory Bandwidth (GB/sec)",
        col = c("green", "red"))
  
# Thêm thông tin thống kê lên biểu đồ
text(1, max(nvidia_memory_bandwidth)*0.9, 
     paste("Mean:", round(mean(nvidia_memory_bandwidth), 1)), 
     col = "darkgreen", font = 2)
text(2, max(amd_memory_bandwidth)*0.9, 
     paste("Mean:", round(mean(amd_memory_bandwidth), 1)), 
     col = "darkred", font = 2)

# Pause để xem boxplot
readline(prompt = "Nhấn Enter để tiếp tục với biểu đồ so sánh...")

# Biểu đồ so sánh histogram chồng lên nhau
cat("Vẽ biểu đồ so sánh histogram...\n")

# Tìm range chung
all_bandwidth <- c(nvidia_memory_bandwidth, amd_memory_bandwidth)
hist_range <- range(all_bandwidth)

# Vẽ histogram Nvidia
hist(nvidia_memory_bandwidth, breaks = 20, 
     col = rgb(0, 1, 0, 0.5),  # Xanh lá trong suốt
     main = "So sánh phân phối Memory Bandwidth",
     xlab = "Memory Bandwidth (GB/sec)",
     ylab = "Frequency",
     xlim = hist_range)

# Vẽ histogram AMD chồng lên
hist(amd_memory_bandwidth, breaks = 20,
     col = rgb(1, 0, 0, 0.5),  # Đỏ trong suốt
     add = TRUE)

# Thêm legend
legend("topright", 
       legend = c("Nvidia", "AMD"),
       fill = c(rgb(0, 1, 0, 0.5), rgb(1, 0, 0, 0.5)),
       border = c("green", "red"))

# Thêm đường mean
abline(v = mean(nvidia_memory_bandwidth), col = "darkgreen", lwd = 2, lty = 2)
abline(v = mean(amd_memory_bandwidth), col = "darkred", lwd = 2, lty = 2)

cat("Biểu đồ hoàn thành!\n")

# Reset layout về mặc định
par(mfrow = c(1, 1))
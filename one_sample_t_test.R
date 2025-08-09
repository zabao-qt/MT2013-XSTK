# Một số nguồn tin không đáng tin cậy cho rằng tốc độ lõi (Core Speed) trung bình của các GPU do hãng Nvidia sản xuất là 1200MHz. 
# Để kiếm tra nguồn thông tin này có chính xác hay không, hãy tiến hành kiểm định giả thuyết để xác định độ chính xác của nhận định này với mức ý nghĩa 5%.

# Lấy dữ liệu
source("data_preprocessing.R")
nvidia_gpu <- subset(gpu_clean, Manufacturer == "Nvidia")

# Vẽ biểu đồ để nhận xét
qqnorm(nvidia_gpu$Core_Speed); 
qqline(nvidia_gpu$Core_Speed, col = "red")

# Kiểm tra xem mẫu có phân phối chuẩn không
print(shapiro.test(nvidia_gpu$Core_Speed))

# Các đại lượng đặc trưng của mẫu
n   <- length(nvidia_gpu$Core_Speed)
xtb <- mean(nvidia_gpu$Core_Speed)
sd  <- sd(nvidia_gpu$Core_Speed)
print(data.frame(n = n, mean = xtb, sd = sd))

# Miền bác bỏ RR
z_alpha <- qnorm(0.975)
z_qs    <- (xtb - 1200)*sqrt(n)/sd 
cat("z < -", round(z_alpha, 2), "hoặc z >", round(z_alpha, 2), "\n")
cat("Giá trị z_qs:", round(z_qs, 4), "\n")

if (z_qs < -z_alpha || z_qs > z_alpha) {
  cat("BÁC BỎ H0\n")
} else {
  cat("KHÔNG BÁC BỎ H0: Không có đủ bằng chứng thống kê\n")
}
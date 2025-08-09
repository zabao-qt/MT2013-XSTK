#-------------------------------KHAI BÁO THƯ VIỆN-----------------------------------
if (!require("car")) {
  install.packages("car")
  library(car)
} else {
  library(car)
}
if (!require("ggplot2")) {
  install.packages("ggplot2")
  library(ggplot2)
} else {
  library(ggplot2)
}
if (!require("dplyr")) {
  install.packages("dplyr")
  library(dplyr)
} else {
  library(dplyr)
}
if (!require("WRS2")) {
  install.packages("WRS2")
  library(WRS2)
} else {
  library(WRS2)
}
#--------------------------------XỬ LÝ DỮ LIỆU--------------------------------------
source('data_preprocessing.R')
#---------------------------KIỂM TRA ĐIỀU KIỆN ANOVA--------------------------------
#Chọn mức ý nghĩa 5%
#Kiểm tra xem có những Manufacturer nào
manufacturers <- unique(gpu_clean$Manufacturer)
cat("\n---- Normality check (QQ + Shapiro) by Manufacturer ----\n")
#Kiểm tra phân phối chuẩn
#Vẽ QQplot và chạy Shapiro-Wilk test cho Memory_bandwidth của từng Manufacturer
for (m in manufacturers) {
            # Subset data cho từng manufacturer
            subset_data <- gpu_clean[gpu_clean$Manufacturer == m, "Memory_Bandwidth"]
            if (length(subset_data) < 3) next
            # Plot QQ plot
            qqnorm(subset_data, main = paste("QQ Plot of Memory_Bandwidth -", m))
            qqline(subset_data, , col = "blue", lwd = 2)
            # Shapiro test
            sh <- shapiro.test(subset_data)
            cat("Manufacturer:", m, "\n",
                "  Shapiro-Wilk W =", round(sh$statistic, 4),
                ",  p-value =", format.pval(sh$p.value, digits = 4), "\n\n")
}
#=>Dữ liệu của Bandwidth của cả 4 Manufacturer đều không tuân theo phân phối chuẩn
cat("---- End normality checks ----\n\n")
#Kiểm tra phương sai bằng levene test
cat("---- Levene's test (center = median) ----\n")
levene_result <- leveneTest(Memory_Bandwidth ~ Manufacturer,
                            data = gpu_clean,
                            center = median)
print(levene_result)
#=>Phương sai không đồng nhất

#---------------------------XÂY DỰNG MÔ HÌNH ANOVA-------------------------------
#Mô hình ANOVA cổ điển
cat("---- Classic one-way ANOVA ----\n")
aov_mod <- aov(Memory_Bandwidth ~ Manufacturer, data = gpu_clean)
cat("ANOVA table (Memory_Bandwidth ~ Manufacturer):\n")
print( summary(aov_mod) )
cat("\n")
#p-value < 0.05
#=>Bác bỏ H0, chấp nhận H1 => Có ít nhất 2 trong các trung bình nhóm khác nhau
#---------------------------PHÂN TíCH SÂU SAU ANOVA------------------------------
cat("---- TukeyHSD (pairwise, conf.level = 0.95) ----\n")
tukey_res <- TukeyHSD(aov_mod)
print(tukey_res)
plot(tukey_res)
#p-adj đều nhỏ hơn mức ý nghĩa 0.05
#=> mọi cặp đều khác nhau (khi plot ra mọi khoảng đều không chứa số 0

#-------------------------------MỞ RỘNG------------------------------------------
#Vì data gốc không thoả điều kiện ANOVA cổ điển, ta sẽ sử dụng Robust ANOVA trimmed-mean
#Chạy robust ANOVA với trim = 0.2 (mặc định)
cat("---- Robust trimmed-mean ANOVA (WRS2::t1way) ----\n")
res_trim <- t1way(Memory_Bandwidth ~ Manufacturer,
                  data = gpu_clean,
                  tr = 0.2,    # trim 20% ở mỗi đầu
                  alpha = 0.05)
print(res_trim)
cat("\n")
#Post-hoc
#Lin’s contrasts (dùng trimmed data)
cat("---- Post-hoc trimmed contrasts (lincon) ----\n")
res_post <- lincon(Memory_Bandwidth ~ Manufacturer,
                   data = gpu_clean,
                   tr = 0.2,
                   alpha = 0.05)
print(res_post)
cat("\n---- End of ANOVA analysis ----\n")
#p-value xấp xỉ bằng 0
#=>Có sự khác biệt rõ ràng giữa ít nhất 2 manufacturer, với effect size lớn (0.62)
#=>Post-hoc khẳng định mọi cặp trong bốn nhóm đều có trimmed-mean khác nhau có ý nghĩa (mọi p < 0.0001)
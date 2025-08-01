library(caret)
library(ggplot2)

set.seed(123)
train_index <- createDataPartition(gpu_clean$Memory_Bandwidth, p = 0.7, list = FALSE)

train_data <- gpu_clean[train_index, ]
test_data <- gpu_clean[-train_index, ]

# Xây dựng mô hình hồi quy bội
model_1 <- lm(Memory_Bandwidth ~ Memory + Process + Memory_Speed + Memory_Bus, data = train_data)
summary(model_1)

# Tính sai số (residuals)
train_residuals <- residuals(model_1)

# Tính x (mean), s (standard deviation), n (sample size), z (quantile for 95% CI)
mean_x <- mean(train_residuals)
sd_x <- sd(train_residuals)
n_x <- length(train_residuals)
z_alphachia2 <- qnorm(p = 0.05 / 2, lower.tail = FALSE)

# Hiển thị bảng thông số
data.frame(mean_x, sd_x, n_x, z_alphachia2)

# Dự đoán với tập test
test_data$Memory_Bandwidth_Predict <- predict(model_1, newdata = test_data)
head(test_data, 5)

# Tính RMSE
rmse <- sqrt(mean((test_data$Memory_Bandwidth - test_data$Memory_Bandwidth_Predict)^2))
print(paste("RMSE:", rmse))

# Tính R-squared
r_squared <- 1 - (sum((test_data$Memory_Bandwidth - test_data$Memory_Bandwidth_Predict)^2) /
                    sum((test_data$Memory_Bandwidth - mean(test_data$Memory_Bandwidth))^2))
print(paste("R-squared:", r_squared))

par(mfrow = c(2, 2))  # Bố cục 2x2
plot(model_1)


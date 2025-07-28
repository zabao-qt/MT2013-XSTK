# ------------------------------ KHAI BÁO THƯ VIỆN ------------------------------ #
library(dplyr)
library(stringr)
library(GGally)
library(ggplot2)

# ------------------------------ PHẦN 3. XỬ LÝ DỮ LIỆU ------------------------------ #
source("data_preprocessing.R")                              # Làm sạch dữ liệu

# ------------------------------ PHẦN 4. THỐNG KÊ MÔ TẢ ------------------------------ #
source("descriptive_stats/split_variable_types.R")          # Chia dữ liệu dưới dạng định lượng, định tính

# ==== CÁC ĐẶC TRƯNG CỦA MẪU ==== #
source("descriptive_stats/data_summary.R")

pdf("ggplots.pdf", width = 8, height = 6)                   # Vẽ biểu đồ trong thành file pdf
# ==== DỮ LIỆU ĐỊNH TÍNH ==== #
source("descriptive_stats/Bar_Plot_of_GPU_Manufacturer.R")  # Bar Plot of GPU Manufacturer

# ==== DỮ LIỆU ĐỊNH LƯỢNG ==== #
source("descriptive_stats/Histogram_of_Core_Speed.R")       # Histogram of Core Speed
source("descriptive_stats/Histogram_of_Memory_Bandwidth.R") # Histogram of Memory Bandwidth
source("descriptive_stats/Histogram_of_Memory_Speed.R")     # Histogram of Memory_Speed
source("descriptive_stats/Histogram_of_Memory_Bus.R")       # Histogram of Memory_Bus
source("descriptive_stats/Histogram_of_Process.R")          # Histogram of Process
source("descriptive_stats/Histogram_of_Max_Power.R")        # Histogram of Max Power
source("descriptive_stats/Histogram_of_TMUs.R")             # Histogram of TMUs
source("descriptive_stats/Histogram_of_ROPs.R")             # Histogram of ROPs

# ==== BIỂU ĐỒ TƯƠNG QUAN GIỮA CÁC CẶP DỮ LIỆU ĐỊNH LƯỢNG ==== #
pairs(quantitative_data, main = "Pairs Plot of Numeric Data", pch = 16, col = "blue") # Biểu đồ Scatter plots

### Biểu đồ tương quan giữa 2 biến
source("descriptive_stats/Plot_Process_vs_Max_Power.R")     # Biểu đồ Process vs Max Power
source("descriptive_stats/Plot_Process_vs_Core_Speed.R")    # Biểu đồ Process vs Core Speed

dev.off() # Đóng file pdf



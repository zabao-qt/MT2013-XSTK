library(dplyr)
library(stringr)
library(ggplot2)

# PHAN 3 tien xu ly so lieu
data<-read.csv("All_GPUs.csv")
head(data)

gpu <- data[, c("Core_Speed", "Manufacturer", "Memory", "Memory_Bandwidth", "Memory_Speed", "Memory_Bus", "Process", "Max_Power", "TMUs", "ROPs")]
head(gpu)

gpu_clean <- gpu

gpu_clean$Core_Speed <- as.numeric(str_remove(gpu_clean$Core_Speed, " MHz"))
gpu_clean$Memory_Speed <- as.numeric(str_remove(gpu_clean$Memory_Speed, " MHz"))
gpu_clean$Memory_Bandwidth <- as.numeric(str_remove(gpu_clean$Memory_Bandwidth, "GB/sec"))
gpu_clean$Max_Power <- as.numeric(str_remove(gpu_clean$Max_Power, " Watts"))
gpu_clean$Memory_Bus <- as.numeric(str_remove(gpu_clean$Memory_Bus, " Bit"))
gpu_clean$Process <- as.numeric(str_remove(gpu_clean$Process, "nm"))
gpu_clean$Memory <- as.numeric(str_remove(gpu_clean$Memory, " MB"))

head(gpu_clean)


apply(is.na(gpu_clean),2,sum)
apply(is.na(gpu_clean),2,mean)


gpu_clean <- gpu_clean %>% 
  filter(!is.na(Memory_Speed), 
         !is.na(Memory_Bandwidth), 
         !is.na(Memory_Bus))

cols_median_fill <- c("Core_Speed", "Process", "Max_Power", "TMUs", "Memory")

for (col in cols_median_fill) {
  median_value <- median(gpu_clean[[col]], na.rm = TRUE)
  gpu_clean[[col]][is.na(gpu_clean[[col]])] <- median_value
}

apply(is.na(gpu_clean),2,sum)
apply(is.na(gpu_clean),2,mean)

# View(gpu_clean)
# PHAN 4 Thong ke ta
barplot(
  table(gpu_clean$Manufacturer),
  xlab = "Manufacturer",
  ylab = "Frequency",
  main = "Bar Plot of GPU Manufacturer",
  col = "steelblue",
  border = "black"
)

boxplot(Max_Power ~ Manufacturer,
        data = gpu_clean,
        xlab = "Manufacturer",
        ylab = "Max_Power",
        main = "Manufacturer vs TMUs",
        pch = 20,
        cex = 1.5,
        col = "lightgreen",
        border = "black")

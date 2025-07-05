library(dplyr)
library(stringr)

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

summary(gpu_clean)


apply(is.na(gpu_clean),2,sum)
apply(is.na(gpu_clean),2,mean)



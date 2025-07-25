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
gpu_clean$ROPs <- ifelse(
  str_detect(gpu_clean$ROPs, "\\(x2\\)"),
  as.numeric(str_extract(gpu_clean$ROPs, "\\d+")) * 2,
  as.numeric(str_extract(gpu_clean$ROPs, "\\d+"))
)

summary(gpu_clean)


apply(is.na(gpu_clean),2,sum)
apply(is.na(gpu_clean),2,mean)


gpu_clean <- gpu_clean %>% 
  filter(!is.na(Memory_Speed), 
         !is.na(Memory_Bandwidth), 
         !is.na(Memory_Bus))

gpu_clean$Core_Speed[is.na(gpu_clean$Core_Speed)] <- median(gpu_clean$Core_Speed, na.rm = TRUE)
gpu_clean$Process[is.na(gpu_clean$Process)] <- median(gpu_clean$Process, na.rm = TRUE)
gpu_clean$Max_Power[is.na(gpu_clean$Max_Power)] <- median(gpu_clean$Max_Power, na.rm = TRUE)
gpu_clean$TMUs[is.na(gpu_clean$TMUs)] <- median(gpu_clean$TMUs, na.rm = TRUE)
gpu_clean$Memory[is.na(gpu_clean$Memory)] <- median(gpu_clean$Memory, na.rm = TRUE)
gpu_clean$ROPs[is.na(gpu_clean$ROPs)] <- median(gpu_clean$ROPs, na.rm = TRUE)


apply(is.na(gpu_clean),2,sum)
apply(is.na(gpu_clean),2,mean)
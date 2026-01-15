#------------Imports--------
library(tidyverse)
library(readxl)
library(ggplot2)
library(dplyr)
library(forcats)

data_original <- read_xlsx("dataset.xlsx")
summary(data_original)

#--------Cleaning and Organization----------
#Check data classes -- variable types, Mouse IDs
sapply(data_original, class) # --> All values numeric

#remove mice excluded from analysis (9.4, 10.5, 12.2, 12.4, 13.4)
remove_mice <- function(data_original, box_num, mouse_num){
  data_subset <- subset(data_original, !(Box==box_num & Mouse==mouse_num))
}
data_clean <- remove_mice(data_original, 9,4)
data_clean <- remove_mice(data_clean, 10,5)
data_clean <- remove_mice(data_clean, 12,2)
data_clean <- remove_mice(data_clean, 12,4)
data_clean <- remove_mice(data_clean, 13,4)
nrow(data_original)
nrow(data_clean)

#remove R.gam and S.gam
data_clean <- data_clean |>
  select(-R.gam, -S.gam)

#change Box and Mouse into factors
data_clean <- data_clean |> mutate(
  Box = as.factor(Box),
  Mouse = as.factor(Mouse),
  Mouse_ID = as.factor(paste(Box, Mouse, sep = "_")) #Unique identifier
)
summary(data_clean)

# merge R_asex and S_asex
data_clean <- pivot_longer(
  data_clean,
  cols = c(R.asex, S.asex), 
  names_to = "Strain", 
  values_to = "Density"
)
head(data_clean)

#Check NA values
sum(is.na(data_clean)) # No NA values

#log10 transform data
data_clean <- data_clean |>
  mutate(
    log_density = log10(Density + 1)
  )

#----------------Check for zeros in RBC and Weight-------------
ggplot(data_clean, aes(x = Day, y = RBC)) +
  geom_point(aes(color = RBC == 0), alpha = 0.5) +
  scale_color_manual(values = c("black", "red"), labels = c("Live", "Zero")) +
  theme_minimal() +
  labs(title = "RBC Zeros over Time")

ggplot(data_clean, aes(x = Day, y = Weight)) +
  geom_point(aes(color = RBC == 0), alpha = 0.5) +
  scale_color_manual(values = c("darkblue", "red"), labels = c("Live", "Zero")) +
  theme_minimal() +
  labs(title = "Weight Zeros over Time")

#------------------- Parasite Anomalies ----------------
# daily-fold change of parasite density/day -> one parasite should be making 8 progeny per day
data_clean <- data_clean |>
  arrange(Mouse_ID, Strain, Day) |>
  group_by(Mouse_ID, Strain) |>
  mutate(
    log_growth = log_density - lag(log_density)
  ) |>
  filter(!is.na(log_growth))

ggplot(data_clean, aes(x = Day, y = log_growth)) +
  geom_point(alpha = 0.4, color = "steelblue") +
  geom_hline(yintercept = log10(8), linetype = "dashed", color = "red") + 
  labs(title = "Daily Parasite Growth (Log Scale)",
       y = "Change in Log10 Density") +
  theme_minimal()

total_anomalies <- sum(data_clean$log_growth > log10(8), na.rm = TRUE)
print(paste("Total biological anomalies found:", total_anomalies))

# Mask impossible growth values as NA
data_clean <- data_clean |>
  mutate(
    log_growth = ifelse(log_growth > log10(8), NA, log_growth)
  )
sum(is.na(data_clean$log_growth))

#Check fold change after removing anomalies
ggplot(data_clean, aes(x = Day, y = log_growth)) +
  geom_point(alpha = 0.4, color = "steelblue") +
  geom_hline(yintercept = log10(8), linetype = "dashed", color = "red") + 
  labs(title = "Daily Parasite Growth (Log Scale)",
       y = "Change in Log10 Density") +
  theme_minimal()

#-----------------------Save as .rds-----------------------
saveRDS(data_clean, file="cleaned_malaria_data.rds")


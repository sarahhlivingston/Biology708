
# Imports
library(tidyverse)
library(readxl)
library(ggplot2)
library(dplyr)

data <- read_xlsx("dataset.xlsx")
head(data)
summary(data)

#------------------------------------
#Max RBC Loss for the untreated competition group vs the untreated control group
#drop from the baseline (Day 3) to the lowest RBC count.

calc_max_loss <- function(box_num,variable) {
  subset_data <- subset(data, Box == box_num)
  loss_stats <- subset_data %>%
  group_by(Mouse) %>%
    summarize(
    baseline = first({{variable}}), #{{}} -> makes sure it reads as col name not a random variable
    min = min({{variable}}, na.rm = TRUE),
    max_loss = baseline - min
  )
  return(loss_stats)
}
# Loss stats: Mouse, baseline, min, max_loss

competition_group_rbc <- calc_max_loss(13, RBC) 
control_group_rbc <- calc_max_loss(4, RBC)
competition_group_weight <- calc_max_loss(1, Weight)
control_group_weight <- calc_max_loss(4, Weight)

#cat = concatenate and print (like f-string)
cat("Average max RBC loss in competition:", mean(competition_group_rbc$max_loss), "x 10^6 / ul blood ","\n")
cat("Average max RBC loss alone:", mean(control_group_rbc$max_loss), "x 10^6 / ul blood ","\n")
cat("Average max weight loss in competition:", mean(competition_group_weight$max_loss), "g","\n")
cat("Average max weight loss alone:", mean(control_group_weight$max_loss),"g", "\n")

t_result_rbc <- t.test(competition_group_rbc$max_loss, control_group_rbc$max_loss)
print(t_result_rbc)

t_result_weight <- t.test(competition_group_weight$max_loss, control_group_weight$max_loss)
print(t_result_weight)

#### Output #####
# data:  competition_group_rbc$max_loss and control_group_rbc$max_loss
# t = 4.7278, df = 6.5131, p-value = 0.002596
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#   0.9859021 3.0204979
# sample estimates:
#   mean of x mean of y 
# 7.9360    5.9328 

# data:  competition_group_weight$max_loss and control_group_weight$max_loss
# t = -0.40999, df = 7.2597, p-value = 0.6936
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#   -2.421332  1.701332
# sample estimates:
#   mean of x mean of y 
# 2.06      2.42








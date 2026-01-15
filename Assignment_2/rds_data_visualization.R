library(ggplot2)

#Load data
data <- readRDS("cleaned_malaria_data.rds")

# Calculate minimum RBC for living mice only
health_summary <- data |>
  filter(RBC > 0) |> 
  group_by(Box, Mouse_ID) |>
  summarize(min_rbc = min(RBC, na.rm = TRUE), .groups = "drop")
head(health_summary)

# boxplot (min RBC vs box)
ggplot(health_summary, aes(x = Box, y = min_rbc, fill = Box)) +
  geom_boxplot() +
  labs(title = "Infection Severity by Treatment Box",
       y = "Minimum RBC Count (Live)") +
  theme_minimal()
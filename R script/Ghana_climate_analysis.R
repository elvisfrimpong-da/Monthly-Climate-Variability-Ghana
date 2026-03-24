# displaying the structure of the dataset
str(ghana_weather_final)

#displaying the first 5 rows
head(ghana_weather_final)

#converting month to a factor
ghana_weather_final$Month <- as.factor(ghana_weather_final$Month)


# splitting thje dataset according to month automatically
monthly_data <- split(ghana_weather_final, ghana_weather_final$Month)

#crosschecking the dataset
#viewing the names of the dataset
names(monthly_data)

#viewing the Jan dataset only
View(monthly_data$Jan)

#viewing the Feb dataset only
View(monthly_data$Feb)

#viewing the Mar dataset only
View(monthly_data$Mar)

#Viewing the Dec dataset only
View(monthly_data$Dec)


#checking the number of observations each month has
sapply(monthly_data, nrow)

#loading the libraries for graph plotting
library(ggplot2)
library(dplyr)

#installing the libraries needed
install.packages("ggplot2")
install.packages("dplyr")
install.packages("tidyr")

# setting the correct month order
ghana_weather_final$Month <- factor(
  ghana_weather_final$Month,
  levels = c("Jan","Feb","Mar","Apr","May","Jun",
             "Jul","Aug","Sep","Oct","Nov","Dec")
)

# Creating a 12 rainfall trend plots (one per month) across the year
ggplot(ghana_weather_final, aes(x = Year, y = Rainfall_mm)) +
  geom_point(color = "steelblue", alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  facet_wrap(~ Month, ncol = 4) +
  labs(
    title = "Monthly Rainfall Trends in Ghana",
    x = "Year",
    y = "Rainfall (mm)"
  ) +
  theme_minimal(base_size = 12)

#saving the plot for my report
ggsave("monthly_rainfall_trends_across_years.png", width = 12, height = 8)


#A rainfall anomaly shows: Actual Rainfall − Long-term Average Rainfall
#calculating the long term average rainfall
mean(ghana_weather_final$Rainfall_mm, na.rm = TRUE)

#calculating rainfall anormalies
rain_anomaly <- ghana_weather_final %>%
  group_by(Month) %>%
  mutate(
    mean_rain = mean(Rainfall_mm, na.rm = TRUE),
    anomaly = Rainfall_mm - mean_rain
  )

#long term average ranfall by month
library(dplyr)

monthly_average <- ghana_weather_final %>%
  group_by(Month) %>%
  summarise(
    long_term_avg = mean(Rainfall_mm, na.rm = TRUE)
  )

#displaying the long term average rainfall by month
monthly_average

#rainfall anormaly plot
library(ggplot2)

ggplot(rain_anomaly, aes(x = Year, y = anomaly, fill = anomaly > 0)) +
  geom_col() +
  geom_hline(yintercept = 0, linetype = "dashed") +
  facet_wrap(~ Month, ncol = 4) +
  scale_x_continuous(
    breaks = seq(min(rain_anomaly$Year),
                 max(rain_anomaly$Year), 1)
  ) +
  scale_fill_manual(values = c("red", "blue"), guide = "none") +
  labs(
    title = "Monthly Rainfall Anomalies in Ghana",
    x = "Year",
    y = "Rainfall Anomaly (mm)"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

#A bar chart showing the Long term average monthly rainfall
ggplot(monthly_average, aes(x = Month, y = long_term_avg)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(
    title = "Long-Term Average Monthly Rainfall in Ghana",
    x = "Month",
    y = "Average Rainfall (mm)"
  ) +
  theme_minimal()

library(dplyr)

#a table identifying the wettest and driest month
rain_extremes <- ghana_weather_final %>%
  group_by(Month) %>%
  summarise(
    Wettest_Year = Year[which.max(Rainfall_mm)],
    Max_Rainfall = max(Rainfall_mm, na.rm = TRUE),
    Driest_Year = Year[which.min(Rainfall_mm)],
    Min_Rainfall = min(Rainfall_mm, na.rm = TRUE)
  )

rain_extremes
write.csv(rain_extremes, "monthly_rainfall_extremes.csv", row.names = FALSE)


#calculating the rainfall statistics for each month, mean, sd, and cv
library(dplyr)

rain_stats <- ghana_weather_final %>%
  group_by(Month) %>%
  summarise(
    Mean_Rainfall = mean(Rainfall_mm, na.rm = TRUE),
    SD_Rainfall = sd(Rainfall_mm, na.rm = TRUE),
    CV = (SD_Rainfall / Mean_Rainfall) * 100
  )

rain_stats

# plotting the cofficient of variation of monthly rainfall
ggplot(rain_stats, aes(x = Month, y = CV)) +
  geom_bar(stat = "identity", fill = "orange") +
  geom_hline(yintercept = 30, linetype = "dashed", color = "red", linewidth = 1) +
  labs(
    title = "Coefficient of Variation of Monthly Rainfall",
    x = "Month",
    y = "CV (%)"
  ) +
  theme_minimal()

#Rainfall Concentration Index, tells us how rainfall is distributed through the year
#calculating the total rainfall for each month per year
library(dplyr)

yearly_rain <- ghana_weather_final %>%
  group_by(Year) %>%
  summarise(
    total_rain = sum(Rainfall_mm, na.rm = TRUE)
  )

# calculating Rainfall Concentration Index
rci <- ghana_weather_final %>%
  group_by(Year) %>%
  summarise(
    RCI = (sum(Rainfall_mm^2) / (sum(Rainfall_mm)^2)) * 100
  )

rci

# plotting the Rainfall Concentration Index
library(ggplot2)

ggplot(rci, aes(x = Year, y = RCI)) +
  geom_line(color = "blue", linewidth = 1) +
  geom_point(size = 3, color = "darkblue") +
  geom_text(aes(label = round(RCI,1)), vjust = -0.7, size = 3) +
  geom_hline(yintercept = 20, linetype = "dashed", color = "red") +
  labs(
    title = "Rainfall Concentration Index in Ghana",
    x = "Year",
    y = "RCI"
  ) +
  theme_minimal()

# calculating the mean rainfall for each month
library(dplyr)

monthly_mean <- ghana_weather_final %>%
  group_by(Month, Month_Num) %>%
  summarise(
    Mean_Rainfall = mean(Rainfall_mm, na.rm = TRUE)
  ) %>%
  arrange(Month_Num)

# creating a clean seasonality diagram
library(ggplot2)

ggplot(monthly_mean, aes(x = Month_Num, y = Mean_Rainfall)) +
  geom_line(color = "blue", linewidth = 1.2) +
  geom_point(size = 3, color = "darkblue") +
  geom_text(aes(label = round(Mean_Rainfall,1)), vjust = -0.8, size = 3) +
  scale_x_continuous(
    breaks = monthly_mean$Month_Num,
    labels = monthly_mean$Month
  ) +
  labs(
    title = "Seasonality of Rainfall in Ghana",
    x = "Month",
    y = "Mean Rainfall (mm)"
  ) +
  theme_minimal(base_size = 14)

# computing the Standardized Precipation Index (SPI) to detect drought and wet years
#installing the libraries
install.packages("SPEI")
#loading the library
library(SPEI)
#preparing the rainfall data
rain_ts <- ts(ghana_weather_final$Rainfall_mm,
              start = c(min(ghana_weather_final$Year),1),
              frequency = 12)

# calculate SPI ( 1-month scale)
spi_1 <- spi(rain_ts, scale = 1)

# plotting the SPI index
plot(spi_1)

#Extract SPI values for analysis
spi_values <- spi_1$fitted
head(spi_values)


#creating a SPI plot with ggplot
spi_df <- data.frame(
  YearMonth = time(rain_ts),
  SPI = spi_1$fitted
)

spi_1
spi_values <- spi_1$fitted
spi_df <- data.frame(
  Time = time(spi_values),
  SPI = as.numeric(spi_values)
)
head(spi_df)


#Plotting the stanaderized Precipitation index (SPI)
library(ggplot2)

ggplot(spi_df, aes(x = Time, y = SPI)) +
  geom_col(fill = "steelblue") +
  geom_hline(yintercept = 0, color = "black", linewidth = 1) +
  geom_hline(yintercept = -1, linetype = "dashed", color = "red", linewidth = 0.8) +
  geom_hline(yintercept = 1, linetype = "dashed", color = "blue", linewidth = 0.8) +
  labs(
    title = "Standardized Precipitation Index (SPI)",
    x = "Time",
    y = "SPI"
  ) +
  theme_minimal()


# ------------------------------------------------
# Monthly Rainfall Distribution Boxplot
# This script visualizes rainfall distribution
# across the 12 months in Ghana


# Step 1: Convert Month to an ordered factor
# This ensures months appear from Jan → Dec
ghana_weather_final$Month <- factor(
  ghana_weather_final$Month,
  levels = c("Jan","Feb","Mar","Apr","May","Jun",
             "Jul","Aug","Sep","Oct","Nov","Dec")
)

# Step 2: Generate the boxplot
boxplot(Rainfall_mm ~ Month,
        data = ghana_weather_final,
        
        # Plot title
        main = "Monthly Rainfall Distribution in Ghana",
        
        # Axis labels
        xlab = "Month",
        ylab = "Rainfall (mm)",
        
        # Professional color scheme
        col = "lightblue",
        border = "darkblue"
)

# Run one-way ANOVA
anova_model <- aov(Rainfall_mm ~ Month, data = ghana_weather_final)

# Display ANOVA summary
summary(anova_model)
par(mfrow=c(2,2))
plot(anova_model)

#---------------------------------------------------
# Tukey HSD Pairwise Comparison for Monthly Rainfall
#---------------------------------------------------

# Run Tukey HSD test on the ANOVA model
tukey_results <- TukeyHSD(anova_model)

# View the results
tukey_results
#---------------------------------------------------
# Convert Tukey output to a dataframe
#---------------------------------------------------

tukey_df <- as.data.frame(tukey_results$Month)

# Add comparison names as a column
tukey_df$Comparison <- rownames(tukey_df)

# View table
tukey_df
#---------------------------------------------------
# Extract only statistically significant comparisons
#---------------------------------------------------

significant_pairs <- subset(tukey_df, `p adj` < 0.05)

significant_pairs
#---------------------------------------------------
# Plot Tukey HSD confidence intervals
#---------------------------------------------------

plot(tukey_results,
     las = 1,                 # horizontal labels
     col = "blue",
     main = "Tukey HSD Pairwise Comparison of Monthly Rainfall")
#---------------------------------------------------
# Plot Tukey HSD confidence intervals
#---------------------------------------------------
library(ggplot2)

ggplot(tukey_df, aes(x = diff, y = reorder(Comparison, diff))) +
  geom_point(color = "darkblue") +
  geom_errorbarh(aes(xmin = lwr, xmax = upr), height = 0.2) +
  geom_vline(xintercept = 0, linetype = "dashed", color = "red") +
  labs(
    title = "Tukey HSD Pairwise Comparison of Monthly Rainfall",
    x = "Mean Difference in Rainfall (mm)",
    y = "Month Comparison"
  ) +
  theme_minimal()

# ------------------------------------------------
# Monthly Rainfall Trends Across Years
# This plot shows rainfall variation over time
# for each month separately
# ------------------------------------------------

library(ggplot2)

ggplot(ghana_weather_final, aes(x = Year, y = Rainfall_mm)) +
  geom_line(color = "steelblue") +
  geom_point(size = 2) +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  facet_wrap(~ Month, ncol = 4) +
  labs(
    title = "Monthly Rainfall Trends in Ghana",
    x = "Year",
    y = "Rainfall (mm)"
  ) +
  theme_minimal()

# ------------------------------------------------
# Run linear regression for rainfall trends
# within each month
# ------------------------------------------------

monthly_trends <- ghana_weather_final |>
  split(ghana_weather_final$Month)

trend_models <- lapply(monthly_trends, function(df) {
  lm(Rainfall_mm ~ Year, data = df)
})

# View regression summaries
lapply(trend_models, summary)

# Extract slope coefficients
trend_slopes <- sapply(trend_models, function(model) coef(model)[2])

trend_slopes

install.packages("Kendall")
library(Kendall)

# Split dataset by month
monthly_data <- split(ghana_weather_final, ghana_weather_final$Month)

# Run Mann-Kendall test for each month
mk_results <- lapply(monthly_data, function(df) {
  MannKendall(df$Rainfall_mm)
})

# View results
mk_results

mk_summary <- data.frame(
  Month = names(mk_results),
  Tau = sapply(mk_results, function(x) x$tau),
  p_value = sapply(mk_results, function(x) x$sl)
)

mk_summary

library(ggplot2)

ggplot(mk_summary, aes(x = Month, y = Tau)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  labs(
    title = "Mann-Kendall Trend Statistics for Monthly Rainfall",
    x = "Month",
    y = "Kendall Tau"
  ) +
  theme_minimal()

# -------------------------------------------------------
# Rainfall Variability Analysis using Coefficient of Variation
# -------------------------------------------------------

# Load required libraries
library(dplyr)
library(ggplot2)

# Step 1: Calculate mean rainfall, standard deviation, and CV for each month
rain_stats <- ghana_weather_final %>%
  group_by(Month) %>%
  summarise(
    Mean_Rainfall = mean(Rainfall_mm, na.rm = TRUE),
    SD_Rainfall = sd(Rainfall_mm, na.rm = TRUE),
    CV = (SD_Rainfall / Mean_Rainfall) * 100
  )

# View the calculated statistics
rain_stats

# -------------------------------------------------------
# Plot Monthly Rainfall Variability
# -------------------------------------------------------

ggplot(rain_stats, aes(x = Month, y = CV)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  geom_hline(yintercept = 30, linetype = "dashed", color = "red") +
  labs(
    title = "Coefficient of Variation of Monthly Rainfall",
    x = "Month",
    y = "Coefficient of Variation (%)"
  ) +
  theme_minimal()

# -------------------------------------------------------
# Save the figure as a high-resolution image
# -------------------------------------------------------

ggsave("rainfall_variability_cv.png",
       width = 10,
       height = 6,
       dpi = 300)

# Correlation between rainfall and average temperature
correlation_result <- cor.test(
  ghana_weather_final$Rainfall_mm,
  ghana_weather_final$Avg_Temp,
  method = "pearson"
)

correlation_result
ggplot(ghana_weather_final, aes(x = Avg_Temp, y = Rainfall_mm)) +
  
  geom_point(color = "steelblue", alpha = 0.7) +
  
  geom_smooth(method = "lm", color = "red", se = TRUE) +
  
  labs(
    title = "Relationship Between Rainfall and Temperature in Ghana",
    x = "Average Temperature (°C)",
    y = "Rainfall (mm)"
  ) +
  
  theme_minimal()

# Linear regression model
rain_temp_model <- lm(Rainfall_mm ~ Avg_Temp, data = ghana_weather_final)

summary(rain_temp_model)
ggplot(ghana_weather_final, aes(x = Avg_Temp, y = Rainfall_mm)) +
  
  geom_point(color = "steelblue", alpha = 0.7) +
  
  geom_smooth(method = "lm", color = "red", se = TRUE) +
  
  labs(
    title = "Relationship Between Rainfall and Temperature in Ghana",
    x = "Average Temperature (°C)",
    y = "Rainfall (mm)"
  ) +
  
  theme_minimal()
# Extract R-squared
r_squared <- summary(rain_temp_model)$r.squared
r_squared

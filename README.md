# Rainfall Variability and Prediction Analysis in Ghana

## Overview
This project presents a comprehensive analysis of rainfall patterns in Ghana using statistical methods, climate indices, and predictive modeling. The goal is to understand seasonal variability, detect trends, and explore the potential for rainfall prediction to support agricultural and environmental decision-making.

---

##  Objectives
- Analyze monthly rainfall trends and seasonal variability
- Test for statistically significant differences in rainfall across months
- Identify wet and dry periods using climate indices
- Evaluate rainfall variability and concentration patterns
- Explore the relationship between rainfall and temperature
- Develop a predictive model for future rainfall estimation

---

## Dataset
The dataset consists of **180 monthly observations** of climate data in Ghana, including:
- Rainfall (mm)
- Average Temperature (°C)
- Maximum Temperature (°C)
- Year and Month information

---

## 🔍 Exploratory Data Analysis (EDA)
- Examined rainfall distribution across months using boxplots
- Identified strong **seasonal rainfall patterns**
- Observed significant **interannual variability**
- Compared rainfall and temperature behavior

---

## 📈 Statistical Analysis
### ✔️ ANOVA
- Conducted one-way ANOVA to test differences in mean rainfall across months
- Result: **Significant variation across months (p < 0.001)**

### ✔️ Tukey HSD
- Identified specific months with statistically significant differences
- Confirmed clear seasonal rainfall contrasts

---

## 🌦️ Climate Indices
### ✔️ Rainfall Anomalies
- Detected deviations from long-term average rainfall
- Identified periods of unusually high and low rainfall

### ✔️ Standardized Precipitation Index (SPI)
- Classified drought and wet periods
- Highlighted temporal rainfall variability

### ✔️ Rainfall Concentration Index (RCI)
- Showed rainfall is **moderately concentrated in specific months**
- Confirms seasonal rainfall dependence

### ✔️ Coefficient of Variation (CV)
- Measured rainfall variability across months
- Higher variability observed during peak rainy seasons

---

## 📉 Trend Analysis
### ✔️ Linear Trend Analysis
- Estimated monthly rainfall trends over time
- Mixed trends observed across months

### ✔️ Mann-Kendall Test
- Confirmed statistically significant trends in selected months
- Identified both increasing and decreasing rainfall patterns

---

## 🌡️ Rainfall–Temperature Relationship
- Weak relationship observed between rainfall and temperature
- **R² ≈ 0.0028**, indicating temperature alone is not a strong predictor of rainfall

---

## 🤖 Predictive Modeling
### Model Features:
- Average Temperature
- Month (Seasonality)
- Year (Trend)
- Lagged Rainfall (Previous Month)

### Model Performance:
- **R² ≈ 0.078**
- **RMSE ≈ 13.77 mm**

### Key Insights:
- Model captures **seasonal rainfall patterns**
- Predictive power remains limited due to complex climate dynamics

---

## 🔮 Rainfall Projection (2040)
- Generated monthly rainfall predictions for the year 2040
- Used recursive approach with lagged rainfall
- Results show:
  - Increasing rainfall toward late months
  - Underestimation of rainfall magnitude

⚠️ *Predictions are indicative and should be interpreted with caution.*

---

## 🛠️ Tools and Technologies
- Python (Pandas, NumPy, Matplotlib, Scikit-learn)
- R (ggplot2, statistical tests)
- Google Colab
- Excel (data preprocessing)

---

## 📌 Key Takeaways
- Rainfall in Ghana is **highly seasonal and variable**
- Significant differences exist across months
- Rainfall trends are **inconsistent across time**
- Temperature alone does not explain rainfall variability
- Simple models capture patterns but struggle with accuracy

---

## ⚠️ Limitations
- Limited predictor variables
- Absence of key climatic drivers (e.g., humidity, pressure)
- Linear modeling assumptions
- Recursive prediction introduces cumulative error

---

## 🚀 Future Improvements
- Incorporate additional climate variables
- Apply machine learning and time-series models
- Expand dataset (longer time range, regional data)
- Improve prediction accuracy

---

## 🌍 Applications
- Agricultural planning
- Water resource management
- Climate risk assessment
- Policy and decision-making

---

## 👤 Author
**Frimpong Elvis**  
Data Analyst | Agricultural Engineer  

---

## ⭐ If you found this useful
Give this repo a star ⭐ and feel free to connect or collaborate!

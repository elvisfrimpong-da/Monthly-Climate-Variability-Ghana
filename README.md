# Monthly Climate Variability in Ghana

This project presents a statistical and exploratory analysis of monthly rainfall and temperature patterns in Ghana using satellite-derived climate data. The study focuses on seasonal and interannual variability with direct relevance to rain-fed agricultural decision-making.

---

## Project Objectives

The main objectives of this project are to:

- Examine monthly and seasonal variability in rainfall and temperature  
- Explore interannual rainfall patterns during agriculturally important periods  
- Prepare climate data for statistical testing and predictive modeling  
- Demonstrate applied skills in data cleaning, analysis, and research reporting  

---

## Data Description

### Raw Data

The raw dataset was downloaded from the **NASA POWER (Prediction of Worldwide Energy Resources)** database.  
It contains monthly climate observations for Ghana and has been preserved in its original format without modification.

**File:**
- `Raw_Dataset.xlsx`

The raw data are retained to ensure transparency and reproducibility.

---

### Processed Data

The processed dataset contains cleaned and analysis-ready climate data derived from the raw source. Data preparation involved restructuring the original wide-format data into a tidy, long-format structure suitable for statistical analysis.

**File:**
- `ghana_weather_final.csv`

The processed dataset includes the following variables:

- `Year` – Observation year  
- `Month` – Month name  
- `Month_Num` – Numeric month indicator (1–12)  
- `Rainfall_mm` – Monthly total rainfall (mm)  
- `Avg_Temp` – Monthly average air temperature (°C)  
- `Max_Temp` – Monthly maximum air temperature (°C)  

---

## Methodology Overview

The analysis follows a structured research workflow:

1. **Data Cleaning and Restructuring**  
   Raw climate data were cleaned and transformed using Microsoft Excel to ensure consistency, accuracy, and suitability for analysis.

2. **Exploratory Data Analysis (EDA)**  
   Visual and descriptive analysis was conducted to assess seasonal and interannual variability in rainfall and temperature.

3. **Statistical Analysis**  
   One-way Analysis of Variance (ANOVA) is applied to evaluate whether significant differences exist in mean rainfall across months.

4. **Predictive Modeling (Planned)**  
   Regression-based models will be implemented in Python to explore temporal patterns and demonstrate predictive analysis techniques.

---

## Tools and Technologies

- **Microsoft Excel** – Data cleaning and restructuring  
- **rStudio** – Exploratory analysis and statistical testing  
- **Python** – Predictive modeling and trend analysis  
- **GitHub** – Version control and reproducibility  

---

## Repository Contents

- `Raw_Dataset.xlsx` – Original unmodified climate data  
- `ghana_weather_final.csv` – Cleaned and analysis-ready dataset  
- `README.md` – Project documentation  

Additional scripts, figures, and reports will be added as analysis progresses.

---

## Relevance

This project demonstrates practical research and programming skills relevant to graduate-level study in:

- Agricultural and Environmental Sciences  
- Climate and Data Science  
- Applied Statistics and Research Methods  

---

## Author

**Elvis Frimpong**  
Agricultural Data Scientist  

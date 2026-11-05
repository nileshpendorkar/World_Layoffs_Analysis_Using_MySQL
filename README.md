# 🌎 World Layoffs Analysis Using MySQL

## Overview

This project analyzes global layoff trends using SQL and a real-world dataset containing layoffs from companies across multiple countries and industries between 2020 and 2023.

The project follows a complete data analytics workflow:

1. Data Cleaning & Preparation
2. Exploratory Data Analysis (EDA)
3. Trend Identification
4. Business Insights Generation

Using MySQL, I cleaned raw layoff data, addressed data quality issues, and performed exploratory analysis to uncover patterns in workforce reductions across industries, countries, funding stages, and time periods.

---

## Project Objectives

- Clean and prepare a real-world layoffs dataset for analysis.
- Remove duplicate and inconsistent records.
- Standardize text values and date formats.
- Analyze layoffs by company, industry, country, and year.
- Identify companies with the highest workforce reductions.
- Discover trends in layoffs over time.
- Apply advanced SQL techniques such as CTEs and Window Functions.
- Generate business insights from the data.

---

## Dataset Information

The dataset contains publicly reported layoff events from companies worldwide.

### Features

| Column | Description |
|----------|------------|
| company | Company name |
| location | Company location |
| industry | Industry category |
| total_laid_off | Number of employees laid off |
| percentage_laid_off | Percentage of workforce laid off |
| date | Layoff announcement date |
| stage | Company growth/funding stage |
| country | Country |
| funds_raised_millions | Funding raised (in millions) |

---

## Tools & Technologies

- MySQL
- MySQL Workbench
- SQL
- Window Functions
- Common Table Expressions (CTEs)
- Aggregate Functions
- Data Cleaning Techniques
- Exploratory Data Analysis (EDA)

---

# Phase 1: Data Cleaning

Before performing analysis, the dataset was cleaned and standardized to improve reliability and consistency.

### Data Cleaning Tasks

✅ Created staging tables

✅ Removed duplicate records

✅ Standardized company names

✅ Standardized industry values

✅ Corrected country name inconsistencies

✅ Converted text dates into DATE format

✅ Handled NULL and blank values

✅ Populated missing industry values using self-joins

✅ Removed records with insufficient layoff information

✅ Dropped temporary helper columns

---

## SQL Concepts Used During Cleaning

```sql
ROW_NUMBER()
PARTITION BY
CTE (WITH)
TRIM()
STR_TO_DATE()
UPDATE
DELETE
ALTER TABLE
SELF JOIN
```

---

# Phase 2: Exploratory Data Analysis (EDA)

After cleaning the data, exploratory analysis was conducted to understand layoff patterns and identify meaningful business insights.

---

## Key Questions Explored

### 1. Which companies had the highest total layoffs?

Analyzed cumulative layoffs by company using aggregation functions.

### Key Findings

- Amazon
- Google
- Meta
- Salesforce
- Microsoft
- Uber
- Dell
- Cisco
- Twitter

were among the organizations with the largest reported layoffs.

---

### 2. Which industries were impacted the most?

Layoffs were grouped by industry to determine which sectors experienced the greatest workforce reductions.

### Most Impacted Industries

- Consumer
- Retail
- Transportation
- Finance
- Healthcare
- Food
- Real Estate

---

### 3. Which countries experienced the most layoffs?

The dataset was aggregated by country.

### Top Countries by Layoffs

1. United States
2. India
3. Netherlands
4. Sweden
5. Brazil
6. Germany
7. United Kingdom

The United States accounted for the largest number of reported layoffs.

---

### 4. How did layoffs change over time?

Layoffs were analyzed using yearly and monthly trends.

### Observations

- 2020 saw significant layoffs during the pandemic period.
- 2021 showed temporary recovery and slower workforce reductions.
- 2022 experienced a major increase in layoffs.
- Early 2023 already exceeded expectations with substantial workforce cuts.

---

### 5. Which company stage was most affected?

Companies were grouped by funding and business stage.

### Finding

Companies in the **Post-IPO** stage recorded the highest number of layoffs, indicating that larger publicly traded organizations contributed significantly to workforce reductions.

---

### 6. Which companies completely shut down?

Records where:

```sql
percentage_laid_off = 1
```

were analyzed.

These represented companies that laid off 100% of their workforce, often indicating company shutdowns or complete business closures.

---

## Monthly Trend Analysis

A Year-Month aggregation was created to analyze layoffs over time.

This enabled:

- Monthly trend tracking
- Time-series analysis
- Identification of major layoff periods

---

## Rolling Total Analysis

A cumulative rolling total was calculated using SQL Window Functions.

### Example

```sql
SUM(total_laid_off)
OVER(ORDER BY month)
```

This analysis revealed a steady increase in layoffs throughout the dataset period and highlighted periods of accelerated workforce reductions.

---

## Ranking Top Companies by Year

To identify the largest layoffs each year, multiple CTEs and a Window Function were used.

### SQL Concepts

```sql
WITH
DENSE_RANK()
OVER()
PARTITION BY
```

### Example Results

#### 2020

- Uber
- Booking.com
- Groupon
- Airbnb

#### 2021

- ByteDance
- Katerra
- Zillow

#### 2022

- Meta
- Amazon
- Cisco
- Peloton
- Carvana

#### 2023

- Google
- Microsoft
- Amazon
- Salesforce
- Dell

---

# Key Business Insights

### Insight 1

Large technology companies accounted for a significant portion of reported layoffs.

### Insight 2

Layoffs accelerated dramatically during 2022 and continued into 2023.

### Insight 3

Post-IPO companies experienced the largest workforce reductions.

### Insight 4

The United States reported substantially more layoffs than any other country in the dataset.

### Insight 5

Consumer, Retail, Transportation, and Finance industries were heavily impacted.

### Insight 6

Several companies reported 100% workforce reductions, indicating complete shutdowns.

---

# SQL Skills Demonstrated

- Data Cleaning
- Data Wrangling
- Data Validation
- Exploratory Data Analysis
- Aggregate Functions
- CTEs
- Window Functions
- Self Joins
- Date Functions
- Ranking Functions
- Business Analysis
- Trend Analysis

---

## Project Structure

```

World-Layoffs-Analysis/
│
├── Data Cleaning SQL.sql
├── Exploratory Data Analysis.sql
├── layoffs.csv
└── README.md

```

---

## Conclusion

This project demonstrates an end-to-end SQL analytics workflow using a real-world layoffs dataset.

Starting with raw data, the project involved cleaning, transforming, and analyzing thousands of records to uncover workforce reduction trends across companies, industries, countries, and time periods.

The project highlights practical SQL skills commonly used by Data Analysts, including data cleaning, aggregations, CTEs, window functions, ranking methods, and time-series analysis, making it an excellent portfolio project that reflects real-world business analytics work.

---

## Author

**Nilesh Pendorkar**

Aspiring Data Analyst | SQL | Excel | Power BI | Python

GitHub: https://github.com/nileshpendorkar

LinkedIn: https://www.linkedin.com/in/nileshpendorkar/

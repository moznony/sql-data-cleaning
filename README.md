# SQL Data Cleaning Project: Layoffs 2022

Welcome to my first SQL data cleaning project! 🚀 This project explores data cleaning techniques using SQL on the **"Layoffs 2022"** dataset sourced from [Kaggle](https://www.kaggle.com/datasets/swaptr/layoffs-2022). The goal is to transform raw data into a clean, structured format suitable for analysis.

---

## Project Overview

The **Layoffs 2022** dataset tracks tech layoffs throughout 2022, including company details, the number of employees laid off, and other key information. This project focuses on:

1. Cleaning and standardizing data for consistency.
2. Handling missing and duplicate values.
3. Identifying trends in layoffs for further analysis.

---

## Dataset Details

The dataset contains the following columns:

| Column Name       | Description                                         |
|-------------------|-----------------------------------------------------|
| `Company`         | Name of the company that laid off employees         |
| `Date`            | Date of the layoffs                                 |
| `Industry`        | Industry the company belongs to                     |
| `Laid_Off_Count`  | Number of employees laid off                        |
| `Percentage`      | Percentage of total workforce affected by layoffs   |
| `Country`         | Country where the layoffs occurred                  |
| `Funding`         | Funding status of the company                       |

---

## Tools & Techniques

This project uses the following:

- **Database**: MySQL/PostgreSQL/SQLite (choose one based on your usage).
- **Key SQL Commands**:
  - Data Selection: `SELECT`, `WHERE`, `GROUP BY`
  - Data Transformation: `UPDATE`, `CASE`, `CAST`
  - Data Cleaning: `DELETE`, `COALESCE`, `IS NULL`
  - Data Analysis: Aggregation functions (`SUM`, `AVG`, `COUNT`)
- **Cleaning Techniques**:
  - Resolving inconsistent date formats.
  - Standardizing company and country names.
  - Handling outliers in `Laid_Off_Count` and `Percentage`.

---

## Project Highlights

Key cleaning steps include:

- **Missing Data**: Addressed null values in critical columns like `Industry` and `Country`.
- **Duplicates**: Removed duplicate records for accurate analysis.
- **Outlier Detection**: Analyzed outliers in `Percentage` to ensure logical values.
- **Date Standardization**: Converted all date values to a uniform format (`YYYY-MM-DD`).

---

## Results

- Cleaned dataset with consistent and reliable data for analysis.
- Highlighted trends, such as:
  - Industries with the highest layoffs.
  - Countries most affected.
  - Monthly breakdown of layoffs.

---

## How to Use

1. ## How to Use

1. Clone this repository:  
   ```bash
   git clone https://github.com/moznony/sql-data-cleaning.git

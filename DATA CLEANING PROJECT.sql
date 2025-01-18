-- SQL Project - Data Cleaning
-- https://www.kaggle.com/datasets/swaptr/layoffs-2022 

-- 1. Check for duplicates and remove any
-- 2. Standardize data and fix errors
-- 3. Look at null values and see what 
-- 4. Remove any columns and rows that are not necessary 


-- Dataset Preview
SELECT * 
FROM world_layoffs.layoffs;


-- (1) -- CHECKING FOR DUPLICATES AND REMOVING IF ANY

-- Dataset Preparation
CREATE TABLE layoffs_staging
LIKE layoffs;

INSERT layoffs_staging
SELECT *
FROM layoffs;

SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, total_laid_off, percentage_laid_off,`date`, stage, funds_raised_millions
) AS row_num
FROM layoffs_staging;

-- Creating a CTE to Indetify Duplicates)
WITH duplicate_cte AS(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, total_laid_off, percentage_laid_off,`date`, stage, funds_raised_millions
) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- Creating another table to remove duplicates
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, total_laid_off, percentage_laid_off,`date`, stage, funds_raised_millions
) AS row_num
FROM layoffs_staging;

-- Identifying & Deleting Duplicates 
SELECT *
FROM layoffs_staging2
WHERE row_num >= 2;

DELETE
FROM layoffs_staging2
WHERE row_num > 1;


-- (2) -- STANDARDIZING THE DATA
SELECT DISTINCT company, (trim(company))
from layoffs_staging2;

UPDATE layoffs_staging2
set company = TRIM(company);

SELECT DISTINCT industry
from layoffs_staging2
ORDER BY 1;

SELECT *
from layoffs_staging2
WHERE industry LIKE 'crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'crypto%';

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
order by 1;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

SELECT `date`,
str_to_date(`date`, '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = str_to_date(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;


-- (3) -- REPOPULATING NULL OR EMPTY VALUES

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL OR '';

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry LIKE '';

SELECT t1.industry, t2.industry
FROM layoffs_staging2 AS t1
JOIN layoffs_staging2 AS t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2 AS t1
JOIN layoffs_staging2 AS t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;


-- (4) -- REMOVING NULL VALUES AND UNWANTED COLUMNS

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;
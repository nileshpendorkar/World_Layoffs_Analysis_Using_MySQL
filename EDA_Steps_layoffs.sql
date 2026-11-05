-- EXPLORATORY DATA ANALYSIS

SELECT * FROM layoffs_copy2;

SELECT MAX(total_laid_off) FROM layoffs_copy2;      -- one company laid off 12000 employees on a single day

-- looking for the companies who has complitly laid off their 100% employees
select * 
from layoffs_copy2
where percentage_laid_off = 1
order by total_laid_off desc;

-- looking for the heavily funded companies
select company, funds_raised_millions
from layoffs_copy2
where percentage_laid_off = 1
order by funds_raised_millions desc;

-- duration 
select min(`date`), max(`date`)
FROM layoffs_copy2;
-- looking for top laying off companies 
-- duration 3 years
select company, sum(total_laid_off)
from layoffs_copy2
group by company
order by 2 desc;


-- WHAT COUNTRY GOT HIT OF THE MOST LAYOFFS
SELECT country, sum(total_laid_off)
from layoffs_copy2
group by country
order by 2 desc;

-- WHAT INDUSTRY GOT HIT OF THE MOST LAYOFFS
SELECT industry, sum(total_laid_off)
from layoffs_copy2
group by industry
order by 2 desc;

-- WHAT INDUSTRY GOT HIT OF THE low LAYOFFS
SELECT industry, sum(total_laid_off)
from layoffs_copy2
group by industry
order by 2;


-- YEARWISE LAYOFFS
SELECT YEAR(`date`), sum(total_laid_off)
from layoffs_copy2
group by YEAR(`date`)
order by 1 DESC;


-- SERIES_WISE COMPANIES LAYOFFS
SELECT stage, sum(total_laid_off)
from layoffs_copy2
group by stage
order by 1;

-- MONTH_WISE TOTAL LAID_OFFS

SELECT SUBSTRING(`date`, 1,7) as `MONTH`, SUM(total_laid_off)
FROM layoffs_copy2
group by 1
order by 1;

-- MONTH_WISE TOTAL LAID_OFFS

SELECT SUBSTRING(`date`, 1,7) as `MONTH`, SUM(total_laid_off)
FROM layoffs_copy2
group by 1
order by 1;

-- MONTH_WISE RUNNING TOTAL OF LAYOFFS	
WITH Rolling_Total AS (
						SELECT SUBSTRING(`date`, 1,7) as `MONTH`, 
							   SUM(total_laid_off) AS total_offs
						FROM layoffs_copy2
						group by 1
						order by 2
                        )
SELECT `MONTH`,total_offs, 
		SUM(total_offs) OVER(ORDER BY `MONTH`) as layoffs_running_Total 
FROM Rolling_Total;




-- create database world_layoffs
create database world_layoffs;

 -- IMPORT TABLE FROM directory
 USE world_layoffs;
	
SELECT * FROM layoffs;
 
											--    DATA CLEANING
                                             
											-- 1 REMOVE DUPLICATES

											-- 2 STANDERDISE THE DATA

											-- 3 NULL VALUES, BLANK VALUES

											-- 4 REMOVE UNWANTED COLUMNS AND ROWS

											
CREATE TABLE layoffs_copy1					
LIKE layoffs;

SELECT * FROM layoffs_copy1;
	
											
INSERT INTO layoffs_copy1					-- copying everything from real table to layoffs_copy1
SELECT * FROM layoffs;

SELECT * FROM layoffs_copy1; 


											-- adding row numbers to check duplicate dataset

SELECT *,
		ROW_NUMBER() OVER(
						  PARTITION BY company,location,industry,total_laid_off, 
                          percentage_laid_off, `date`, stage, country,funds_raised_millions
                          ) as row_num
		FROM layoffs_copy1;
        
WITH duplicate_cte as (
						SELECT *,
								ROW_NUMBER() OVER(
												  PARTITION BY company,location,industry,total_laid_off, 
                                                  percentage_laid_off, `date`, stage, country,funds_raised_millions
												  ) as row_num
						FROM layoffs_copy1
						)
SELECT * 
FROM duplicate_cte 
where row_num > 1;
						

                        -- CREATE ANOTHER TABLE TOO REMOVE DUPLICATES

CREATE TABLE layoffs_copy2 
LIKE layoffs_copy1;

select * from layoffs_copy2;

					-- TABLE STATEMENT IS CREATED TO ADD NEW ROW "row_num"

CREATE TABLE `layoffs_copy1` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` date DEFAULT NULL,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int														-- new column added
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- new column added

ALTER TABLE layoffs_copy2
ADD COLUMN row_num INT;

				-- data from layoffs_copy1 along with row_num is insesrted 
                
INSERT INTO layoffs_copy2 (											
SELECT *,ROW_NUMBER() OVER(
					  PARTITION BY company,location,industry,total_laid_off, 
					  percentage_laid_off, `date`, stage, country,funds_raised_millions
					  ) as row_num
FROM layoffs_copy1
);

				-- check for duplicates
                
SELECT * FROM layoffs_copy2											
where row_num>1;

				-- TIME TO DELETE DUPLICATES
                
SET SQL_SAFE_UPDATES = 0;

delete FROM layoffs_copy2
where row_num >1;

				-- STANDERDISING DATA

SELECT company, trim(company) from layoffs_copy2;

UPDATE layoffs_copy2
SET company = trim(company);

SELECT DISTINCT industry from layoffs_copy2 GROUP BY 1 ORDER BY 1;						-- found crypto industry name incorrrect so :


SELECT * from layoffs_copy2 where industry like 'crypto%' ORDER BY industry desc;		-- found crypto industry name incorrrect so :


UPDATE layoffs_copy2																	-- changed this crypto currency to crypto
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT location from layoffs_copy2 ORDER BY 1;   								-- no need to make changes in location united states '.'

SELECT DISTINCT country from layoffs_copy2 ORDER BY 1;									-- found problem in united states

SELECT DISTINCT country, trim(trailing '.' from country) FROM layoffs_copy2 ORDER BY 1 desc;

UPDATE layoffs_copy2 																	
SET country = trim(trailing '.' from country)
WHERE country = 'United States%';

SELECT `date`, STR_TO_DATE(`date`, '%m/%d/%Y') from layoffs_copy2;						-- have to change date datatype to date

UPDATE layoffs_copy2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y') ;											-- date fixed
SELECT * from layoffs_copy2;

ALTER TABLE layoffs_copy2																-- date datatype changed
MODIFY COLUMN `date` DATE;

-- FIXING NULL AND BLANK VALUES

SELECT company, location, industry 										-- found few industry null and blank
from layoffs_copy2
where company is null 
    or company = ''
    or location is null 
    or location = ''
    or industry is null
    or industry ='';
    
SELECT * 										
from layoffs_copy2
where company is null 
    or company = ''
    or location is null 
    or location = ''
    or industry is null
    or industry ='';
    
SELECT t1.company, t1.location, t2.industry,t1.industry				-- some industry found blank which is present in data 
FROM layoffs_copy2 as t1											-- so need to propagate
join layoffs_copy2 as t2
ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
	AND t2.industry is NOT NULL;
    
UPDATE layoffs_copy2 t1												-- trying to update but not updating .. need to set blank industry null before updating
join layoffs_copy2 t2
ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry = '')
	AND t2.industry is NOT NULL;
    
UPDATE layoffs_copy2											-- industry set to null where it was blank
SET industry = NULL
where industry = '';

UPDATE layoffs_copy2 t1												-- trying to update but not updating .. need to set blank industry null before updating
join layoffs_copy2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL 
	AND t2.industry is NOT NULL;

SELECT t1.company, t1.location, t2.industry,t1.industry				
FROM layoffs_copy2 as t1											-- industries checked and looks fine
join layoffs_copy2 as t2
ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
	AND t2.industry is NOT NULL;


select industry from layoffs_copy2 where company = 'Airbnb';		-- fixed

select * from layoffs_copy2;

SELECT * from layoffs_copy2									-- found 362 entries null/blank in percentage_laid_off & total_laid_off
where (total_laid_off is null or total_laid_off = '')				-- have to delete them 
	and (percentage_laid_off is null or percentage_laid_off = '');

DELETE from layoffs_copy2
where (total_laid_off is null )										-- deleted 362 entries from row_num
	and (percentage_laid_off is null);
    
ALTER TABLE layoffs_copy2
DROP COLUMN row_num;

SELECT * from layoffs_copy2;


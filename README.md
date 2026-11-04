# World Layoffs Data Cleaning \| MySQL

## Project Overview

This project focuses on cleaning a real-world global layoffs dataset
using **MySQL**. The goal is to prepare raw data in a consistent,
reliable format so it can be used for further analysis and
visualisation.

The work follows a practical data-cleaning workflow: preserve the
original data, create a staging copy, identify and remove duplicate
records, standardise inconsistent values, investigate missing data, and
remove records or helper columns that are not needed for the next stage
of analysis.

> **Project scope:** This is the data-cleaning project only. Exploratory
> data analysis (EDA), trend analysis, and visualisation are outside the
> scope of this project.

## Project Objectives

-   Import the raw layoffs dataset into MySQL.
-   Preserve an untouched copy of the raw data.
-   Create staging tables for cleaning.
-   Identify and remove exact duplicate records.
-   Standardise inconsistent text values.
-   Convert the date field from text to the `DATE` data type.
-   Investigate `NULL` and blank values and populate values only when
    the available data supports doing so.
-   Remove records that do not contain either a total laid-off value or
    a percentage laid-off value.
-   Remove temporary/helper columns added during cleaning.

## Tools & Technologies

-   **Database:** MySQL
-   **SQL environment:** MySQL Workbench
-   **Dataset format:** CSV
-   **SQL techniques:** `CREATE TABLE`, `INSERT INTO ... SELECT`,
    `ROW_NUMBER()`, CTEs, self-joins, `UPDATE`, `DELETE`, `ALTER TABLE`,
    `TRIM()`, `STR_TO_DATE()`, `IS NULL`, and filtering.

## Dataset Description

The dataset contains company layoff records from around the world. The
imported dataset contained **2,361 records** before cleaning.

The fields covered in the project include:

  Column                    Description
  ------------------------- ------------------------------------------------
  `company`                 Company associated with the layoff record
  `location`                Location associated with the company or layoff
  `industry`                Company's industry
  `total_laid_off`          Number of employees laid off
  `percentage_laid_off`     Percentage of the workforce laid off
  `date`                    Date of the layoff record
  `stage`                   Company funding/business stage
  `country`                 Country associated with the record
  `funds_raised_millions`   Funds raised, in millions


## Workflow

### 1. Import the raw data

-   Created a MySQL schema for the World Layoffs project.
-   Imported the CSV file using MySQL Workbench's Table Data Import
    Wizard.
-   Kept the imported data in a raw table for reference.

### 2. Create staging tables

Created a staging table based on the raw table structure and copied the
source records into it using `INSERT INTO ... SELECT`.

The cleaning work was performed on staging tables rather than directly
on the raw data. A second staging table was created to support duplicate
removal using a row-number helper column.

**Why this matters:** Keeping the raw data unchanged provides a fallback
if a cleaning operation is incorrect and makes the workflow safer and
easier to audit.

### 3. Identify and remove duplicate records

-   Used `ROW_NUMBER()` with `PARTITION BY` across all dataset columns
    to identify exact duplicate rows.
-   Used a CTE to filter records where the generated row number was
    greater than 1.
-   Checked sample records to make sure similar-looking records were not
    incorrectly treated as duplicates.
-   Created a second staging table containing the row-number helper
    column.
-   Deleted duplicate rows from that table while retaining one copy of
    each record.

### 4. Standardise inconsistent values

Applied text-cleaning and standardisation steps, including:

-   Used `TRIM()` to remove leading and trailing whitespace from company
    names.
-   Standardised industry values such as `crypto` and `cryptocurrency`
    to a common value (`crypto`).
-   Removed a trailing period from the affected `country` value
    (`United States.`), so it matched the standard country name.

### 5. Convert the date field

-   The imported `date` field was initially stored as text.
-   Used `STR_TO_DATE()` to parse the text values using the source
    format (`%m/%d/%Y`).
-   Updated the staging data with the converted date values.
-   Changed the staging column's data type to `DATE` using
    `ALTER TABLE ... MODIFY COLUMN`.

This makes the date field suitable for date-based filtering and future
time-series analysis.

### 6. Investigate missing and blank values

-   Checked missing values in fields such as `total_laid_off`,
    `percentage_laid_off`, and `industry`.
-   Distinguished between `NULL` values and empty strings.
-   Converted blank industry values to `NULL` before attempting to
    populate missing values.
-   Used a self-join on the staging table, matching records by company
    and location, to find another record with a known industry.
-   Populated missing industry values only where a matching non-`NULL`
    industry value was available.
-   Left values missing when the dataset did not provide enough
    information to determine them reliably.

Not every missing value can be safely inferred.

### 7. Remove unnecessary records and helper columns

-   Removed records where both `total_laid_off` and
    `percentage_laid_off` were missing, because the project treated them
    as unsuitable for the intended layoff analysis.
-   Dropped the temporary `row_num` helper column after duplicate
    removal was complete.

## SQL Concepts Demonstrated

  -----------------------------------------------------------------------
  SQL concept/function                How it was used
  ----------------------------------- -----------------------------------
  `CREATE DATABASE` / schema creation Set up the project database

  `CREATE TABLE ... LIKE`             Create a staging table with the raw
                                      table's structure

  `INSERT INTO ... SELECT`            Copy records between tables

  `ROW_NUMBER()`                      Number records within groups of
                                      matching values

  `PARTITION BY`                      Group identical records for
                                      duplicate detection

  CTE (`WITH`)                        Make the duplicate-identification
                                      query easier to read

  Self-join                           Find another record that contains a
                                      known industry value

  `TRIM()`                            Remove unwanted whitespace

  `UPDATE`                            Standardise values and populate
                                      supported missing values

  `STR_TO_DATE()`                     Convert date strings into date
                                      values

  `IS NULL`                           Identify missing values

  `DELETE`                            Remove duplicate and selected
                                      incomplete records

  `ALTER TABLE ... MODIFY COLUMN`     Change the date column's data type

  `ALTER TABLE ... DROP COLUMN`       Remove the temporary row-number
                                      column
  -----------------------------------------------------------------------

## Data Quality Issues Addressed

-   Exact duplicate rows
-   Leading/trailing whitespace in company names
-   Inconsistent industry labels
-   Trailing punctuation in a country value
-   Date values imported as text
-   Blank and `NULL` industry values
-   Records missing both layoff count and layoff percentage
-   Temporary helper column left over from duplicate removal

## Outcome

The project produced a cleaned staging dataset that is better prepared
for subsequent analysis.

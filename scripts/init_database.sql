-- ==============================================================================
-- SCRIPT PURPOSE: Initialize Medallion Architecture Database
-- ==============================================================================
-- This script automates the creation of the core data warehouse infrastructure.
-- It establishes the 'DataWarehouse' database and builds the three structural 
-- layers (Bronze, Silver, Gold) required for data segregation and refinement.
--
-- ⚠️ WARNING / DISCLAIMER FOR GITHUB USERS:
-- 1. DO NOT hardcode production credentials or server names in this repository.
-- 2. Ensure your .gitignore file excludes any local configuration or data files.
-- 3. Always run this script in a Development environment before Production.
-- ==============================================================================
-- ==============================================================================
-- STEP 1: CREATE THE DATA WAREHOUSE DATABASE
-- ==============================================================================
-- We check if the database already exists to prevent execution errors.
-- If it does not exist, we initialize the 'DataWarehouse' database.

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    CREATE DATABASE DataWarehouse;
END;
GO

-- Switch the execution context to the newly created database.
USE DataWarehouse;
GO 

-- ==============================================================================
-- STEP 2: CREATE THE MEDALLION ARCHITECTURE SCHEMAS
-- ==============================================================================

-- 1. Bronze Schema (Raw Data Layer)
-- This layer stores the exact copy of data from source systems with minimal changes.
-- It preserves historical data lineage and acts as the landing zone.
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Bronze')
BEGIN
    EXEC('CREATE SCHEMA Bronze;');
END;
GO

-- 2. Silver Schema (Cleansed and Conformed Layer)
-- This layer stores validated, deduplicated, and enriched data.
-- Data here is matched, merged, and structured into clean tables for enterprise use.
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Silver')
BEGIN
    EXEC('CREATE SCHEMA Silver;');
END;
GO

-- 3. Gold Schema (Curated Business Layer)
-- This layer stores data optimized for business intelligence, reporting, and analytics.
-- It typically uses a Star Schema (Dimensions and Facts) or aggregated data models.
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Gold')
BEGIN
    EXEC('CREATE SCHEMA Gold;');
END;
GO

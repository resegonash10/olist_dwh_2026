/*==============================================================
  Project: Olist E-Commerce Data Warehouse
  Script: 01_create_schemas.sql
  Purpose: Create the warehouse schemas
==============================================================*/

USE olist_dwh;
GO

IF SCHEMA_ID('bronze') IS NULL
    EXEC('CREATE SCHEMA bronze');
GO

IF SCHEMA_ID('silver') IS NULL
    EXEC('CREATE SCHEMA silver');
GO

IF SCHEMA_ID('gold') IS NULL
    EXEC('CREATE SCHEMA gold');
GO

IF SCHEMA_ID('etl') IS NULL
    EXEC('CREATE SCHEMA etl');
GO

PRINT 'Warehouse schemas checked successfully.';
GO
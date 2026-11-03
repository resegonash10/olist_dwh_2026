/*==============================================================
  Project: Olist E-Commerce Data Warehouse
  Script: 00_create_database.sql
  Purpose: Create the Olist data warehouse database
==============================================================*/

USE master;
GO

IF DB_ID('olist_dwh') IS NULL
BEGIN
    EXEC('CREATE DATABASE olist_dwh');
    PRINT 'Database olist_dwh created successfully.';
END
ELSE
BEGIN
    PRINT 'Database olist_dwh already exists.';
END;
GO
/*==============================================================
  Project: Olist E-Commerce Data Warehouse
  Script: 05_etl_audit_ddl.sql
  Purpose: Create ETL audit and logging table
==============================================================*/

USE olist_dwh;
GO

IF OBJECT_ID('etl.load_log', 'U') IS NULL
BEGIN
    CREATE TABLE etl.load_log
    (
        load_log_id INT IDENTITY(1,1) PRIMARY KEY,

        batch_id INT NOT NULL,

        package_name NVARCHAR(200) NOT NULL,

        source_file NVARCHAR(260) NOT NULL,

        target_table NVARCHAR(200) NOT NULL,

        rows_written BIGINT NOT NULL
            CONSTRAINT DF_load_log_rows_written DEFAULT 0,

        load_status NVARCHAR(30) NOT NULL,

        load_start_ts DATETIME2 NULL,

        load_end_ts DATETIME2 NOT NULL
            CONSTRAINT DF_load_log_load_end_ts DEFAULT SYSDATETIME(),

        error_message NVARCHAR(MAX) NULL
    );
END;
GO

PRINT 'ETL audit table creation check completed.';
GO
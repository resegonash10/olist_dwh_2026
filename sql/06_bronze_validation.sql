/*==============================================================
  Project: Olist E-Commerce Data Warehouse
  Script: 06_bronze_validation.sql
  Purpose: Validate Bronze table record counts and audit logs
==============================================================*/

USE olist_dwh;
GO

/*--------------------------------------------------------------
  1. Check Bronze table record counts
--------------------------------------------------------------*/

SELECT 'bronze.customers' AS table_name,
       COUNT_BIG(*) AS total_rows
FROM bronze.customers

UNION ALL

SELECT 'bronze.geolocation',
       COUNT_BIG(*)
FROM bronze.geolocation

UNION ALL

SELECT 'bronze.order_items',
       COUNT_BIG(*)
FROM bronze.order_items

UNION ALL

SELECT 'bronze.order_payments',
       COUNT_BIG(*)
FROM bronze.order_payments

UNION ALL

SELECT 'bronze.order_reviews',
       COUNT_BIG(*)
FROM bronze.order_reviews

UNION ALL

SELECT 'bronze.orders',
       COUNT_BIG(*)
FROM bronze.orders

UNION ALL

SELECT 'bronze.products',
       COUNT_BIG(*)
FROM bronze.products

UNION ALL

SELECT 'bronze.sellers',
       COUNT_BIG(*)
FROM bronze.sellers

UNION ALL

SELECT 'bronze.product_category_name_translation',
       COUNT_BIG(*)
FROM bronze.product_category_name_translation;
GO

/*--------------------------------------------------------------
  2. Check ETL audit records
--------------------------------------------------------------*/

SELECT
    load_log_id,
    batch_id,
    package_name,
    source_file,
    target_table,
    rows_written,
    load_status,
    load_start_ts,
    load_end_ts,
    error_message
FROM etl.load_log
ORDER BY load_log_id;
GO

/*--------------------------------------------------------------
  3. Check successful and failed loads
--------------------------------------------------------------*/

SELECT
    load_status,
    COUNT(*) AS total_loads
FROM etl.load_log
GROUP BY load_status;
GO

/*--------------------------------------------------------------
  4. Check metadata columns in Bronze tables
--------------------------------------------------------------*/

SELECT
    'customers' AS table_name,
    COUNT_BIG(*) AS total_rows,
    COUNT_BIG(dwh_load_ts) AS rows_with_load_timestamp,
    COUNT_BIG(dwh_source_file) AS rows_with_source_file,
    COUNT_BIG(dwh_batch_id) AS rows_with_batch_id
FROM bronze.customers;
GO
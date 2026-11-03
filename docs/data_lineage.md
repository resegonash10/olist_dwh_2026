# Olist E-Commerce Data Warehouse — Bronze Data Lineage

## 1. Overview

The Bronze layer is the raw data ingestion layer of the Olist E-Commerce Data Warehouse.

Its purpose is to store source data from the original CSV files in SQL Server without changing the original source values.

The project uses SQL Server Integration Services (SSIS) to load the nine CSV files into the Bronze schema.

**Target database:** `olist_dwh`

**Target schema:** `bronze`

**SSIS package:** `01_bronze_load.dtsx`

## 2. Source-to-Target Mapping

| Source CSV file | Bronze destination table |
|---|---|
| olist_customers_dataset.csv | bronze.customers |
| olist_geolocation_dataset.csv | bronze.geolocation |
| olist_order_items_dataset.csv | bronze.order_items |
| olist_order_payments_dataset.csv | bronze.order_payments |
| olist_order_reviews_dataset.csv | bronze.order_reviews |
| olist_orders_dataset.csv | bronze.orders |
| olist_products_dataset.csv | bronze.products |
| olist_sellers_dataset.csv | bronze.sellers |
| product_category_name_translation.csv | bronze.product_category_name_translation |

## 3. Bronze Table Structure

All source columns are stored using the NVARCHAR data type to preserve the original source values.

Each Bronze table includes the following metadata columns:

| Column | Data type | Purpose |
|---|---|---|
| dwh_load_ts | DATETIME2 | Records the data load timestamp |
| dwh_source_file | NVARCHAR(260) | Identifies the source CSV file |
| dwh_batch_id | INT | Identifies the ingestion batch |

## 4. SSIS Data Flow

The Bronze ingestion package follows this process:

1. Execute SQL Task — truncates the existing Bronze tables before a full reload.
2. Flat File Source — reads the source CSV file.
3. Derived Column — adds the ingestion metadata.
4. OLE DB Destination — inserts records into the corresponding Bronze table.

The package contains separate Data Flow Tasks for the nine source files.

## 5. Source File Configuration

The Flat File Connection Managers use:

- Code page: 65001 (UTF-8)
- Text qualifier: double quotation mark (")
- Column delimiter: comma
- Header row: enabled

UTF-8 supports special characters found in the source data, including Portuguese characters.

## 6. Load Audit and Logging

The ETL logging table is:

`etl.load_log`

It records:

- Batch ID
- SSIS package name
- Source file
- Target table
- Number of rows written
- Load status
- Load start and end timestamps
- Error messages

The initial Bronze load was recorded retrospectively after the successful ingestion.

The initial audit records show nine successful source-to-target loads under batch ID 1.

## 7. Validation

The Bronze ingestion was validated by:

- Checking that all nine Bronze tables contain loaded records.
- Comparing source file record counts against Bronze table counts.
- Checking the presence of ingestion metadata.
- Confirming nine successful records in `etl.load_log`.

## 8. Issues Encountered and Resolutions

### CSV header and column metadata

Some CSV header fields caused SSIS source metadata and column mapping issues.

**Resolution:** The Flat File Connection Manager and source column mappings were corrected.

### Order reviews file

The order reviews CSV contains review text fields that can include embedded line breaks.

**Resolution:** The CSV was configured with the appropriate text qualifier and UTF-8 settings to ensure records were interpreted correctly.

### SSIS validation

Some package validation settings can cause issues when destination metadata changes.

**Resolution:** Destination validation settings were reviewed during troubleshooting.

## 9. Phase 1 Outcome

The nine Olist source CSV files were successfully loaded into their corresponding Bronze tables in the `olist_dwh` database.

The Bronze layer now provides the raw foundation for the next stage of the warehouse project: Silver data transformation and cleaning.
/*==============================================================
  Project: Olist E-Commerce Data Warehouse
  Script: 02_bronze_ddl.sql
  Purpose: Create the nine raw Bronze tables
  Rule: All source columns must remain NVARCHAR
==============================================================*/

USE olist_dwh;
GO

/*==============================================================
  1. CUSTOMERS
  Source: olist_customers_dataset.csv
==============================================================*/

IF OBJECT_ID('bronze.customers', 'U') IS NULL
BEGIN
    CREATE TABLE bronze.customers
    (
        customer_id NVARCHAR(50),
        customer_unique_id NVARCHAR(50),
        customer_zip_code_prefix NVARCHAR(20),
        customer_city NVARCHAR(100),
        customer_state NVARCHAR(10),

        dwh_load_ts DATETIME2 DEFAULT SYSDATETIME(),
        dwh_source_file NVARCHAR(260),
        dwh_batch_id INT
    );
END;
GO

/*==============================================================
  2. GEOLOCATION
  Source: olist_geolocation_dataset.csv
==============================================================*/

IF OBJECT_ID('bronze.geolocation', 'U') IS NULL
BEGIN
    CREATE TABLE bronze.geolocation
    (
        geolocation_zip_code_prefix NVARCHAR(20),
        geolocation_lat NVARCHAR(50),
        geolocation_lng NVARCHAR(50),
        geolocation_city NVARCHAR(100),
        geolocation_state NVARCHAR(10),

        dwh_load_ts DATETIME2 DEFAULT SYSDATETIME(),
        dwh_source_file NVARCHAR(260),
        dwh_batch_id INT
    );
END;
GO

/*==============================================================
  3. ORDER ITEMS
  Source: olist_order_items_dataset.csv
==============================================================*/

IF OBJECT_ID('bronze.order_items', 'U') IS NULL
BEGIN
    CREATE TABLE bronze.order_items
    (
        order_id NVARCHAR(50),
        order_item_id NVARCHAR(20),
        product_id NVARCHAR(50),
        seller_id NVARCHAR(50),
        shipping_limit_date NVARCHAR(50),
        price NVARCHAR(50),
        freight_value NVARCHAR(50),

        dwh_load_ts DATETIME2 DEFAULT SYSDATETIME(),
        dwh_source_file NVARCHAR(260),
        dwh_batch_id INT
    );
END;
GO

/*==============================================================
  4. ORDER PAYMENTS
  Source: olist_order_payments_dataset.csv
==============================================================*/

IF OBJECT_ID('bronze.order_payments', 'U') IS NULL
BEGIN
    CREATE TABLE bronze.order_payments
    (
        order_id NVARCHAR(50),
        payment_sequential NVARCHAR(20),
        payment_type NVARCHAR(50),
        payment_installments NVARCHAR(20),
        payment_value NVARCHAR(50),

        dwh_load_ts DATETIME2 DEFAULT SYSDATETIME(),
        dwh_source_file NVARCHAR(260),
        dwh_batch_id INT
    );
END;
GO

/*==============================================================
  5. ORDER REVIEWS
  Source: olist_order_reviews_dataset.csv
==============================================================*/

IF OBJECT_ID('bronze.order_reviews', 'U') IS NULL
BEGIN
    CREATE TABLE bronze.order_reviews
    (
        review_id NVARCHAR(50),
        order_id NVARCHAR(50),
        review_score NVARCHAR(20),
        review_comment_title NVARCHAR(MAX),
        review_comment_message NVARCHAR(MAX),
        review_creation_date NVARCHAR(50),
        review_answer_timestamp NVARCHAR(50),

        dwh_load_ts DATETIME2 DEFAULT SYSDATETIME(),
        dwh_source_file NVARCHAR(260),
        dwh_batch_id INT
    );
END;
GO

/*==============================================================
  6. ORDERS
  Source: olist_orders_dataset.csv
==============================================================*/

IF OBJECT_ID('bronze.orders', 'U') IS NULL
BEGIN
    CREATE TABLE bronze.orders
    (
        order_id NVARCHAR(50),
        customer_id NVARCHAR(50),
        order_status NVARCHAR(50),
        order_purchase_timestamp NVARCHAR(50),
        order_approved_at NVARCHAR(50),
        order_delivered_carrier_date NVARCHAR(50),
        order_delivered_customer_date NVARCHAR(50),
        order_estimated_delivery_date NVARCHAR(50),

        dwh_load_ts DATETIME2 DEFAULT SYSDATETIME(),
        dwh_source_file NVARCHAR(260),
        dwh_batch_id INT
    );
END;
GO

/*==============================================================
  7. PRODUCTS
  Source: olist_products_dataset.csv
==============================================================*/

IF OBJECT_ID('bronze.products', 'U') IS NULL
BEGIN
    CREATE TABLE bronze.products
    (
        product_id NVARCHAR(50),
        product_category_name NVARCHAR(100),
        product_name_lenght NVARCHAR(20),
        product_description_lenght NVARCHAR(20),
        product_photos_qty NVARCHAR(20),
        product_weight_g NVARCHAR(30),
        product_length_cm NVARCHAR(30),
        product_height_cm NVARCHAR(30),
        product_width_cm NVARCHAR(30),

        dwh_load_ts DATETIME2 DEFAULT SYSDATETIME(),
        dwh_source_file NVARCHAR(260),
        dwh_batch_id INT
    );
END;
GO

/*==============================================================
  8. SELLERS
  Source: olist_sellers_dataset.csv
==============================================================*/

IF OBJECT_ID('bronze.sellers', 'U') IS NULL
BEGIN
    CREATE TABLE bronze.sellers
    (
        seller_id NVARCHAR(50),
        seller_zip_code_prefix NVARCHAR(20),
        seller_city NVARCHAR(100),
        seller_state NVARCHAR(10),

        dwh_load_ts DATETIME2 DEFAULT SYSDATETIME(),
        dwh_source_file NVARCHAR(260),
        dwh_batch_id INT
    );
END;
GO

/*==============================================================
  9. PRODUCT CATEGORY TRANSLATION
  Source: product_category_name_translation.csv
==============================================================*/

IF OBJECT_ID('bronze.product_category_name_translation', 'U') IS NULL
BEGIN
    CREATE TABLE bronze.product_category_name_translation
    (
        product_category_name NVARCHAR(100),
        product_category_name_english NVARCHAR(100),

        dwh_load_ts DATETIME2 DEFAULT SYSDATETIME(),
        dwh_source_file NVARCHAR(260),
        dwh_batch_id INT
    );
END;
GO

PRINT 'Bronze table creation checks completed.';
GO

DROP VIEW IF EXISTS v_clean_raw;

CREATE VIEW v_clean_raw AS
SELECT
    TRIM("Order ID")      AS order_id,
    TRIM("Order Date")    AS order_date,
    TRIM("Customer ID")   AS customer_id,
    TRIM("Product ID")    AS product_id,
    TRIM("Product Name")  AS product_name,
    TRIM("Sub-Category")  AS sub_category,
    TRIM("Category")      AS category,
    TRIM("Segment")       AS segment,
    TRIM("Order Mode")    AS order_mode,
    TRIM("City")          AS city,
    TRIM("Region")        AS region,
    TRIM("Country")       AS country,
    TRIM("Postal Code")   AS postal_code,
    "Quantity"            AS quantity,
    "Sales"               AS sales,
    "Cost Price"          AS cost_price,
    "Discount"            AS discount
FROM   ace_sales_raw;


INSERT OR IGNORE INTO dim_customer (customer_id)
SELECT DISTINCT customer_id
FROM v_clean_raw
WHERE customer_id IS NOT NULL;


INSERT OR IGNORE INTO dim_order_mode (order_mode)
SELECT DISTINCT order_mode
FROM v_clean_raw
WHERE order_mode IS NOT NULL;


INSERT OR IGNORE INTO dim_segment (segment)
SELECT DISTINCT segment
FROM v_clean_raw
WHERE segment IS NOT NULL;


INSERT OR IGNORE INTO dim_category (category)
SELECT DISTINCT category
FROM v_clean_raw
WHERE category IS NOT NULL;


INSERT OR IGNORE INTO dim_location (city, region, country, postal_code)
SELECT DISTINCT city, region, country, postal_code
FROM v_clean_raw
WHERE city IS NOT NULL
  AND region IS NOT NULL
  AND country IS NOT NULL;

INSERT OR IGNORE INTO dim_date (full_date, year, month, quarter, week, day)
SELECT DISTINCT
       order_date                                   AS full_date,
       CAST(STRFTIME('%Y', order_date) AS INTEGER)  AS year,
       CAST(STRFTIME('%m', order_date) AS INTEGER)  AS month,
       CASE
           WHEN CAST(STRFTIME('%m', order_date) AS INTEGER) BETWEEN 1 AND 3 THEN 1
           WHEN CAST(STRFTIME('%m', order_date) AS INTEGER) BETWEEN 4 AND 6 THEN 2
           WHEN CAST(STRFTIME('%m', order_date) AS INTEGER) BETWEEN 7 AND 9 THEN 3
           ELSE 4
       END                                          AS quarter,
       CAST(STRFTIME('%W', order_date) AS INTEGER)  AS week,
       CAST(STRFTIME('%d', order_date) AS INTEGER)  AS day
FROM v_clean_raw
WHERE order_date IS NOT NULL;


INSERT OR IGNORE INTO dim_product (product_id, product_name, sub_category, category_id)
SELECT
       vr.product_id,
       MIN(vr.product_name)  AS product_name,
       MIN(vr.sub_category)  AS sub_category,
       c.category_id
FROM   v_clean_raw   AS vr
JOIN   dim_category  AS c
  ON   vr.category = c.category
WHERE  vr.product_id IS NOT NULL
GROUP  BY vr.product_id;

-- Verification
SELECT 'dim_customer'    AS table_name , COUNT(*) FROM dim_customer
UNION ALL SELECT 'dim_order_mode' , COUNT(*) FROM dim_order_mode
UNION ALL SELECT 'dim_segment'    , COUNT(*) FROM dim_segment
UNION ALL SELECT 'dim_category'   , COUNT(*) FROM dim_category
UNION ALL SELECT 'dim_location'   , COUNT(*) FROM dim_location
UNION ALL SELECT 'dim_date'       , COUNT(*) FROM dim_date
UNION ALL SELECT 'dim_product'    , COUNT(*) FROM dim_product;
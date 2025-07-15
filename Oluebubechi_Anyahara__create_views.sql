/* ===============================================================
   File: create_views.sql
   Purpose: Create SQL views for Power BI dashboard reporting
   Author: [Your Name]
   ============================================================== */


/* 1️⃣ Product Seasonality
   ------------------------
   View: vw_product_seasonality
   Insight: Sales trend by product name over months
*/
CREATE VIEW vw_product_seasonality AS
SELECT
    dp.product_name,
    dd.month,
    SUM(fs.total_sales) AS monthly_sales
FROM fact_sales fs
JOIN dim_product dp     ON fs.product_id = dp.product_id
JOIN dim_date dd        ON fs.date_id = dd.date_id
GROUP BY dp.product_name, dd.month
ORDER BY dp.product_name, dd.month;


/* 2️⃣ Discount Impact on Profit
   ------------------------------
   View: vw_discount_impact_analysis
   Insight: Profit vs. Discount correlation
*/
CREATE VIEW vw_discount_impact_analysis AS
SELECT
    ROUND(fs.discount_amount, 2) AS discount_amount,
    ROUND(fs.profit, 2)          AS profit,
    dp.product_name
FROM fact_sales fs
JOIN dim_product dp ON fs.product_id = dp.product_id;


/* 3️⃣ Customer Order Patterns
   ----------------------------
   View: vw_customer_order_patterns
   Insight: AOV, frequency, profit grouped by segment
*/
CREATE VIEW vw_customer_order_patterns AS
SELECT
    ds.segment,
    COUNT(DISTINCT fs.order_id)         AS order_count,
    ROUND(AVG(fs.total_sales), 2)       AS avg_order_value,
    ROUND(SUM(fs.profit), 2)            AS total_profit
FROM fact_sales fs
JOIN dim_segment ds ON fs.segment_id = ds.segment_id
GROUP BY ds.segment;


/* 4️⃣ Channel Margin Report
   --------------------------
   View: vw_channel_margin_report
   Insight: Comparison between Online and In-Store
*/
CREATE VIEW vw_channel_margin_report AS
SELECT
    dom.order_mode,
    ROUND(SUM(fs.total_sales), 2) AS total_sales,
    ROUND(SUM(fs.total_cost), 2)  AS total_cost,
    ROUND(SUM(fs.profit), 2)      AS total_profit
FROM fact_sales fs
JOIN dim_order_mode dom ON fs.order_mode_id = dom.order_mode_id
GROUP BY dom.order_mode;


/* 5️⃣ Region & Category Rankings
   -------------------------------
   View: vw_region_category_rankings
   Insight: Top categories by region using profit
*/
CREATE VIEW vw_region_category_rankings AS
SELECT
    dl.region,
    dc.category,
    ROUND(SUM(fs.profit), 2) AS total_profit
FROM fact_sales fs
JOIN dim_location dl ON fs.location_id = dl.location_id
JOIN dim_category dc ON fs.category_id = dc.category_id
GROUP BY dl.region, dc.category
ORDER BY dl.region, total_profit DESC;
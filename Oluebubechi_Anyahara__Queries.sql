Absolutely! Below is a **single SQL script** that contains all **5 reusable business insight queries**, each created as a **named SQL view**.

---

✅ These views:
- Join `fact_sales` to relevant dimensions  
- Return strategic, reusable insights  
- Can be loaded directly into **Power BI** via ODBC  
- Are grouped logically with comments for clarity

---

# 📦 SINGLE SQL SCRIPT – 5 REUSABLE INSIGHT VIEWS

```sql
-- Drop views if they already exist
DROP VIEW IF EXISTS vw_customer_profit_breakdown;
DROP VIEW IF EXISTS vw_region_category_performance;
DROP VIEW IF EXISTS vw_top_loss_making_products;
DROP VIEW IF EXISTS vw_monthly_sales_trend;
DROP VIEW IF EXISTS vw_channel_profit_summary;

-- 1️⃣ Customer Profitability Breakdown
CREATE VIEW vw_customer_profit_breakdown AS
SELECT 
  dc.customer_id,
  ds.segment,
  SUM(fs.total_sales) AS total_sales,
  SUM(fs.profit) AS total_profit
FROM fact_sales fs
JOIN dim_customer dc ON fs.customer_id = dc.customer_id
JOIN dim_segment ds ON fs.segment_id = ds.segment_id
GROUP BY dc.customer_id, ds.segment
ORDER BY total_profit DESC;

-- 2️⃣ Region and Category Performance
CREATE VIEW vw_region_category_performance AS
SELECT 
  dl.region,
  cat.category,
  COUNT(*) AS order_count,
  SUM(fs.total_sales) AS total_sales,
  SUM(fs.profit) AS total_profit
FROM fact_sales fs
JOIN dim_location dl ON fs.location_id = dl.location_id
JOIN dim_category cat ON fs.category_id = cat.category_id
GROUP BY dl.region, cat.category
ORDER BY dl.region, total_profit DESC;

-- 3️⃣ Top 10 Loss-Making Products
CREATE VIEW vw_top_loss_making_products AS
SELECT 
  dp.product_name,
  COUNT(*) AS times_sold,
  SUM(fs.total_sales) AS total_revenue,
  SUM(fs.total_cost) AS total_cost,
  SUM(fs.profit) AS total_profit
FROM fact_sales fs
JOIN dim_product dp ON fs.product_id = dp.product_id
GROUP BY dp.product_name
ORDER BY total_profit ASC
LIMIT 10;

-- 4️⃣ Monthly Sales and Profit Trend
CREATE VIEW vw_monthly_sales_trend AS
SELECT 
  dd.year,
  dd.month,
  SUM(fs.total_sales) AS monthly_sales,
  SUM(fs.profit) AS monthly_profit
FROM fact_sales fs
JOIN dim_date dd ON fs.date_id = dd.date_id
GROUP BY dd.year, dd.month
ORDER BY dd.year, dd.month;

-- 5️⃣ Sales Channel Comparison Summary
CREATE VIEW vw_channel_profit_summary AS
SELECT 
  dom.order_mode,
  COUNT(*) AS order_count,
  ROUND(AVG(fs.total_sales), 2) AS avg_order_value,
  ROUND(SUM(fs.profit), 2) AS total_profit
FROM fact_sales fs
JOIN dim_order_mode dom ON fs.order_mode_id = dom.order_mode_id
GROUP BY dom.order_mode;
```

---

## ✅ What to Do with This File

In your SQLite tool (e.g., DB Browser for SQLite):

1. Open the **Execute SQL** tab  
2. Paste the code above  
3. Click **"Execute All" (F5)**  
4. ⚠️ Don’t forget to **click "Write Changes"** to save the views!

Once done, these views will be visible in your Power BI **Navigator**, ready to be used in charts.

---

Let me know if you also want this bundled together with your `.README.md`, KPIs, and schema as a project handover package 🎁. You're wrapping this up like a pro ✅🔥
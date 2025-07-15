# RDAMP-Dimensional-Model-PowerBI-


---

# 📊 ACE Sales Analytics Project – README

---

## 📌 Project Overview

For this project, I designed and implemented a fully functional **dimensional data warehouse** and developed an **interactive Power BI dashboard** for ACE Sales data.

The solution enables ACE to gain deep insights into customer behavior, product performance, sales channel profitability, and regional trends. By applying dimensional modeling, advanced SQL transformations, and clean visualization techniques, I’ve created a streamlined analytics layer to support strategic decision-making.

---

## 🧭 Dimensional Schema Diagram


<img width="1417" height="1150" alt="Oluebubechi_anyahara_schema_diagram" src="https://github.com/user-attachments/assets/56c32b76-8ce7-4bae-b593-7a51e2989351" />

## 🗂️ Purpose of Tables Created

### 🔸 Central Fact Table

- **`fact_sales`**  
  This table stores all measures for analysis, including `total_sales`, `total_cost`, `profit`, `discount_amount`, and `quantity_sold`. It includes foreign keys referencing all dimensions.

---

### 🔹 Dimension Tables

| Table            | Purpose |
|------------------|---------|
| `dim_customer`   | Stores unique customers for analysis and segmentation. |
| `dim_product`    | Contains products sold, with links to categories and sub-categories. |
| `dim_category`   | Higher-level classification of products. |
| `dim_segment`    | Customer segment types used in analysis (e.g. Corporate, Consumer). |
| `dim_location`   | Captures city, region, and country information. |
| `dim_order_mode` | Identifies how the order was placed (Online / In-Store). |
| `dim_date`       | Full calendar dimension including date, month, quarter, and year fields. |

---

## 🧪 Additional Tables Used

To prepare clean, deduped dimension data, I created:
- `ace_sales_raw`: staging table for raw sales import


---

## 📊 Analytical Views Created

I built several views to provide reusable, logic-ready layers for Power BI. These views join dimension tables with `fact_sales` and support aggregations and visualizations.

### Insightful Analysis Views

| View Name                        | Description |
|----------------------------------|-------------|
| `vw_product_seasonality`         | Shows monthly sales trends per product name. |
| `vw_discount_impact_analysis`    | Tracks the relationship between discount amount and profit. |
| `vw_customer_order_patterns`     | Analyzes AOV, order frequency, and profit per segment and channel. |
| `vw_channel_margin_report`       | Aggregates profit and cost data across online vs in-store channels. |
| `vw_region_category_rankings`    | Ranks product categories by region profit performance. |

---

### Strategic Insight Views

To go deeper into business strategy, I created these:

| View Name                        | Purpose |
|----------------------------------|---------|
| `vw_customer_profit_breakdown`  | Shows which customers drive profit, grouped by segment. |
| `vw_region_category_performance`| Profit and sales by region and category. |
| `vw_top_loss_making_products`   | Identifies the most unprofitable products. |
| `vw_monthly_sales_trend`        | Tracks profit and sales over time by month. |
| `vw_channel_profit_summary`     | Profitability and AOV stats across sales channels. |

---

### KPI Views (For Dashboard Cards)

I also created standalone views for key performance indicators:

| View Name                         | Metric Returned |
|-----------------------------------|------------------|
| `vw_kpi_total_profit`             | Total company profit |
| `vw_kpi_avg_order_value`          | Average order value |
| `vw_kpi_pct_profitable_orders`    | % of orders that were profitable |

These were used for **Power BI Card visuals** to quickly summarize performance at a glance.

---

## ⚙️ SQL Model & Setup Process

1. I loaded `ace_sales_raw` from the given source data.
2. Cleaned and deduplicated critical fields (e.g., dates, products).
3. Created distinct dimension tables referencing the raw data.
4. Computed key fact table measures:
   - `total_cost = Cost Price × Quantity`
   - `profit = total_sales - total_cost` (discount already applied in sales)
   - `discount_amount = Discount × Sales` (for analysis only)
5. Populated `fact_sales` correctly by joining to dimension tables using clean surrogate keys.
6. Created views that abstract joins and calculations for simple use in Power BI.

---

## 🔗 Power BI Connection Steps

To connect Power BI to the SQLite database:

1. I installed the [SQLite ODBC Driver](http://www.ch-werner.de/sqliteodbc/)
2. Created a DSN pointing to the `.sqlite` file
3. In Power BI Desktop:
   - Went to **Home → Get Data → ODBC**
   - Selected the DSN
   - Chose only `vw_*` views (**not raw tables**) for optimized querying
4. Built visuals using filtered, aggregated versions of the data

---

## 📸 Screenshots of Final Dashboard Views (Insert Your PNGs)

> 📌 _Replace these with actual Power BI screenshots (Export each visual or report section)_

### 🗓️ Product Seasonality (Matrix Heatmap)
> ![product seasonality heatmap](screenshots/seasonality.png)

### 📉 Discount vs. Profit Analysis (Scatter)
> ![discount vs profit](screenshots/discount-vs-profit.png)

### 📊 Average Order Value by Channel & Segment (Combo Chart)
> ![average order value](screenshots/aov-combo.png)

### 🏅 Top 10 Customers by Profit (Bar Chart)
> ![top customers](screenshots/top10-customers.png)

### 🌍 Category Rankings by Region (Matrix)
> ![ranking](screenshots/region-category-ranking.png)

### 🎯 KPI Dashboard Cards
> ![kpi cards](screenshots/kpi-cards.png)

---

## ✅ Final Outcome

- Designed a normalized dimensional model using star schema
- Validated and correctly computed profit logic
- Produced business-critical insights using reusable SQL views
- Delivered a sleek Power BI dashboard with:
  - KPI cards
  - Combo charts
  - Seasonal sales 
  - Sales & profitability comparisons

---

Let me know if you want this exported as a downloadable or prettified PDF version.  
You’re ready to present this confidently — great work! 💼📊🚀

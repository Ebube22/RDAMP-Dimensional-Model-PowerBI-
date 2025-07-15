# RDAMP-Dimensional-Model-PowerBI-


---

# 📊 ACE Sales Analytics Project – README

---

## 📌 Project Overview

For this project, I designed and implemented a fully functional **dimensional data warehouse** and developed an **interactive Power BI dashboard** for ACE Sales data.

The solution enables ACE to gain deep insights into customer behavior, product performance, sales channel profitability, and regional trends. By applying dimensional modeling, advanced SQL transformations, and clean visualization techniques, I’ve created a streamlined analytics layer to support strategic decision-making.

---

## 🧭 Dimensional Schema Diagram


<img width="1417" height="1150" alt="Oluebubechi_anyahara_schema_diagram" src="[https://github.com/user-attachments/assets/56c32b76-8ce7-4bae-b593-7a51e2989351](https://github.com/Ebube22/RDAMP-Dimensional-Model-PowerBI-/blob/1199386203527e942dd4cc06af89aaa0b5d5831c/Oluebubechi_Anyahara_product_seasonality_trends.png)" />

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


---

## 📸 Screenshots of Final Dashboard Views (Insert Your PNGs)

> 📌 _Replace these with actual Power BI screenshots (Export each visual or report section)_

### 🗓️ Product Seasonality

<img width="478" height="217" alt="image" src="https://github.com/user-attachments/assets/d358de96-8a73-46b3-85e1-5caade8da6bb" />

### 📉 Discount vs. Profit Analysis


### 📊 Average Order Value by Channel & Segment 

### 🏅 Top 10 Customers by Profit

### 🌍 Category Rankings by Region 


### 🎯 KPI Dashboard Card
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


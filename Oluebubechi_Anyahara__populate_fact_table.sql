INSERT INTO fact_sales (
    order_id,
    date_id,
    customer_id,
    product_id,
    location_id,
    category_id,
    segment_id,
    order_mode_id,
    quantity,
    total_sales,
    total_cost,
    profit,
    discount_amount
)
SELECT
    vr.order_id,
    d.date_id,
    vr.customer_id,
    vr.product_id,
    l.location_id,
    c.category_id,
    s.segment_id,
    o.order_mode_id,
    vr.quantity,
    vr.sales,
    vr.cost_price * vr.quantity,
    vr.sales - (vr.cost_price * vr.quantity),
    vr.sales * vr.discount
FROM v_clean_raw AS vr
JOIN dim_date       d  ON vr.order_date  = d.full_date
JOIN dim_customer   cu ON vr.customer_id = cu.customer_id
JOIN dim_product    p  ON vr.product_id  = p.product_id
JOIN dim_location   l  ON vr.city = l.city
                         AND vr.region = l.region AND vr.country = l.country
JOIN dim_category   c  ON vr.category = c.category
JOIN dim_segment    s  ON vr.segment  = s.segment
JOIN dim_order_mode o  ON vr.order_mode = o.order_mode;
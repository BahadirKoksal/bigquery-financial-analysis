-- ============================================
-- STEP 2: Order-Level Aggregation
-- Aggregate gwz_sales_margin by orders_id
-- to avoid shipping cost duplication in next join
-- ============================================

-- Create orders table
CREATE TABLE course16.gwz_orders AS
SELECT
  orders_id,
  date_date,
  SUM(qty)           AS qty,
  SUM(turnover)      AS turnover,
  SUM(purchase_cost) AS purchase_cost,
  SUM(margin)        AS margin
FROM course16.gwz_sales_margin
GROUP BY orders_id, date_date;

-- ============================================
-- TEST
-- ============================================

-- PK test (should return 0 rows)
CREATE TABLE course16.gwz_orders_pk AS
SELECT
  orders_id,
  COUNT(*) AS cnt
FROM course16.gwz_orders
GROUP BY orders_id
HAVING COUNT(*) > 1;

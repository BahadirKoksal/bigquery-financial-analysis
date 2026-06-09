-- ============================================
-- STEP 1: Product Margin
-- Join gwz_sales and gwz_product to calculate
-- purchase_cost and margin per order line
-- ============================================

-- Create sales margin table
CREATE TABLE course16.gwz_sales_margin AS
SELECT
  s.*,
  p.purchase_price
FROM course16.gwz_sales s
LEFT JOIN course16.gwz_product p
  ON s.products_id = p.products_id;

-- Add purchase_cost and margin columns
CREATE OR REPLACE TABLE course16.gwz_sales_margin AS
SELECT
  *,
  qty * purchase_price AS purchase_cost,
  turnover - (qty * purchase_price) AS margin
FROM course16.gwz_sales_margin;

-- ============================================
-- TESTS
-- ============================================

-- PK test (should return 0 rows)
CREATE TABLE course16.gwz_sales_margin_pk AS
SELECT
  orders_id,
  products_id,
  COUNT(*) AS cnt
FROM course16.gwz_sales_margin
GROUP BY orders_id, products_id
HAVING COUNT(*) > 1;

-- NULL test on purchase_price (should return 0 rows)
CREATE TABLE course16.gwz_sales_margin_pp_not_null AS
SELECT *
FROM course16.gwz_sales_margin
WHERE purchase_price IS NULL;

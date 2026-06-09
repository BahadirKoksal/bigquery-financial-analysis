-- ============================================
-- STEP 3: Operational Margin
-- Join gwz_orders and gwz_ship to calculate
-- operational margin per order
-- ============================================

-- Create orders operational table
CREATE TABLE course16.gwz_orders_operational AS
SELECT
  o.*,
  s.shipping_fee,
  s.ship_cost,
  s.log_cost
FROM course16.gwz_orders o
LEFT JOIN course16.gwz_ship s
  ON o.orders_id = s.orders_id;

-- Add operational_margin column
CREATE OR REPLACE TABLE course16.gwz_orders_operational AS
SELECT
  *,
  margin + shipping_fee - (ship_cost + log_cost) AS operational_margin
FROM course16.gwz_orders_operational;

-- ============================================
-- TESTS
-- ============================================

-- PK test (should return 0 rows)
CREATE TABLE course16.gwz_orders_operational_pk AS
SELECT
  orders_id,
  COUNT(*) AS cnt
FROM course16.gwz_orders_operational
GROUP BY orders_id
HAVING COUNT(*) > 1;

-- NULL test on shipping columns (should return 0 rows)
CREATE TABLE course16.gwz_orders_operational_not_null AS
SELECT *
FROM course16.gwz_orders_operational
WHERE shipping_fee IS NULL
   OR ship_cost    IS NULL
   OR log_cost     IS NULL;

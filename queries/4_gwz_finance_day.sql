-- ============================================
-- STEP 4: Daily Financial Tracking
-- Aggregate all KPIs by date for finance team
-- ============================================

-- Create daily finance table
CREATE TABLE course16.gwz_finance_day AS
SELECT
  date_date,
  SUM(turnover)            AS turnover,
  SUM(purchase_cost)       AS purchase_cost,
  SUM(margin)              AS margin,
  SUM(shipping_fee)        AS shipping_fee,
  SUM(ship_cost)           AS ship_cost,
  SUM(log_cost)            AS log_cost,
  SUM(operational_margin)  AS operational_margin,
  COUNT(orders_id)         AS nb_transactions,
  SUM(turnover) / COUNT(orders_id) AS avg_basket
FROM course16.gwz_orders_operational
GROUP BY date_date
ORDER BY date_date DESC;

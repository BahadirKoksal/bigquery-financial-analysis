# 💰 BigQuery Financial Analysis

## 📌 Project Overview
This project analyzes financial data using BigQuery SQL to track daily business profitability. By joining multiple financial tables, we calculate product margins, operational margins, and daily KPIs to give the finance team a clear picture of business performance over time.

---

## 🗃️ Dataset
- **Platform:** Google BigQuery
- **Dataset:** `course16`
- **Tables:**
  - `gwz_product` — Product catalog with purchase prices
  - `gwz_sales` — Order line items with turnover and quantity
  - `gwz_ship` — Shipping fees and logistics costs per order

### Table Relationships
gwz_product (PK: products_id)
      ▲
gwz_sales (PK: orders_id + products_id | FK: product_id, orders_id)
      ▲
gwz_ship (PK: orders_id | FK: orders_id)

---

## 🔄 Methodology

### Step 1 — Product Margin (gwz_sales_margin)
- Joined `gwz_sales` and `gwz_product` on `product_id`
- Calculated `purchase_cost` = qty × purchase_price
- Calculated `margin` = turnover − purchase_cost
- Data quality checks: PK uniqueness test, NULL check on `purchase_price` → all passed ✅

### Step 2 — Order-Level Aggregation (gwz_orders)
- Aggregated `gwz_sales_margin` by `orders_id` to avoid cost duplication in the next join
- Metrics: `qty`, `turnover`, `purchase_cost`, `margin`

### Step 3 — Operational Margin (gwz_orders_operational)
- Joined `gwz_orders` and `gwz_ship` on `orders_id`
- Calculated `operational_margin` = margin + shipping_fee − (ship_cost + log_cost)
- Data quality checks: PK test, NULL check on shipping columns → all passed ✅

### Step 4 — Daily Financial Tracking (gwz_finance_day)
- Aggregated all KPIs by `date_date`
- Final metrics per day: `turnover`, `purchase_cost`, `margin`, `shipping_fee`, `ship_cost`, `log_cost`, `operational_margin`, `nb_transactions`, `avg_basket`

---

## 📊 Key Findings
- ✅ Data quality is high — all PK and NULL tests passed across all tables
- ⚠️ 2 products in `gwz_product` have no sales records
- 📦 Daily transactions range between ~579 and ~1,284 orders
- 🛒 Average basket value hovers around €70–78
- 📈 Operational margin is positive across all days — business is profitable

---

## 🛠️ Tech Stack
- Google BigQuery (SQL)
- Techniques: LEFT JOIN, GROUP BY aggregation, layered data transformation, data quality testing

---

## 📁 Repository Structure
- README.md
- queries/
  - 1_gwz_sales_margin.sql
  - 2_gwz_orders.sql
  - 3_gwz_orders_operational.sql
  - 4_gwz_finance_day.sql

---


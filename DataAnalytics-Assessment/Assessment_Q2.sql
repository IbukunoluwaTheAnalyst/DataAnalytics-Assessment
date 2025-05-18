USE adashi_assessment;

-- Q2: Transaction Frequency Analysis
-- This query analyzes the transaction frequency of customers on their savings accounts.
-- It categorizes customers based on their average monthly successful transactions into 
-- High, Medium, and Low Frequency groups, and summarizes the count and average transactions per category.

-- Step 1: Calculate the number of successful transactions per customer per month
WITH customer_monthly_txns AS (
    SELECT 
        owner_id,
        DATE_FORMAT(transaction_date, '%Y-%m') AS txn_month,  -- Format date to Year-Month for grouping
        COUNT(*) AS txns_in_month                              -- Count transactions in each month
    FROM savings_savingsaccount
    WHERE transaction_status = 'success'                      -- Consider only successful transactions
    GROUP BY owner_id, txn_month
),

-- Step 2: Calculate average transactions per month per customer
avg_txn_rate_per_customer AS (
    SELECT 
        owner_id,
        AVG(txns_in_month) AS avg_txn_per_month               -- Average transactions over all months
    FROM customer_monthly_txns
    GROUP BY owner_id
),

-- Step 3: Categorize customers based on average monthly transaction frequency
categorized_customers AS (
    SELECT 
        owner_id,
        avg_txn_per_month,
        CASE
            WHEN avg_txn_per_month >= 10 THEN 'High Frequency'  -- 10 or more transactions per month
            WHEN avg_txn_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'  -- Between 3 and 9 transactions
            ELSE 'Low Frequency'                                 -- Less than 3 transactions per month
        END AS frequency_category
    FROM avg_txn_rate_per_customer
)

-- Final output: Number of customers and average transactions per category
SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_txn_per_month), 1) AS avg_transactions_per_month
FROM categorized_customers
GROUP BY frequency_category
ORDER BY 
    FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency');  -- Custom order for output

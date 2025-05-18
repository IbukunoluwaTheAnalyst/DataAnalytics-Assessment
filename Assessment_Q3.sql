use adashi_assessment;

-- Q3: Account Inactivity Alert
-- This query identifies active Savings and Investment plans that have been inactive for 365 days or more.
-- It retrieves the last transaction date per plan and calculates the number of days since that transaction.
-- If a plan has never had a transaction (NULL last transaction date), it is also flagged as inactive.

SELECT 
    p.id AS plan_id,
    p.owner_id,
    
    -- Map plan_type_id to a readable type label
    CASE 
        WHEN p.plan_type_id = 2 THEN 'Savings' 
        WHEN p.plan_type_id = 4 THEN 'Investments' 
        ELSE 'Other' 
    END AS type,
    
    -- Get the most recent transaction date for each plan
    MAX(s.transaction_date) AS last_transaction_date,
    
    -- Calculate inactivity duration in days from the last transaction date to today
    DATEDIFF(CURDATE(), MAX(s.transaction_date)) AS inactivity_days

FROM plans_plan p
LEFT JOIN savings_savingsaccount s ON s.plan_id = p.id

WHERE 
    p.status_id = 1              -- Include only active plans
    AND p.is_deleted = 0         -- Exclude deleted plans
    AND p.plan_type_id IN (2, 4) -- Focus on Savings and Investment plans only

GROUP BY p.id, p.owner_id, p.plan_type_id

-- Filter for plans with no transactions or inactive for 365 days or more
HAVING 
    last_transaction_date IS NULL 
    OR DATEDIFF(CURDATE(), last_transaction_date) >= 365

ORDER BY inactivity_days DESC;  -- Order by longest inactivity first

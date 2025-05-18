USE adashi_assessment;

-- Q4: Customer Lifetime Value (CLV) Estimation
-- This query estimates the Customer Lifetime Value (CLV) for each customer based on their transaction history.
-- CLV is calculated using the average transaction amount, transaction frequency, and customer tenure.
-- The formula approximates annual value by scaling average monthly transactions and average transaction amount.

SELECT 
    u.id AS customer_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    
    -- Calculate customer tenure in months from join date to today
    TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months,
    
    -- Count total transactions made by the customer
    COUNT(s.id) AS total_transactions,
    
    -- Estimate CLV using:
    -- (Average monthly transactions) * 12 months * (0.001 * Average transaction amount)
    -- NULLIF avoids division by zero if tenure is zero
    ROUND(
        (COUNT(s.id) / NULLIF(TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()), 0)) * 12 * (0.001 * AVG(s.amount)),
        2
    ) AS estimated_clv

FROM users_customuser u
LEFT JOIN savings_savingsaccount s ON s.owner_id = u.id

GROUP BY u.id, u.name, u.date_joined

-- Include only customers with at least one transaction
HAVING total_transactions > 0

-- Rank customers by estimated CLV descending
ORDER BY estimated_clv DESC;


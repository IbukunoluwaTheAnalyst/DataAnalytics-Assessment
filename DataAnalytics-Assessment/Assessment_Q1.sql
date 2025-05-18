USE adashi_assessment;

-- Q1: High-Value Customers with Multiple Products
-- This query identifies customers who own at least one 'Savings' plan (plan_type_id = 2)
-- and at least one 'Investment' plan (plan_type_id = 3), and calculates their total deposits.
-- It returns:
--   - owner_id: the user ID
--   - name: the full name of the user
--   - savings_count: count of distinct savings plans the user owns
--   - investment_count: count of distinct investment plans the user owns
--   - total_deposits: sum of all active plan amounts owned by the user
-- Only active (status_id = 1) and non-deleted (is_deleted = 0) plans are considered.
-- The results are grouped by user and ordered by total deposits in descending order.

SELECT 
    u.id AS owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    
    -- Count of distinct savings plans (plan_type_id = 2)
    COUNT(DISTINCT CASE WHEN p.plan_type_id = 2 THEN p.id END) AS savings_count,
    
    -- Count of distinct investment plans (plan_type_id = 4)
    COUNT(DISTINCT CASE WHEN p.plan_type_id = 4 THEN p.id END) AS investment_count,
    
    -- Total amount deposited across all plans for the user
    SUM(p.amount) AS total_deposits

FROM plans_plan p
JOIN users_customuser u ON p.owner_id = u.id

-- Consider only active and non-deleted plans
WHERE p.status_id = 1 AND p.is_deleted = 0

GROUP BY u.id, u.first_name 

-- Filter users who have at least one savings plan AND one investment plan
HAVING 
    COUNT(DISTINCT CASE WHEN p.plan_type_id = 2 THEN p.id END) >= 1 AND
    COUNT(DISTINCT CASE WHEN p.plan_type_id = 3 THEN p.id END) >= 1

ORDER BY total_deposits DESC;




# DataAnalytics-Assessment

This repository contains SQL queries developed to answer specific data analytics questions as part of the SQL assessment. Each query is saved in a separate `.sql` file, with detailed comments explaining the logic and approach.

---

## Per-Question Explanations

### Assessment_Q1.sql - High-Value Customers with Multiple Products
The query identifies customers who own at least one Savings plan and at least one Investment plan. It calculates the total deposits for each user by summing all active, non-deleted plans. The approach uses conditional aggregation with `COUNT(DISTINCT CASE ...)` to count different plan types and filters users accordingly. Results are ordered by total deposits to highlight high-value customers.

### Assessment_Q2.sql - Transaction Frequency Analysis
This query analyzes customers’ transaction frequency by calculating the average number of successful transactions per month. It categorizes customers into High, Medium, and Low frequency groups based on average monthly transactions. The approach uses Common Table Expressions (CTEs) to break down the problem into calculating monthly transaction counts, averaging them, and then categorizing customers. The final output summarizes counts and average transactions per category.

### Assessment_Q3.sql - Account Inactivity Alert
The query detects active Savings and Investment plans that have been inactive for 365 days or more. It finds the last transaction date for each plan, calculates days of inactivity, and flags plans without any transactions. A LEFT JOIN is used to include plans that may have never had a transaction, ensuring no inactive plans are missed.

### Assessment_Q4.sql - Customer Lifetime Value (CLV) Estimation
This query estimates CLV by combining customer tenure, transaction frequency, and average transaction amount. Tenure is measured in months since the join date. The formula scales average monthly transactions to an annual value and multiplies by average transaction amount, applying a scaling factor (0.001) for realistic CLV approximation. Customers without transactions are excluded from the final list.

---

## Challenges Faced & Solutions

### 1. Importing the Dataset
*Challenge*: The `.sql` file did not automatically load into MySQL Workbench.  
*Solution*: Created a new schema manually and used the **Open SQL Script** function to execute the file, then refreshed the schema panel to view the tables.

### 2. Understanding Schema Relationships
*Challenge*: The relationships between tables and which fields to filter on were not immediately clear.  
*Solution*: Previewed tables using `SELECT * LIMIT 10` queries and referred to business logic documentation to understand how to segment savings vs. investment accounts correctly.

### 3. Currency Format (Kobo to Naira)
*Challenge*: All monetary amounts were stored in kobo, leading to inflated values.  
*Solution*: Applied a multiplication factor of `0.01` to convert all amounts from kobo to naira for accurate financial calculations.

### 4. Query Optimization and Readability
*Challenge*: Complex queries with multiple joins and filters became difficult to read and maintain.  
*Solution*: Used Common Table Expressions (CTEs) to modularize query logic, improve readability, and make debugging easier.

### 5. Handling Null and Edge Cases in Date Calculations
*Challenge*: Plans or customers with no transactions or zero tenure could cause errors in date difference calculations or division by zero.  
*Solution*: Incorporated `LEFT JOIN` and `NULLIF` functions to safely handle nulls and avoid division errors.

### 6. Custom Sorting of Results
*Challenge*: Ensuring categories like transaction frequency were sorted in a meaningful order instead of alphabetically.  
*Solution*: Utilized MySQL’s `FIELD()` function to define a custom ordering sequence for frequency categories.

---

## Notes

- All queries assume MySQL syntax and functions.
- Only active and non-deleted records were considered unless otherwise specified.
- Queries are individually saved and commented for clarity and easy review.


**Author:** [AJIBADE IBUKUNOLUWA GIFT]  
**Date:** [18/05/2025]  




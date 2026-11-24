/* ---------------------------------------------------------------------
   SECTION 1 - CHURN OVERVIEW
   --------------------------------------------------------------------- */

-- 1.1 Purchase frequency analysis

SELECT frequency_of_purchases,
COUNT(*) AS customers
FROM customer_shopping_analysis
GROUP BY frequency_of_purchases
ORDER BY customers DESC;

-- 1.2 Average previous purchases by age group

SELECT age_group,
ROUND(AVG(previous_purchases),2) AS avg_previous_purchases
FROM customer_shopping_analysis
GROUP BY age_group;


-- 1.3 Customers with low ratings

SELECT COUNT(*) AS low_rating_customers
FROM customer_shopping_analysis
WHERE review_rating < 3;


-- 1.4 Average purchase frequency days

SELECT
ROUND(AVG(purchase_frequency_days),2)
AS avg_days_between_purchases
FROM customer_shopping_analysis;

SELECT COUNT(*) AS total_customers,
       SUM(churn_flag) AS churned_customers,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct
FROM customer_shopping_analysis;


-- 1.5 How much revenue is coming from churned customers (revenue at risk)?
SELECT SUM(purchase_amount) AS revenue_at_risk
FROM customer_shopping_analysis
WHERE churn_flag = 1;


-- 1.6 What share of total revenue is at risk?
SELECT ROUND(100.0 * SUM(purchase_amount) /
             (SELECT SUM(purchase_amount) FROM customer_shopping_analysis), 2) AS pct_revenue_at_risk
FROM customer_shopping_analysis
WHERE churn_flag = 1;


-- 1.7 Do churned customers spend, rate and buy differently from retained customers?
SELECT churn_flag,
       COUNT(*) AS customers,
       ROUND(AVG(purchase_amount), 2) AS avg_spend,
       ROUND(AVG(review_rating), 2) AS avg_rating,
       ROUND(AVG(previous_purchases), 1) AS avg_previous_purchases,
       ROUND(AVG(purchase_frequency_days), 0) AS avg_days_between_purchases
FROM customer_shopping_analysis
GROUP BY churn_flag;


-- 1.8 How many customers are in each risk segment, and how many of them churned?
SELECT risk_segment,
       COUNT(*) AS customers,
       SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct,
       SUM(purchase_amount) AS total_revenue
FROM customer_shopping_analysis
GROUP BY risk_segment
ORDER BY churn_rate_pct DESC;


/* ---------------------------------------------------------------------
   SECTION 2 - WHICH CUSTOMER GROUPS CHURN MORE?
   Note: churn rates here are all close to the overall rate (about 22%).
   Small gaps (a few %) are normal random variation, not real patterns.
   --------------------------------------------------------------------- */

-- 2.1 Do subscribers churn less than non-subscribers?
SELECT subscription_status,
       COUNT(*) AS customers,
       SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct
FROM customer_shopping_analysis
GROUP BY subscription_status;


-- 2.2 Which product category has the highest churn rate?
SELECT category,
       COUNT(*) AS customers,
       SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct
FROM customer_shopping_analysis
GROUP BY category
ORDER BY churn_rate_pct DESC;


-- 2.3 Which age group has the highest churn rate?
SELECT age_group,
       COUNT(*) AS customers,
       SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct
FROM customer_shopping_analysis
GROUP BY age_group
ORDER BY churn_rate_pct DESC;


-- 2.4 Do male and female customers churn differently?
SELECT gender,
       COUNT(*) AS customers,
       SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct
FROM customer_shopping_analysis
GROUP BY gender;


-- 2.5 Which shipping type has the highest churn rate?
SELECT shipping_type,
       COUNT(*) AS customers,
       SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct
FROM customer_shopping_analysis
GROUP BY shipping_type
ORDER BY churn_rate_pct DESC;


-- 2.6 Which payment method has the highest churn rate?
SELECT payment_method,
       COUNT(*) AS customers,
       SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct
FROM customer_shopping_analysis
GROUP BY payment_method
ORDER BY churn_rate_pct DESC;


-- 2.7 Which season has the highest churn rate?
SELECT season,
       COUNT(*) AS customers,
       SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct
FROM customer_shopping_analysis
GROUP BY season
ORDER BY churn_rate_pct DESC;


-- 2.8 Do customers who use discounts churn more or less?
SELECT discount_applied,
       COUNT(*) AS customers,
       SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct
FROM customer_shopping_analysis
GROUP BY discount_applied;


-- 2.9 Which 10 states have the highest churn rate?
SELECT location,
       COUNT(*) AS customers,
       SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct
FROM customer_shopping_analysis
GROUP BY location
ORDER BY churn_rate_pct DESC
LIMIT 10;


/* ---------------------------------------------------------------------
   SECTION 3 - ENGAGEMENT AND CUSTOMER TYPE
   --------------------------------------------------------------------- */

-- 3.1 How does churn change with how often customers buy?
--     (Churn only happens at 90+ days because that is part of our definition.)
SELECT frequency_of_purchases,
       purchase_frequency_days,
       COUNT(*) AS customers,
       SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct
FROM customer_shopping_analysis
GROUP BY frequency_of_purchases, purchase_frequency_days
ORDER BY purchase_frequency_days;


-- 3.2 Do New, Returning or Loyal customers churn more?
--     (Same groups as your earlier query: New <= 5, Returning 6-20, Loyal 21+ previous purchases)
--     This follows from our churn definition (churn needs 25 or fewer previous purchases),
--     so it shows how the definition works. It is not a separate discovery.
SELECT CASE
           WHEN previous_purchases <= 5 THEN 'New'
           WHEN previous_purchases <= 20 THEN 'Returning'
           ELSE 'Loyal'
       END AS customer_type,
       COUNT(*) AS customers,
       SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct
FROM customer_shopping_analysis
GROUP BY customer_type
ORDER BY churn_rate_pct DESC;


-- 3.3 Are unhappy customers (low ratings) more likely to churn?
SELECT CASE
           WHEN review_rating < 3.5 THEN 'Below 3.5'
           WHEN review_rating < 4.5 THEN '3.5 to 4.4'
           ELSE '4.5 and above'
       END AS rating_group,
       COUNT(*) AS customers,
       SUM(churn_flag) AS churned,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct
FROM customer_shopping_analysis
GROUP BY rating_group
ORDER BY rating_group;


/* ---------------------------------------------------------------------
   SECTION 4 - WHO SHOULD WE CONTACT? (ACTION LISTS)
   --------------------------------------------------------------------- */

-- 4.1 Which category has the most revenue at risk?
SELECT category,
       SUM(purchase_amount) AS revenue_at_risk
FROM customer_shopping_analysis
WHERE churn_flag = 1
GROUP BY category
ORDER BY revenue_at_risk DESC;


-- 4.2 Who are the top 10 highest-spending customers who churned? (win-back priority)
SELECT customer_id, category, item_purchased, purchase_amount, review_rating
FROM customer_shopping_analysis
WHERE churn_flag = 1
ORDER BY purchase_amount DESC
LIMIT 10;


-- 4.3 Which churned customers were happy (rating 4+) but are not subscribed?
--     They liked us, so a subscription or loyalty offer could bring them back.
SELECT customer_id, category, purchase_amount, review_rating
FROM customer_shopping_analysis
WHERE churn_flag = 1
  AND review_rating >= 4
  AND subscription_status = 'No'
ORDER BY purchase_amount DESC
LIMIT 20;


-- 4.4 Early warning: which customers are HIGH risk but have not churned yet?
SELECT customer_id, category, purchase_amount, frequency_of_purchases,
       previous_purchases, engagement_risk_score
FROM customer_shopping_analysis
WHERE risk_segment = 'High'
  AND churn_flag = 0
ORDER BY engagement_risk_score DESC
LIMIT 20;


-- 4.5 Which subscribers are at high risk? (they already pay us, so protect them first)
SELECT customer_id, category, purchase_amount, frequency_of_purchases,
       engagement_risk_score
FROM customer_shopping_analysis
WHERE subscription_status = 'Yes'
  AND risk_segment = 'High'
ORDER BY engagement_risk_score DESC
LIMIT 20;


-- 4.6 What percentage of churned customers used a discount?
SELECT ROUND(100.0 * SUM(CASE WHEN discount_applied = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS pct_used_discount
FROM customer_shopping_analysis
WHERE churn_flag = 1;


/* ---------------------------------------------------------------------
   SECTION 5 - HOW GOOD ARE THE ML MODEL AND CLUSTERS?
   --------------------------------------------------------------------- */

-- 5.1 On customers the model never saw (test split): actual vs predicted churn
--     churn_flag = actual, ml_churn_prediction = model's guess
--     (1,1) = correctly caught churn   (0,0) = correctly caught retained
--     (0,1) = false alarm              (1,0) = missed churn
SELECT churn_flag AS actual,
       ml_churn_prediction AS predicted,
       COUNT(*) AS customers
FROM customer_shopping_analysis
WHERE split = 'test'
GROUP BY churn_flag, ml_churn_prediction;


-- 5.2 What percentage of test customers did the model get right (accuracy)?
--     It is ~100% because the churn label is built from purchase frequency and previous
--     purchases, and the model can see those columns. It shows the model learned the rule.
--     It does NOT mean the model can forecast future churn from other information.
SELECT ROUND(100.0 * SUM(CASE WHEN churn_flag = ml_churn_prediction THEN 1 ELSE 0 END) / COUNT(*), 2) AS accuracy_pct
FROM customer_shopping_analysis
WHERE split = 'test';


-- 5.3 What do the KMeans customer groups look like?
SELECT kmeans_cluster,
       kmeans_at_risk,
       COUNT(*) AS customers,
       ROUND(AVG(purchase_frequency_days), 0) AS avg_days_between_purchases,
       ROUND(AVG(previous_purchases), 1) AS avg_previous_purchases,
       ROUND(100.0 * SUM(churn_flag) / COUNT(*), 2) AS churn_rate_pct
FROM customer_shopping_analysis
GROUP BY kmeans_cluster, kmeans_at_risk
ORDER BY kmeans_cluster;

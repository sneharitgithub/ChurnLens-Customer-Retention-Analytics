# ChurnLens: Customer Shopping & Retention Analytics

## Project Overview

ChurnLens is an end-to-end customer shopping analytics project built using Python, SQL, and Power BI.

The project analyzes 3,900 customer purchase records to understand customer purchasing behavior, spending patterns, product and category performance, subscription behavior, seasonal trends, and customer segments.

Instead of focusing only on descriptive metrics, I worked through the complete analytics workflow:

**Data Cleaning → Feature Engineering → SQL Business Analysis → Power BI Dashboard → Business Insights**

The goal was to turn raw customer transaction data into insights that could help a retail business understand where revenue is coming from, which customer segments contribute most, how products perform, and where marketing, retention, and inventory decisions could be better informed.

---

## Business Problem

Retail businesses collect large amounts of customer transaction data, but raw transaction records do not directly answer important business questions.

This project addresses questions such as:

- Which customer segments contribute the most revenue?
- Which categories and products perform best?
- Are subscribers spending more than non-subscribers?
- Which seasons generate higher sales?
- Which customers are high-value?
- Which payment and shipping methods are most commonly used?
- Does discount usage appear alongside higher customer spending?
- Which categories generate higher revenue per customer?

The objective was to transform these questions into measurable analysis using Python, SQL, and Power BI.

---

## Dataset

The dataset contains **3,900 customer purchase records and 19 attributes** covering:

- Customer demographics
- Products and categories
- Purchase amounts
- Locations
- Review ratings
- Subscription status
- Shipping preferences
- Discount usage
- Previous purchases
- Payment methods
- Purchase frequency

### Main Features

`customer_id`  
`age`  
`gender`  
`item_purchased`  
`category`  
`purchase_amount`  
`location`  
`size`  
`color`  
`season`  
`review_rating`  
`subscription_status`  
`shipping_type`  
`discount_applied`  
`previous_purchases`  
`payment_method`  
`frequency_of_purchases`  
`age_group`  
`purchase_frequency_days`

---

# Project Workflow

## 1. Data Cleaning & Preparation — Python / Pandas

I used Python and Pandas to prepare the raw dataset for analysis.

The cleaning process included:

- Inspecting dataset structure and data types
- Checking missing values
- Checking duplicate records
- Identifying inconsistent values
- Standardizing categorical data
- Removing redundant/unnecessary fields where required
- Creating analytical features
- Validating the cleaned dataset
- Exporting the cleaned dataset for SQL analysis

### Feature Engineering

I created additional analytical features including:

- `age_group` — grouped customers into meaningful age segments
- `purchase_frequency_days` — converted purchase-frequency information into an analytical time-based feature

This made it easier to perform customer segmentation and compare purchasing behavior.

---

## 2. Business Analysis — MySQL

After cleaning the data, I imported the dataset into MySQL and performed business-focused analysis.

I used SQL concepts including:

- Aggregate Functions
- `GROUP BY`
- `HAVING`
- `CASE`
- Subqueries
- CTEs
- Window Functions
- Joins
- Filtering and sorting
- Customer segmentation

The analysis was designed around actual business questions rather than only performing basic SQL operations.

---

## 3. Interactive Dashboard — Power BI

I used Power BI to convert the SQL analysis and cleaned customer data into an interactive business dashboard.

The dashboard includes KPI metrics and visual analysis covering:

- Total Revenue
- Total Customers
- Total Orders
- Average Purchase
- Average Rating
- Revenue per Customer
- Revenue by Category
- Revenue by Gender
- Revenue by Season
- Subscription Status
- Payment Methods
- Shipping Preferences
- Customer Age Groups
- Product Performance
- Location-level revenue

I also used DAX measures to create reusable business metrics and make the dashboard respond dynamically to filters and slicers.

### Power BI File

The Power BI report is included in this repository.

`Power BI Dashboard / Customer Shopping Behavior Dashboard`

---

# Key Business Insights

The analysis produced several findings from the 3,900 purchase records.

### 1. Revenue is concentrated among male customers

Male customers generated approximately **$157.9K**, compared with **$75.2K** from female customers.

This means the business could examine whether its current product mix, promotions, or customer acquisition strategy is particularly effective with male customers.

---

### 2. Non-subscribers generated more total revenue

Non-subscribers generated approximately **$170.4K** in revenue compared with **$62.6K** from subscribers.

However, average purchase values were very similar:

- Subscribers: approximately **$59.49**
- Non-subscribers: approximately **$59.87**

This is important because the data does **not** show a meaningful difference in average transaction value between subscribers and non-subscribers.

For the business, this could be a reason to investigate whether the subscription program needs stronger value propositions or better conversion strategies.

---

### 3. Clothing is the largest revenue-generating category

Clothing generated approximately **$104.3K**, representing about **45% of total revenue**.

Accessories generated around **$74.2K**, followed by Footwear and Outerwear.

This indicates that clothing is a major revenue driver and could be important for inventory planning, merchandising, and promotional campaigns.

---

### 4. Footwear has the highest average purchase value among categories

Footwear had the highest average purchase amount at approximately **$60.26**, slightly above Clothing at approximately **$60.03**.

Although the difference is small, this metric provides another perspective beyond total revenue: a category can have lower overall revenue because it has fewer transactions while still having a relatively high average transaction value.

---

### 5. Fall generated the highest seasonal revenue

Fall generated approximately **$60.0K**, making it the highest-revenue season in this dataset.

Spring and Winter followed closely, while Summer generated the lowest revenue among the four seasons.

This can help a business compare seasonal demand and plan inventory or promotional activity accordingly.

---

### 6. Young adults contributed the highest revenue among age groups

The Young Adult segment generated approximately **$62.1K**, followed by Middle-aged, Adult, and Senior customers.

This provides a useful customer-segmentation view that can support more targeted marketing and product analysis.

---

### 7. Payment preferences were relatively distributed

PayPal was the most frequently used payment method with **677 transactions**, followed closely by Credit Card and Cash.

Because the distribution is relatively balanced, the business may benefit from continuing to support multiple payment options rather than relying heavily on a single method.

---

### 8. Free Shipping was the most frequently used shipping option

Free Shipping had the highest number of transactions among the available shipping methods.

This provides a useful operational signal when evaluating shipping preferences and customer purchase behavior.

---

### 9. Loyal customers contribute most of the analyzed revenue

Based on previous purchase history, customers were segmented into:

- New
- Returning
- Loyal

The Loyal segment represented the largest group in the dataset and contributed the majority of analyzed revenue.

This highlights the importance of understanding repeat-purchase behavior and maintaining customer relationships rather than focusing only on acquiring new customers.

---

# Business Value

The project demonstrates how customer transaction data can be used to support practical business decisions.

The analysis can help a retail business:

- Identify major revenue-generating customer segments
- Understand category and product performance
- Compare subscriber and non-subscriber behavior
- Identify seasonal revenue patterns
- Understand payment and shipping preferences
- Support inventory and merchandising decisions
- Identify areas for customer retention and engagement
- Build more targeted marketing strategies
- Monitor business performance through an interactive dashboard

The project does not claim to predict customer churn because the dataset does not contain a dedicated churn label. Instead, it uses purchasing history, subscription status, and customer behavior to provide **retention-related insights and customer segmentation**.

---

# Tools & Technologies

### Programming & Data Analysis
- Python
- Pandas
- Google Colab

### Database & SQL
- MySQL
- SQL
- CTEs
- Window Functions
- Joins
- Subqueries
- Aggregate Functions

### Business Intelligence
- Power BI
- DAX
- Interactive Dashboards
- Data Visualization

### Version Control
- Git
- GitHub

---
### Built by Sneha Gubrele

---

📧 Email: snehagubrele55@gmail.com

🔗 LinkedIn: https://www.linkedin.com/in/snehagubrele55/

⭐ If you found this project interesting, feel free to star the repository.


# Project Structure

```text
ChurnLens-Customer-Retention-Analytics/
│
├── Notebooks/
│   └── Customer_Shopping_Data_Cleaning.ipynb
│
├── SQL/
│   ├── schema.sql
│   ├── data_cleaning.sql
│   └── analysis.sql
│
├── PowerBI/
│   └── Customer Shopping Behavior Dashboard.pbix
│
├── README.md
└── dataset/
    └── customer_shopping_clean.csv



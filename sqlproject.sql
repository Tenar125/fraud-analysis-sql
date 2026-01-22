CREATE DATABASE  if not exists fraud_analysis;
use fraud_analysis ;
select * from credittransactions ;
-- What is the total number of transactions?
select count(*) from credittransactions ;
-- insight there are 10000 rows 
-- What is the total number of fraud transactions?
select count(*) as Fraud_transactions from credittransactions
where is_fraud = 1 ;
-- Insight:Only about 151 of transactions are fraudulent, which means fraud is rare,
--  but it still matters a lot because even a few frauds can cause big losses.
-- What is the fraud rate (%)?
select 
(count(case when is_fraud= 1 then 1 end)/count(*))*100 as fraud_percent
from credittransactions ;
-- key insight
-- Only ~1.5% of transactions are fraudulent. Fraud is rare but critical 
-- to detect, so even a small percentage can cause significant losses.
-- What is the average transaction amount for fraud transactions?
select  
round(avg(amount),2) as avg_transaction_amount
from credittransactions 
where is_fraud= 1 ;
-- Insight “The average fraudulent transaction amount is 216.18, 
-- showing most frauds involve moderate amounts.”
-- What is the average transaction amount for non-fraud transactions?
select  
round(avg(amount),2) as avg_non_fraud_transactions
from credittransactions 
where is_fraud<> 1 ;
-- Insight:Average non-fraud transaction is 175.33,
-- lower than fraud transactions.”
-- Find the highest amount fraud transaction.
select max(amount) as highest_amount
from credittransactions
where is_fraud = 1  ;
-- Total transactions per customer.
select transaction_id,count(*) as total_transactions,sum(amount)
from credittransactions
group by transaction_id  ;
-- Total fraud transactions per customer.
select transaction_id , count(*) as total_fraud_transactions ,sum(amount)
from credittransactions
where is_fraud= 1 
group by transaction_id ; 
-- Top 5 customers with the highest number of fraud transactions.
select transaction_id , count(*) as total_fraud_transactions ,sum(amount)
from credittransactions
where is_fraud= 1 
group by transaction_id 
order by sum(amount) desc limit  5 ;
-- Hour-wise fraud count.
SELECT transaction_hour, COUNT(*) AS fraud_count
FROM credittransactions
WHERE is_fraud = 1
GROUP BY transaction_hour
ORDER BY transaction_hour limit  1 ;
-- Merchant category-wise fraud count
select merchant_category,count(*) as fraud_count 
from credittransactions
where is_fraud=1 
group by merchant_category ;
-- Highest fraud-rate  categories
select merchant_category,count(*) as fraud_count 
from credittransactions
where is_fraud=1 
group by merchant_category 
order by fraud_count desc ;
-- Top 5 high-risk merchants
select merchant_category,count(*) as fraud_count 
from credittransactions
where is_fraud=1 
group by merchant_category 
order by fraud_count desc  limit 5 ;
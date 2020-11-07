-- How can you isolate (or group) the transactions of each cardholder?
SELECT card_holder.name AS "Card Holder", COUNT(transaction.amount) AS "Count of Transaction per Card Holder"
FROM card_holder, transaction, credit_card
WHERE card_holder.id = credit_card.id_card_holder and credit_card.card = transaction.card
GROUP BY card_holder.name

-- Consider the time period 7:00 a.m. to 9:00 a.m.
-- What are the 100 highest transactions during this time period?
SELECT * FROM transaction
WHERE EXTRACT(HOUR FROM date)>= 7 AND EXTRACT(HOUR FROM date)<= 9
ORDER BY transaction.amount DESC LIMIT 100;

-- Count the transactions that are less than $2.00 per cardholder. 
SELECT card_holder.name, COUNT(DISTINCT transaction.id) as "Number of Customer Transactions Less than $2.00"
FROM card_holder LEFT JOIN credit_card ON card_holder.id = credit_card.id_card_holder
LEFT JOIN transaction ON credit_card.card = transaction.card
WHERE transaction.amount < '2'
GROUP BY card_holder.name
ORDER BY "Number of Customer Transactions Less than $2.00" DESC;

-- What are the top five merchants prone to being hacked using small transactions?
SELECT merchant.name, COUNT(DISTINCT transaction.id) as "Number of Merchant Transactions Less than $2.00"
FROM merchant LEFT JOIN transaction ON merchant.id = transaction.id_merchant 
WHERE transaction.amount < '2'
GROUP BY merchant.name
ORDER BY "Number of Merchant Transactions Less than $2.00" DESC LIMIT 5;

-- Create a view for each of the previous queries.

-- Create a view for isolating (or grouping) the transactions of each cardholder
CREATE VIEW transaction_by_cardholder AS
SELECT card_holder.name AS "Card Holder", COUNT(transaction.amount) AS "Count of Transaction per Card Holder"
FROM card_holder, transaction, credit_card
WHERE card_holder.id = credit_card.id_card_holder and credit_card.card = transaction.card
GROUP BY card_holder.name

-- Create view for query of transactions during a specified time period
-- Use entire table so you can GROUP BY credit card number to find potential fraud
CREATE VIEW transaction_by_timestamp AS
SELECT * FROM transaction
ORDER BY transaction.amount DESC;
-- Query transaction_by_timestamp
SELECT transaction_by_timestamp.card, COUNT(*) 
FROM transaction_by_timestamp
WHERE EXTRACT(HOUR FROM date)>= 11 AND EXTRACT(HOUR FROM date)<= 18
GROUP BY transaction_by_timestamp.card
ORDER BY COUNT(*) DESC;


-- Create view for query of transactions less than $2.00
CREATE VIEW possible_fraud_transactions AS
SELECT card_holder.name as "card holder name", merchant.name as "merchant name", COUNT(DISTINCT transaction.id)
FROM merchant, card_holder JOIN credit_card ON card_holder.id = credit_card.id_card_holder
JOIN transaction ON credit_card.card = transaction.card
WHERE transaction.amount < '2'
GROUP BY card_holder.name, merchant.name


-- Query possible_fraud_transactions
SELECT card_holder.name, merchant.name, COUNT(DISTINCT transaction.id) as "Number of Transactions Less than $2.00"
FROM merchant, card_holder JOIN credit_card ON card_holder.id = credit_card.id_card_holder
JOIN transaction ON credit_card.card = transaction.card
WHERE transaction.amount < '2'
GROUP BY card_holder.name, merchant.name
ORDER BY "Number of Transactions Less than $2.00" DESC;

-- ALTERNATIVE QUERY adding in merchant_category for: Count 
-- the transactions that are less than $2.00 per cardholder. 
SELECT card_holder.name, transaction.id_merchant, merchant_category.name,
COUNT(DISTINCT transaction.id_merchant) as "Number of Customer Transactions Less than $2.00"
FROM card_holder LEFT JOIN credit_card ON card_holder.id = credit_card.id_card_holder
LEFT JOIN transaction ON credit_card.card = transaction.card
LEFT JOIN merchant_category ON transaction.id_merchant = transaction.id_merchant
WHERE transaction.amount < '2'
GROUP BY card_holder.name, transaction.id_merchant, merchant_category.name
ORDER BY "Number of Customer Transactions Less than $2.00" DESC;



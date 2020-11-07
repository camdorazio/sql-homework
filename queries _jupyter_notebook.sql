-- Query to create dataframe for transactions
SELECT credit_card.id_card_holder, transaction.date, CAST(transaction.amount as numeric), transaction.card
FROM transaction JOIN credit_card ON transaction.card = credit_card.card;

-- Query data for card holder 2 and 18 to create dataframe for plotting
SELECT credit_card.id_card_holder, transaction.date, CAST(transaction.amount as numeric), transaction.card
FROM transaction JOIN credit_card ON transaction.card = credit_card.card
WHERE credit_card.id_card_holder = 2;

SELECT credit_card.id_card_holder, transaction.date, CAST(transaction.amount as numeric), transaction.card
FROM transaction JOIN credit_card ON transaction.card = credit_card.card
WHERE credit_card.id_card_holder = 18;

SELECT credit_card.id_card_holder, transaction.date, CAST(transaction.amount as numeric), transaction.card
FROM transaction JOIN credit_card ON transaction.card = credit_card.card
WHERE credit_card.id_card_holder IN (2,18);

-- Query for daily transactions from Jan to Jun 2018 for card holder 25
-- Note all transactions in the file are for Year 2018 only.
SELECT credit_card.id_card_holder, CAST(EXTRACT(MONTH FROM transaction.date) AS INT) AS date_month, 
CAST(transaction.amount as numeric), transaction.card
FROM transaction JOIN credit_card ON transaction.card = credit_card.card
WHERE credit_card.id_card_holder = 25 
AND CAST(EXTRACT(MONTH FROM transaction.date) AS INT) < 7;

-- ALTERNATIVE Query for daily transactions from Jan to Jun 2018 
-- for card holder 25 that includes merchant_category
SELECT credit_card.id_card_holder, CAST(EXTRACT(MONTH FROM transaction.date) AS INT) AS date_month, 
CAST(transaction.amount as numeric), transaction.card, transaction.id
FROM transaction JOIN credit_card ON transaction.card = credit_card.card
LEFT JOIN merchant_category ON transaction.id_merchant = merchant_category.id
WHERE credit_card.id_card_holder = 25 
AND CAST(EXTRACT(MONTH FROM transaction.date) AS INT) < 7
AND transaction.card = '4319653513507'
ORDER BY CAST(transaction.amount as numeric) DESC LIMIT 10;

SELECT * FROM transaction
WHERE id IN (2582,
2840,
1415,
1790,
1341,
1377,
224,
329,
774,
2630
);

SELECT * FROM merchant_category

-- Check to see if card holder has more than 1 credit card (Yes, they both have 2)
SELECT card_holder.name, credit_card.card 
FROM card_holder JOIN credit_card ON card_holder.id = credit_card.id_card_holder
WHERE credit_card.id_card_holder = 2;

SELECT card_holder.name, credit_card.card 
FROM card_holder JOIN credit_card ON card_holder.id = credit_card.id_card_holder
WHERE credit_card.id_card_holder = 18;

SELECT card_holder.name, credit_card.card 
FROM card_holder JOIN credit_card ON card_holder.id = credit_card.id_card_holder
WHERE credit_card.id_card_holder = 25;

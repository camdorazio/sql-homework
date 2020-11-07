--Consider the time period 7:00 a.m. to 9:00 a.m.

	-What are the 100 highest transactions during this time period?

	Refer to "credit_card_fraud_query.sql" for SQL query of credit_card_fraud_db
	Refer to "top_100_highest_transactions.csv" file for output

	-Do you see any fraudulent or anomalous transactions?

	Looking at the results of the query, it is not overly obvious whether there are potential fraud transactions. 
	Typically,fraud transactions that are large dollar amounts happen quickly, on the same day, within 
	a short/specified time window. The other criteria to look at for fraud would be large purchase transactions
	with high end clothing retailers, electronics and car parts. Typically fraudsters tend to make purchases 
	with these types of merchants. In reviewing the results, I don't see any large transactions that happen in the 
	same day for the same card number. However, there are not any merchant_category for these types of transactions.
	Given that the merchant_category are establishments for dining only, it would be highly suspicous for 
	large transactions. Therefore, there seem to be anomalous and possible fraudulent transactions.

	-If you answered yes to the previous question, explain why you think there might be fraudulent 
	transactions during this time frame.

	In reviewing the results, there are 12 transactions over $25.00 and I would consider these as anomalous.
	id	date		amount		card		id_merchant	merchant_category
	3163	12/7/2018 7:22	$1,894.00 	4.76105E+18	9		3
	2451	3/5/2018 8:26	$1,617.00 	5.5706E+15	4		3
	2840	3/6/2018 7:18	$1,334.00 	4.31965E+12	87		3
	2461	12/21/2018 9:56	$1,301.00 	3.0143E+13	96		4
	1442	1/22/2018 8:07	$1,131.00 	5.5706E+15	144		1
	968	9/26/2018 8:48	$1,060.00 	4.76105E+18	134		1
	1368	9/6/2018 8:28	$1,017.00 	4.76105E+18	135		3
	1620	3/26/2018 7:41	$1,009.00 	3.0182E+13	111		2
	136	7/18/2018 9:19	$974.00 	3.4412E+14	19		4
	208	12/14/2018 8:51	$748.00 	5.0188E+11	96		4
	2240	11/23/2018 9:08	$233.00 	5.0188E+11	47		1
	774	4/1/2018 7:17	$100.00 	4.31965E+12	111		2

	Let's take a closer look at these 12 transactions that are outliers.
	It's reasonable to believe that the last transaction for $100 at a coffee shop would not be a fraudelent
	transaction. The customer may have bought a mug or perhaps a few bags of coffee or even a gift card.

	The other 11 transactions could be some type of fraud. Observations and action items:
		a. What are the operating hours of the merchants in category 1 (restaurants), category 3 (bars),
	   	and category 4 (pub). If none of these establishments are open between the hours of 7AM and 9AM,
	   	these are definitely	fraudulent transactions. If they are open for breakfast hours, some the charges
	   	may be valid as they are occuring around holidays (i.e. Thanksgiving on 11/23/2018, Christmas
	   	on 12/25/2018, or possibly a Jewish holiday - 4/1 could be Passover, 9/26 could be Sukkot). 
	   	We could call the customers to confirm the validity of transaction id's around the holidays.
		
		b. Transaction id 1620 for $1,009.00 for a coffee shop seems highly suspicous and could be fraud.
		
		c. Any other transactions I would consider to potentially be fraud. Transaction id's 2451, 2840, 1442,
	   	1368 and 136. 
		
		d. Transaction id 1368 is the same card as transaction 3163 and 968, so I would definitely call this 
	   	customer first to verify transactions.

		e. Are the customers paying their bills on time? If they are, there is no reason to believe any of 
		these transactions are fraudulent. They would just be anomolies and outliers.

-- Some fraudsters hack a credit card by making several small payments (generally less than $2.00), which are typically 
ignored by cardholders. 

	- Count the transactions that are less than $2.00 per cardholder. Is there any evidence to suggest that a credit 
	  card has been hacked? Explain your rationale.

	File:customer_transactions_under_2dollars.csv
	There are 350 total transactions under $2.00. It's difficult to immediately discern if any of the cards have been 
	hacked just by looking at the count results. With an additional query to provide merchant_category.name it's still
	a challange to see if any transactions would be considered fraudulent as the merchants could all potentially sell 
	items that are less than $2.00 in the normal course of business (i.e. a cup of coffee, a bottle of beer, a donut
	or a croissant, etc.). We would need more information about these customers such as where they live and cost of
	normal course of business items, review spending patterns of each customer (i.e. do they frequent the same establishments,
	daily, weekly, monthly, etc.) and hours of operation for each distinct merchant.

	- What are the top five merchants prone to being hacked using small transactions?

	Wood-Ramirez, Baker Inc, Hood-Phillips, Clark and Sons, and Atkinson Ltd

-- Verify if there are any fraudulent transactions in the history of two of the most important customers of the firm. 
For privacy reasons, you only know that their cardholders' IDs are 18 and 2.


	- Using hvPlot, create a line plot representing the time series of transactions over the course of the year for each 
	cardholder. In order to compare the patterns of both cardholders, create a line plot containing both lines.


	- What difference do you observe between the consumption patterns? Does the difference suggest a fraudulent 
	transaction? Explain your rationale.

	There is a noticeable difference in consumption patterns. Cardholder ID 2 has a consistent spending range between $0
	and $20 each month. Cardholder ID 18, seems to have large transactions (over $1000) about every 4-6 weeks. It is possible
	that Cardholder ID 18 may have some fraudelent activity, given the repeated pattern of high dollar amount transactions
	every 4-6 weeks. It would be prudent to call the cardholder to verify. But again, if the cardholder is paying their bill
	every month, there is no reason to believe there is fraud.

-- The CEO of the firm's biggest customer suspects that someone has used her corporate credit card without authorization in the 
first quarter of 2018 to pay for several expensive restaurant bills. You are asked to find any anomalous transactions during that period.


	- Using Plotly Express, create a series of six box plots, one for each month, in order to identify how many 
	outliers there are per month for cardholder ID 25.


	- Do you notice any anomalies? Describe your observations and conclusions.

	There are 2 transactions over $1,000 in the first quarter of 2018 (January and March) which are anomolies. However, 
	looking at the data for all 6 months, it appears that this employee may be having monthly lunches/dinners with clients.
	Again, there would need to be further investigation into where these transactions occurred. Looking at the raw data,
	all these large transactions are on the same card (card number = 4319653513507). Isolating these transactions, the one
	that seems to be most suspicious, and probably is fraud, is transaction.id = 1377 on 5/13/2018 (2nd quarter) for 
	$1,046.00 spent at a food truck.
 
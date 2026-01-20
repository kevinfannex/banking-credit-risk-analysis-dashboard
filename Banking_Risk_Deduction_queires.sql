SELECT * FROM public.banking_customer
LIMIT 10

-- Total Customer 
SELECT COUNT(*) AS total_customers FROM banking_customer;

-- risk label
SELECT DISTINCT risk_sensitivity FROM banking_customer;

-- Count customers by risk category

SELECT risk_sensitivity , COUNT(*) AS risk_category FROM banking_customer 
GROUP BY risk_sensitivity ;

-- Average income of the customer

SELECT ROUND(AVG(estimated_income :: numeric),2) AS Average_income From banking_customer ;

-- High Risk Customer
SELECT client_id , name ,nationality , bank_loans , risk_sensitivity From banking_customer
WHERE risk_sensitivity IN ('High_Risk' , 'Very_High_Risk') 
LIMIT 25;

--Customers with loans greater than income
SELECT name , bank_loans , estimated_income  FROM banking_customer
WHERE bank_loans > estimated_income ;

--Risk by occupation
select occupation , risk_sensitivity from banking_customer 
WHERE risk_sensitivity IN ('High_Risk' , 'Very_High_Risk')
group by occupation;

-- Customers with no savings but active loans
SELECT *
FROM banking_customer 
WHERE saving_accounts = 0 AND bank_loans > 0;

--Count of Risk by occupation 
SELECT occupation , COUNT(*) as high_risk_customer FROM banking_customer
where risk_sensitivity in ('High_Risk' , 'Very_High_Risk') 
group by occupation 
order by high_risk_customer desc;

--Debt ratio calculation
SELECT name , ROUND(((bank_loans + credit_card_balance)/estimated_income)::numeric ,2) AS debt_ratio  
FROM banking_customer ;

--Customers with debt ratio (>70%)
select name from banking_customer
where ((bank_loans + credit_card_balance)/estimated_income) > 0.7 ;

--Risk exposure by categor
SELECT risk_sensitivity,
       SUM(bank_loans) AS total_exposure
FROM banking_customer 
GROUP BY risk_sensitivity
ORDER BY total_exposure DESC ;

--High-risk customers with high exposure
select name , risk_sensitivity , bank_loans from banking_customer 
where risk_sensitivity in ('High_Risk','Very_High_Risk' ) and bank_loans > 500000 ;

--Loyal customers turning risky
select name , client_id , gender from banking_customer 
where loyalty_classification = 'Platinum' and risk_sensitivity in ('High_Risk','Very_High_Risk') 

--Portfolio risk percentage

select 
	sum(CASE WHEN risk_sensitivity in  ('High_Risk','Very_High_Risk') then bank_loans else 0 end)/sum(bank_loans)*100 as risk_portfolio_percentage
	from banking_customer ;

--Location-wise high-risk exposure
select location_id , sum(bank_loans) AS total_exposure 
FROM banking_customer 
where risk_sensitivity IN ('High_Risk','Very_High_Risk') 
group by location_id 
order by total_exposure ;

--Customers to block from lending (decision query)
select * from banking_customer
where ((bank_loans + credit_card_balance)/estimated_income) > 0.8
and risk_sensitivity = 'Very_High_Risk' ;

--Top 10 riskiest customers
select name , bank_loans , risk_sensitivity from banking_customer
order by risk_sensitivity  , bank_loans  ;





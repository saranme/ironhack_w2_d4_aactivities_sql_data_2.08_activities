Use bank;
/*2.08 Activity 1*/
/*
In this activity, we will be using the table district from the bank database and according to the description for the different columns:

A4: no. of inhabitants
A9: no. of cities
A10: the ratio of urban inhabitants
A11: average salary
A12: the unemployment rate

Rank districts by different variables.
*/
select *, row_number() over (order by A4 desc) as 'Position'
from bank.district;

select *, row_number() over (order by A9 desc) as 'Position'
from bank.district;

select *, row_number() over (order by A10 desc) as 'Position'
from bank.district;

select *, row_number() over (order by A11 desc) as 'Position'
from bank.district;

select *, row_number() over (order by A12 desc) as 'Position'
from bank.district;

select * , rank() over (partition by A3 order by A4 desc) as "Position"
from bank.district;

select * , rank() over (partition by A3 order by A9 desc) as "Position"
from bank.district;

select * , rank() over (partition by A3 order by A10 desc) as "Position"
from bank.district;

select * , rank() over (partition by A3 order by A11 desc) as "Position"
from bank.district;

select * , rank() over (partition by A3 order by A12 desc) as "Position"
from bank.district;

/*
Do the same but group by region.
*/
select * , rank() over (order by A12 desc) as "Position"
from district
GROUP BY A3;

/*2.08 Activity 2*/
/*
Use the transactions table in the bank database to find the 
Top 20 account_ids based on the amount.
*/
SELECT *,RANK() OVER(ORDER BY balance DESC) AS top_20_accounts
FROM trans
LIMIT 20;

/*
Illustrate the difference between rank() and dense_rank().
*/
SELECT *, DENSE_RANK() OVER(ORDER BY balance DESC) AS top_20_accounts
FROM trans
LIMIT 20;

/*2.08 Activity 3*/
/*Get a rank of districts ordered by the number of customers.*/
SELECT COUNT(*) n_customers, A3 AS district
FROM district
GROUP BY A3
ORDER BY COUNT(*) DESC;

/*Get a rank of regions ordered by the number of customers.*/
SELECT RANK() OVER(ORDER BY COUNT(*)), COUNT(*) n_customers, A3 AS district
FROM district
GROUP BY A3;
/*Get the total amount borrowed by the district together with the average 
loan in that district.*/
SELECT SUM(l.amount) total_amount, AVG(l.amount) avg_loan, d.A1 district_id
FROM loan l
JOIN account a
ON l.account_id = a.account_id
JOIN district d
ON d.A1 = a.district_id
GROUP BY d.A1
ORDER BY d.A1 ASC;

select a.district_id, sum(l.amount) as total_borrowed, avg(amount) over (partition by a.district_id) as avg_loan
from loan l join account a using(account_id)
group by district_id;

/*Get the number of accounts opened by district and year.*/
SELECT COUNT(*) n_accounts, YEAR(CONVERT(date, date)) year, d.A2,d.A1 district_id
FROM district d
JOIN account a
ON a.district_id = d.A1
GROUP BY YEAR(CONVERT(date, date)), d.A1, d.A2
order by d.A2, YEAR;

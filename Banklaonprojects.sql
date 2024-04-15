select * from bank_loan_data
use [Bank Loan DB]


----- find the total loan application----
select COUNT(id) as 'Total_loan_application' from  bank_loan_data 

----- find the month charges mom---
select COUNT(id) as 'PMTD_total_loan_application' from  bank_loan_data 
where MONTH(issue_date) = 11 AND  YEAR(issue_date)= 2021


select COUNT(id) as 'PMTD_total_loan_application' from  bank_loan_data 
where MONTH(issue_date) = 12 AND  YEAR(issue_date)= 2021
----(MTD-PMTD)/PMTD)-----


------secound KPI find the total founded amount   founded amount is loan amount ------


select SUM(loan_amount)  as 'MTD_Total_Founded_Amount'from bank_loan_data
where MONTH(issue_date)=12 and YEAR(issue_date)=2021

----find the previous month founded amount ----

select sum(loan_amount) as 'PMTD_Total_Founded_Amount' from bank_loan_data
where MONTH(issue_date)=11 and YEAR(issue_date)=2021


------ find the total recived amount is total amount in bankdata---- 
select SUM(total_payment) as  'MTD_Total_Amount_Recived' from bank_loan_data
where MONTH(issue_date)=12 and YEAR(issue_date)=2021

select SUM(total_payment) as 'PMTD_Total_Amount_Recived' from  bank_loan_data
where MONTH(issue_date)=11 and YEAR(issue_date) = 2021


---- find the Average the of intrest-----
select round(AVG(int_rate), 4)*100 as MTD_Avg_Interst_Rate from bank_loan_data
where MONTH(issue_date)=12 and YEAR(issue_date)=2021

select round(Avg(int_rate),4)*100 as PMTD_Avg_Interst_Rate from bank_loan_data
where MONTH(issue_date) = 11 and YEAR(issue_date)= 2021

---- find the avrage debt-to-income rectio-------
use  [Bank Loan DB]
select * from bank_loan_data

select Round(AVG(dti),4)*100 as MTD_Avg_dti from bank_loan_data
where MONTH(issue_date) = 12 and YEAR(issue_date) = 2021

select ROUND(AVG(dti),4)*100 as PMTD_Avg_dti from bank_loan_data
where MONTH(issue_date)= 11 and YEAR(issue_date)= 2021



--------scecound page-----

select * from bank_loan_data

select loan_status from bank_loan_data

--- find the good loan percentage-----

select(
	COUNT(case when loan_status = 'Fully Paid'  or  loan_status ='Current' then id end)*100)
	/
	COUNT(id) AS 'Good_loan_percentage'
	from bank_loan_data

------ find the good loan appliction----- appliction is equl to  our id

select COUNT(id) as Good_Loan_Appliction from bank_loan_data
where loan_status = 'Fully Paid' or loan_status = 'Current'

---- find the founded Amount means loan amount---
select SUM(loan_amount)as Good_Loan_founded_Amount from bank_loan_data
where loan_status ='Fully Paid' or loan_status ='Current'


---- find the Good_Loan_Amount_Received  work on  total amount----

select sum(total_payment) as Good_Loan_Received_Amount from bank_loan_data
where loan_status = 'Fully Paid' or loan_status = 'Current'


---- then  find the  bad loan
select (
	count(case when loan_status = 'Charged Off' then id end) *100.0)
	/
	COUNT(id) as Bad_Loan_Percentage 
	from bank_loan_data

	----- find the bad loan appliction
select  count(id) as Bad_Loan_Application from bank_loan_data
where loan_status = 'Charged Off'


---- find the bad loan funded ammount ---
select sum(loan_amount) as Bad_Loan_Funded_Amount from bank_loan_data
where loan_status = 'Charged Off'

---- find the  bad laon  received anount 
SELECT SUM(total_payment) AS Bad_Loan_amount_received FROM bank_loan_data
WHERE loan_status = 'Charged Off'



----- find the  Loan  Status grid view----
--1) find the lon status
select 
	loan_status,
	COUNT(id) as  Total_Loan_Appliction,
	sum(total_payment) as Total_Received_Amount,
	sum(loan_amount) as Total_Funded_Amount,
	AVG(int_rate*100) as Interst_Rate,
	AVG(dti*100) as dit
	from
		bank_loan_data
	group by 
		loan_status
 --- find the MTD
		SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status



----- banl loan report---
--MONTH
SELECT 
	MONTH(issue_date) AS Month_Munber, 
	DATENAME(MONTH, issue_date) AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)


--STATE
SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state

----TERM
SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY term
ORDER BY term

---EMPLOYEE LENGTH
SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length

----PURPOSE
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose


--HOME OWNERSHIP
SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership


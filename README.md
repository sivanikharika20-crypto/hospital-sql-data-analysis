\## Hospital Management System – SQL Data Analysis Project



\## Project Overview

This project analyzes hospital operational data using SQL.

The objective is to extract meaningful insights about patients, doctors, appointments, treatments, and hospital revenue.



The dataset simulates a hospital management system with multiple relational tables.

Using SQL queries, the project explores patient visits, treatment costs, and billing information.



\---



\## Database Structure



The database contains 5 relational tables.



\### 1. Patients

Stores patient demographic and registration details.

2\. Doctors

Stores doctor information and specialization.

3\. Appointments

Tracks patient visits to doctors.

4\. Treatments

Stores treatment details and cost.

5\. Billing

Stores billing and payment information.



\---



\## SQL Concepts Used



This project demonstrates the following SQL concepts:



SELECT statements

Filtering using WHERE

Aggregate functions (SUM, AVG, COUNT)

GROUP BY

JOIN operations

Subqueries

Window Functions

Views

Business analysis queries



\---



\## Key Business Questions



Which doctor handles the most appointments?

Which treatment generates the highest revenue?

What is the total hospital revenue?

Which payment method is used most frequently?

Which patients have the highest medical expenses?

Which specialization performs the most treatments?

What is the monthly revenue trend?



\---



\## Example SQL Queries



Total Hospital Revenue



SELECT SUM(amount) AS total\_revenue

FROM billing;



Doctor with Most Appointments



SELECT d.first\_name, d.last\_name, COUNT(a.appointment\_id) AS total\_appointments

FROM doctors d

JOIN appointments a

ON d.doctor\_id = a.doctor\_id

GROUP BY d.doctor\_id

ORDER BY total\_appointments DESC;



Most Profitable Treatment Type



SELECT treatment\_type, SUM(cost) AS total\_revenue

FROM treatments

GROUP BY treatment\_type

ORDER BY total\_revenue DESC;



\---



\## Tools Used



MySQL

MySQL Workbench

GitHub



\---



\## Project Insights



Certain doctor specializations handle more appointments than others.

Some treatments contribute more to hospital revenue.

A small group of patients account for higher medical expenses.

Payment methods vary across billing records.

Revenue trends can help hospitals plan resources and operations.



\---



\## Author



Sivanikharika R

SQL Data Analysis Project


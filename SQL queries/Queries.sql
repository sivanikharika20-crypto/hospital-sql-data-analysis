-- Showing tables
USE hospital_managment;
SHOW TABLES;

-- Total Patients in the Hospital
SELECT COUNT(*) AS Total_patients FROM patients;

-- Doctors and Their Specializations
SELECT first_name, last_name, specialization FROM doctors;

-- Doctor Count by Specialization
SELECT specialization, COUNT(*) AS Doctor_count FROM doctors
GROUP BY specialization;

-- Total Number of Appointments
SELECT COUNT(*) AS Total_appointments FROM appointments;

-- Completed Appointments
SELECT * FROM appointments
WHERE status = 'Completed';

-- Total Revenue Generated
SELECT ROUND(SUM(amount),2) AS Total_revenue FROM billing;

-- Revenue by Payment Method
SELECT payment_method, ROUND(SUM(amount),2) AS Revenue FROM billing
GROUP BY payment_method;

-- Payment Status 
SELECT payment_status, COUNT(*) AS Total FROM billing
GROUP BY payment_status;

-- Average Cost of Treatments
SELECT ROUND(AVG(cost),2) AS Avg_treatment_cost FROM treatments;

-- Patient Appointment Details
SELECT p.first_name, p.last_name, a.appointment_date, a.status
FROM patients AS p
JOIN appointments AS a
ON p.patient_id = a.patient_id;

-- Doctor Appointment Schedule
SELECT d.first_name, d.last_name, d.specialization, a.appointment_date
FROM doctors AS d
JOIN appointments AS a
ON d.doctor_id = a.doctor_id;

-- Treatments Received by Patients
SELECT p.first_name, p.last_name, t.treatment_type, t.cost
FROM treatments AS t
JOIN appointments AS a ON t.appointment_id = a.appointment_id
JOIN patients p ON a.patient_id = p.patient_id;

-- Billing Details for Each Patient
SELECT p.first_name, p.last_name, b.amount, b.payment_status
FROM billing AS b
JOIN patients AS p
ON b.patient_id = p.patient_id;

-- Highest Treatment Cost
SELECT treatment_type, MAX(cost) AS Highest_cost FROM treatments
GROUP BY treatment_type;

-- Revenue Generated per Treatment Type
SELECT treatment_type, ROUND(SUM(cost),2) AS Total_revenue FROM treatments
GROUP BY treatment_type;

-- Experienced Doctors
SELECT first_name, last_name, years_experience FROM doctors
WHERE years_experience > 20;

-- Patients Paying Above Average Bill
SELECT patient_id, amount FROM billing
WHERE amount > (SELECT AVG(amount) FROM billing);

-- Ranking Treatments by Cost
SELECT treatment_type, cost,
RANK() OVER (ORDER BY cost DESC) AS Cost_rank FROM treatments;
  
-- Running Total Revenue
SELECT bill_date, amount,
SUM(amount) OVER (ORDER BY bill_date) AS Running_revenue FROM billing;  

-- Create Revenue Summary View
CREATE VIEW revenue_summary AS
SELECT payment_method,
ROUND(SUM(amount),2) AS total_revenue FROM billing
GROUP BY payment_method;
SELECT * FROM revenue_summary;

-- Doctors with Highest Number of Appointments
SELECT d.first_name, d.last_name,
COUNT(a.appointment_id) AS Total_appointments
FROM doctors d
JOIN appointments a
ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.first_name, d.last_name
ORDER BY Total_appointments DESC;

-- Most Profitable Treatment Type
SELECT treatment_type, ROUND(SUM(cost),2) AS Total_revenue FROM treatments
GROUP BY treatment_type
ORDER BY total_revenue DESC;

-- Most Used Payment Method
SELECT payment_method, COUNT(*) AS Total_transactions FROM billing
GROUP BY payment_method
ORDER BY total_transactions DESC;

-- Monthly Revenue Analysis
SELECT MONTH(bill_date) AS Month_,
ROUND(SUM(amount),2) AS monthly_revenue FROM billing
GROUP BY Month_
ORDER BY Month_;

-- Top Spending Patients
SELECT p.first_name,p.last_name,
ROUND(SUM(b.amount),2)AS total_spent
FROM patients AS p
JOIN appointments AS a 
ON p.patient_id = a.patient_id
JOIN treatments AS t 
ON a.appointment_id = t.appointment_id
JOIN billing AS b 
ON t.treatment_id = b.treatment_id
GROUP BY p.patient_id, p.first_name, p.last_name
ORDER BY total_spent DESC;

-- Treatments by Doctor Specialization
SELECT d.specialization, COUNT(t.treatment_id) AS Total_treatments
FROM doctors AS d
JOIN appointments AS a 
ON d.doctor_id = a.doctor_id
JOIN treatments t 
ON a.appointment_id = t.appointment_id
GROUP BY d.specialization
ORDER BY Total_treatments DESC;

-- Average Treatment Cost by Type
SELECT treatment_type, ROUND(AVG(cost),2) AS Avg_cost FROM treatments
GROUP BY treatment_type
ORDER BY Avg_cost DESC;

-- Expensive Treatments
SELECT treatment_type, cost FROM treatments
WHERE cost > (SELECT AVG(cost) FROM treatments)
ORDER BY cost DESC;

-- Doctor Revenue Contribution
SELECT d.first_name, d.last_name, ROUND(SUM(b.amount),2) AS total_revenue
FROM doctors d
JOIN appointments a 
ON d.doctor_id = a.doctor_id
JOIN treatments t 
ON a.appointment_id = t.appointment_id
JOIN billing b 
ON t.treatment_id = b.treatment_id
GROUP BY d.doctor_id, d.first_name, d.last_name
ORDER BY total_revenue DESC;

-- Pending Payments Summary
SELECT COUNT(*) AS pending_bills,
ROUND(SUM(amount),2) AS total_pending_amount FROM billing
WHERE payment_status = 'Pending';
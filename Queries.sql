--1. How many employees are there in total?

CREATE VIEW Total_employees AS 
SELECT COUNT(employee_id) AS total_employees
FROM hr_analytics;

SELECT * FROM Total_employees


--2. Count of employees by gender:

CREATE VIEW emp_gender AS 
SELECT gender, COUNT(*) AS count
FROM hr_analytics
GROUP BY gender;

SELECT * FROM emp_gender


--3. State-wise employee count:

CREATE VIEW emp_state AS 
SELECT state, COUNT(*) AS employee_count
FROM hr_analytics
GROUP BY state
ORDER BY employee_count DESC;

SELECT * FROM emp_state

--4. Employee work location:

CREATE VIEW emp_location AS 
SELECT work_location_type,
COUNT (*) AS employee_count
FROM hr_analytics
GROUP BY work_location_type;

SELECT * FROM emp_location


--5. Number and avg salary by department:

CREATE VIEW avg_salary AS 
SELECT 
  department,
  COUNT(*) AS employee_count,
  ROUND(AVG(annual_salary_lpa), 0) AS avg_salary_lpa
FROM hr_analytics
GROUP BY department
ORDER BY department;

SELECT * FROM avg_salary


--6. Avg performance and avg satisfaction rating by deparment:

CREATE VIEW avg_rating  AS
SELECT 
  department,
  ROUND(AVG(performance_rating), 1) AS avg_performance_rating,
  ROUND(AVG(satisfaction_rating), 1) AS avg_satisfaction_rating
FROM hr_analytics
GROUP BY department
ORDER BY department;

SELECT * FROM avg_rating  


--7. Top 10 highest paid employees:

CREATE VIEW top10_emp AS 
SELECT employee_id, full_name, department, annual_salary_lpa, job_role
FROM hr_analytics
ORDER BY annual_salary_lpa DESC
LIMIT 10;

SELECT * FROM top10_emp


--8. count of promotions by year and department:

CREATE VIEW promo_count AS 
SELECT 
  last_promotion_year,
  department,
  COUNT(*) AS promotion_count
FROM hr_analytics
WHERE last_promotion_year IS NOT NULL
GROUP BY last_promotion_year, department
ORDER BY last_promotion_year, department;

SELECT * FROM promo_count


--9. Are there any employees working overtime with below average satisfaction?

CREATE VIEW overtime_emp AS 
SELECT employee_id, full_name, department, satisfaction_rating
FROM hr_analytics
WHERE overtime = 'Yes'
  AND satisfaction_rating < (
    SELECT AVG(satisfaction_rating)
    FROM hr_analytics
  );

SELECT * FROM overtime_emp

--10. Experience bands with average salary and satisfaction:

CREATE VIEW exp_band AS 
SELECT 
  CASE 
    WHEN experience_years < 6 THEN '0-5 yrs'
    WHEN experience_years BETWEEN 6 AND 10 THEN '6-10 yrs'
    WHEN experience_years BETWEEN 10 AND 15 THEN '10-15 yrs'
    ELSE '15+ yrs'
  END AS experience_band,
  ROUND(AVG(annual_salary_lpa), 0) AS avg_salary,
  ROUND(AVG(satisfaction_rating), 1) AS avg_satisfaction
FROM hr_analytics
GROUP BY experience_band
order by experience_band;

SELECT * FROM exp_band



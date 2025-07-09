--1. How many employees are there in total?

SELECT COUNT(employee_id) AS total_employees
FROM hr_analytics;


--2. Count of employees by gender:

SELECT gender, COUNT(*) AS count
FROM hr_analytics
GROUP BY gender;


--3. State-wise employee count:

SELECT state, COUNT(*) AS employee_count
FROM hr_analytics
GROUP BY state
ORDER BY employee_count DESC;


--4. Employee work location:

SELECT work_location_type,
COUNT (*) AS employee_count
FROM hr_analytics
GROUP BY work_location_type;



--5. Number and avg salary by department:

SELECT 
  department,
  COUNT(*) AS employee_count,
  ROUND(AVG(annual_salary_lpa), 0) AS avg_salary_lpa
FROM hr_analytics
GROUP BY department
ORDER BY department;


--6. Avg performance and avg satisfaction rating by deparment:

SELECT 
  department,
  ROUND(AVG(performance_rating), 1) AS avg_performance_rating,
  ROUND(AVG(satisfaction_rating), 1) AS avg_satisfaction_rating
FROM hr_analytics
GROUP BY department
ORDER BY department;

--7. Top 10 highest paid employees:

SELECT employee_id, full_name, department, annual_salary_lpa, job_role
FROM hr_analytics
ORDER BY annual_salary_lpa DESC
LIMIT 10;


--8. count of promotions by year and department:

SELECT 
  last_promotion_year,
  department,
  COUNT(*) AS promotion_count
FROM hr_analytics
WHERE last_promotion_year IS NOT NULL
GROUP BY last_promotion_year, department
ORDER BY last_promotion_year, department;


--9. Are there any employees working overtime with below average satisfaction?

SELECT employee_id, full_name, department, satisfaction_rating
FROM hr_analytics
WHERE overtime = 'Yes'
  AND satisfaction_rating < (
    SELECT AVG(satisfaction_rating)
    FROM hr_analytics
  );

--10. Experience bands with average salary and satisfaction:

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



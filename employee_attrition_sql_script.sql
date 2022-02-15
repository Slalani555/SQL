CREATE DATABASE employee_attrition;

SELECT * 
FROM employee_attrition;

SELECT Count(*) 
FROM employee_attrition 
WHERE Attrition='Yes';

-- Filtering data based on Department and Gender
SELECT E.EmployeeNumber,
E.Attrition,
E.Department,
E.Gender,
E.HourlyRate
FROM employee_attrition E
WHERE (E.Department='Sales' OR E.Department='Human Resources') AND 
(E.Gender='Female');


SELECT Department,max(HourlyRate) as max_hourly_rate
FROM employee_attrition
group by Department;

-- Window Functions
SELECT E.*,
max(HourlyRate) over(partition by Department) as max_hourly_rate
from employee_attrition E;

-- Window Functions row_number,rank,dense_rank,lead and lag.
SELECT E.*,
row_number() over(partition by Department) as row_num 
FROM employee_attrition E;

-- Fetch the first 2 employees from each department to attrite.
SELECT * FROM(
SELECT E.*,
row_number() over(partition by Department order by EmployeeNumber) as row_num 
FROM employee_attrition E
WHERE Attrition='Yes') x
WHERE x.row_num<3;

-- Fetch the top 3 employees in each department earning max hourly rate
SELECT * FROM(
SELECT E.EmployeeNumber,
E.Department,
E.HourlyRate,
rank() over(partition by Department order by HourlyRate desc) as rnk
FROM employee_attrition E)x
WHERE x.rnk<4;

SELECT E.EmployeeNumber,
E.Department,
E.HourlyRate,
E.MonthlyIncome,
rank() over(partition by Department order by MonthlyIncome desc) as rnk,
dense_rank() over(partition by Department order by MonthlyIncome desc) as Dense_rnk,
row_number() over(partition by Department order by MonthlyIncome desc) as row_num 
FROM employee_attrition E;


SELECT E.EmployeeNumber,
E.Department,
E.HourlyRate,
lag(HourlyRate) over(partition by Department order by EmployeeNumber) as prev_emp_hourly_rate,
lead(HourlyRate) over(partition by Department order by EmployeeNumber) as next_emp_hourly_rate
FROM employee_attrition E;

-- Display if the hourly rate is higher, lower or equal to the previous employee.
SELECT E.EmployeeNumber,
E.Department,
E.HourlyRate,
lag(HourlyRate) over(partition by Department order by EmployeeNumber) as prev_emp_hourly_rate,
case when E.HourlyRate >lag(HourlyRate) over(partition by Department order by EmployeeNumber) then 'Higher than previous employee'
     when E.HourlyRate <lag(HourlyRate) over(partition by Department order by EmployeeNumber) then 'Lower than previous employee'
     when E.HourlyRate =lag(HourlyRate) over(partition by Department order by EmployeeNumber) then 'Same as previous employee'
     end Hourly_rate_range
FROM employee_attrition E;








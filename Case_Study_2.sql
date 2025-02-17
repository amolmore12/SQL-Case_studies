--LOCATION TABLE
CREATE TABLE LOCATION_1(
LOCATION_ID INT,
CITY VARCHAR(100));

INSERT INTO LOCATION_1
(LOCATION_ID, CITY) VALUES 
(122, 'NEW YORK'),
(123, 'DALLAS'),
(124, 'CHICAGO'),
(167, 'BOSTAN');

--DROP TABLE DEPARTMENT--;

--DEPARTMENT TABLE
CREATE TABLE DEPARTMENT(
DEPARTMENT_ID INT, 
NAME VARCHAR(100), 
LOCATION_ID INT);

INSERT INTO DEPARTMENT
(DEPARTMENT_ID,NAME,LOCATION_ID) VALUES
(10,'ACCOUTING',122),
(20,'SALES',124),
(30,'RESEARCH',123),
(40,'OPRATIONS',167);

--JOB TABLE
CREATE TABLE JOB(
JOB_ID INT,
DESIGANATION VARCHAR(100)
);

INSERT INTO JOB
(JOB_ID,DESIGANATION) VALUES
(667,'CLERK'),
(668,'STAFF'),
(669,'ANALYST'),
(670,'SALES PERSON'),
(671,'MANAGER'),
(672,'PRESIDENT');
 
--EMPLOYEES Table
CREATE TABLE EMPLOYEES_1 (
    EMPLOYEE_ID INT,
    LAST_NAME VARCHAR(100),
    FIRST_NAME VARCHAR(100),
    MIDDLE_NAME VARCHAR(100),
    JOB_ID INT,
    HIRE_DATE DATE,
    SALARY INT,
    COMM VARCHAR(100),
    DEPARTMENT_ID INT
);

-- Insert Records into EMPLOYEES
INSERT INTO EMPLOYEES_1 (EMPLOYEE_ID, LAST_NAME, FIRST_NAME, MIDDLE_NAME, JOB_ID, HIRE_DATE, SALARY, COMM, DEPARTMENT_ID) VALUES
(7369, 'Smith', 'John', 'Q', 667, '1984-12-17', 800, NULL, 20),
(7499, 'Allen', 'Kevin', 'J', 670, '1985-02-20', 1600, '300', 30),
(755, 'Doyle', 'Jean', 'K', 671, '1985-04-04', 2850, NULL, 30),
(756, 'Dennis', 'Lynn', 'S', 671, '1985-05-15', 2750, NULL, 30),
(757, 'Baker', 'Leslie', 'D', 671, '1985-06-10', 2200, NULL, 40),
(7521, 'Wark', 'Cynthia', 'D', 670, '1985-02-22', 1250, '50', 30);

--Simple Queries:

--#List all the employee details
SELECT * FROM EMPLOYEES_1;

--#List all the department details.
SELECT * FROM DEPARTMENT;

--#List all job details
SELECT * FROM JOB;

--#List all the locations.
SELECT * FROM LOCATION_1;

--#List out the First Name, Last Name, Salary, Commission for all Employees.
SELECT FIRST_NAME, LAST_NAME, SALARY, COMM 
FROM EMPLOYEES_1;

--#List out the Employee ID, Last Name, Department ID for all employees and
--alias Employee ID as "ID of the Employee", Last Name as "Name of the Employee", Department ID as "Dep_id"
SELECT 
    EMPLOYEE_ID AS "ID of the Employee", 
    LAST_NAME AS "Name of the Employee", 
    DEPARTMENT_ID AS "Dep_id" 
FROM EMPLOYEES_1;

--#List out the annual salary of the employees with their names only
SELECT 
    FIRST_NAME, 
    LAST_NAME, 
    SALARY * 12 AS "Annual Salary" 
FROM EMPLOYEES_1;

--WHERE Condition:

--#List the details about "Smith"
SELECT *  FROM EMPLOYEES_1 WHERE LAST_NAME = 'Smith';

--#List out the employees who are working in department 20.
SELECT *  FROM EMPLOYEES_1  WHERE DEPARTMENT_ID = 20;

--#List out the employees who are earning salary between 2000 and 3000.
SELECT *  FROM EMPLOYEES_1  WHERE SALARY BETWEEN 2000 AND 3000;

--#List out the employees who are working in department 10 or 20.SELECT *  FROM EMPLOYEES_1  WHERE DEPARTMENT_ID IN (10, 20);

--#Find out the employees who are not working in department 10 or 30.SELECT *  FROM EMPLOYEES_1  WHERE DEPARTMENT_ID NOT IN (10, 30);

--# List out the employees whose name starts with 'L'
SELECT *  FROM EMPLOYEES_1  WHERE FIRST_NAME LIKE 'L%';

--#List out the employees whose name starts with 'L' and ends with 'E'.
SELECT * FROM EMPLOYEES_1  WHERE FIRST_NAME LIKE 'L%' AND FIRST_NAME LIKE '%E';

--#List out the employees whose name length is 4 and start with 'J'.
SELECT * FROM EMPLOYEES_1  WHERE FIRST_NAME LIKE 'J%' AND LEN(FIRST_NAME) = 4;

--#List out the employees who are working in department 30 and draw the salaries more than 2500.
SELECT * FROM EMPLOYEES_1  WHERE DEPARTMENT_ID = 30 AND SALARY > 2500;

--#List out the employees who are not receiving commission.
SELECT *  FROM EMPLOYEES_1  WHERE COMM IS NULL OR COMM = '';

--ORDER BY Clause:--#List out the Employee ID and Last Name in ascending order based on the Employee ID.SELECT EMPLOYEE_ID, LAST_NAME  FROM EMPLOYEES_1  ORDER BY EMPLOYEE_ID ASC;

--#List out the Employee ID and Name in descending order based on salary.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME  FROM EMPLOYEES_1 ORDER BY SALARY DESC;

--#List out the employee details according to their Last Name in ascending-order
SELECT *  FROM EMPLOYEES_1  ORDER BY LAST_NAME ASC;

--#List out the employee details according to their Last Name in ascending order and then Department ID in descending order
SELECT *  FROM EMPLOYEES_1  ORDER BY LAST_NAME ASC, DEPARTMENT_ID DESC;

--GROUP BY and HAVING Clause

--#List out the department wise maximum salary, minimum salary and average salary of the employees.
SELECT 
    DEPARTMENT_ID,
    MAX(SALARY) AS Max_Salary,
    MIN(SALARY) AS Min_Salary,
    AVG(SALARY) AS Avg_Salary
FROM EMPLOYEES_1
GROUP BY DEPARTMENT_ID;

--#List out the job wise maximum salary, minimum salary and average salary of the employees.
SELECT 
    JOB_ID,
    MAX(SALARY) AS Max_Salary,
    MIN(SALARY) AS Min_Salary,
    AVG(SALARY) AS Avg_Salary
FROM EMPLOYEES_1
GROUP BY JOB_ID;

--#List out the number of employees who joined each month in ascending order
SELECT 
    MONTH(HIRE_DATE) AS Hire_Month,
    COUNT(*) AS Number_of_Employees
FROM EMPLOYEES_1
GROUP BY MONTH(HIRE_DATE)
ORDER BY Hire_Month ASC;

--#List out the number of employees for each month and year in ascending order based on the year and month.SELECT 
    YEAR(HIRE_DATE) AS Hire_Year,
    MONTH(HIRE_DATE) AS Hire_Month,
    COUNT(*) AS Number_of_Employees
FROM EMPLOYEES_1
GROUP BY YEAR(HIRE_DATE), MONTH(HIRE_DATE)
ORDER BY Hire_Year ASC, Hire_Month ASC;

--#List out the Department ID having at least four employees
SELECT 
    DEPARTMENT_ID,
    COUNT(*) AS Number_of_Employees
FROM EMPLOYEES_1
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 4;

--#How many employees joined in February month.
SELECT COUNT(*) AS Number_of_Employees
FROM EMPLOYEES_1
WHERE MONTH(HIRE_DATE) = 2;

--#How many employees joined in May or June month
SELECT COUNT(*) AS Number_of_Employees
FROM EMPLOYEES_1
WHERE MONTH(HIRE_DATE) IN (5, 6);

--#How many employees joined in 1985?
SELECT COUNT(*) AS Number_of_Employees
FROM EMPLOYEES_1
WHERE YEAR(HIRE_DATE) = 1985;

--#How many employees joined each month in 1985?
SELECT 
    MONTH(HIRE_DATE) AS Hire_Month,
    COUNT(*) AS Number_of_Employees
FROM EMPLOYEES_1
WHERE YEAR(HIRE_DATE) = 1985
GROUP BY MONTH(HIRE_DATE)
ORDER BY Hire_Month ASC;

--#How many employees were joined in April 1985?SELECT COUNT(*) AS Number_of_Employees
FROM EMPLOYEES_1
WHERE MONTH(HIRE_DATE) = 4 AND YEAR(HIRE_DATE) = 1985;

--#Which is the Department ID having greater than or equal to 3 employees joining in April 1985?
SELECT 
    DEPARTMENT_ID,
    COUNT(*) AS Number_of_Employees
FROM EMPLOYEES_1
WHERE MONTH(HIRE_DATE) = 4 AND YEAR(HIRE_DATE) = 1985
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 3;

--Joins:

SELECT 
    A.EMPLOYEE_ID,
    A.FIRST_NAME,
    A.LAST_NAME,
    B.NAME
FROM EMPLOYEES_1 AS A
LEFT JOIN DEPARTMENT AS B
ON A.DEPARTMENT_ID = B.DEPARTMENT_ID;

--#Display employees with their designations
SELECT 
    A.EMPLOYEE_ID,
    A.FIRST_NAME,
    A.LAST_NAME,
    B.DESIGANATION
FROM EMPLOYEES_1 AS A
LEFT JOIN JOB AS B 
ON A.JOB_ID = B.JOB_ID;

--#Display the employees with their department names and city.
SELECT 
    A.EMPLOYEE_ID,
    A.FIRST_NAME,
    A.LAST_NAME,
    B.NAME,
    C.CITY
FROM EMPLOYEES_1 AS A
LEFT JOIN DEPARTMENT AS B
ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
LEFT JOIN LOCATION_1 C 
ON B.LOCATION_ID = C.LOCATION_ID;

--#How many employees are working in different departments? Display with department names.
SELECT 
    A.NAME,
    COUNT(B.EMPLOYEE_ID) AS Number_of_Employees
FROM DEPARTMENT AS A
LEFT JOIN EMPLOYEES_1 AS B
ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
GROUP BY A.NAME;

--#How many employees are working in the sales department?
SELECT COUNT(A.EMPLOYEE_ID) AS Number_of_Employees
FROM EMPLOYEES_1 AS A
LEFT JOIN DEPARTMENT AS B
ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
WHERE B.NAME = 'Sales';

--#Which is the department having greater than or equal to 3 employees and display the department names in ascending order.
SELECT 
    A.NAME,
    COUNT(B.EMPLOYEE_ID) AS Number_of_Employees
FROM DEPARTMENT AS A
LEFT JOIN EMPLOYEES_1 AS B
ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
GROUP BY A.NAME
HAVING COUNT(B.EMPLOYEE_ID) >= 3
ORDER BY A.NAME ASC;

--#How many employees are working in 'Dallas'?SELECT COUNT(A.EMPLOYEE_ID) AS Number_of_Employees
FROM EMPLOYEES_1 AS A
LEFT JOIN DEPARTMENT AS B
ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
LEFT JOIN LOCATION_1 AS C 
ON B.LOCATION_ID = C.LOCATION_ID
WHERE C.CITY = 'Dallas';

--#Display all employees in sales or operation departments.
SELECT 
    A.EMPLOYEE_ID,
    A.FIRST_NAME,
    A.LAST_NAME,
    B.NAME
FROM EMPLOYEES_1 AS A
LEFT JOIN DEPARTMENT AS B
ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
WHERE B.NAME IN ('SALES', 'OPERATIONS');

--CONDITIONAL STATEMENT

--#Display the employee details with salary grades. Use conditional statement to create a grade column.
SELECT 
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    SALARY,
    CASE 
        WHEN SALARY < 2000 THEN 'Grade D'
        WHEN SALARY BETWEEN 2000 AND 4000 THEN 'Grade C'
        WHEN SALARY BETWEEN 4001 AND 6000 THEN 'Grade B'
        ELSE 'Grade A'
    END AS Salary_Grade
FROM EMPLOYEES_1;

--#List out the number of employees grade wise. Use conditional statement to create a grade column.SELECT 
    CASE 
        WHEN SALARY < 2000 THEN 'Grade D'
        WHEN SALARY BETWEEN 2000 AND 4000 THEN 'Grade C'
        WHEN SALARY BETWEEN 4001 AND 6000 THEN 'Grade B'
        ELSE 'Grade A'
    END AS Salary_Grade,
    COUNT(*) AS Number_of_Employees
FROM EMPLOYEES_1
GROUP BY 
    CASE 
        WHEN SALARY < 2000 THEN 'Grade D'
        WHEN SALARY BETWEEN 2000 AND 4000 THEN 'Grade C'
        WHEN SALARY BETWEEN 4001 AND 6000 THEN 'Grade B'
        ELSE 'Grade A'
    END
ORDER BY Salary_Grade;

--#Display the employee salary grades and the number of employees between 2000 to 5000 range of salary.
SELECT 
    CASE 
        WHEN SALARY < 2000 THEN 'Grade D'
        WHEN SALARY BETWEEN 2000 AND 4000 THEN 'Grade C'
        WHEN SALARY BETWEEN 4001 AND 5000 THEN 'Grade B'
        ELSE 'Grade A'
    END AS Salary_Grade,
    COUNT(*) AS Number_of_Employees
FROM EMPLOYEES_1
WHERE SALARY BETWEEN 2000 AND 5000
GROUP BY 
    CASE 
        WHEN SALARY < 2000 THEN 'Grade D'
        WHEN SALARY BETWEEN 2000 AND 4000 THEN 'Grade C'
        WHEN SALARY BETWEEN 4001 AND 5000 THEN 'Grade B'
        ELSE 'Grade A'
    END
ORDER BY Salary_Grade;

--Subqueries:

--#Display the employees list who got the maximum salary
SELECT *
FROM EMPLOYEES_1
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEES_1);

--#Display the employees who are working in the sales department.
SELECT 
    A.EMPLOYEE_ID,
    A.FIRST_NAME,
    A.LAST_NAME,
    A.SALARY,
    B.NAME
FROM EMPLOYEES_1 AS A
LEFT JOIN DEPARTMENT AS B 
ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
WHERE B.NAME = 'Sales';

--#Display the employees who are working as 'Clerk'.SELECT 
    A.EMPLOYEE_ID,
    A.FIRST_NAME,
    A.LAST_NAME,
    A.SALARY,
    B.DESIGANATION
FROM EMPLOYEES_1 AS A
LEFT JOIN JOB AS B
ON A.JOB_ID = B.JOB_ID
WHERE B.DESIGANATION = 'Clerk';

--#Display the list of employees who are living in 'Boston'.
SELECT 
    A.EMPLOYEE_ID,
    A.FIRST_NAME,
    A.LAST_NAME,
    B.NAME,
	C.CITY
FROM EMPLOYEES_1 AS A
LEFT JOIN DEPARTMENT AS B
ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
LEFT JOIN LOCATION_1 C
ON B.LOCATION_ID = C.LOCATION_ID
WHERE C.CITY = 'Boston';

--#Find out the number of employees working in the sales department.
SELECT COUNT(A.EMPLOYEE_ID) AS Number_of_Employees
FROM EMPLOYEES_1 AS A
LEFT JOIN DEPARTMENT AS B
ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
WHERE B.NAME = 'Sales';

--#Update the salaries of employees who are working as clerks on the basis of 10%.
UPDATE EMPLOYEES_1
SET SALARY = SALARY * 1.10
WHERE JOB_ID IN (SELECT JOB_ID FROM JOB WHERE DESIGANATION = 'Clerk');

--#Display the second highest salary drawing employee details.
SELECT *
FROM EMPLOYEES_1
WHERE SALARY = (
    SELECT DISTINCT SALARY
    FROM EMPLOYEES_1
    ORDER BY SALARY DESC
    OFFSET 1 ROWS FETCH NEXT 1 ROWS ONLY
);

--#List out the employees who earn more than every employee in department 30
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
FROM EMPLOYEES_1
SELECT MAX(SALARY) AS Max_Salary
FROM EMPLOYEES_1
WHERE DEPARTMENT_ID = 30;

--#Find out which department has no employees.SELECT A.DEPARTMENT_ID, A.NAME
FROM DEPARTMENT AS A
LEFT JOIN EMPLOYEES_1 AS B 
ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
WHERE B.EMPLOYEE_ID IS NULL;

--#Find out the employees who earn greater than the average salary for their department.
SELECT A.*
FROM EMPLOYEES_1 AS A
LEFT JOIN (
    SELECT DEPARTMENT_ID, AVG(SALARY) AS Avg_Salary
    FROM EMPLOYEES_1
    GROUP BY DEPARTMENT_ID
) AS AvgSalaries ON A.DEPARTMENT_ID = AvgSalaries.DEPARTMENT_ID
WHERE A.SALARY > AvgSalaries.Avg_Salary;

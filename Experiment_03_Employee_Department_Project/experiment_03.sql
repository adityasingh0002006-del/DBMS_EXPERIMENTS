-- ============================================================
-- EXPERIMENT 3
-- Employee-Department-Project Database
-- CO2
-- ============================================================

-- 1. CREATE TABLES

CREATE TABLE Department (
   Dept_ID INT PRIMARY KEY,
   Dept_Name VARCHAR(50),
   Location VARCHAR(50)
);

CREATE TABLE Project (
   Project_ID INT PRIMARY KEY,
   Project_Name VARCHAR(100),
   Budget DECIMAL(12,2)
);

CREATE TABLE Employee (
   Emp_ID INT PRIMARY KEY,
   Emp_Name VARCHAR(50),
   Salary DECIMAL(10,2),
   Job_Role VARCHAR(50),
   Dept_ID INT,
   Project_ID INT,
   FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID),
   FOREIGN KEY (Project_ID) REFERENCES Project(Project_ID)
);


-- 2. INSERT DATA INTO DEPARTMENT

INSERT INTO Department (Dept_ID, Dept_Name, Location) VALUES
(1, 'Human Resources', 'Delhi'),
(2, 'Information Technology', 'Chandigarh'),
(3, 'Finance', 'Mumbai'),
(4, 'Marketing', 'Bangalore'),
(5, 'Research and Development', 'Hyderabad');


-- 3. INSERT DATA INTO PROJECT

INSERT INTO Project (Project_ID, Project_Name, Budget) VALUES
(101, 'Website Development', 500000),
(102, 'Mobile Application', 750000),
(103, 'Cyber Security System', 900000),
(104, 'Data Analytics Platform', 850000),
(105, 'AI Chatbot', 1200000),
(106, 'Cloud Migration', 1000000),
(107, 'Payroll Management', 400000),
(108, 'Market Research System', 600000);


-- 4. INSERT DATA INTO EMPLOYEE

INSERT INTO Employee (Emp_ID, Emp_Name, Salary, Job_Role, Dept_ID, Project_ID)
VALUES
(1, 'Aarav Sharma', 45000, 'HR Executive', 1, 107),
(2, 'Ananya Gupta', 52000, 'HR Manager', 1, 107),
(3, 'Riya Verma', 48000, 'Recruiter', 1, 107),
(4, 'Karan Singh', 55000, 'HR Analyst', 1, 107),
(5, 'Priya Mehta', 60000, 'HR Manager', 1, 107),

(6, 'Rahul Kumar', 75000, 'Software Engineer', 2, 101),
(7, 'Neha Sharma', 82000, 'Software Engineer', 2, 102),
(8, 'Aditya Singh', 95000, 'Security Engineer', 2, 103),
(9, 'Simran Kaur', 88000, 'Data Analyst', 2, 104),
(10, 'Vivek Gupta', 105000, 'Cloud Engineer', 2, 106),
(11, 'Ishita Jain', 78000, 'Software Developer', 2, 101),
(12, 'Rohan Verma', 92000, 'AI Engineer', 2, 105),

(13, 'Aman Yadav', 65000, 'Financial Analyst', 3, 107),
(14, 'Sneha Kapoor', 72000, 'Accountant', 3, 107),
(15, 'Mohit Agarwal', 85000, 'Finance Manager', 3, 107),
(16, 'Pooja Sharma', 68000, 'Financial Analyst', 3, 107),
(17, 'Nikhil Jain', 90000, 'Senior Accountant', 3, 107),
(18, 'Kriti Verma', 62000, 'Accountant', 3, 107),

(19, 'Arjun Malhotra', 58000, 'Marketing Executive', 4, 108),
(20, 'Tanya Singh', 70000, 'Marketing Manager', 4, 108),
(21, 'Yash Gupta', 62000, 'Marketing Analyst', 4, 108),
(22, 'Muskan Sharma', 75000, 'Brand Manager', 4, 108),
(23, 'Dev Kumar', 66000, 'Sales Executive', 4, 108),
(24, 'Naina Kapoor', 80000, 'Marketing Analyst', 4, 108),

(25, 'Kabir Sharma', 95000, 'Research Scientist', 5, 105),
(26, 'Meera Gupta', 88000, 'ML Engineer', 5, 105),
(27, 'Varun Singh', 92000, 'Research Analyst', 5, 104),
(28, 'Aditi Verma', 110000, 'AI Engineer', 5, 105),
(29, 'Harsh Jain', 98000, 'Data Scientist', 5, 104),
(30, 'Isha Kapoor', 85000, 'Research Engineer', 5, 103);


-- ============================================================
-- QUERIES
-- ============================================================

-- QUERY 1 – VERIFY EMPLOYEE RECORDS

SELECT * FROM Employee;


-- QUERY 2 – SELECTION

SELECT *
FROM Employee
WHERE Salary > 80000;


-- QUERY 3 – SELECTION USING DEPARTMENT

SELECT *
FROM Employee
WHERE Dept_ID = 2;


-- QUERY 4 – PROJECTION

SELECT Emp_ID, Emp_Name, Salary
FROM Employee;


-- QUERY 5 – AGGREGATE FUNCTIONS

SELECT
  COUNT(*) AS Total_Employees,
  AVG(Salary) AS Average_Salary,
  MAX(Salary) AS Highest_Salary,
  MIN(Salary) AS Lowest_Salary
FROM Employee;


-- QUERY 6 – SUM FUNCTION

SELECT SUM(Salary) AS Total_Salary
FROM Employee;


-- QUERY 7 – GROUP BY

SELECT Dept_ID, COUNT(*) AS Employee_Count
FROM Employee
GROUP BY Dept_ID;


-- QUERY 8 – GROUP BY WITH AVG()

SELECT Dept_ID, AVG(Salary) AS Average_Salary
FROM Employee
GROUP BY Dept_ID;


-- QUERY 9 – GROUP BY WITH HAVING

SELECT Dept_ID, COUNT(*) AS Employee_Count
FROM Employee
GROUP BY Dept_ID
HAVING COUNT(*) > 5;


-- QUERY 10 – CASE EXPRESSION

SELECT
  Emp_Name,
  Salary,
  CASE
    WHEN Salary >= 90000 THEN 'High Salary'
    WHEN Salary >= 70000 THEN 'Medium Salary'
    ELSE 'Low Salary'
  END AS Salary_Category
FROM Employee;


-- QUERY 11 – ORDER BY ASCENDING

SELECT Emp_ID, Emp_Name, Salary
FROM Employee
ORDER BY Salary ASC;


-- QUERY 12 – ORDER BY DESCENDING

SELECT Emp_ID, Emp_Name, Salary
FROM Employee
ORDER BY Salary DESC;


-- QUERY 13 – GROUP BY, HAVING AND ORDER BY

SELECT
  Dept_ID,
  COUNT(*) AS Employee_Count,
  AVG(Salary) AS Average_Salary
FROM Employee
GROUP BY Dept_ID
HAVING AVG(Salary) > 70000
ORDER BY Average_Salary DESC;


-- QUERY 14 – DEPARTMENT-WISE EMPLOYEE DETAILS

SELECT
  d.Dept_Name,
  COUNT(e.Emp_ID) AS Employee_Count,
  AVG(e.Salary) AS Average_Salary
FROM Department d
JOIN Employee e
ON d.Dept_ID = e.Dept_ID
GROUP BY d.Dept_ID, d.Dept_Name
ORDER BY Employee_Count DESC;


-- QUERY 15 – PROJECT-WISE EMPLOYEE COUNT

SELECT
  p.Project_Name,
  COUNT(e.Emp_ID) AS Employee_Count
FROM Project p
LEFT JOIN Employee e
ON p.Project_ID = e.Project_ID
GROUP BY p.Project_ID, p.Project_Name
ORDER BY Employee_Count DESC;

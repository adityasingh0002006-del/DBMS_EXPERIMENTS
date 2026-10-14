-- ============================================================
-- EXPERIMENT 5
-- Views and Recursive CTE
-- CO3
-- ============================================================

-- CREATE TABLES

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
   Manager_ID INT,
   FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID),
   FOREIGN KEY (Project_ID) REFERENCES Project(Project_ID)
);


-- INSERT DATA INTO DEPARTMENT

INSERT INTO Department VALUES
(1, 'Human Resources', 'Delhi'),
(2, 'Information Technology', 'Chandigarh'),
(3, 'Finance', 'Mumbai'),
(4, 'Marketing', 'Bangalore'),
(5, 'Research and Development', 'Hyderabad');


-- INSERT DATA INTO PROJECT

INSERT INTO Project VALUES
(101, 'Website Development', 500000),
(102, 'Mobile Application', 750000),
(103, 'Cyber Security System', 900000),
(104, 'Data Analytics Platform', 850000),
(105, 'AI Chatbot', 1200000),
(106, 'Cloud Migration', 1000000),
(107, 'Payroll Management', 400000),
(108, 'Market Research System', 600000);


-- INSERT DATA INTO EMPLOYEE

INSERT INTO Employee VALUES
(1, 'Aarav Sharma', 45000, 'HR Executive', 1, 107, NULL),
(2, 'Ananya Gupta', 52000, 'HR Manager', 1, 107, NULL),
(3, 'Riya Verma', 48000, 'Recruiter', 1, 107, 2),
(4, 'Karan Singh', 55000, 'HR Analyst', 1, 107, 2),
(5, 'Priya Mehta', 60000, 'HR Manager', 1, 107, NULL),
(6, 'Rahul Kumar', 75000, 'Software Engineer', 2, 101, 10),
(7, 'Neha Sharma', 82000, 'Software Engineer', 2, 102, 10),
(8, 'Aditya Singh', 95000, 'Security Engineer', 2, 103, 10),
(9, 'Simran Kaur', 88000, 'Data Analyst', 2, 104, 10),
(10, 'Vivek Gupta', 105000, 'Cloud Engineer', 2, 106, NULL),
(11, 'Ishita Jain', 78000, 'Software Developer', 2, 101, 10),
(12, 'Rohan Verma', 92000, 'AI Engineer', 2, 105, 10),
(13, 'Aman Yadav', 65000, 'Financial Analyst', 3, 107, 15),
(14, 'Sneha Kapoor', 72000, 'Accountant', 3, 107, 15),
(15, 'Mohit Agarwal', 85000, 'Finance Manager', 3, 107, NULL),
(16, 'Pooja Sharma', 68000, 'Financial Analyst', 3, 107, 15),
(17, 'Nikhil Jain', 90000, 'Senior Accountant', 3, 107, 15),
(18, 'Kriti Verma', 62000, 'Accountant', 3, 107, 15),
(19, 'Arjun Malhotra', 58000, 'Marketing Executive', 4, 108, 20),
(20, 'Tanya Singh', 70000, 'Marketing Manager', 4, 108, NULL),
(21, 'Yash Gupta', 62000, 'Marketing Analyst', 4, 108, 20),
(22, 'Muskan Sharma', 75000, 'Brand Manager', 4, 108, 20),
(23, 'Dev Kumar', 66000, 'Sales Executive', 4, 108, 20),
(24, 'Naina Kapoor', 80000, 'Marketing Analyst', 4, 108, 20),
(25, 'Kabir Sharma', 95000, 'Research Scientist', 5, 105, 28),
(26, 'Meera Gupta', 88000, 'ML Engineer', 5, 105, 28),
(27, 'Varun Singh', 92000, 'Research Analyst', 5, 104, 28),
(28, 'Aditi Verma', 110000, 'AI Engineer', 5, 105, NULL),
(29, 'Harsh Jain', 98000, 'Data Scientist', 5, 104, 28),
(30, 'Isha Kapoor', 85000, 'Research Engineer', 5, 103, 28);


-- VIEW 1 – DEPARTMENT SALARY SUMMARY

CREATE VIEW Department_Salary_Summary AS
SELECT
  d.Dept_ID,
  d.Dept_Name,
  COUNT(e.Emp_ID) AS Employee_Count,
  AVG(e.Salary) AS Average_Salary,
  SUM(e.Salary) AS Total_Salary,
  MAX(e.Salary) AS Highest_Salary,
  MIN(e.Salary) AS Lowest_Salary
FROM Department d
LEFT JOIN Employee e
ON d.Dept_ID = e.Dept_ID
GROUP BY d.Dept_ID, d.Dept_Name;

SELECT * FROM Department_Salary_Summary;


-- VIEW 2 – EMPLOYEE HIERARCHY

CREATE VIEW Employee_Hierarchy AS
SELECT
  e.Emp_ID,
  e.Emp_Name,
  e.Job_Role,
  e.Dept_ID,
  e.Manager_ID,
  m.Emp_Name AS Manager_Name
FROM Employee e
LEFT JOIN Employee m
ON e.Manager_ID = m.Emp_ID;

SELECT * FROM Employee_Hierarchy;


-- VIEW 3 – TEST VIEW UPDATABILITY

CREATE VIEW Employee_Basic_View AS
SELECT
  Emp_ID,
  Emp_Name,
  Salary,
  Dept_ID
FROM Employee;

UPDATE Employee_Basic_View
SET Salary = Salary + 1000
WHERE Emp_ID = 1;

SELECT * FROM Employee_Basic_View
WHERE Emp_ID = 1;


-- RECURSIVE CTE – REPORTING CHAIN

WITH RECURSIVE Reporting_Chain AS
(
  SELECT
    Emp_ID,
    Emp_Name,
    Manager_ID,
    0 AS Level
  FROM Employee
  WHERE Manager_ID IS NULL

  UNION ALL

  SELECT
    e.Emp_ID,
    e.Emp_Name,
    e.Manager_ID,
    rc.Level + 1
  FROM Employee e
  INNER JOIN Reporting_Chain rc
  ON e.Manager_ID = rc.Emp_ID
)
SELECT
  Emp_ID,
  Emp_Name,
  Manager_ID,
  Level
FROM Reporting_Chain
ORDER BY Level, Emp_ID;

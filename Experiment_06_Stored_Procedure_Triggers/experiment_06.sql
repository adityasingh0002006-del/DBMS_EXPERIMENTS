-- ============================================================
-- EXPERIMENT 6
-- Stored Procedure, Salary Validation Triggers and Audit Logging
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
   FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID),
   FOREIGN KEY (Project_ID) REFERENCES Project(Project_ID)
);

CREATE TABLE Employee_Audit (
   Audit_ID INT AUTO_INCREMENT PRIMARY KEY,
   Emp_ID INT,
   Old_Salary DECIMAL(10,2),
   New_Salary DECIMAL(10,2),
   Action_Time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
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


-- STORED PROCEDURE: transfer_employee

DELIMITER //

CREATE PROCEDURE transfer_employee(
  IN p_emp_id INT,
  IN p_new_dept_id INT
)
BEGIN
  DECLARE v_emp_count INT DEFAULT 0;
  DECLARE v_dept_count INT DEFAULT 0;

  SELECT COUNT(*)
  INTO v_emp_count
  FROM Employee
  WHERE Emp_ID = p_emp_id;

  IF v_emp_count = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Employee does not exist';
  END IF;

  SELECT COUNT(*)
  INTO v_dept_count
  FROM Department
  WHERE Dept_ID = p_new_dept_id;

  IF v_dept_count = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Department does not exist';
  END IF;

  UPDATE Employee
  SET Dept_ID = p_new_dept_id
  WHERE Emp_ID = p_emp_id;
END //


-- TRIGGER: validate salary before INSERT

CREATE TRIGGER validate_salary_before_insert
BEFORE INSERT ON Employee
FOR EACH ROW
BEGIN
  IF NEW.Salary <= 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Salary must be greater than zero';
  END IF;
END //


-- TRIGGER: validate salary before UPDATE

CREATE TRIGGER validate_salary_before_update
BEFORE UPDATE ON Employee
FOR EACH ROW
BEGIN
  IF NEW.Salary <= 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Salary must be greater than zero';
  END IF;
END //


-- TRIGGER: salary audit after UPDATE

CREATE TRIGGER salary_audit_after_update
AFTER UPDATE ON Employee
FOR EACH ROW
BEGIN
  IF OLD.Salary <> NEW.Salary THEN
    INSERT INTO Employee_Audit
    (Emp_ID, Old_Salary, New_Salary)
    VALUES
    (OLD.Emp_ID, OLD.Salary, NEW.Salary);
  END IF;
END //

DELIMITER ;


-- TEST CASES

CALL transfer_employee(1, 2);

SELECT Emp_ID, Emp_Name, Dept_ID
FROM Employee
WHERE Emp_ID = 1;

UPDATE Employee
SET Salary = 50000
WHERE Emp_ID = 1;

SELECT * FROM Employee_Audit;

-- Invalid employee
CALL transfer_employee(999, 2);

-- Invalid department
CALL transfer_employee(1, 999);

-- Invalid salary
UPDATE Employee
SET Salary = -5000
WHERE Emp_ID = 1;

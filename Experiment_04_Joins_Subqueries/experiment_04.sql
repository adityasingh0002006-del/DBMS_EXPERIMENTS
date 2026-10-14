-- ============================================================
-- EXPERIMENT 4
-- Joins, Subqueries, EXISTS, Simulated INTERSECT/EXCEPT and EXPLAIN
-- CO2
-- ============================================================

-- QUERY 1 – INNER JOIN
SELECT
  e.Emp_ID,
  e.Emp_Name,
  d.Dept_Name
FROM Employee e
INNER JOIN Department d
ON e.Dept_ID = d.Dept_ID;


-- QUERY 2 – LEFT JOIN
SELECT
  d.Dept_ID,
  d.Dept_Name,
  e.Emp_Name
FROM Department d
LEFT JOIN Employee e
ON d.Dept_ID = e.Dept_ID;


-- QUERY 3 – SELF JOIN
SELECT
  e1.Emp_Name AS Employee_1,
  e2.Emp_Name AS Employee_2,
  e1.Dept_ID
FROM Employee e1
INNER JOIN Employee e2
ON e1.Dept_ID = e2.Dept_ID
AND e1.Emp_ID < e2.Emp_ID;


-- QUERY 4 – 3-WAY JOIN
SELECT
  e.Emp_Name,
  d.Dept_Name,
  p.Project_Name
FROM Employee e
INNER JOIN Department d
ON e.Dept_ID = d.Dept_ID
INNER JOIN Project p
ON e.Project_ID = p.Project_ID;


-- QUERY 5 – CORRELATED SUBQUERY
SELECT
  e.Emp_ID,
  e.Emp_Name,
  e.Salary,
  e.Dept_ID
FROM Employee e
WHERE e.Salary >
(
  SELECT AVG(e2.Salary)
  FROM Employee e2
  WHERE e2.Dept_ID = e.Dept_ID
);


-- QUERY 6 – EXISTS
SELECT
   d.Dept_ID,
   d.Dept_Name
FROM Department d
WHERE EXISTS
(
   SELECT 1
   FROM Employee e
   WHERE e.Dept_ID = d.Dept_ID
);


-- QUERY 7 – SIMULATED INTERSECT USING EXISTS
SELECT
  e.Emp_ID,
  e.Emp_Name
FROM Employee e
WHERE e.Salary > 80000
AND EXISTS
(
  SELECT 1
  FROM Project p
  WHERE p.Project_ID = e.Project_ID
  AND p.Budget > 800000
);


-- QUERY 8 – SIMULATED EXCEPT USING NOT EXISTS
SELECT
   e.Emp_ID,
   e.Emp_Name,
   e.Project_ID
FROM Employee e
WHERE NOT EXISTS
(
   SELECT 1
   FROM Project p
   WHERE p.Project_ID = e.Project_ID
   AND p.Project_Name = 'AI Chatbot'
);


-- QUERY 9 – EXPLAIN FOR INNER JOIN
EXPLAIN
SELECT
  e.Emp_ID,
  e.Emp_Name,
  d.Dept_Name
FROM Employee e
INNER JOIN Department d
ON e.Dept_ID = d.Dept_ID;


-- QUERY 10 – EXPLAIN FOR LEFT JOIN
EXPLAIN
SELECT
  d.Dept_Name,
  e.Emp_Name
FROM Department d
LEFT JOIN Employee e
ON d.Dept_ID = e.Dept_ID;


-- QUERY 11 – EXPLAIN FOR CORRELATED SUBQUERY
EXPLAIN
SELECT
   e.Emp_ID,
   e.Emp_Name,
   e.Salary
FROM Employee e
WHERE e.Salary >
(
   SELECT AVG(e2.Salary)
   FROM Employee e2
   WHERE e2.Dept_ID = e.Dept_ID
);


-- QUERY 12 – EXPLAIN FOR 3-WAY JOIN
EXPLAIN
SELECT
  e.Emp_Name,
  d.Dept_Name,
  p.Project_Name
FROM Employee e
INNER JOIN Department d
ON e.Dept_ID = d.Dept_ID
INNER JOIN Project p
ON e.Project_ID = p.Project_ID;


-- QUERY 13 – COMPARISON OF EXECUTION PLANS

-- INNER JOIN
EXPLAIN
SELECT
  e.Emp_ID,
  e.Emp_Name,
  d.Dept_Name
FROM Employee e
INNER JOIN Department d
ON e.Dept_ID = d.Dept_ID;

-- CORRELATED SUBQUERY
EXPLAIN
SELECT
  e.Emp_ID,
  e.Emp_Name,
  e.Salary
FROM Employee e
WHERE e.Salary >
(
  SELECT AVG(e2.Salary)
  FROM Employee e2
  WHERE e2.Dept_ID = e.Dept_ID
);

-- EXPLAIN comparison attributes:
-- Table        – table accessed by the query
-- Type         – type of table access or join operation
-- Possible_Keys– indexes MySQL could potentially use
-- Key          – index actually selected by MySQL, if any
-- Rows         – estimated number of rows examined
-- Extra        – additional information about query processing

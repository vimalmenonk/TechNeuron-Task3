USE EmployeeManagement;

-- List all employees with their department names
SELECT e.EmployeeID, e.Name, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- Calculate Net Salary for each employee
SELECT e.EmployeeID, e.Name, 
       (s.BaseSalary + s.Bonus - s.Deductions) AS NetSalary
FROM Employees e
JOIN Salaries s ON e.EmployeeID = s.EmployeeID;

-- Find the department with the highest average salary
SELECT TOP 1 d.DepartmentName, AVG(s.BaseSalary + s.Bonus - s.Deductions) AS AvgSalary
FROM Departments d
JOIN Employees e ON d.DepartmentID = e.DepartmentID
JOIN Salaries s ON e.EmployeeID = s.EmployeeID
GROUP BY d.DepartmentName
ORDER BY AvgSalary DESC;

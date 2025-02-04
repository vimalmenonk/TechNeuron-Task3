USE EmployeeManagement;

-- View: Employee Salary Details
CREATE VIEW EmployeeSalaryView AS
SELECT e.EmployeeID, e.Name, d.DepartmentName, 
       (s.BaseSalary + s.Bonus - s.Deductions) AS NetSalary
FROM Employees e
JOIN Salaries s ON e.EmployeeID = s.EmployeeID
JOIN Departments d ON e.DepartmentID = d.DepartmentID;
GO

-- Usage:
-- SELECT * FROM EmployeeSalaryView;

-- View: High Earners (Above ₹50,000)
CREATE VIEW HighEarnerView AS
SELECT e.EmployeeID, e.Name, (s.BaseSalary + s.Bonus - s.Deductions) AS NetSalary
FROM Employees e
JOIN Salaries s ON e.EmployeeID = s.EmployeeID
WHERE (s.BaseSalary + s.Bonus - s.Deductions) > 50000;
GO

-- Usage:
-- SELECT * FROM HighEarnerView;

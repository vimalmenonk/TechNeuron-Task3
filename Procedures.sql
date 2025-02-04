USE EmployeeManagement;

-- Add Employee Procedure
CREATE OR ALTER PROCEDURE AddEmployee
    @Name VARCHAR(255),
    @DepartmentID INT,
    @HireDate DATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Departments WHERE DepartmentID = @DepartmentID)
    BEGIN
        INSERT INTO Employees (Name, DepartmentID, HireDate)
        VALUES (@Name, @DepartmentID, @HireDate);
    END
    ELSE
    BEGIN
        PRINT 'Invalid Department ID';
    END
END;
GO

-- Usage Example:
-- EXEC AddEmployee 'John Doe', 1, '2025-02-01';

-- Update Salary and Log Changes Procedure
CREATE TABLE SalaryHistory (
    ChangeID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    OldSalary DECIMAL(10,2),
    NewSalary DECIMAL(10,2),
    ChangeDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);
GO

CREATE OR ALTER PROCEDURE UpdateSalary
    @EmployeeID INT,
    @NewBaseSalary DECIMAL(10,2),
    @NewBonus DECIMAL(10,2),
    @NewDeductions DECIMAL(10,2)
AS
BEGIN
    DECLARE @OldSalary DECIMAL(10,2);

    SELECT @OldSalary = BaseSalary + Bonus - Deductions 
    FROM Salaries WHERE EmployeeID = @EmployeeID;

    UPDATE Salaries 
    SET BaseSalary = @NewBaseSalary, Bonus = @NewBonus, Deductions = @NewDeductions
    WHERE EmployeeID = @EmployeeID;

    INSERT INTO SalaryHistory (EmployeeID, OldSalary, NewSalary)
    VALUES (@EmployeeID, @OldSalary, @NewBaseSalary + @NewBonus - @NewDeductions);
END;
GO

-- Usage Example:
-- EXEC UpdateSalary 1, 60000, 5000, 2000;

-- Calculate Total Payroll Procedure
CREATE OR ALTER PROCEDURE CalculatePayroll
    @DepartmentID INT
AS
BEGIN
    SELECT SUM(BaseSalary + Bonus - Deductions) AS TotalPayroll
    FROM Employees e
    JOIN Salaries s ON e.EmployeeID = s.EmployeeID
    WHERE e.DepartmentID = @DepartmentID;
END;
GO

-- Usage Example:
-- EXEC CalculatePayroll 1;

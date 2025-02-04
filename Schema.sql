-- Create Database
CREATE DATABASE EmployeeManagement;
USE EmployeeManagement;

-- Departments Table
CREATE TABLE Departments (
    DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
    DepartmentName VARCHAR(255) NOT NULL
);

-- Employees Table
CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    DepartmentID INT,
    HireDate DATE,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Salaries Table
CREATE TABLE Salaries (
    EmployeeID INT PRIMARY KEY,
    BaseSalary DECIMAL(10,2),
    Bonus DECIMAL(10,2),
    Deductions DECIMAL(10,2),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

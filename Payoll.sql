-- ===================================================================
-- 1. DATABASE CREATION & TABLE STRUCTURE
-- ===================================================================


 CREATE DATABASE payroll_system;
 USE payroll_system;

-- Departments table
CREATE TABLE departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(100) NOT NULL,
    dept_head VARCHAR(100),
    budget DECIMAL(10,2),
    created_date DATE DEFAULT (CURRENT_DATE)
);

-- Employees table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_code VARCHAR(10) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    hire_date DATE NOT NULL,
    dept_id INT,
    job_title VARCHAR(100),
    salary DECIMAL(10,2) NOT NULL,
    status ENUM('Active', 'Inactive') DEFAULT 'Active',
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Attendance table
CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT NOT NULL,
    work_date DATE NOT NULL,
    check_in TIME,
    check_out TIME,
    hours_worked DECIMAL(4,2) DEFAULT 8.00,
    overtime_hours DECIMAL(4,2) DEFAULT 0.00,
    status VARCHAR(20) DEFAULT 'Present',
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

-- Payroll table
CREATE TABLE payroll (
    payroll_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT NOT NULL,
    pay_month INT NOT NULL,
    pay_year INT NOT NULL,
    basic_salary DECIMAL(10,2) NOT NULL,
    overtime_pay DECIMAL(8,2) DEFAULT 0.00,
    bonus DECIMAL(8,2) DEFAULT 0.00,
    gross_salary DECIMAL(10,2) NOT NULL,
    tax_deduction DECIMAL(8,2) DEFAULT 0.00,
    insurance DECIMAL(6,2) DEFAULT 500.00,
    other_deductions DECIMAL(8,2) DEFAULT 0.00,
    net_salary DECIMAL(10,2) NOT NULL,
    pay_date DATE,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

-- Leaves table
CREATE TABLE leaves (
    leave_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT NOT NULL,
    leave_type VARCHAR(20) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_days INT NOT NULL,
    reason TEXT,
    status VARCHAR(20) DEFAULT 'Pending',
    applied_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

-- ===================================================================
-- 2. SAMPLE DATA INSERTION
-- ===================================================================

-- Insert departments
INSERT INTO departments (dept_name, dept_head, budget) VALUES
('Human Resources', 'Sarah Wilson', 300000),
('Information Technology', 'Mike Johnson', 800000),
('Sales', 'John Davis', 500000),
('Marketing', 'Emma Brown', 400000),
('Finance', 'Robert Smith', 350000);

-- Insert employees
INSERT INTO employees (emp_code, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary) VALUES
('E001', 'Alice', 'Johnson', 'alice.j@company.com', '555-1001', '2023-01-15', 2, 'Software Developer', 60000),
('E002', 'Bob', 'Smith', 'bob.s@company.com', '555-1002', '2023-02-01', 1, 'HR Executive', 45000),
('E003', 'Carol', 'Davis', 'carol.d@company.com', '555-1003', '2023-01-20', 3, 'Sales Executive', 40000),
('E004', 'David', 'Wilson', 'david.w@company.com', '555-1004', '2023-03-10', 4, 'Marketing Specialist', 42000),
('E005', 'Eva', 'Brown', 'eva.b@company.com', '555-1005', '2023-02-15', 5, 'Accountant', 48000),
('E006', 'Frank', 'Miller', 'frank.m@company.com', '555-1006', '2023-04-01', 2, 'Junior Developer', 35000),
('E007', 'Grace', 'Taylor', 'grace.t@company.com', '555-1007', '2023-03-20', 3, 'Sales Manager', 55000),
('E008', 'Henry', 'Anderson', 'henry.a@company.com', '555-1008', '2023-05-10', 1, 'Recruiter', 38000);

-- Insert attendance data (sample for current month)
INSERT INTO attendance (emp_id, work_date, check_in, check_out, hours_worked, overtime_hours, status) VALUES
(1, '2024-01-02', '09:00', '18:00', 8.00, 1.00, 'Present'),
(1, '2024-01-03', '09:15', '18:15', 8.00, 0.00, 'Present'),
(1, '2024-01-04', '09:00', '19:00', 9.00, 1.00, 'Present'),
(2, '2024-01-02', '08:30', '17:30', 8.00, 0.00, 'Present'),
(2, '2024-01-03', '08:45', '17:45', 8.00, 0.00, 'Present'),
(3, '2024-01-02', '10:00', '19:00', 8.00, 0.00, 'Present'),
(3, '2024-01-03', NULL, NULL, 0.00, 0.00, 'Absent'),
(4, '2024-01-02', '09:30', '18:30', 8.00, 0.00, 'Present'),
(5, '2024-01-02', '09:00', '18:30', 8.50, 0.50, 'Present');

-- Insert leave applications
INSERT INTO leaves (emp_id, leave_type, start_date, end_date, total_days, reason, status) VALUES
(1, 'Sick Leave', '2024-01-10', '2024-01-11', 2, 'Fever and flu', 'Approved'),
(3, 'Casual Leave', '2024-01-15', '2024-01-15', 1, 'Personal work', 'Pending'),
(4, 'Vacation', '2024-02-20', '2024-02-25', 5, 'Family trip', 'Approved'),
(2, 'Sick Leave', '2024-01-08', '2024-01-09', 2, 'Medical checkup', 'Approved');

-- Insert payroll data (sample)
INSERT INTO payroll (emp_id, pay_month, pay_year, basic_salary, overtime_pay, bonus, gross_salary, tax_deduction, net_salary, pay_date) VALUES
(1, 12, 2023, 60000, 2000, 5000, 67000, 8000, 58500, '2023-12-30'),
(2, 12, 2023, 45000, 0, 2000, 47000, 5500, 41000, '2023-12-30'),
(3, 12, 2023, 40000, 500, 8000, 48500, 5800, 42200, '2023-12-30'),
(4, 12, 2023, 42000, 0, 3000, 45000, 5300, 39200, '2023-12-30'),
(5, 12, 2023, 48000, 1000, 2500, 51500, 6000, 45000, '2023-12-30');

-- ===================================================================
-- 3. USEFUL VIEWS FOR REPORTING
-- ===================================================================

-- Employee details with department info
CREATE VIEW employee_details AS
SELECT 
    e.emp_code,
    CONCAT(e.first_name, ' ', e.last_name) AS full_name,
    e.email,
    e.job_title,
    d.dept_name,
    e.salary,
    e.hire_date,
    e.status
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;

-- Monthly attendance summary
CREATE VIEW attendance_summary AS
SELECT 
    e.emp_code,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    COUNT(a.attendance_id) AS total_days,
    SUM(a.hours_worked) AS total_hours,
    SUM(a.overtime_hours) AS total_overtime,
    MONTH(a.work_date) AS work_month,
    YEAR(a.work_date) AS work_year
FROM employees e
LEFT JOIN attendance a ON e.emp_id = a.emp_id
GROUP BY e.emp_id, MONTH(a.work_date), YEAR(a.work_date);

-- ===================================================================
-- 4. IMPORTANT BUSINESS QUERIES
-- ===================================================================

-- 1. Get all employees with their current salary and department
SELECT 
    emp_code,
    full_name,
    job_title,
    dept_name,
    salary
FROM employee_details
WHERE status = 'Active'
ORDER BY salary DESC;

-- 2. Monthly payroll summary by department
SELECT 
    d.dept_name,
    COUNT(p.emp_id) as employee_count,
    SUM(p.gross_salary) as total_gross,
    SUM(p.net_salary) as total_net,
    AVG(p.net_salary) as average_salary
FROM departments d
JOIN employees e ON d.dept_id = e.dept_id
JOIN payroll p ON e.emp_id = p.emp_id
WHERE p.pay_month = 12 AND p.pay_year = 2023
GROUP BY d.dept_name
ORDER BY total_gross DESC;

-- 3. Employee attendance report for current month
SELECT 
    e.emp_code,
    CONCAT(e.first_name, ' ', e.last_name) AS name,
    COUNT(CASE WHEN a.status = 'Present' THEN 1 END) as present_days,
    COUNT(CASE WHEN a.status = 'Absent' THEN 1 END) as absent_days,
    SUM(a.overtime_hours) as total_overtime
FROM employees e
LEFT JOIN attendance a ON e.emp_id = a.emp_id
WHERE MONTH(a.work_date) = 1 AND YEAR(a.work_date) = 2024
GROUP BY e.emp_id, e.emp_code, e.first_name, e.last_name
ORDER BY present_days DESC;

-- 4. Employees with pending leave requests
SELECT 
    e.emp_code,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    l.leave_type,
    l.start_date,
    l.end_date,
    l.total_days,
    l.reason
FROM employees e
JOIN leaves l ON e.emp_id = l.emp_id
WHERE l.status = 'Pending'
ORDER BY l.applied_date;

-- 5. Top 5 highest paid employees
SELECT 
    emp_code,
    full_name,
    job_title,
    dept_name,
    salary
FROM employee_details
WHERE status = 'Active'
ORDER BY salary DESC
LIMIT 5;

-- 6. Department wise salary budget analysis
SELECT 
    d.dept_name,
    d.budget as allocated_budget,
    SUM(e.salary) as current_salary_cost,
    (d.budget - SUM(e.salary)) as remaining_budget,
    ROUND((SUM(e.salary) / d.budget * 100), 2) as budget_utilized_percent
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
WHERE e.status = 'Active' OR e.status IS NULL
GROUP BY d.dept_id, d.dept_name, d.budget
ORDER BY budget_utilized_percent DESC;

-- 7. Overtime analysis
SELECT 
    e.emp_code,
    CONCAT(e.first_name, ' ', e.last_name) AS name,
    d.dept_name,
    SUM(a.overtime_hours) as total_overtime_hours,
    (SUM(a.overtime_hours) * 500) as overtime_pay_earned
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
JOIN attendance a ON e.emp_id = a.emp_id
WHERE a.overtime_hours > 0
GROUP BY e.emp_id, e.emp_code, e.first_name, e.last_name, d.dept_name
ORDER BY total_overtime_hours DESC;

-- 8. Recent hires (last 6 months)
SELECT 
    emp_code,
    full_name,
    job_title,
    dept_name,
    hire_date,
    salary
FROM employee_details
WHERE hire_date >= DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH)
ORDER BY hire_date DESC;

-- ===================================================================
-- 5. BASIC INDEXES FOR BETTER PERFORMANCE
-- ===================================================================

CREATE INDEX idx_emp_dept ON employees(dept_id);
CREATE INDEX idx_attendance_emp_date ON attendance(emp_id, work_date);
CREATE INDEX idx_payroll_emp_period ON payroll(emp_id, pay_month, pay_year);
CREATE INDEX idx_leaves_emp_status ON leaves(emp_id, status);

-- ===================================================================
-- 6. SAMPLE BUSINESS OPERATIONS
-- ===================================================================

-- Calculate monthly salary for an employee (example for emp_id = 1)
SELECT 
    e.emp_code,
    CONCAT(e.first_name, ' ', e.last_name) AS name,
    e.salary as basic_salary,
    COALESCE(SUM(a.overtime_hours) * 500, 0) as overtime_pay,
    (e.salary + COALESCE(SUM(a.overtime_hours) * 500, 0)) as gross_salary,
    (e.salary + COALESCE(SUM(a.overtime_hours) * 500, 0)) * 0.10 as tax_deduction,
    ((e.salary + COALESCE(SUM(a.overtime_hours) * 500, 0)) - 
     (e.salary + COALESCE(SUM(a.overtime_hours) * 500, 0)) * 0.10 - 500) as net_salary
FROM employees e
LEFT JOIN attendance a ON e.emp_id = a.emp_id 
    AND MONTH(a.work_date) = 1 
    AND YEAR(a.work_date) = 2024
WHERE e.emp_id = 1
GROUP BY e.emp_id, e.emp_code, e.first_name, e.last_name, e.salary;

-- Find employees who worked overtime this month
SELECT 
    e.emp_code,
    CONCAT(e.first_name, ' ', e.last_name) AS name,
    SUM(a.overtime_hours) as total_overtime,
    COUNT(CASE WHEN a.overtime_hours > 0 THEN 1 END) as overtime_days
FROM employees e
JOIN attendance a ON e.emp_id = a.emp_id
WHERE MONTH(a.work_date) = 1 
  AND YEAR(a.work_date) = 2024
  AND a.overtime_hours > 0
GROUP BY e.emp_id, e.emp_code, e.first_name, e.last_name
ORDER BY total_overtime DESC;

-- Check department salary expenses
SELECT 
    d.dept_name,
    COUNT(e.emp_id) as total_employees,
    SUM(e.salary) as monthly_salary_expense,
    AVG(e.salary) as average_salary,
    MAX(e.salary) as highest_salary,
    MIN(e.salary) as lowest_salary
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
WHERE e.status = 'Active'
GROUP BY d.dept_id, d.dept_name
ORDER BY monthly_salary_expense DESC;
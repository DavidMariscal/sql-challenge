-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.
DROP TABLE IF EXISTS departments cascade;
DROP TABLE IF EXISTS dept_emp cascade;
DROP TABLE IF EXISTS dept_manager cascade;
DROP TABLE IF EXISTS employees cascade;
DROP TABLE IF EXISTS salaries cascade;
DROP TABLE IF EXISTS titles cascade;

CREATE TABLE "departments" (
    "dept_no" VARCHAR(30)   NOT NULL,
    "dept_name" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

COPY departments
from '/Users/davidmariscal/Projects/sql-challenge/EmployeeSQL/Data/departments.csv'
with (format csv, header); 

SELECT * FROM departments

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(30)   NOT NULL,
    "from_date" Date   NOT NULL,
    "to_date" Date   NOT NULL
);

COPY dept_emp
from '/Users/davidmariscal/Projects/sql-challenge/EmployeeSQL/Data/dept_emp.csv'
with (format csv, header);
SELECT * FROM dept_emp



CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(30)   NOT NULL,
    "emp_no" INT   NOT NULL,
    "from_date" Date   NOT NULL,
    "to_date" Date   NOT NULL
);


COPY dept_manager
from '/Users/davidmariscal/Projects/sql-challenge/EmployeeSQL/Data/dept_manager.csv'
with (format csv, header);
SELECT * FROM dept_manager

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    "from_date" Date   NOT NULL,
    "to_date" Date   NOT NULL
);

COPY salaries
from '/Users/davidmariscal/Projects/sql-challenge/EmployeeSQL/Data/salaries.csv'
with (format csv, header);
SELECT * FROM salaries


CREATE TABLE "titles" (
    "emp_no" INT   NOT NULL,
    "title" VARCHAR(255)   NOT NULL,
    "from_date" Date   NOT NULL,
    "to_date" Date   NOT NULL
);

COPY titles
from '/Users/davidmariscal/Projects/sql-challenge/EmployeeSQL/Data/titles.csv'
with (format csv, header);
SELECT * FROM titles


CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "birth_date" Date   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" Date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

COPY employees
from '/Users/davidmariscal/Projects/sql-challenge/EmployeeSQL/Data/employees.csv'
with (format csv, header);
SELECT * FROM employees

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");


/* 1.- List the following details of each employee: employee number, last name, first name, gender, and salary. */
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
FROM employees
INNER JOIN salaries
ON employees.emp_no = salaries.emp_no
Order by employees.emp_no;


/* 2.-List employees who were hired in 1986. */

SELECT emp_no, first_name, last_name, hire_date 
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

/* 3.- List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates. */

SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name, dept_manager.from_date, dept_manager.to_date
FROM departments
JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no
JOIN employees
ON dept_manager.emp_no = employees.emp_no
Order by dept_no;

/* 4.- List the department of each employee with the following information: employee number, last name, first name, and department name. */

SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
INNER JOIN employees
ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments
ON dept_emp.dept_no = departments.dept_no


/* 5.- List all employees whose first name is "Hercules" and last names begin with "B." */

SELECT first_name, last_name
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%'
Order by last_name;


/* 6.- List all employees in the Sales department, including their employee number, last name, first name, and department name. */
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
INNER JOIN employees
ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';



/* 7.- List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name. */

SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
INNER JOIN employees
ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name in ('Sales','Development');



/* 8.- In descending order, list the frequency count of employee last names, i.e., how many employees share each last name. */

SELECT last_name,
COUNT(last_name) AS "frequency"
FROM employees
GROUP BY last_name
ORDER BY "frequency" DESC;



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


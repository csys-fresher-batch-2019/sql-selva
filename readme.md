# Payroll Management system

## Features

### Feature I: Employee Details

```sql
      CREATE TABLE employee(
      emp_id  number not null,
      emp_name varchar2(50) not null,
      designation varchar2(20) not null,
      login_time timestamp not null,
      logout_time timestamp default null,
      performance_grade number check(performance_grade > 0),
      leaves_taken number,

      constraint emp_id_pk primary key(emp_id)
      );
      
      insert into employee(emp_id,emp_name,designation,login_time,leaves_taken,performance_grade)
      values(1001,'Aadhav','DBA',systimestamp,0,2);

      insert into employee(emp_id,emp_name,designation,login_time,leaves_taken,performance_grade)
      values(1011,'Rahul','Project Manger',systimestamp,0,1);

      insert into employee(emp_id,emp_name,designation,login_time,leaves_taken,performance_grade)
      values(1012,'Vani','Project Manger',systimestamp,1,3);

      insert into employee(emp_id,emp_name,designation,login_time,leaves_taken,performance_grade)
      values(1023,'Thamos','Team Leader',systimestamp,2,3);
 
      insert into employee(emp_id,emp_name,designation,login_time,leaves_taken,performance_grade)
       values(1112,'Raji','Technical consultant',systimestamp,0,1);

```

```

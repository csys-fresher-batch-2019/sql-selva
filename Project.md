# Payroll Management system

## Features

### Feature I: Employee Details
| EMP_ID | EMP_NAME |      DESIGNATION     | PERFORMANCE_GRADE | LEAVES_TAKEN | SALARY | TOTAL_LEAVES | FOOD | CAB_FACILITY |
|:------:|:--------:|:--------------------:|:-----------------:|:------------:|:------:|:------------:|:----:|:------------:|
|  1001  |  Aadhav  |          DBA         |         2         |       1      |  20000 |      11      |   Y  |       Y      |
|  1011  |   Rahul  |    Project Manager   |         1         |       0      |  25000 |      12      |   Y  |       Y      |
|  1012  |   Vani   |    Project Manager   |         3         |       1      |  25000 |      11      |   N  |       Y      |
|  1023  |  Thomas  |      Team Leader     |         3         |       2      |  20000 |      10      |   Y  |       N      |
|  1112  |   Raji   | Technical consultant |         1         |       0      |  15000 |      12      |   N  |       N      |


```sql
      CREATE TABLE employee(
      emp_id  number not null,
      emp_name varchar2(50) not null,
      designation varchar2(20) not null,
      performance_grade number check(performance_grade > 0),
      leaves_taken number,
      salary number not null,
      total_leaves number,

      constraint emp_id_pk primary key(emp_id)
      );
```
        
```sql

      insert into employee(emp_id,emp_name,designation,leaves_taken,performance_grade,salary,total_leaves)
      values(1001,'Aadhav','DBA',1,2,20000,11);
 ```
```sql
      insert into employee(emp_id,emp_name,designation,leaves_taken,performance_grade,salary,total_leaves)
      values(1011,'Rahul','Project Manger',0,2,25000,12);
```
```sql
      insert into employee(emp_id,emp_name,designation,leaves_taken,performance_grade,salary,total_leaves)
      values(1012,'Vani','Project Manger',1,2,25000,11);

```

### Feature II: Credit Details

| EMP_ID | ALLOWANCE | SALARY_INCREMENT |
|:------:|:---------:|:----------------:|
|  1001  |    500    |         0        |
|  1011  |    700    |         0        |
|  1012  |    600    |         0        |
|  1023  |    500    |         0        |
|  1112  |    300    |         0        |


```sql

            create table credits(
            emp_id number not null,
            allowance number,
            salary_increment number,
            constraint emp_id_fk foreign key(emp_id) references employee(emp_id));
```
```sql
            insert into credits(emp_id,allowance,salary_increment)
            values(1001,500,0);
```
```sql
            insert into credits(emp_id,allowance,salary_increment)
            values(1011,700,0);
```
```sql
            insert into credits(emp_id,allowance,salary_increment)
            values(1012,600,0);
```
### Feature III: Detections details

| EMP_ID | FOOD_DETECTION | CAB_DETECTION | LOSS_OF_PAY | PROVIDENT_FUND |
|:------:|:--------------:|:-------------:|:-----------:|:--------------:|
|  1001  |       200      |      2000     |      0      |      1000      |
|  1011  |       200      |      1000     |      0      |      1000      |
|  1012  |        0       |      1000     |      0      |      1000      |
|  1023  |       200      |       0       |      0      |      1000      |
|  1112  |        0       |       0       |      0      |      1000      |

```sql
            create table detections(
            emp_id number not null,
            food_detection number,
            cab_detection number,
            loss_of_pay number,
            provident_fund number not null,
            constraint empl_id_fk foreign key(emp_id) references employee(emp_id)
            );
```
```sql
            insert into detections(emp_id,food_detection,cab_detection,loss_of_pay,profident_fund)
            values(1001,200,2000,0,1000);
```
```sql
            insert into detections(emp_id,food_detection,cab_detection,loss_of_pay,profident_fund)
            values(1011,200,1000,0,1000);
```
```sql
            insert into detections(emp_id,food_detection,cab_detection,loan_detection,loss_of_pay,profident_fund)
            values(1012,0,1000,0,1000);
```
### Feature IV: Attendance Monitoring

| EMP_ID |           LOGIN_TIME           | LOGOUT_TIME |
|:------:|:------------------------------:|:-----------:|
|  1001  | 02-01-20 05:42:26.921000000 PM |      0      |
|  1011  | 02-01-20 05:42:26.921000000 PM |      0      |
|  1012  | 02-01-20 05:42:26.921000000 PM |      0      |
|  1023  | 02-01-20 05:42:26.921000000 PM |      0      |
|  1112  | 02-01-20 05:42:26.921000000 PM |      0      |


```sql 
            create table biometrices(
            emp_id number not null,
            login_time timestamp,   
            logout_time timestamp,
            constraint emp_id_fkey foreign key(emp_id) references employee(emp_id));
```
```sql
            insert into biometrices(emp_id,login_time)values(1001,systimestamp);
```
```sql
            insert into biometrices(emp_id,login_time)values(1011,systimestamp);
```
```sql
            insert into biometrices(emp_id,login_time)values(1012,systimestamp);
```

### Feature V : Salary Calculation

| EMP_ID | FINAL_SALARY |
|:------:|:------------:|
|  1001  |       0      |
|  1011  |       0      |
|  1012  |       0      |
|  1023  |       0      |
|  1112  |       0      |

```sql 
            create table final_salary(
            emp_id number not null,
            salary_to_be_credited number,
            constraint emp_id_key foreign key(emp_id) references employee(emp_id));
```
```sql
            insert into final_salary(emp_id)values(1001);
```
```sql
            insert into final_salary(emp_id)values(1011);
```
```sql
            insert into final_salary(emp_id)values(1012);
```

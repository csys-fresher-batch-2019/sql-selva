# Payroll Management system

## Features

### Feature I: Employee Details
| EMP_ID | EMP_NAME |      DESIGNATION     | PERFORMANCE_GRADE | LEAVES_TAKEN | SALARY | TOTAL_LEAVES |
|:------:|:--------:|:--------------------:|:-----------------:|:------------:|:------:|:------------:|
|  1001  |  Aadhav  |          DBA         |         2         |       1      |  20000 |      11      |
|  1011  |   Rahul  |    Project Manager   |         1         |       0      |  25000 |      12      |
|  1012  |   Vani   |    Project Manager   |         3         |       1      |  25000 |      11      |
|  1023  |  Thomas  |      Team Leader     |         3         |       2      |  20000 |      10      |
|  1112  |   Raji   | Technical consultant |         1         |       0      |  15000 |      12      |


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
### Feature IV: Salary Calculation

```sql 
            create table salary (
            emp_id number not null,
            salary number ,
            constraint emp_id_fk1 foreign key(emp_id) references employee(emp_id));
```
```sql
            insert into salary(emp_id,salary)values(1001,0);
```
```sql
            insert into salary(emp_id,salary)values(1011,0);
```
```sql
            insert into salary(emp_id,salary)values(1012,0);
```

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
```
        
```sql

      insert into employee(emp_id,emp_name,designation,login_time,leaves_taken,performance_grade)
      values(1001,'Aadhav','DBA',systimestamp,0,2);
 ```
```sql
      insert into employee(emp_id,emp_name,designation,login_time,leaves_taken,performance_grade)
      values(1011,'Rahul','Project Manger',systimestamp,0,1);
```
```sql
      insert into employee(emp_id,emp_name,designation,login_time,leaves_taken,performance_grade)
      values(1012,'Vani','Project Manger',systimestamp,1,3);

```

### Feature II: Credit Details

```sql

            create table credits(
            emp_id number not null,
            base_pay number not null,
            allowance number,
            balance_loan_amount number,
            salary_increment number,
            constraint emp_id_fk foreign key(emp_id) references employee(emp_id));
```
```sql
            insert into credits(emp_id,base_pay,allowance,balance_loan_amount,salary_increment)
            values(1001,1000,500,40000,0);
```
```sql
            insert into credits(emp_id,base_pay,allowance,balance_loan_amount,salary_increment)
            values(1011,1200,700,45000,0);
```
```sql
            insert into credits(emp_id,base_pay,allowance,balance_loan_amount,salary_increment)
            values(1012,1200,600,0,0);
```
### Feature III: Detections details

```sql
            create table detections(
            emp_id number not null,
            food_detection number,
            cab_detection number,
            loan_detection number,
            loss_of_pay number,
            profident_fund number not null,
            constraint empl_id_fk foreign key(emp_id) references employee(emp_id)
            );
```
```sql
            insert into detections(emp_id,food_detection,cab_detection,loan_detection,loss_of_pay,profident_fund)
            values(1001,200,2000,1500,0,1000);
```
```sql
            insert into detections(emp_id,food_detection,cab_detection,loan_detection,loss_of_pay,profident_fund)
            values(1011,200,1000,1500,0,1000);
```
```sql
            insert into detections(emp_id,food_detection,cab_detection,loan_detection,loss_of_pay,profident_fund)
            values(1012,0,1000,1500,0,1000);
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

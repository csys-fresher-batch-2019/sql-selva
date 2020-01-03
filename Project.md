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
```sql
            drop table final_salary;

            create table final_salary(
            emp_id number not null,
            salary_to_be_credited number,
            constraint emp_id_key foreign key(emp_id) references employee(emp_id));

            insert into final_salary(emp_id)values(1001);

            insert into final_salary(emp_id)values(1011);

            insert into final_salary(emp_id)values(1012);

            insert into final_salary(emp_id)values(1023);

            insert into final_salary(emp_id)values(1112);

            select * from final_salary;
```
```sql
            create or replace procedure entry_gate(employee_id in number,swiping_count in number )
            as
            swiping number;
            begin
                    if(swiping_count = 0) then 
                        update biometrices set login_time = systimestamp where emp_id = employee_id;
                    else
                        update biometrices set logout_time = systimestamp where emp_id = employee_id;
                    end if;
                commit;
            end;

            declare 
                begin 
                entry_gate(1001,0);
                end;



            create or replace procedure attedance_check(employee_id in number )
            as
            present_hour number;
            begin
                    select extract(hour from diff) into present_hour from ( select (logout_time - login_time) diff from biometrices                         where emp_id = employee_id);
                    if(present_hour < 8) then 
                        update employee set leaves_taken = leaves_taken+1,total_leaves = total_leaves-1 where emp_id = employee_id;
                    end if;
                commit;
            end;

            declare 
                begin 
                attedance_check(1001);
                end;

```sql
            
      update detections d set food_detection = 200 where emp_id = (select emp_id from employee  where emp_id = d.emp_id and food = 'Y');
     ```
     
 ```sql
            update credits c 
            set salary_increment = 2000 * (SELECT performance_grade FROM employee WHERE emp_id = c.emp_id)  
            where emp_id = (select emp_id from employee where emp_id = c.emp_id);
```
```sql
            update detections d 
            set loss_of_pay = (SELECT base_pay *(SELECT leaves_taken FROM employee WHERE emp_id = d.emp_id)
            FROM credits  WHERE emp_id = d.emp_id)  
            where emp_id = (select emp_id from employee where emp_id = d.emp_id);
```

```sql
            create or replace FUNCTION get_salary(in_person_id IN NUMBER) 
               RETURN NUMBER AS 
                v_credits number := 0;
                v_detections number := 0;
                v_total number := 0;
               BEGIN 

                    select allowance + (select salary_increment from credits where emp_id = in_person_id)
                  into v_credits from credits where emp_id = in_person_id;

                  select food_detection + (select cab_detection +(select loss_of_pay + 
                  (select profident_fund from detections where emp_id = in_person_id)
                  from detections where emp_id = in_person_id)
                  from detections where emp_id = in_person_id)
                  into v_detections from detections where emp_id = in_person_id;

                 select salary+(v_credits - v_detections) into v_total from employee where emp_id = in_person_id;

                  RETURN(v_total); 

                END get_salary; 

            --select get_salary(1112) from dual;

            update final_salary set salary_to_be_credited = (select get_salary(1001) from dual) where emp_id = 1001;

            update final_salary set salary_to_be_credited = (select get_salary(1011) from dual) where emp_id = 1011;

            update final_salary set salary_to_be_credited = (select get_salary(1012) from dual) where emp_id = 1012;

            update final_salary set salary_to_be_credited = (select get_salary(1023) from dual) where emp_id = 1023;

            update final_salary set salary_to_be_credited = (select get_salary(1112) from dual) where emp_id = 1112;

```

```sql 
      select e.emp_id,e.emp_name,f.salary_to_be_credited from employee e,final_salary f where e.emp_id = f.emp_id;

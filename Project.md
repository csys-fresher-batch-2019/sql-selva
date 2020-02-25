# Payroll Management system

## Features
```sql
create sequence emp_id_seq start with 1000 increment by 1;
```

```sql
      CREATE TABLE employee(
emp_id  number not null,
emp_name varchar2(50) not null,
designation varchar2(50) not null,
email varchar(50) unique,
performance_grade number check(performance_grade > 0),
leaves_taken number,
basepay number,
total_leaves number default 12,
food_subscription char default 'N',
cab_subscription char default 'N',
Pan_number varchar2(10) unique,

constraint emp_id_pk primary key(emp_id),
constraint food_cq check(food_subscription in('Y','N')),
constraint cab_cq check(cab_subscription in('Y','N'))
);

```

```sql

     insert into employee(emp_id,emp_name,designation,email,performance_grade,leaves_taken,basepay,total_leaves,food_subscription,cab_subscription,pan_number)
values(emp_id_seq.nextval,'Selva','Admin','selvamanikandan.ks@gmail.com',2,0,20000,12,'N','Y','ABC14345')
 ```

| EMP_ID | EMP_NAME | DESIGNATION | EMAIL                        | PERFORMANCE_GRADE | LEAVES-TAKEN | BASEPAY | TOTAL_LEAVES | FOOD_SUBSCRIPTION | CAB_SUBSCRIPTION | PAN_NUMBER |
|--------|----------|-------------|------------------------------|-------------------|--------------|---------|--------------|-------------------|------------------|------------|
| 1000   | Selva    | Admin       | selvamanikandan.ks@gmail.com | 2                 | 0            | 20000   | 12           | Y                 | N                | ABCD1234   |



```sql

           create table credits(
emp_id number not null,
allowance number,
salary_increment number,
constraint emp_id_fk foreign key(emp_id) references employee(emp_id));
```
```sql
            insert into credits(emp_id,allowance,salary_increment)values(emp_id_seq.currval,0,0);

```

| EMP_ID | ALLOWANCE | SALARY_INCREMENT |
|:------:|:---------:|:----------------:|
|  1000  |    0      |         0        |




```sql
            create table deductions(
emp_id number not null,
food_deduction number,
cab_deduction number,
loss_of_pay number,
provident_fund number,
constraint empl_id_fk foreign key(emp_id) references employee(emp_id)
);
```
```sql
            insert into deductions(emp_id,food_deduction,cab_deduction,loss_of_pay,provident_fund)values(emp_id_seq.currval,0,2000,0,0);
```

| EMP_ID | FOOD_DETECTION | CAB_DETECTION | LOSS_OF_PAY | PROVIDENT_FUND |
|:------:|:--------------:|:-------------:|:-----------:|:--------------:|
|  1000  |         0      |      2000     |      0      |         0      |



```sql 
            create table biometrices(
emp_id number not null,
login_time timestamp,
logout_time timestamp,
swipe_count number default 0,
constraint emp_id_fkey foreign key(emp_id) references employee(emp_id)
);
```
```sql
            insert into biometrices(emp_id,swipe_count)values(emp_id_seq.currval,0);

```

| EMP_ID | LOGIN_TIME | LOGOUT_TIME | SWIPE |
|--------|------------|-------------|-------|
| 1000   | 0          | 0           | 0     |

### Feature V : Salary Calculation

```sql 
            create table final_salary(
            emp_id number not null,
            salary_to_be_credited number,
            constraint emp_id_key foreign key(emp_id) references employee(emp_id));
```
```sql
            insert into final_salary(emp_id.currval)values(1001);
```
| EMP_ID | FINAL_SALARY |
|:------:|:------------:|
|  1000  |       0      |

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
  ```

| EMP_ID |           LOGIN_TIME           |         LOGOUT_TIME        |  SWIPE |
|:------:|:------------------------------:|:--------------------------:|        |
|  1000  | 02-01-20 15:42:26.921000000 PM |03-01-20 10:44:02.183000000 |    1   |

```sql

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
                
  ```              
                
| EMP_ID | EMP_NAME | DESIGNATION | EMAIL                        | PERFORMANCE_GRADE | LEAVES-TAKEN | BASEPAY | TOTAL_LEAVES | FOOD_SUBSCRIPTION | CAB_SUBSCRIPTION | PAN_NUMBER |
|--------|----------|-------------|------------------------------|-------------------|--------------|---------|--------------|-------------------|------------------|------------|
| 1000   | Selva    | Admin       | selvamanikandan.ks@gmail.com | 2                 | 1            | 20000   | 11           | Y                 | N                | ABCD1234   |




```sql
            
      update detections d set food_detection = 200 where emp_id = (select emp_id from employee  where emp_id = d.emp_id and food = 'Y');
```

| EMP_ID | FOOD_DETECTION | CAB_DETECTION | LOSS_OF_PAY | PROVIDENT_FUND |
|:------:|:--------------:|:-------------:|:-----------:|:--------------:|
|  1000  |       200      |      2000     |      0      |      1000      |

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
| EMP_ID | FOOD_DETECTION | CAB_DETECTION | LOSS_OF_PAY | PROVIDENT_FUND |
|:------:|:--------------:|:-------------:|:-----------:|:--------------:|
|  1001  |       200      |      2000     |    200      |      1000      |

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
| EMP_ID | FINAL_SALARY |
|:------:|:------------:|
|  1000  |   21300      |
```sql 
      select e.emp_id,e.emp_name,f.salary_to_be_credited from employee e,final_salary f where e.emp_id = f.emp_id;
```
| EMP_ID | EMP_NAME | FINAL_SALARY |
|:------:|:--------:|:------------:|
|  1000  |  Selva   |   21300      |


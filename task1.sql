create table task_manager(
task_name varchar2(20) not null,
task_by varchar2(20) not null,
deadline_date date not null,
completed_date date,
task_status varchar2(20) not null);

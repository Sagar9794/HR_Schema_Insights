/*1	Using HR Schema, Write a Query to find the first day of first job of every employee.*/
use hr;
select distinct first_name,
first_value(start_date) over (partition by jh.employee_id order by start_date) as 'first)_job_date'
from job_history jh
join employees e using (employee_id);

/*2	Using HR Schema, Write a Query to find the starting minimum salary of the first job 
that every employee held.*/
select first_name, 
ifnull(first_value(min_salary) over (partition by employee_id order by start_date), e.salary)salar
from employees  e
left join job_history jh using (employee_id)
left join jobs j on j.job_id= jh.job_id;

/*3	Using HR Schema, Write a Query to find the first day of the most recent job of every employee.*/
select distinct first_name, 
first_value(start_date) over (partition by jh.employee_id order by start_date desc) as 'last_job_date'
from job_history jh
join employees e using (employee_id);

/*4	Using HR Schema, Write a Query to find the minimum salary of the most recent job that every employee holds.*/
select distinct first_name, 
first_value(min_salary) over (partition by employee_id order by start_date desc)recent_job
from employees  e
 join job_history jh using (employee_id)
join jobs j on j.job_id= jh.job_id;

/*5	Using HR Schema, Write a Query to find the last day of first job of every employee.*/
select distinct first_name, 
first_value(end_date) over (partition by jh.employee_id order by start_date desc) as 'last_job_date'
from job_history jh
join employees e using (employee_id);

/*6	Using HR Schema, Write a Query to find the maximum salary of the most recent job that every employee holds.*/
select distinct first_name,
first_value(max_salary) over(partition by jh.employee_id order by start_date desc)as 'last_job_max_sal' 
from job_history jh join employees e using(employee_id)
join jobs j on jh.job_id=j.job_id;


/*7	Using HR Schema, Write a Query to find the last day of the most recent job of every employee.*/
select distinct first_name,
first_value(start_date) over(partition by jh.employee_id order by start_date desc)as 'lastdayrecentjob' 
from job_history jh join employees e using(employee_id)
join jobs j on jh.job_id=j.job_id;

/*8	Using HR Schema, Write a Query to List the current designation and previous designation of all the employees in the company.*/
use hr;
select * from(select distinct first_name,
first_value(jh.job_id) over (partition by jh.employee_id order by start_date desc)current_job,
lead(jh.job_id,1) over(partition by jh.employee_id order by start_date desc)as 'prev_job'
from job_history jh join employees e using(employee_id)
join jobs j on jh.job_id=j.job_id)t
where prev_job is not null;

/*9	Using HR Schema, Write a Query to List the first designation and next promoted designation of all the employees in the company.*/
use hr;
select * from(select distinct first_name,
first_value(jh.job_id) over (partition by jh.employee_id order by start_date desc)current_job,
lead(jh.job_id,1) over(partition by jh.employee_id order by start_date desc)as 'prev_job'
from job_history jh join employees e using(employee_id)
join jobs j on jh.job_id=j.job_id)t
where prev_job is not null;

/*10 Using HR Schema, Write a Query to calculate the cumulative distribution of Salary in the employees table.	*/
select first_name, salary, 
cume_dist() over (order by salary)cum_dist_val from employees;



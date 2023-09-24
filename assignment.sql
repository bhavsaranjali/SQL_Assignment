#1  Display all information in the tables EMP and DEPT.      
 select * from employees;
select * from Departments;

#2  Display only the hire date and employee name for each employee.   
select  first_name, last_name,hire_date
from  employees;

#3  Display the ename concatenated with the job ID, separated by a comma and space, and name the column Employee and Title   
select concat(first_name , " ",last_name, " ", "," , job_id) as employee_and_title
from employees;

#4  Display the hire date, name and department number for all clerks.
select hire_date , first_name, department_id
from employees
where job_id like "%Clerk%" ;

#5  Create a query to display all the data from the EMP table. Separate each column by a comma. Name the column THE OUTPUT   
 select concat(employee_id, ' , ', first_name,',',last_name,',',email,',',phone_number,',',hire_date,',',job_id,',',salary,',',commission_pct,',',
 manager_id,',',department_id) 'The Output from employees ' from employees;

#6  Display the names and salaries of all employees with a salary greater than 2000.   

select first_name , salary 
from employees 
where salary > 2000.00;

#7 Display the names and dates of employees with the column headers "Name" and "Start Date"  
select first_name  as Name ,hire_date as start_date
from employees;

#8   Display the names and hire dates of all employees in the order they were hired.   
select  concat(first_name ,',',last_name) as Name ,hire_date as start_date
from employees
order by hire_date;

#9  Display the names and salaries of all employees in reverse salary order.   
select first_name ,salary 
from employees
order by salary desc;

#
select first_name , department_id , salary ,
case 
when  commission_pct is  null then 0
else commission_pct
end as comm
from employees 
order by salary desc;

#10  Display 'ename" and "deptno" who are all earned commission and display salary in reverse order.   
 
select concat(first_name, last_name ) as employeename , department_id , salary 
from employees
where commission_pct is not null 
order by salary desc;

#11 Display the last name and job title of all employees who do not have a manager   
select last_name , job_title
from employees as e join jobs as j 
on e.job_id = j.job_id
where e.manager_id is null;   

#12  Display the last name, job, and salary for all employees whose job is sales representative or stock clerk and 
#whose salary is not equal to $2,500, $3,500, or $5,000 
 select e.last_name , e.job_id , e.salary ,j.job_title
 from jobs as j  join employees as e
on j.job_id = e.job_id
where j.job_title  in ('sales representative','stock clerk') and salary not in (2500,3500,5000);

#1)  Display the maximum, minimum and average salary and commission earned. 
select max(commission_pct) 'Max commssion', max(salary)'Max Salary' ,min(salary)'Min salary',min(commission_pct)'Min commssion',
avg(commission_pct) 'Avg commssion', avg(salary)'Avg salary' 
from employees
where commission_pct is not null;


/*2) Display the department number, total salary payout 
and total commission payout for each department.   */

select department_id  , sum(salary) 'Total salary'  , sum(commission_pct) 'Total commission' from employees
group by department_id;

 #3)  Display the department number and number of employees in each department.   
 select department_id , count(employee_id)  'number of employees'from employees
 group by department_id;
 
 #4)  Display the department number and total salary of employees in each department.  
  select department_id  , sum(salary) ' Total salary' from employees
group by department_id;

 #5) Display the employee's name who doesn't earn a commission. Order the result set without using the column name
 
select first_name ,commission_pct
from employees 
where commission_pct is null;

#6) Display the employees name, department id and commission. If an Employee doesn't  earn the commission, then display as 'No commission'. Name the columns appropriately  
 
 select concat(first_name , " ", last_name) as employee_name , 
 department_id , commission_pct ,
 case
 when  commission_pct is  null then "No commission"
 else commission_pct
 end as commission
 from employees 
 order by department_id;
 
 # 7) Display the employee's name, salary and commission multiplied by 2. If an Employee doesn't earn the commission, then display as 'No commission. Name the columns appropriately  
 select concat(first_name , " ", last_name) as employee_name , 
 department_id , 
 case
when commission_pct > 0 then commission_pct*2
 else  "No commission"
 end as commission
 from employees 
 order by department_id;
 
 #8)Display the employee's name, department id who have the first name same as another employee in the same department  
 select first_name , department_id 
 from employees
 group by  first_name , department_id 
 having count(first_name) >1 ;
 
 # 9)  Display the sum of salaries of the employees working under each Manager.
 
 select e.manager_id, sum(e.salary)  'sum of salaries'
 from employees as e left join employees as m
 on e.manager_id = m.employee_id
 where  m.employee_id is not null
 group by e.manager_id;
 
 #10)  Select the Managers name, the count of employees working under and the department ID of the manager. 
 select concat(m.first_name,m.last_name) 'Manager Name',count(e.employee_id) ' count of employees' ,
 m.department_id
 from employees as e left join employees as m
 on e.manager_id = m.employee_id
 group by e.manager_id
 order by m.department_id desc;
 
 #11) Select the employee name, department id, and the salary. Group the result with the manager name and the employee last name should have second letter 'a!   
 select m.first_name,m.last_name,m.department_id, avg(e.salary)
from employees as e left join employees as m
 on e.manager_id = m.employee_id
 group by m.first_name,m.last_name, m.department_id
 having  m.last_name like "_a%";

#12) Display the average of sum of the salaries and group the result with the department id. Order the result with the department id.   
select department_id,avg(salary) ' Avg_salary'
from employees 
group by department_id 
order by department_id asc;

select department_id,avg(salary) ' Avg_salary'
from employees 
group by department_id 
having  avg(salary) > (select avg(salary) from employees )
order by department_id asc;

#13) Select the maximum salary of each department along with the department id   
 select department_id ,max(salary) 'Max Salary'
 from employees
 group by department_id;
 
 #14) Display the commission, if not null display 10% of salary, if null display a default value 1 
  select commission_pct,
 case
when commission_pct is not null then salary + (salary * 10/ 100)
 else  '1'
 end as new_salary
 from employees ;

 
 /*1. Write a query that displays the employee's last names only
 from the string's 2-5th position with the first letter capitalized and 
 all other letters lowercase, Give each column an appropriate label.  */
SELECT last_name , concat(upper(substring(last_name,2,1)),lower(substring(last_name,3,3)))
'2-5th Last Name ' from employees;

 /*2. Write a query that displays the employee's first name and last name
 along with a " in between for e.g.: first name : Ram; last name : Kumar then Ram-Kumar.
 Also displays the month on which the employee has joined.  */
 select concat(first_name,"-" , last_name) 'Employee name ', month(hire_date) 'Month Number',hire_date
 from employees;
 
 /* Write a query to display the employee's last name and if half of the salary is greater than
 ten thousand then increase the salary by 10% else by 11.5% along with the bonus amount of 1500 each. 
 Provide each column an appropriate label.    */
 select last_name,
 case
 when  (salary/2) >10000 then (salary + ((salary *10) /100 )+ 1500)
 else (salary + ((salary * 11.5 ) /100) + 1500)
 end as 'New Salary'
 from employees;
 
 
 /* 4. Display the employee ID by Appending two zeros after 2nd digit and
 'E' in the end, department id, salary and the manager name all in Upper case, 
 if the Manager name consists of 'z' replace it with '$!    */
 
 select employee_id 
 ,concat(substring(cast(employee_id as varchar),1,2),'00',
 substring(cast(employee_id as varchar),3,3)'E')
 from employees;
  

 /* 5. Write a query that displays the employee's last names with the first letter capitalized and 
 all other letters lowercase, and the length of the names, 
 for all employees whose name starts with J, A, or M. Give each column 
 an appropriate label. Sort the results by the employees' last names */
 
Select last_name,first_name, 
case 
when first_name like 'J%' or first_name like 'A%' or first_name like 'M%' 
then length(first_name) 
else null 
end 'LEN of J,A,M'
from employees order by last_name;
 
 /* 6 Create a query to 
 display the last name and salary for all employees.
 Format the salary to be 15 characters long, left-padded with $. Label the column SALARY   */
SELECT last_name,
LPAD(salary, 15, '$') SALARY
FROM employees;

/*7. Display the employee's name if it is a palindrom*/
 Select first_name, 
 Case 
 when first_name=REVERSE(first_name) then first_name
 else null end 'Palindrome'
 from employees;

/*8. Display First names of all employees with initcaps.*/
Select CONCAT(UPPER(SUBSTRING(first_name,1,1)),LOWER(Substring(first_name,2)))
from employees;


/*9  From LOCATIONS table, extract the word between first and second space from the STREET ADDRESS column. locations*/   
select
SUBSTRING_INDEX(street_address, " ", -2), street_address
from locations;

select SUBSTRING_INDEX(SUBSTRING_INDEX(street_address, " ", 2), " ", -1),street_address
from locations;

/*10. Extract first letter from First Name column and append it with the Last Name. Also add "@systechusa.com" at the end. 
Name the column as e-mail address. All characters should be in lower case. Display this along with their First Name. */

Select first_name,
CONCAT(LOWER(SUBSTRING(first_name,1,1)),LOWER(SUBSTRING(last_name,1,length(last_name))),
'@systechusa.com') 'E-mail Address' from employees;


/*11. Display the names and job titles of all employees with the same job as Trenna.   */
select e.first_name,j.job_title
from employees e join jobs j 
on e.job_id =j.job_id
where j.job_id= (select job_id from employees where first_name = 'Trenna');

/*12. Display the names and department name of all employees working in the same city as Trenna.   */
Select e.first_name,e.last_name,e.department_id
from employees e join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id 
where l.city = 
(Select l.city from employees e join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id where e.first_name = 'Trenna');


/*13. Display the name of the employee whose salary is the lowest. */
Select first_name,last_name from employees where salary = 
(Select MIN(salary) from employees);
 
/*14. Display the names of all employees except the lowest paid.*/
Select first_name,last_name from employees where salary != 
(Select MIN(salary) from employees);


/*1. Write a query to display the last name, department number, department name for all employees.  */

select e.last_name, e.department_id,d. Department_name
from employees e left join departments d
on e.department_id = d.department_id
group by department_id , last_name;


/*2. Create a unique list of all jobs that are in department 4.
 Include the location of the department in the output.*/
Select Distinct(j.job_title),d.department_name,l.city
from employees e join departments d on e.department_id = d.department_id
join jobs j on e.job_id = j.job_id join locations l on d.location_id = l.location_id
where d.department_id in (10,20,30,40);
 
 /*3. Write a query to display the employee last name,department name,location id and city of all employees who earn commission. */
 
 select e.last_name ,d.department_name ,l.location_id, l.city 
 from employees e join departments d
 on e.department_id = d.department_id 
 join locations l 
on  d.location_id = l.location_id 
where e.commission_pct is not null;
 
 /*4. Display the employee last name and department name of all employees who have an 'a' in their last name  */
 select e.last_name ,d.department_name 
  from employees e join departments d
 on e.department_id = d.department_id 
 where last_name like "%a%";
 
 /*5. Write a query to display the last name,job,department number and 
 department name for all employees who work in ATLANTA.*/ 
 select e.last_name ,e.job_id,d.department_id,d.department_name , l.city 
 from employees e join departments d
 on e.department_id = d.department_id 
 join locations l 
on  d.location_id = l.location_id 
where l.city = 'toronto';

/*6. Display the employee last name and employee number along with their manager's last name and manager number. */
select e.last_name 'employee last name',e.employee_id, m.last_name'manager last name',m.manager_id
from employees as e left join employees as m
on e.manager_id = m.employee_id
-- on e.employee_id = m.employee_id
group by m.manager_id,m.last_name,e.employee_id
having m.manager_id is not null;

/*7. Display the employee last name and employee number along with
 their manager's last name and manager number (including the employees who have no manager).  */ 
 select e.last_name 'employee last name',e.employee_id, m.last_name'manager last name',m.manager_id
from employees as e left join employees as m
on e.manager_id = m.employee_id
group by m.manager_id,m.last_name,e.employee_id;

/*8. Create a query that displays employees last name,department number,
and all the employees who work in the same department as a given employee.  */
select last_name, department_id
from employees 
group by last_name,department_id;

/*9 Create a query that displays the name,job,department name,
salary,grade for all employees.  Derive grade based on salary(>=50000=A, >=30000=B,<30000=C)*/

select concat(e.first_name , " ", e.last_name) 'name',e.job_id,d.department_name ,e.salary,
case 
when e.salary >= 5000 then 'A'
when e.salary >= 3000 then 'B'
when e.salary <3000 then 'C'
end as 'grade salary'
from employees e join departments d
 on e.department_id = d.department_id ;
 
 /*10. Display the names and hire date for all employees who were hired before their managers 
 along withe their manager names and hire date. Label the columns as Employee name, emp_hire_date,manager name,man_hire_date */
select  concat(e.first_name , " ", e.last_name) 'Employee name',e.hire_date 'emp_hire_date',
concat(m.first_name , " ", m.last_name) 'Manager name',m.hire_date 'man_hire_date'
from employees as e left join employees as m
on e.employee_id = m.manager_id
where m.hire_date > e.hire_date;


 /* 1 Write a query to display the
 last name and hire date of any employee in the same department as SALES. */
 select e.last_name , e.hire_date ,d.department_name
 from employees e join departments d
 on e.department_id = d.department_id 
 where d.department_name = 'SALES';

/*2. Create a query to display the employee numbers and last names of all
 employees who earn more than the average salary. Sort the results in
 ascending order of salary.   */
 
select  employee_id, last_name ,salary
from employees 
where salary > (select avg(salary) from employees) 
order by salary asc;

/*3. Write a query that displays the employee numbers and last names of all employees 
who work in a department with any employee whose last name contains a' u   */

select employee_id , last_name 
from employees 
where department_id is not null and last_name like '%u%';
 
 /* 4. Display the last name, department number, and job ID of all employees whose 
department location is ATLANTA.*/ 

select e.last_name , e.department_id , e.job_id 
from employees e join departments d
on e.department_id = d.department_id
join locations l 
on d.location_id = l.location_id
where l.state_province = 'Washington';

/*5. Display the last name and salary of every employee who reports to FILLMORE.*/
Select m.last_name,m.salary 
from employees e join employees m 
on e.employee_id = m.employee_id 
where e.last_name = 'King';

/* 6. Display the department number, last name, and job ID for every employee in the 
OPERATIONS department.*/ 
select em.department_id, em.last_name, em.job_id 
from employees em join departmentS de
ON EM.department_id= DE.department_id
where  de.department_name = 'OPERATIONS';

/* 7. Modify the above query to display the employee numbers, last names, and salaries of all 
employees who earn more than the average salary and who work in a department with any 
employee with a 'u'in their name.*/

select employee_id , last_name ,  salary 
from employees
where   department_id is not null and last_name like '%u%' and salary>(select avg(salary) from employees)  ;

/* 8. Display the names of all employees whose job title is the same as anyone in the sales dept. */
select first_name ,j.job_title, department_name
from employees e join departments d
on e.department_id = d.department_id 
join jobs j 
on e.job_id = j.job_id 
where department_name='sales';

/* 9. Write a compound query to produce a list of employees showing raise percentages, 
employee IDs, and salaries. Employees in department 1 and 3 are given a 5% raise, 
employees in department 2 are given a 10% raise, employees in departments 4 and 5 are 
given a 15% raise, and employees in department 6 are not given a raise.*/

select employee_id , salary, department_id,
case 
when  department_id in (10,30) then salary+((salary*5)/100) 
when department_id = 20 then salary+((salary*10)/100) 
when department_id in (40,50)then salary+((salary*15)/100) 
when department_id = 60 then salary
else salary
end 'New salary'
from employees
where department_id in (10,20,30,40,50,60);

/* 10. Write a query to display the top three earners in the EMPLOYEES table. 
Display their last names and salaries.*/
 
 Select  last_name,salary from employees 
 order by salary desc
 limit 3;

/* 11. Display the names of all employees with their salary and commission earned. Employees 
with a null commission should have O in the commission column */
select first_name , salary ,
case 
when commission_pct is null then 0
else commission_pct
end Commission
from employees;

/* 12. Display the Managers (name) with top three salaries along with their salaries and 
department information*/

Select distinct(e.first_name), e.salary ,e.department_id 
from employees e join employees m 
on e.employee_id = m.manager_id 
order by e.salary desc
limit 3;


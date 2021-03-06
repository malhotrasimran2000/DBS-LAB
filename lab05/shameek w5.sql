--1)	
select bdate,address
from employee
where fname='John' and minit='B' and lname='Smith';

select fname,minit,lname,address
from employee natural join department1
where dname='Research';

--2)	
select pnumber,dnumber,lname,address,bdate
from department1 natural join project, employee
where plocation='Stafford' and employee.ssn = mgr_ssn;

--3)	
select distinct salary from employee;

--4)	
select a.fname,a.lname,b.fname,b.lname
from employee a,employee b
where a.super_ssn=b.ssn;

--5)	

--6)	
select * from employee where address like '%Houston, TX%';

--7)	
update employee set salary = 1.1*salary where ssn in 
(select essn from project,works_on where works_on.pno=project.pnumber
and project.pname='ProductX');

--8)	
select fname from department1,employee
where department1.dnumber=employee.dno and 
dnumber=5 and salary between 30000 and 40000;

--9)	
select dno,fname,lname
from employee,project,works_on
where works_on.pno=project.pnumber
and works_on.essn=employee.ssn
order by dno,lname,fname;

--10)	
select fname
from employee
where Super_ssn is NULL;

--11)	
select fname
from employee,dependent
where ssn=essn
and fname=Dependent_name
and dependent.sex=employee.sex;

--12)	
select fname from employee where not exists
(select * from dependent where dependent.essn =employee.ssn);

--13)	
with a(b,c) as 
(select distinct employee.ssn,employee.fname from employee,department1
where employee.ssn=department1.mgr_ssn)
select * from a
where 1<=(select count(*) from dependent where dependent.essn=a.b);

--14)	
select distinct essn
from works_on
where pno=1 or pno=2 or pno=3;

--15)	
select avg(salary) from employee;
select sum(salary) from employee;
select max(salary) from employee;
select min(salary) from employee;

--16)	
select avg(salary)
from employee,department1
where dno=dnumber
and department1.dname='Research';

--17)	
select pno,pname,count(essn)
from works_on,project
where works_on.pno=project.pnumber
group by(pno,pname);

--18)	
select pno,pname,count(essn)
from works_on,project
where works_on.pno=project.pnumber
group by(pno,pname)
having count(essn)>2;

--19)	
with a(b) as(select dno
from employee
group by(dno)
having count(ssn)>=5)
select count(*)
from employee,a
where employee.dno=a.b
and salary>40000;


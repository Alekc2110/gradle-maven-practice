-- Find user by name (exact match)
select s.person_id, p.name, p.surname, p.phone, p.birth_date
from student s
         join person p on s.person_id = p.id
where p.name = 'Alisha';

explain analyse select s.person_id, p.name, p.surname, p.phone, p.birth_date
from student s
         join person p on s.person_id = p.id
where p.name = 'Alisha';
--**************************************

--Find user by surname (partial match)
select s.person_id, p.name, p.surname, p.phone, p.birth_date
from student s
         join person p on s.person_id = p.id
where p.surname LIKE 'John%';

explain analyse select s.person_id, p.name, p.surname, p.phone, p.birth_date
from student s
         join person p on s.person_id = p.id
where p.surname LIKE 'John%';
--**************************************

-- Find user by phone number (partial match) 687-516-4092
select s.person_id, p.name, p.surname, p.phone, p.birth_date
from student s
         join person p on s.person_id = p.id
where p.phone SIMILAR TO '\d{3}-\d{3}-\d{4}';

explain analyse select s.person_id, p.name, p.surname, p.phone, p.birth_date
from student s
         join person p on s.person_id = p.id
where p.phone SIMILAR TO '\d{3}-\d{3}-\d{4}';
--**************************************

--Find user with marks by user surname (partial match)
select p.id,p.name, p.surname, er.mark
from student s
         join person p on s.person_id = p.id
         join exam_results er on s.person_id = er.student_id
where p.surname LIKE 'John%'
order by p.id;

explain analyse select p.id,p.name, p.surname, er.mark
from student s
         join person p on s.person_id = p.id
         join exam_results er on s.person_id = er.student_id
where p.surname LIKE 'John%'
order by p.id;
--***************************************

--throw validation exception
insert into person (name, surname, phone, birth_date)
values ('test#', 'test_surname', '+380508877999', '1988-01-01');

update student set primary_skill='Law' where person_id=100;

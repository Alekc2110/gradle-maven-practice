CREATE TABLE student_snapshot AS
SELECT p.name AS student_name, p.surname AS student_surname, sub.name AS subject_name, er.mark
FROM student s
         JOIN person p ON p.id = s.person_id
         JOIN exam_results er ON s.person_id = er.student_id
         JOIN tutors_subjects ts ON er.subject_id = ts.subject_id
         JOIN subject sub ON ts.subject_id = sub.id;

SELECT * FROM student_snapshot;
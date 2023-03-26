-- function that will return average mark for input user
CREATE OR REPLACE FUNCTION get_average_mark_for_student(stud_id INTEGER)
RETURNS TABLE(average_mark NUMERIC) AS
$$
BEGIN
    RETURN QUERY SELECT round(AVG(mark)) FROM exam_results
                 WHERE student_id = stud_id;
END;
$$
    LANGUAGE plpgsql;

--example
select get_average_mark_for_student(100);


-- function that will return average mark for input subject name
CREATE OR REPLACE FUNCTION get_average_mark_for_subject(p_subject_name VARCHAR)
    RETURNS TABLE(average_mark NUMERIC) AS
$$
BEGIN
    RETURN QUERY SELECT round(AVG(es.mark))
                 FROM exam_results es
                          JOIN subject s ON es.subject_id = s.id
                 WHERE s.name = p_subject_name;
END;
$$
    LANGUAGE plpgsql;

--example
select get_average_mark_for_subject('Mathematics');


-- function that will return student at "red zone"
CREATE FUNCTION get_red_zone_students()
RETURNS TABLE (stud_id INTEGER, stud_name VARCHAR, stud_surname VARCHAR) AS
$$
BEGIN
    RETURN QUERY
        SELECT s.person_id, p.name AS student_name, p.surname AS student_surname
        FROM student s
                 JOIN person p on p.id = s.person_id
                 JOIN exam_results er ON s.person_id = er.student_id
        WHERE er.mark <= 3
        GROUP BY s.person_id, p.name, p.surname
        HAVING COUNT(*) >= 2;
END;
$$ LANGUAGE plpgsql;

--example
select get_red_zone_students();
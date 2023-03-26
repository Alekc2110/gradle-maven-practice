DROP TABLE IF EXISTS person, student, tutor, subject, tutors_subjects, exam_results, student_snapshot;
DROP FUNCTION IF EXISTS get_average_mark_for_student;
DROP FUNCTION IF EXISTS get_average_mark_for_subject;
DROP FUNCTION IF EXISTS get_red_zone_students;
DROP FUNCTION IF EXISTS update_student_updated_at cascade;

DROP SEQUENCE IF EXISTS doctors_d_id_seq;
CREATE SEQUENCE person_id_seq START WITH 100010 INCREMENT BY 10;


CREATE TABLE IF NOT EXISTS person
(
    id         INTEGER NOT NULL default NEXTVAL('person_id_seq'),
    name       VARCHAR(45) NOT NULL,
    surname    VARCHAR(45) NOT NULL,
    phone      VARCHAR(45),
    birth_date DATE        NOT NULL,

    PRIMARY KEY (id)
);

--add constraint to reject student name with next characters '@', '#', '$'
ALTER TABLE person ADD CONSTRAINT name_check CHECK (name !~ '[@#$]');


CREATE TABLE IF NOT EXISTS student
(
    person_id     INT         NOT NULL UNIQUE,
    primary_skill VARCHAR(45) NOT NULL,
    created_at    TIMESTAMP,
    updated_at    TIMESTAMP,
    CONSTRAINT stud_id_person_id_fk
        FOREIGN KEY (person_id)
            REFERENCES person (id)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS tutor
(
    person_id INT NOT NULL UNIQUE,
    position  VARCHAR(45),
    CONSTRAINT tutor_id_per_id_fk
        FOREIGN KEY (person_id)
            REFERENCES person (id)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS subject
(
    id   SERIAL      NOT NULL,
    name VARCHAR(45) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS tutors_subjects
(
    tutor_id   int NOT NULL,
    subject_id int NOT NULL,
    CONSTRAINT tutor_id_person_id_tutor_fk
        FOREIGN KEY (tutor_id)
            REFERENCES tutor (person_id)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT subject_id_id_subject_fk
        FOREIGN KEY (subject_id)
            REFERENCES subject (id)
            ON DELETE CASCADE
            ON UPDATE CASCADE

);


CREATE TABLE IF NOT EXISTS exam_results
(
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    mark       INT,
    CONSTRAINT st_id_person_id_student_fk
        FOREIGN KEY (student_id)
            REFERENCES student (person_id)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT sub_id_id_subject_fk
        FOREIGN KEY (subject_id)
            REFERENCES subject (id)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);
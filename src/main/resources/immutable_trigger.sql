CREATE TABLE student_address
(
    id         SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES student (person_id),
    address    TEXT NOT NULL,
    city       TEXT NOT NULL,
    state      TEXT NOT NULL,
    zip        TEXT NOT NULL
);


INSERT INTO student_address (id, student_id, address, city, state, zip)
VALUES
    (1, 100,'test str.','Kiev','Ukraine','12234'),
    (2, 101,'test1 str.','Lviv','Ukraine','12235'),
    (3, 102,'test2 str.','Dnipro','Ukraine','12236'),
    (4, 103,'test3 str.','Kharkiv','Ukraine','12237');


CREATE OR REPLACE FUNCTION immutable_student_address_trigger()
    RETURNS TRIGGER AS
$$
BEGIN
    -- Reject any UPDATE operation on student_address and throw exception
    IF TG_OP = 'UPDATE'
    THEN
        RAISE EXCEPTION 'Cannot update student_address table!';
    END IF;

    RETURN NULL;
END
$$ LANGUAGE plpgsql;


CREATE TRIGGER immutable_student_address_trigger
    BEFORE UPDATE
    ON student_address
    FOR EACH ROW
EXECUTE FUNCTION immutable_student_address_trigger();

DROP function immutable_student_address_trigger CASCADE ;

UPDATE student_address SET state = 'CANADA' WHERE id=1;
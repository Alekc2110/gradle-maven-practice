CREATE OR REPLACE FUNCTION update_student_updated_at()
RETURNS TRIGGER AS
$$
BEGIN
  NEW.updated_at := now();
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER student_update_trigger
    BEFORE UPDATE ON student
    FOR EACH ROW
    EXECUTE FUNCTION update_student_updated_at();


CREATE INDEX person_name_idx ON person USING btree (name);
CREATE INDEX person_name_idx ON person USING hash (name);
CREATE INDEX person_name_idx ON person USING gin (name gin_trgm_ops);
CREATE INDEX person_name_idx ON person USING gist (name gist_trgm_ops);


CREATE INDEX person_surname_idx ON person USING btree (surname);
CREATE INDEX person_surname_idx ON person USING hash (surname);
CREATE INDEX person_surname_idx ON person USING gin (surname gin_trgm_ops);
CREATE INDEX person_surname_idx ON person USING gist (surname gist_trgm_ops);


CREATE INDEX person_phone_idx ON person USING btree (phone);
CREATE INDEX person_phone_idx ON person USING hash (phone);
CREATE INDEX person_phone_idx ON person USING gin (phone gin_trgm_ops);
CREATE INDEX person_phone_idx ON person USING gist (phone gist_trgm_ops);
DROP INDEX person_phone_idx;

--return index size
select pg_size_pretty(pg_total_relation_size('person_phone_idx')) as person_phone_gist_idx_size;

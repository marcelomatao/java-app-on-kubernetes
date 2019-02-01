CREATE SEQUENCE hibernate_sequence START WITH 1;

CREATE TABLE customer (
    id bigint NOT NULL PRIMARY KEY,
    first_name varchar NOT NULL,
    last_name varchar NOT NULL,
    UNIQUE(first_name, last_name)
);

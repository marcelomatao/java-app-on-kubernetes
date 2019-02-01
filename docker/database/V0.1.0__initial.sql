CREATE SCHEMA `customerdb`;
USE `customerdb`;

CREATE SEQUENCE hibernate_sequence START WITH 1;

CREATE TABLE customer (
    id bigint NOT NULL PRIMARY KEY,
    first_name varchar(255) NOT NULL,
    last_name varchar(255) NOT NULL,
    UNIQUE(first_name, last_name)
);

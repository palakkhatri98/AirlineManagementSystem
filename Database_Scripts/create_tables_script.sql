-- Database: airline_management

-- DROP DATABASE IF EXISTS airline_management;

CREATE DATABASE airline_management
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- Table: public.customer

-- DROP TABLE IF EXISTS public.customer;

CREATE TABLE IF NOT EXISTS public.customer
(
    cus_id bigint NOT NULL DEFAULT nextval('customer_cus_id_seq'::regclass),
    fname text COLLATE pg_catalog."default" NOT NULL,
    lname text COLLATE pg_catalog."default" NOT NULL,
    address text COLLATE pg_catalog."default" NOT NULL,
    phone character varying(10) COLLATE pg_catalog."default" NOT NULL,
    age integer NOT NULL,
    birth_date date NOT NULL,
    CONSTRAINT customer_pkey PRIMARY KEY (cus_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.customer
    OWNER to postgres;
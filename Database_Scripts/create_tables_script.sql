

-- Table: public.customer

DROP TABLE IF EXISTS public.customer;

CREATE SEQUENCE public.customer_cus_id_seq 
START WITH 1 
INCREMENT BY 1;

CREATE TABLE public.customer
(
    cus_id BIGINT NOT NULL DEFAULT nextval('public.customer_cus_id_seq'::regclass),
    fname TEXT COLLATE pg_catalog."default" NOT NULL,
    lname TEXT COLLATE pg_catalog."default" NOT NULL,
    address TEXT COLLATE pg_catalog."default" NOT NULL,
    phone VARCHAR(10) COLLATE pg_catalog."default" NOT NULL,
    age INTEGER NOT NULL,
    birth_date DATE NOT NULL,
    CONSTRAINT customer_pkey PRIMARY KEY (cus_id)
)
TABLESPACE pg_default;

ALTER SEQUENCE public.customer_cus_id_seq OWNED BY public.customer.cus_id;

ALTER TABLE public.customer OWNER TO postgres;


-- Table: public.airport

-- Table: public.airport

DROP TABLE IF EXISTS public.airport;

CREATE SEQUENCE public.airport_airport_id_seq 
START WITH 1 
INCREMENT BY 1;

CREATE TABLE IF NOT EXISTS public.airport
(
    airport_id bigint NOT NULL DEFAULT nextval('airport_airport_id_seq'::regclass),
    name text COLLATE pg_catalog."default",
    CONSTRAINT airport_pkey PRIMARY KEY (airport_id)
)

TABLESPACE pg_default;

ALTER SEQUENCE public.airport_airport_id_seq OWNED BY public.airport.airport_id;


ALTER TABLE IF EXISTS public.airport
    OWNER to postgres;
-- Table: public.flight

DROP TABLE IF EXISTS public.flight;

CREATE TABLE IF NOT EXISTS public.flight
(
    flight_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    total_seats integer,
    price integer,
    flight_from text COLLATE pg_catalog."default",
    flight_to text COLLATE pg_catalog."default",
    arrival_time timestamp with time zone,
    dep_time timestamp with time zone,
    CONSTRAINT flight_pkey PRIMARY KEY (flight_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.flight
    OWNER to postgres;


-- Table: public.staff

DROP TABLE IF EXISTS public.staff;

CREATE TABLE IF NOT EXISTS public.staff
(
    staff_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    staff_name text COLLATE pg_catalog."default",
    phone character varying(10) COLLATE pg_catalog."default",
    email_id text COLLATE pg_catalog."default",
    address text COLLATE pg_catalog."default",
    staff_type text COLLATE pg_catalog."default",
    age integer,
    airport_id bigint,
    CONSTRAINT staff_pkey PRIMARY KEY (staff_id),
    CONSTRAINT airport_id_fk FOREIGN KEY (airport_id)
        REFERENCES public.airport (airport_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.staff
    OWNER to postgres;


-- Table: public.pilot

DROP TABLE IF EXISTS public.pilot;

CREATE TABLE IF NOT EXISTS public.pilot
(
    pilot_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    staff_id bigint,
    experience_level text COLLATE pg_catalog."default",
    CONSTRAINT pilot_pkey PRIMARY KEY (pilot_id),
    CONSTRAINT staff_id_fk FOREIGN KEY (staff_id)
        REFERENCES public.staff (staff_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.pilot
    OWNER to postgres;


-- Table: public.relation_flight_pilot

DROP TABLE IF EXISTS public.relation_flight_pilot;

CREATE TABLE IF NOT EXISTS public.relation_flight_pilot
(
    relation_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    flight_id bigint NOT NULL,
    pilot_id bigint NOT NULL,
    CONSTRAINT relation_flight_pilot_pkey PRIMARY KEY (relation_id),
    CONSTRAINT flight_id_fk FOREIGN KEY (flight_id)
        REFERENCES public.flight (flight_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT pilot_id_fk FOREIGN KEY (pilot_id)
        REFERENCES public.pilot (pilot_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.relation_flight_pilot
    OWNER to postgres;


-- Drop table if it exists
DROP TABLE IF EXISTS public.ticket;

-- Create sequence for ticket_id
CREATE SEQUENCE public.ticket_ticket_id_seq 
START WITH 1 
INCREMENT BY 1;

-- Create the ticket table
CREATE TABLE public.ticket
(
    ticket_id BIGINT NOT NULL DEFAULT nextval('public.ticket_ticket_id_seq'::regclass),
    price INTEGER NOT NULL,
    dep_date DATE,
    dep_time TIME WITHOUT TIME ZONE,
    cus_id BIGINT,
    booking_date DATE,
    booking_time TIME WITHOUT TIME ZONE,
    seat_no INTEGER,
    flight_to INTEGER,
    flight_from INTEGER,
    CONSTRAINT ticket_pkey PRIMARY KEY (ticket_id),
    CONSTRAINT ticket_cus_id_fkey FOREIGN KEY (cus_id)
        REFERENCES public.customer (cus_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

-- Set ownership of the sequence
ALTER SEQUENCE public.ticket_ticket_id_seq OWNED BY public.ticket.ticket_id;

-- Set ownership of the table
ALTER TABLE public.ticket OWNER TO postgres;

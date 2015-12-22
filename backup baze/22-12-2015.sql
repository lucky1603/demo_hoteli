--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: hotel; Type: COMMENT; Schema: -; Owner: hotel
--

COMMENT ON DATABASE hotel IS '- how to set autoincrement

SELECT setval(''[TABLE_NAME]_id_seq'',[NEXT_ID],false);';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: tablefunc; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS tablefunc WITH SCHEMA public;


--
-- Name: EXTENSION tablefunc; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION tablefunc IS 'functions that manipulate whole tables, including crosstab';


SET search_path = public, pg_catalog;

--
-- Name: hash_pwd_trigg_function(); Type: FUNCTION; Schema: public; Owner: hotel
--

CREATE FUNCTION hash_pwd_trigg_function() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.password = md5(NEW.password);
	RETURN NEW;

END;
$$;


ALTER FUNCTION public.hash_pwd_trigg_function() OWNER TO hotel;

--
-- Name: res_num_trigg_func(); Type: FUNCTION; Schema: public; Owner: hotel
--

CREATE FUNCTION res_num_trigg_func() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
NEW.reservation_id = lpad((SELECT currval('reservations_id_seq'))::text, 10,'0');
RETURN NEW;
END
$$;


ALTER FUNCTION public.res_num_trigg_func() OWNER TO hotel;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: attribute; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE attribute (
    id integer NOT NULL,
    code character varying(20),
    label character varying(50),
    type character varying(20),
    sort_order integer,
    unit character varying(20),
    "unique" boolean DEFAULT false NOT NULL,
    nullable boolean DEFAULT true NOT NULL,
    scope integer DEFAULT 1 NOT NULL
);


ALTER TABLE attribute OWNER TO hotel;

--
-- Name: attribute_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE attribute_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE attribute_id_seq OWNER TO hotel;

--
-- Name: attribute_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE attribute_id_seq OWNED BY attribute.id;


--
-- Name: attribute_option_values; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE attribute_option_values (
    id integer NOT NULL,
    attribute_id integer,
    value integer,
    text character varying(50)
);


ALTER TABLE attribute_option_values OWNER TO hotel;

--
-- Name: attribute_option_values_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE attribute_option_values_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE attribute_option_values_id_seq OWNER TO hotel;

--
-- Name: attribute_option_values_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE attribute_option_values_id_seq OWNED BY attribute_option_values.id;


--
-- Name: business; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE business (
    id integer NOT NULL,
    name character varying(100),
    description text,
    company_name character varying(100),
    address text,
    phone character varying(50),
    email character varying,
    contact_first_name character varying(50),
    contact_last_name character varying(50)
);


ALTER TABLE business OWNER TO hotel;

--
-- Name: business_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE business_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE business_id_seq OWNER TO hotel;

--
-- Name: business_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE business_id_seq OWNED BY business.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE categories (
    id integer NOT NULL,
    name character varying(100),
    description text,
    parent_id integer
);


ALTER TABLE categories OWNER TO hotel;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE categories_id_seq OWNER TO hotel;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: clients; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE clients (
    id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100),
    address1 character varying(100),
    address2 character varying(100),
    city character varying(100),
    zipcode character varying(20),
    country character varying(10),
    phone character varying(100),
    mobile character varying(100),
    fax character varying(100),
    email character varying(255),
    title character(4),
    guest_class character varying(10),
    title_id integer
);


ALTER TABLE clients OWNER TO hotel;

--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clients_id_seq OWNER TO hotel;

--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE clients_id_seq OWNED BY clients.id;


--
-- Name: ct; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE ct (
    id integer NOT NULL,
    rowid text,
    attribute text,
    value text
);


ALTER TABLE ct OWNER TO hotel;

--
-- Name: ct_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE ct_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ct_id_seq OWNER TO hotel;

--
-- Name: ct_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE ct_id_seq OWNED BY ct.id;


--
-- Name: entity; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE entity (
    id integer NOT NULL,
    definition_id integer NOT NULL,
    status character varying,
    guid character varying(10),
    status_id integer
);


ALTER TABLE entity OWNER TO hotel;

--
-- Name: COLUMN entity.guid; Type: COMMENT; Schema: public; Owner: hotel
--

COMMENT ON COLUMN entity.guid IS 'ovo neka bude broj sobe, za sada';


--
-- Name: entity_category; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE entity_category (
    id integer NOT NULL,
    entity_id integer,
    category_id integer
);


ALTER TABLE entity_category OWNER TO hotel;

--
-- Name: entity_category_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE entity_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entity_category_id_seq OWNER TO hotel;

--
-- Name: entity_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE entity_category_id_seq OWNED BY entity_category.id;


--
-- Name: entity_definition; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE entity_definition (
    id integer NOT NULL,
    entity_type_id integer NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(10),
    description text,
    price numeric(10,2),
    pax smallint DEFAULT 1
);


ALTER TABLE entity_definition OWNER TO hotel;

--
-- Name: TABLE entity_definition; Type: COMMENT; Schema: public; Owner: hotel
--

COMMENT ON TABLE entity_definition IS ' - za demo verziju ova tabela ce sadrzati samo tip sobe (Single,Double, Suite...)
- kolona price predstavlja cenu na dan';


--
-- Name: COLUMN entity_definition.pax; Type: COMMENT; Schema: public; Owner: hotel
--

COMMENT ON COLUMN entity_definition.pax IS ' - reference for PAX system;
- for now it will represent maximum number of persons for this type';


--
-- Name: entity_definition_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE entity_definition_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entity_definition_id_seq OWNER TO hotel;

--
-- Name: entity_definition_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE entity_definition_id_seq OWNED BY entity_definition.id;


--
-- Name: entity_definition_value_boolean; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE entity_definition_value_boolean (
    id integer NOT NULL,
    entity_definition_id integer,
    attribute_id integer,
    value boolean
);


ALTER TABLE entity_definition_value_boolean OWNER TO hotel;

--
-- Name: entity_definition_value_character; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE entity_definition_value_character (
    id integer NOT NULL,
    entity_definition_id integer,
    attribute_id integer,
    value character varying(255)
);


ALTER TABLE entity_definition_value_character OWNER TO hotel;

--
-- Name: entity_definition_value_character_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE entity_definition_value_character_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entity_definition_value_character_id_seq OWNER TO hotel;

--
-- Name: entity_definition_value_character_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE entity_definition_value_character_id_seq OWNED BY entity_definition_value_character.id;


--
-- Name: entity_value_boolean_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE entity_value_boolean_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entity_value_boolean_id_seq OWNER TO hotel;

--
-- Name: entity_value_boolean_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE entity_value_boolean_id_seq OWNED BY entity_definition_value_boolean.id;


--
-- Name: entity_definition_value_double; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE entity_definition_value_double (
    id integer DEFAULT nextval('entity_value_boolean_id_seq'::regclass) NOT NULL,
    entity_definition_id integer,
    attribute_id integer,
    value double precision
);


ALTER TABLE entity_definition_value_double OWNER TO hotel;

--
-- Name: entity_definition_value_integer; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE entity_definition_value_integer (
    id integer DEFAULT nextval('entity_value_boolean_id_seq'::regclass) NOT NULL,
    entity_definition_id integer,
    attribute_id integer,
    value integer
);


ALTER TABLE entity_definition_value_integer OWNER TO hotel;

--
-- Name: entity_definition_value_select; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE entity_definition_value_select (
    id integer NOT NULL,
    entity_definition_id integer,
    attribute_id integer,
    value integer
);


ALTER TABLE entity_definition_value_select OWNER TO hotel;

--
-- Name: entity_definition_value_select_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE entity_definition_value_select_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entity_definition_value_select_id_seq OWNER TO hotel;

--
-- Name: entity_definition_value_select_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE entity_definition_value_select_id_seq OWNED BY entity_definition_value_select.id;


--
-- Name: entity_definition_value_text; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE entity_definition_value_text (
    id integer NOT NULL,
    entity_definition_id integer,
    attribute_id integer,
    value text
);


ALTER TABLE entity_definition_value_text OWNER TO hotel;

--
-- Name: entity_definition_value_text_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE entity_definition_value_text_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entity_definition_value_text_id_seq OWNER TO hotel;

--
-- Name: entity_definition_value_text_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE entity_definition_value_text_id_seq OWNED BY entity_definition_value_text.id;


--
-- Name: entity_definition_value_timestamp; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE entity_definition_value_timestamp (
    id integer NOT NULL,
    entity_definition_id integer,
    attribute_id integer,
    value timestamp without time zone
);


ALTER TABLE entity_definition_value_timestamp OWNER TO hotel;

--
-- Name: entity_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE entity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entity_id_seq OWNER TO hotel;

--
-- Name: entity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE entity_id_seq OWNED BY entity.id;


--
-- Name: entity_type; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE entity_type (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    time_resolution integer DEFAULT 0
);


ALTER TABLE entity_type OWNER TO hotel;

--
-- Name: TABLE entity_type; Type: COMMENT; Schema: public; Owner: hotel
--

COMMENT ON TABLE entity_type IS '- komentar ovde...';


--
-- Name: entity_type_attribute; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE entity_type_attribute (
    id integer NOT NULL,
    entity_type_id integer NOT NULL,
    attribute_id integer NOT NULL
);


ALTER TABLE entity_type_attribute OWNER TO hotel;

--
-- Name: entity_type_attribute_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE entity_type_attribute_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entity_type_attribute_id_seq OWNER TO hotel;

--
-- Name: entity_type_attribute_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE entity_type_attribute_id_seq OWNED BY entity_type_attribute.id;


--
-- Name: entity_type_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE entity_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entity_type_id_seq OWNER TO hotel;

--
-- Name: entity_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE entity_type_id_seq OWNED BY entity_type.id;


--
-- Name: entity_value_boolean; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE entity_value_boolean (
    id integer NOT NULL,
    attribute_id integer,
    entity_id integer,
    value boolean
);


ALTER TABLE entity_value_boolean OWNER TO hotel;

--
-- Name: entity_value_boolean_id_seq1; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE entity_value_boolean_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entity_value_boolean_id_seq1 OWNER TO hotel;

--
-- Name: entity_value_boolean_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE entity_value_boolean_id_seq1 OWNED BY entity_value_boolean.id;


--
-- Name: entity_value_character; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE entity_value_character (
    id integer NOT NULL,
    attribute_id integer,
    entity_id integer,
    value character varying(100)
);


ALTER TABLE entity_value_character OWNER TO hotel;

--
-- Name: entity_value_character_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE entity_value_character_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entity_value_character_id_seq OWNER TO hotel;

--
-- Name: entity_value_character_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE entity_value_character_id_seq OWNED BY entity_value_character.id;


--
-- Name: entity_value_double; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE entity_value_double (
    id integer NOT NULL,
    attribute_id integer,
    entity_id integer,
    value double precision
);


ALTER TABLE entity_value_double OWNER TO hotel;

--
-- Name: entity_value_double_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE entity_value_double_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entity_value_double_id_seq OWNER TO hotel;

--
-- Name: entity_value_double_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE entity_value_double_id_seq OWNED BY entity_value_double.id;


--
-- Name: entity_value_integer; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE entity_value_integer (
    id integer NOT NULL,
    attribute_id integer,
    entity_id integer,
    value integer
);


ALTER TABLE entity_value_integer OWNER TO hotel;

--
-- Name: entity_value_integer_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE entity_value_integer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entity_value_integer_id_seq OWNER TO hotel;

--
-- Name: entity_value_integer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE entity_value_integer_id_seq OWNED BY entity_value_integer.id;


--
-- Name: entity_value_select; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE entity_value_select (
    id integer NOT NULL,
    attribute_id integer,
    entity_id integer,
    value integer
);


ALTER TABLE entity_value_select OWNER TO hotel;

--
-- Name: COLUMN entity_value_select.attribute_id; Type: COMMENT; Schema: public; Owner: hotel
--

COMMENT ON COLUMN entity_value_select.attribute_id IS '
';


--
-- Name: entity_value_select_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE entity_value_select_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entity_value_select_id_seq OWNER TO hotel;

--
-- Name: entity_value_select_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE entity_value_select_id_seq OWNED BY entity_value_select.id;


--
-- Name: entity_value_text; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE entity_value_text (
    id integer NOT NULL,
    attribute_id integer,
    entity_id integer,
    value text
);


ALTER TABLE entity_value_text OWNER TO hotel;

--
-- Name: COLUMN entity_value_text.attribute_id; Type: COMMENT; Schema: public; Owner: hotel
--

COMMENT ON COLUMN entity_value_text.attribute_id IS ' ';


--
-- Name: entity_value_text_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE entity_value_text_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entity_value_text_id_seq OWNER TO hotel;

--
-- Name: entity_value_text_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE entity_value_text_id_seq OWNED BY entity_value_text.id;


--
-- Name: entity_value_timestamp; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE entity_value_timestamp (
    id integer NOT NULL,
    attribute_id integer,
    entity_id integer,
    value timestamp without time zone
);


ALTER TABLE entity_value_timestamp OWNER TO hotel;

--
-- Name: entity_value_timestamp_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE entity_value_timestamp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entity_value_timestamp_id_seq OWNER TO hotel;

--
-- Name: entity_value_timestamp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE entity_value_timestamp_id_seq OWNED BY entity_value_timestamp.id;


--
-- Name: features; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE features (
    id integer NOT NULL,
    name character varying(100)[],
    description text
);


ALTER TABLE features OWNER TO hotel;

--
-- Name: features_entity_definitions; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE features_entity_definitions (
    id integer NOT NULL,
    feature_id integer,
    entity_definition_id integer
);


ALTER TABLE features_entity_definitions OWNER TO hotel;

--
-- Name: features_entity_definitions_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE features_entity_definitions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE features_entity_definitions_id_seq OWNER TO hotel;

--
-- Name: features_entity_definitions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE features_entity_definitions_id_seq OWNED BY features_entity_definitions.id;


--
-- Name: features_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE features_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE features_id_seq OWNER TO hotel;

--
-- Name: features_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE features_id_seq OWNED BY features.id;


--
-- Name: financial_plan; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE financial_plan (
    id integer NOT NULL,
    name character varying(50),
    description text
);


ALTER TABLE financial_plan OWNER TO hotel;

--
-- Name: financial_plan_entity_definition_price; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE financial_plan_entity_definition_price (
    id integer NOT NULL,
    financial_plan_id integer,
    entity_definition_id integer,
    price_id integer
);


ALTER TABLE financial_plan_entity_definition_price OWNER TO hotel;

--
-- Name: financial_plan_entity_definition_price_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE financial_plan_entity_definition_price_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE financial_plan_entity_definition_price_id_seq OWNER TO hotel;

--
-- Name: financial_plan_entity_definition_price_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE financial_plan_entity_definition_price_id_seq OWNED BY financial_plan_entity_definition_price.id;


--
-- Name: financial_plan_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE financial_plan_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE financial_plan_id_seq OWNER TO hotel;

--
-- Name: financial_plan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE financial_plan_id_seq OWNED BY financial_plan.id;


--
-- Name: price; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE price (
    id integer NOT NULL,
    value double precision,
    currency character varying(3),
    description character varying(50)
);


ALTER TABLE price OWNER TO hotel;

--
-- Name: price_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE price_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE price_id_seq OWNER TO hotel;

--
-- Name: price_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE price_id_seq OWNED BY price.id;


--
-- Name: reservation_entity; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE reservation_entity (
    id integer NOT NULL,
    guest_id integer,
    entity_id integer NOT NULL,
    reservation_id integer NOT NULL,
    date_start bigint NOT NULL,
    date_end integer NOT NULL,
    date_from timestamp without time zone,
    date_to timestamp without time zone
);


ALTER TABLE reservation_entity OWNER TO hotel;

--
-- Name: reservation_entity_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE reservation_entity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE reservation_entity_id_seq OWNER TO hotel;

--
-- Name: reservation_entity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE reservation_entity_id_seq OWNED BY reservation_entity.id;


--
-- Name: reservation_status; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE reservation_status (
    id integer NOT NULL,
    statustext character varying(50)
);


ALTER TABLE reservation_status OWNER TO hotel;

--
-- Name: reservations; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE reservations (
    id integer NOT NULL,
    reservation_id character varying(100) NOT NULL,
    status character varying(100),
    created_at timestamp(0) without time zone NOT NULL,
    modified_at timestamp(0) without time zone DEFAULT now(),
    client_id integer NOT NULL,
    pax_a smallint DEFAULT 0,
    pax_y smallint DEFAULT 0,
    pax_c smallint DEFAULT 0,
    comment text,
    status_id integer
);


ALTER TABLE reservations OWNER TO hotel;

--
-- Name: TABLE reservations; Type: COMMENT; Schema: public; Owner: hotel
--

COMMENT ON TABLE reservations IS '2015-10-12 12:00:00 = 1444644000
2015-10-13 12:00:00 = 1444730400
2015-10-14 12:00:00 = 1444816800
2015-10-15 12:00:00 = 1444903200
2015-10-16 12:00:00 = 1444989600
2015-10-17 12:00:00 = 1445076000
2015-10-18 12:00:00 = 1445162400
2015-10-19 12:00:00 = 1445248800
2015-10-25 12:00:00 = 1445770800
2015-10-26 12:00:00 = 1445857200
2015-10-27 12:00:00 = 1445943600';


--
-- Name: COLUMN reservations.reservation_id; Type: COMMENT; Schema: public; Owner: hotel
--

COMMENT ON COLUMN reservations.reservation_id IS ' - id rezervacije za prikaz na front-endu';


--
-- Name: COLUMN reservations.status; Type: COMMENT; Schema: public; Owner: hotel
--

COMMENT ON COLUMN reservations.status IS '- treba da bude enum, za sada je varchar, zbog jednostavnije izzmene';


--
-- Name: COLUMN reservations.comment; Type: COMMENT; Schema: public; Owner: hotel
--

COMMENT ON COLUMN reservations.comment IS '- comment - free entry, optional at check-in';


--
-- Name: reservations_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE reservations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE reservations_id_seq OWNER TO hotel;

--
-- Name: reservations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE reservations_id_seq OWNED BY reservations.id;


--
-- Name: SEQUENCE reservations_id_seq; Type: COMMENT; Schema: public; Owner: hotel
--

COMMENT ON SEQUENCE reservations_id_seq IS ' - reset auto increment to 1;
SELECT setval(''reservation_id_seq'',1,false);';


--
-- Name: rezervation_status_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE rezervation_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE rezervation_status_id_seq OWNER TO hotel;

--
-- Name: rezervation_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE rezervation_status_id_seq OWNED BY reservation_status.id;


--
-- Name: role; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE role (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text
);


ALTER TABLE role OWNER TO hotel;

--
-- Name: TABLE role; Type: COMMENT; Schema: public; Owner: hotel
--

COMMENT ON TABLE role IS 'Table of possible user roles.';


--
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE role_id_seq OWNER TO hotel;

--
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE role_id_seq OWNED BY role.id;


--
-- Name: role_task; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE role_task (
    id integer NOT NULL,
    role_id integer NOT NULL,
    task_id integer
);


ALTER TABLE role_task OWNER TO hotel;

--
-- Name: TABLE role_task; Type: COMMENT; Schema: public; Owner: hotel
--

COMMENT ON TABLE role_task IS 'Table which connects roles and tasks.';


--
-- Name: COLUMN role_task.role_id; Type: COMMENT; Schema: public; Owner: hotel
--

COMMENT ON COLUMN role_task.role_id IS 'Reference to the role.';


--
-- Name: COLUMN role_task.task_id; Type: COMMENT; Schema: public; Owner: hotel
--

COMMENT ON COLUMN role_task.task_id IS 'Reference to the user task.';


--
-- Name: role_task_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE role_task_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE role_task_id_seq OWNER TO hotel;

--
-- Name: role_task_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE role_task_id_seq OWNED BY role_task.id;


--
-- Name: roomlist; Type: VIEW; Schema: public; Owner: hotel
--

CREATE VIEW roomlist AS
 SELECT e.guid,
    eavi.value
   FROM entity e,
    attribute a,
    entity_value_integer eavi
  WHERE ((eavi.entity_id = e.id) AND (eavi.attribute_id = a.id));


ALTER TABLE roomlist OWNER TO hotel;

--
-- Name: status; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE status (
    id integer NOT NULL,
    value character varying(50)
);


ALTER TABLE status OWNER TO hotel;

--
-- Name: status_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE status_id_seq OWNER TO hotel;

--
-- Name: status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE status_id_seq OWNED BY status.id;


--
-- Name: task; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE task (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text
);


ALTER TABLE task OWNER TO hotel;

--
-- Name: TABLE task; Type: COMMENT; Schema: public; Owner: hotel
--

COMMENT ON TABLE task IS 'Table of possible user tasks.';


--
-- Name: task_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE task_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE task_id_seq OWNER TO hotel;

--
-- Name: task_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE task_id_seq OWNED BY task.id;


--
-- Name: test; Type: VIEW; Schema: public; Owner: hotel
--

CREATE VIEW test AS
 SELECT r.id,
    r.guest_id,
    r.entity_id,
    r.reservation_id,
    r.date_start,
    r.date_end,
    r.date_from,
    r.date_to,
    e.guid
   FROM (reservation_entity r
     JOIN entity e ON ((r.entity_id = e.id)));


ALTER TABLE test OWNER TO hotel;

--
-- Name: test2; Type: VIEW; Schema: public; Owner: hotel
--

CREATE VIEW test2 AS
 SELECT r.id,
    r.guest_id,
    r.entity_id,
    r.reservation_id,
    r.date_from,
    r.date_to,
    e.guid,
    et.time_resolution
   FROM (((reservation_entity r
     JOIN entity e ON ((r.entity_id = e.id)))
     JOIN entity_definition ed ON ((e.definition_id = ed.id)))
     JOIN entity_type et ON ((ed.entity_type_id = et.id)));


ALTER TABLE test2 OWNER TO hotel;

--
-- Name: title; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE title (
    id integer NOT NULL,
    title character varying(20)
);


ALTER TABLE title OWNER TO hotel;

--
-- Name: title_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE title_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE title_id_seq OWNER TO hotel;

--
-- Name: title_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE title_id_seq OWNED BY title.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: hotel; Tablespace: 
--

CREATE TABLE "user" (
    id integer NOT NULL,
    username character varying(20) NOT NULL,
    password character varying(100) NOT NULL,
    email character varying(255),
    role_id integer DEFAULT 1
);


ALTER TABLE "user" OWNER TO hotel;

--
-- Name: TABLE "user"; Type: COMMENT; Schema: public; Owner: hotel
--

COMMENT ON TABLE "user" IS 'System users.';


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: hotel
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO hotel;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hotel
--

ALTER SEQUENCE users_id_seq OWNED BY "user".id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY attribute ALTER COLUMN id SET DEFAULT nextval('attribute_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY attribute_option_values ALTER COLUMN id SET DEFAULT nextval('attribute_option_values_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY business ALTER COLUMN id SET DEFAULT nextval('business_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY clients ALTER COLUMN id SET DEFAULT nextval('clients_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY ct ALTER COLUMN id SET DEFAULT nextval('ct_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity ALTER COLUMN id SET DEFAULT nextval('entity_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_category ALTER COLUMN id SET DEFAULT nextval('entity_category_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_definition ALTER COLUMN id SET DEFAULT nextval('entity_definition_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_definition_value_boolean ALTER COLUMN id SET DEFAULT nextval('entity_value_boolean_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_definition_value_character ALTER COLUMN id SET DEFAULT nextval('entity_definition_value_character_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_definition_value_select ALTER COLUMN id SET DEFAULT nextval('entity_definition_value_select_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_definition_value_text ALTER COLUMN id SET DEFAULT nextval('entity_definition_value_text_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_type ALTER COLUMN id SET DEFAULT nextval('entity_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_type_attribute ALTER COLUMN id SET DEFAULT nextval('entity_type_attribute_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_value_boolean ALTER COLUMN id SET DEFAULT nextval('entity_value_boolean_id_seq1'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_value_character ALTER COLUMN id SET DEFAULT nextval('entity_value_character_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_value_double ALTER COLUMN id SET DEFAULT nextval('entity_value_double_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_value_integer ALTER COLUMN id SET DEFAULT nextval('entity_value_integer_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_value_select ALTER COLUMN id SET DEFAULT nextval('entity_value_select_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_value_text ALTER COLUMN id SET DEFAULT nextval('entity_value_text_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_value_timestamp ALTER COLUMN id SET DEFAULT nextval('entity_value_timestamp_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY features ALTER COLUMN id SET DEFAULT nextval('features_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY features_entity_definitions ALTER COLUMN id SET DEFAULT nextval('features_entity_definitions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY financial_plan ALTER COLUMN id SET DEFAULT nextval('financial_plan_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY financial_plan_entity_definition_price ALTER COLUMN id SET DEFAULT nextval('financial_plan_entity_definition_price_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY price ALTER COLUMN id SET DEFAULT nextval('price_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY reservation_entity ALTER COLUMN id SET DEFAULT nextval('reservation_entity_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY reservation_status ALTER COLUMN id SET DEFAULT nextval('rezervation_status_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY reservations ALTER COLUMN id SET DEFAULT nextval('reservations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY role ALTER COLUMN id SET DEFAULT nextval('role_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY role_task ALTER COLUMN id SET DEFAULT nextval('role_task_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY status ALTER COLUMN id SET DEFAULT nextval('status_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY task ALTER COLUMN id SET DEFAULT nextval('task_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY title ALTER COLUMN id SET DEFAULT nextval('title_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY "user" ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: attribute; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY attribute (id, code, label, type, sort_order, unit, "unique", nullable, scope) FROM stdin;
63	tk_surface	Surface	select	1	\N	f	f	1
64	tk_type	Type	select	2	\N	f	f	1
65	tk_lights	Has Lights	boolean	3	\N	f	f	1
66	trainingtype	Training type	select	1	\N	f	f	1
67	trainies	Number of trainies	integer	2	\N	f	f	1
68	isindividual	Is individual	boolean	3	\N	f	f	1
54	counter	Counter	character	1	\N	t	f	2
55	sbeds	Number of single beds	integer	2	\N	f	t	1
56	dbeds	Number of double beds	integer	2	\N	f	t	1
57	bathroom	Bathroom type	select	3	\N	f	f	1
58	positioning	Positioning	select	4	\N	f	f	2
59	floor	Floor	select	5	\N	f	f	2
60	pax	PAX	integer	7	\N	f	f	1
61	clima	Has Clima	boolean	8	\N	f	f	1
62	roomcount	Count of rooms	integer	16	\N	f	f	1
\.


--
-- Name: attribute_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('attribute_id_seq', 68, true);


--
-- Data for Name: attribute_option_values; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY attribute_option_values (id, attribute_id, value, text) FROM stdin;
61	63	1	Clay
62	63	2	Grass
63	63	3	Polyurethan
64	63	4	Concrete
65	64	1	Opened
66	64	2	Closed
67	64	3	Covered
68	66	1	Basic
69	66	2	Advanced
70	66	3	Pro
54	57	0	Own bathroom
55	57	1	Shared bathroom
56	58	0	Near elevator
57	58	1	Away from elevator
58	59	1	I
59	59	2	II
60	59	3	III
71	59	4	IV
72	59	5	V
\.


--
-- Name: attribute_option_values_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('attribute_option_values_id_seq', 72, true);


--
-- Data for Name: business; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY business (id, name, description, company_name, address, phone, email, contact_first_name, contact_last_name) FROM stdin;
1	Small Hotel on the Beach	This is our small hotel, where we rent rooms and other stuff.	Hotel & Co.	Hollywood Boulevard 14234, CA, Los Angeles	+1 555 333 222	hotel@hollywood.rs	John	Isner
\.


--
-- Name: business_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('business_id_seq', 1, true);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY categories (id, name, description, parent_id) FROM stdin;
0	Vrsta	Kakav je tip sobe	-1
1	Soba	Obicna soba	0
2	Apartman	Apartman sa vise soba	0
4	Pogled	Gde gleda soba	-1
5	Na more	Pogled na more	4
6	Na grad	Pogled na grad	4
7	Na parking	Pogled na parking hotela.	4
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('categories_id_seq', 1, false);


--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY clients (id, first_name, last_name, address1, address2, city, zipcode, country, phone, mobile, fax, email, title, guest_class, title_id) FROM stdin;
2	Louis	Winthorpe III	Address 2	\N	Philadelphia	\N	USA	22222222	\N	\N	louiwinthorpe@example.com	Mr  	\N	\N
3	Randolph	Duke	Address 3	\N	Philadelphia	\N	USA	333333333333	\N	\N	randyduke@example.com	Mr  	\N	\N
4	Mortimer	Duke	Address 4	\N	Philadelphia	\N	USA	444444444	\N	\N	mortyduke@example.com	Mr  	\N	\N
16	Dragana	Milojević	Prva ulica br.11	asdfasdf	Belgrade	11070	Serbia	+381 11 238 2232	+381 11 238 2232	+381 11 238 2232	dragana@tu.com	\N	\N	\N
1	Billy Ray	Valentine	Feet Street 2	Sole Street 3	Philadelphia	1232412	USA	+381 11 238 2232	+381 11 238 2232	+381 11 238 2232	billiray@example.com	\N	\N	\N
7	Billy	Jean	First street 22	Second str. 33	New York	1234123	USA	+1 555-333-222	+1 555-333-222	+1 555-111-222	bjean@mail.us	\N	\N	\N
12	Siniša	Ristić	Dušana Vukasovića 63	Dr. Agostina Neta 48	Beograd	11070	SRB	+381 11 7184763	+381 63 297167	+381 11 7184763	sinisa.ristic@gmail.com	\N	\N	\N
17	Зорица	Митић	Дунавска 13	Дунавска 13	Београд	11000	Србија	+381 11 238 2232	+381 11 238 2232	+381 11 238 2232	zorica@mail.rs	\N	\N	\N
18	Rade	Markovic	Studentska 12	Studentska 12	Beograd	11000	Srbija	+1 555 333 222	+381 11 238 2232	+381 11 238 2232	rade@mail.rs	\N	\N	\N
23	Zizi	Top	Amerika 22	Amerkia 22	Njujork	1231234	Amerika	111 222	222344	234415	moj@mail.rs	\N	\N	\N
24	Синиша	Ристић	adfa 23	aasdf 324	beograd	11000	serbia	011 333 222	2223 33	2342525	sinisa.ristic@gmail.com	\N	\N	\N
25	Синиша	Ристић	Алексиначких Рудара 4	Алексиначких Рудара 4	Београд	11000	Србија	011 333 222	011 333 222	011 222 333	sinisa.ristic@gmail.com	\N	\N	\N
27	Baki	Lepotica	Glavna 33	Glavna 33	Beograd	11000	Serbia	011 333 222	0111 1234123	2341243	mm@mail.rs	\N	\N	\N
28	Petar	Petrovic	Glavna 12		Beograd	11000	Srbija	+381 11 222 333			mail@m.rs	\N	\N	\N
29	Marko 	Markovic	Drvarska 55		Beograd	11000	Srbija	011 222 3131			m@m.rs	\N	\N	\N
33	Aleksandar 	Dobnikar	Bulevar Revolucije 235		Beograd	11000	Srbija	332345523			mail@m.rs	\N	\N	\N
34	Sanja	Bigovic	Mala 23		Beograd	11000	Srbija	3342344			ss@mail.ss	\N	\N	\N
36	Sanja	Ivanišević	Modrinjska 55		Beograd	11000	Srbija	23415123			ma@il.rs	\N	\N	\N
37	Dragana	Milic	Pavla Mincica 33		Beograd	11000	Srbija	324234523			ma@il.rs	\N	\N	\N
38	Dario	Matic	Dubrovacka 55		Beograd	11000	Serbia	33234234			mail@mail.rs	\N	\N	\N
39	Dragana	Mirkovic	Ustanicka 141		Beograd	11000	Serbia	33234234			mail@mail.rs	\N	\N	\N
40	Дејан	Ђорђевић	Београдска 15		Београд	11000	Србија	132415			ma@il.rs	\N	\N	\N
41	Dragana	Pavlovic	Dubrovacka 55		Beograd	11000	Serbia	33234234			mail@mail.rs	\N	\N	\N
42	Dragana	Vidakovic	Cerska 99		Beograd	11000	Serbia	2341234			mail@mail.rs	\N	\N	\N
43	Dragutin	Savic	Dzona Kenedija 48		Beograd	11080	Srbija	52345234			mail@mail.rs	\N	\N	\N
44	Sonja	Savic	Dzona Kenedija 55		Beograd	11070	Serbia	2341234			mail@mail.rs	\N	\N	\N
53	Zorica	Nešić	Vitanovačka 22		Beograd	11000	Serbia	2341234			mail@mail.rs	\N	\N	\N
54	Dragica	Pešić	Moravska 5		Beograd	11000	Serbia	2341234			mail@mail.rs	\N	\N	\N
35	Dorotea	Kesić	Vlaška 5		Kladovo	41000	Srbija	3323452			sas@fee.rs	\N	\N	\N
55	Jovana	Jovanovic	Skadarska 11		Beograd	11000	Srbija	12341234			ma@il.rs	\N	\N	\N
56	Dragana	Petrovic	Skadarska 33		Beograd	11000	Srbija	234153214			ma@il.rs	\N	\N	\N
57	NOvi	Novi	Nova 123		Beograd	11000	Srbija	123412341			ma@il.rs	\N	\N	\N
58	Jos	Noviji	NOva 123		Beograd	11000	Srbija	3523452345			mm@mail.rs	\N	\N	\N
59	Danijela	Stosic	Vojvode Stepe 345		Beograd	11000	Srbija	4234234			ma@il.rs	\N	\N	\N
60	Tamara	Rodenina	Vyacheslavskaya 15		St. Petersburg	123451234	Russia	123451234			vya@mail.ru	\N	\N	\N
61	Rade	Markovic	Gandijeva 49b		Beograd	11070	Srbija	+381 11 234234			rademt@gmail.com	\N	\N	\N
26	Barbara	Vidakovic	Vojvode Stepe 263	Vojvode Stepe 263	Beograd	11000	Serbia	011 222 333	011 222 333	011 222 333	baki@moj.rs	\N	\N	\N
62	Jovanka	Babic	ustanicka 15		Beograd	11000	Srbija	34234243			jov@ma.rs	\N	\N	\N
63	Стеван	Марковић	Бул. Краља Александра 282		Београд	11000	Србија	3423423423			my@mail.rs	\N	\N	\N
\.


--
-- Name: clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('clients_id_seq', 63, true);


--
-- Data for Name: ct; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY ct (id, rowid, attribute, value) FROM stdin;
1	1	visina	188
2	1	tezina	80
3	1	godine	25
4	1	pol	m
5	2	visina	175
6	2	tezina	56
7	2	godine	27
8	2	pol	z
\.


--
-- Name: ct_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('ct_id_seq', 8, true);


--
-- Data for Name: entity; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY entity (id, definition_id, status, guid, status_id) FROM stdin;
33	33	\N	101	1
34	33	\N	102	1
35	34	\N	201	1
36	34	Cleaning	202	2
37	35	Ready	301	1
38	35	\N	302	1
39	38	\N	I1	1
40	37	\N	TC1	1
41	41	Ready	401	1
42	41	\N	402	1
48	41	\N	404	1
43	41	Ready	403	1
49	35	\N	303	1
50	34	\N	203	1
\.


--
-- Data for Name: entity_category; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY entity_category (id, entity_id, category_id) FROM stdin;
\.


--
-- Name: entity_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('entity_category_id_seq', 1, false);


--
-- Data for Name: entity_definition; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY entity_definition (id, entity_type_id, name, code, description, price, pax) FROM stdin;
34	22	Single Room +	SINGLEC	Single room with clima.	\N	1
35	22	Suite Type A	SUIA	Comfortable suite with several rooms 	\N	1
33	22	Single Room	SINGLE	Single room without clima and with shared bathroom on the floor.	\N	1
36	23	Open clay court	OCC	Opened clay court	\N	1
37	23	Closed Poliurethan Court	CPC	Closed poliurethan court.	\N	1
38	24	Beginner Level - Group	TIBL	Beginners level	\N	1
39	24	Beginner Level - Individual	TIBLI	Individual tennis lessons for individuals.	\N	1
41	22	Twin Room	TWINR	Twin room with two single beds.	\N	1
\.


--
-- Name: entity_definition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('entity_definition_id_seq', 41, true);


--
-- Data for Name: entity_definition_value_boolean; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY entity_definition_value_boolean (id, entity_definition_id, attribute_id, value) FROM stdin;
134	34	61	t
138	35	61	t
130	33	61	f
140	36	65	t
141	37	65	t
143	38	68	f
145	39	68	t
154	41	61	t
\.


--
-- Data for Name: entity_definition_value_character; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY entity_definition_value_character (id, entity_definition_id, attribute_id, value) FROM stdin;
\.


--
-- Name: entity_definition_value_character_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('entity_definition_value_character_id_seq', 11, true);


--
-- Data for Name: entity_definition_value_double; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY entity_definition_value_double (id, entity_definition_id, attribute_id, value) FROM stdin;
\.


--
-- Data for Name: entity_definition_value_integer; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY entity_definition_value_integer (id, entity_definition_id, attribute_id, value) FROM stdin;
131	34	55	1
132	34	56	0
133	34	60	1
135	35	55	2
136	35	56	1
137	35	60	4
139	35	62	3
127	33	55	1
128	33	56	0
129	33	60	1
142	38	67	5
144	39	67	1
151	41	55	2
152	41	56	0
153	41	60	2
155	41	62	1
\.


--
-- Data for Name: entity_definition_value_select; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY entity_definition_value_select (id, entity_definition_id, attribute_id, value) FROM stdin;
19	34	57	0
20	35	57	0
18	33	57	1
21	36	63	1
22	36	64	1
23	37	63	3
24	37	64	2
25	38	66	1
26	39	66	1
28	41	57	0
\.


--
-- Name: entity_definition_value_select_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('entity_definition_value_select_id_seq', 28, true);


--
-- Data for Name: entity_definition_value_text; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY entity_definition_value_text (id, entity_definition_id, attribute_id, value) FROM stdin;
\.


--
-- Name: entity_definition_value_text_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('entity_definition_value_text_id_seq', 17, true);


--
-- Data for Name: entity_definition_value_timestamp; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY entity_definition_value_timestamp (id, entity_definition_id, attribute_id, value) FROM stdin;
\.


--
-- Name: entity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('entity_id_seq', 50, true);


--
-- Data for Name: entity_type; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY entity_type (id, name, description, time_resolution) FROM stdin;
23	Tennis Court	Different types of tennis courts.	2
24	Tennis Instructor	Classes at tennis instructor.	2
22	ACUNIT	Hotel accomodation unit. A room, an appartment, a suite, a studio, penthouse etc.	1
\.


--
-- Data for Name: entity_type_attribute; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY entity_type_attribute (id, entity_type_id, attribute_id) FROM stdin;
36	22	54
37	22	55
38	22	56
39	22	57
40	22	58
41	22	59
42	22	60
43	22	61
44	22	62
45	23	63
46	23	64
47	23	65
48	24	66
49	24	67
50	24	68
\.


--
-- Name: entity_type_attribute_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('entity_type_attribute_id_seq', 50, true);


--
-- Name: entity_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('entity_type_id_seq', 24, true);


--
-- Data for Name: entity_value_boolean; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY entity_value_boolean (id, attribute_id, entity_id, value) FROM stdin;
\.


--
-- Name: entity_value_boolean_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('entity_value_boolean_id_seq', 155, true);


--
-- Name: entity_value_boolean_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('entity_value_boolean_id_seq1', 1, false);


--
-- Data for Name: entity_value_character; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY entity_value_character (id, attribute_id, entity_id, value) FROM stdin;
4	54	33	A101
5	54	34	A102
6	54	35	B201
7	54	36	B202
8	54	37	A301
9	54	38	S302
10	54	41	D401
11	54	42	T402
13	54	48	T404
12	54	43	T403
14	54	49	S303
15	54	50	SP203
\.


--
-- Name: entity_value_character_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('entity_value_character_id_seq', 15, true);


--
-- Data for Name: entity_value_double; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY entity_value_double (id, attribute_id, entity_id, value) FROM stdin;
\.


--
-- Name: entity_value_double_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('entity_value_double_id_seq', 1, false);


--
-- Data for Name: entity_value_integer; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY entity_value_integer (id, attribute_id, entity_id, value) FROM stdin;
\.


--
-- Name: entity_value_integer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('entity_value_integer_id_seq', 1, false);


--
-- Data for Name: entity_value_select; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY entity_value_select (id, attribute_id, entity_id, value) FROM stdin;
3	58	33	1
4	59	33	1
5	58	34	0
6	59	34	1
7	58	35	0
8	59	35	2
9	58	36	1
10	59	36	2
11	58	37	1
12	59	37	2
13	58	38	1
14	59	38	3
15	58	41	0
16	59	41	4
17	58	42	1
18	59	42	4
21	58	48	1
22	59	48	4
19	58	43	0
20	59	43	4
23	58	49	0
24	59	49	3
25	58	50	1
26	59	50	2
\.


--
-- Name: entity_value_select_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('entity_value_select_id_seq', 26, true);


--
-- Data for Name: entity_value_text; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY entity_value_text (id, attribute_id, entity_id, value) FROM stdin;
\.


--
-- Name: entity_value_text_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('entity_value_text_id_seq', 1, false);


--
-- Data for Name: entity_value_timestamp; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY entity_value_timestamp (id, attribute_id, entity_id, value) FROM stdin;
\.


--
-- Name: entity_value_timestamp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('entity_value_timestamp_id_seq', 1, false);


--
-- Data for Name: features; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY features (id, name, description) FROM stdin;
\.


--
-- Data for Name: features_entity_definitions; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY features_entity_definitions (id, feature_id, entity_definition_id) FROM stdin;
\.


--
-- Name: features_entity_definitions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('features_entity_definitions_id_seq', 1, false);


--
-- Name: features_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('features_id_seq', 1, false);


--
-- Data for Name: financial_plan; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY financial_plan (id, name, description) FROM stdin;
\.


--
-- Data for Name: financial_plan_entity_definition_price; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY financial_plan_entity_definition_price (id, financial_plan_id, entity_definition_id, price_id) FROM stdin;
\.


--
-- Name: financial_plan_entity_definition_price_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('financial_plan_entity_definition_price_id_seq', 1, false);


--
-- Name: financial_plan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('financial_plan_id_seq', 1, false);


--
-- Data for Name: price; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY price (id, value, currency, description) FROM stdin;
\.


--
-- Name: price_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('price_id_seq', 1, false);


--
-- Data for Name: reservation_entity; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY reservation_entity (id, guest_id, entity_id, reservation_id, date_start, date_end, date_from, date_to) FROM stdin;
68	2	34	80	0	0	2015-12-14 18:00:00	2015-12-23 18:00:00
67	29	36	80	0	0	2015-12-07 17:00:00	2015-12-16 21:00:00
69	54	35	80	0	0	2015-12-08 16:00:00	2015-12-11 18:00:00
87	33	36	97	0	0	2015-12-30 12:00:00	2016-01-06 08:00:00
86	60	37	96	0	0	2015-12-31 12:00:00	2016-01-07 12:00:00
88	34	36	98	0	0	2015-12-21 12:00:00	2015-12-26 10:00:00
84	37	35	95	0	0	2015-12-21 12:00:00	2015-12-25 08:00:00
85	38	33	95	0	0	2015-12-21 08:00:00	2015-12-25 08:00:00
90	2	40	100	0	0	2015-12-16 11:00:00	2015-12-16 12:00:00
91	63	34	101	0	0	2015-12-24 12:00:00	2015-12-26 12:00:00
92	25	33	101	0	0	2015-12-24 12:00:00	2015-12-26 12:00:00
94	12	40	103	0	0	2015-12-22 12:00:00	2015-12-22 15:00:00
66	25	33	78	0	0	2015-12-20 14:00:00	2015-12-24 14:00:00
96	12	48	105	0	0	2015-12-22 12:00:00	2015-12-26 12:00:00
97	63	33	106	0	0	2015-12-22 12:00:00	2015-12-24 00:00:00
74	25	38	85	0	0	2015-12-20 12:00:00	2015-12-26 12:00:00
98	35	33	107	0	0	2015-12-25 12:00:00	2015-12-26 00:00:00
99	27	34	108	0	0	2015-12-27 12:00:00	2015-12-31 12:00:00
100	1	37	109	0	0	2015-12-23 12:00:00	2015-12-22 16:00:00
65	4	37	79	0	0	2015-12-06 12:00:00	2015-12-10 12:00:00
72	59	39	82	0	0	2015-12-10 16:00:00	2015-12-10 17:00:00
75	59	37	86	0	0	2015-12-27 14:00:00	2015-12-31 14:00:00
77	17	38	88	0	0	2015-12-17 12:00:00	2015-12-18 12:00:00
78	12	33	89	0	0	2015-12-27 12:00:00	2015-12-31 12:00:00
79	2	35	90	0	0	2015-12-24 12:00:00	2015-12-31 16:00:00
73	33	33	84	0	0	2015-12-10 21:00:00	2015-12-20 18:00:00
81	16	40	92	0	0	2015-12-18 11:00:00	2015-12-18 13:00:00
82	61	38	93	0	0	2015-12-29 12:00:00	2016-01-15 12:00:00
83	16	40	94	0	0	2015-12-29 15:00:53	2015-12-29 16:00:53
70	18	40	81	0	0	2015-12-09 09:00:00	2015-12-09 11:00:00
71	18	39	81	0	0	2015-12-09 09:00:00	2015-12-09 10:00:00
\.


--
-- Name: reservation_entity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('reservation_entity_id_seq', 100, true);


--
-- Data for Name: reservation_status; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY reservation_status (id, statustext) FROM stdin;
1	Inquiery
2	Confirmed
3	Cancelled
4	In House
5	Premature Checkout
6	Ckeckout
7	Archive
\.


--
-- Data for Name: reservations; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY reservations (id, reservation_id, status, created_at, modified_at, client_id, pax_a, pax_y, pax_c, comment, status_id) FROM stdin;
108	0000000108	Inquiery	2015-12-22 00:00:00	2015-12-22 00:00:00	27	0	0	0	\N	1
109	0000000109	Inquiery	2015-12-22 00:00:00	2015-12-22 00:00:00	1	0	0	0	\N	1
78	0000000078	Confirmed	2015-12-02 00:00:00	2015-12-06 00:00:00	25	0	0	0	\N	2
79	0000000079	Inquiery	2015-12-04 00:00:00	2015-12-10 00:00:00	4	0	0	0	\N	1
82	0000000082	Inquiery	2015-12-10 00:00:00	2015-12-10 00:00:00	37	0	0	0	\N	1
86	0000000086	Inquiery	2015-12-16 00:00:00	2015-12-17 00:00:00	59	0	0	0	\N	1
88	0000000088	Inquiery	2015-12-17 00:00:00	2015-12-17 00:00:00	17	0	0	0	\N	1
89	0000000089	Inquiery	2015-12-17 00:00:00	2015-12-17 00:00:00	12	0	0	0	\N	1
90	0000000090	Inquiery	2015-12-17 00:00:00	2015-12-17 00:00:00	2	0	0	0	\N	1
84	0000000084	In House	2015-12-10 00:00:00	2015-12-17 00:00:00	33	0	0	0	\N	4
92	0000000092	Inquiery	2015-12-18 00:00:00	2015-12-18 00:00:00	2	0	0	0	\N	1
93	0000000093	Confirmed	2015-12-18 00:00:00	2015-12-18 00:00:00	61	0	0	0	\N	2
94	0000000094	Inquiery	2015-12-18 00:00:00	2015-12-18 00:00:00	16	0	0	0	\N	1
81	0000000081	Confirmed	2015-12-08 00:00:00	2015-12-20 00:00:00	18	0	0	0	\N	2
80	0000000080	Confirmed	2015-12-07 00:00:00	2015-12-21 00:00:00	37	0	0	0	\N	2
97	0000000097	Inquiery	2015-12-21 00:00:00	2015-12-21 00:00:00	33	0	0	0	\N	1
96	0000000096	Inquiery	2015-12-21 00:00:00	2015-12-21 00:00:00	60	0	0	0	\N	1
98	0000000098	Inquiery	2015-12-21 00:00:00	2015-12-21 00:00:00	34	0	0	0	\N	1
95	0000000095	Inquiery	2015-12-21 00:00:00	2015-12-21 00:00:00	29	0	0	0	\N	1
100	0000000100	Inquiery	2015-12-21 00:00:00	2015-12-21 00:00:00	2	0	0	0	\N	1
101	0000000101	Inquiery	2015-12-21 00:00:00	2015-12-21 00:00:00	63	0	0	0	\N	1
103	0000000103	Confirmed	2015-12-22 00:00:00	2015-12-22 00:00:00	12	0	0	0	\N	2
91	0000000091	Confirmed	2015-12-17 00:00:00	2015-12-22 00:00:00	35	0	0	0	\N	2
105	0000000105	Inquiery	2015-12-22 00:00:00	2015-12-22 00:00:00	12	0	0	0	\N	1
106	0000000106	Inquiery	2015-12-22 00:00:00	2015-12-22 00:00:00	63	0	0	0	\N	1
85	0000000085	Inquiery	2015-12-11 00:00:00	2015-12-22 00:00:00	36	0	0	0	\N	1
107	0000000107	Inquiery	2015-12-22 00:00:00	2015-12-22 00:00:00	35	0	0	0	\N	1
\.


--
-- Name: reservations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('reservations_id_seq', 109, true);


--
-- Name: rezervation_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('rezervation_status_id_seq', 7, true);


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY role (id, name, description) FROM stdin;
1	sysadmin	System administrator. Can do all.
2	poweruser	Power user. Can read, write to db and change the dabase structure.
3	user	Normal user. Can read and write to db.
\.


--
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('role_id_seq', 1, false);


--
-- Data for Name: role_task; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY role_task (id, role_id, task_id) FROM stdin;
1	1	1
2	1	2
3	1	3
4	1	4
5	2	2
6	2	3
7	2	4
8	3	3
9	3	4
\.


--
-- Name: role_task_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('role_task_id_seq', 1, true);


--
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY status (id, value) FROM stdin;
1	Ready
2	Cleaning
3	Maintenance
4	Occupied/In use
5	Out of order
\.


--
-- Name: status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('status_id_seq', 5, true);


--
-- Data for Name: task; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY task (id, name, description) FROM stdin;
1	sysconfig	Configures the system variables.
2	dbread	Reads the database data.
3	dbwrite	Writes the data to database.
4	dbchange	Changes the dabase structure.
\.


--
-- Name: task_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('task_id_seq', 1, false);


--
-- Data for Name: title; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY title (id, title) FROM stdin;
1	Mr.
2	Mrs.
3	Ms.
\.


--
-- Name: title_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('title_id_seq', 3, true);


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: hotel
--

COPY "user" (id, username, password, email, role_id) FROM stdin;
1	admin	0cc175b9c0f1b6a831c399e269772661	admin@example.com	1
10	sinisa	0cc175b9c0f1b6a831c399e269772661	sinisa.ristic@gmail.com	1
9	gaga	0cc175b9c0f1b6a831c399e269772661	gaga@mail.rs	2
11	obican	92eb5ffee6ae2fec3ad71c777531578f	basobican@mail.rs	3
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('users_id_seq', 11, true);


--
-- Name: attribute_option_value_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY attribute_option_values
    ADD CONSTRAINT attribute_option_value_pk PRIMARY KEY (id);


--
-- Name: attribute_option_value_uk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY attribute_option_values
    ADD CONSTRAINT attribute_option_value_uk UNIQUE (attribute_id, value);


--
-- Name: attribute_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY attribute
    ADD CONSTRAINT attribute_pk PRIMARY KEY (id);


--
-- Name: business_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY business
    ADD CONSTRAINT business_pk PRIMARY KEY (id);


--
-- Name: categories_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pk PRIMARY KEY (id);


--
-- Name: clients_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT clients_pk PRIMARY KEY (id);


--
-- Name: ct_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY ct
    ADD CONSTRAINT ct_pk PRIMARY KEY (id);


--
-- Name: entity_category_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_category
    ADD CONSTRAINT entity_category_pk PRIMARY KEY (id);


--
-- Name: entity_definition_value_character_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_definition_value_character
    ADD CONSTRAINT entity_definition_value_character_pk PRIMARY KEY (id);


--
-- Name: entity_definition_value_character_uk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_definition_value_character
    ADD CONSTRAINT entity_definition_value_character_uk UNIQUE (entity_definition_id, attribute_id);


--
-- Name: entity_definition_value_double_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_definition_value_double
    ADD CONSTRAINT entity_definition_value_double_pk PRIMARY KEY (id);


--
-- Name: entity_definition_value_double_uk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_definition_value_double
    ADD CONSTRAINT entity_definition_value_double_uk UNIQUE (entity_definition_id, attribute_id);


--
-- Name: entity_definition_value_integer_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_definition_value_integer
    ADD CONSTRAINT entity_definition_value_integer_pk PRIMARY KEY (id);


--
-- Name: entity_definition_value_integer_uk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_definition_value_integer
    ADD CONSTRAINT entity_definition_value_integer_uk UNIQUE (entity_definition_id, attribute_id);


--
-- Name: entity_definition_value_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_definition_value_boolean
    ADD CONSTRAINT entity_definition_value_pk PRIMARY KEY (id);


--
-- Name: entity_definition_value_select_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_definition_value_select
    ADD CONSTRAINT entity_definition_value_select_pk PRIMARY KEY (id);


--
-- Name: entity_definition_value_select_uk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_definition_value_select
    ADD CONSTRAINT entity_definition_value_select_uk UNIQUE (entity_definition_id, attribute_id);


--
-- Name: entity_definition_value_text_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_definition_value_text
    ADD CONSTRAINT entity_definition_value_text_pk PRIMARY KEY (id);


--
-- Name: entity_definition_value_text_uk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_definition_value_text
    ADD CONSTRAINT entity_definition_value_text_uk UNIQUE (entity_definition_id, attribute_id);


--
-- Name: entity_definition_value_timestamp_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_definition_value_timestamp
    ADD CONSTRAINT entity_definition_value_timestamp_pk PRIMARY KEY (id);


--
-- Name: entity_definition_value_timestamp_uk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_definition_value_timestamp
    ADD CONSTRAINT entity_definition_value_timestamp_uk UNIQUE (entity_definition_id, attribute_id);


--
-- Name: entity_definition_value_uk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_definition_value_boolean
    ADD CONSTRAINT entity_definition_value_uk UNIQUE (entity_definition_id, attribute_id);


--
-- Name: entity_definiton_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_definition
    ADD CONSTRAINT entity_definiton_pk PRIMARY KEY (id);


--
-- Name: entity_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity
    ADD CONSTRAINT entity_pk PRIMARY KEY (id);


--
-- Name: entity_type_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_type_attribute
    ADD CONSTRAINT entity_type_attribute_pk PRIMARY KEY (id);


--
-- Name: entity_type_attribute_uk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_type_attribute
    ADD CONSTRAINT entity_type_attribute_uk UNIQUE (entity_type_id, attribute_id);


--
-- Name: entity_type_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_type
    ADD CONSTRAINT entity_type_pk PRIMARY KEY (id);


--
-- Name: entity_uk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity
    ADD CONSTRAINT entity_uk UNIQUE (guid);


--
-- Name: evb_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_value_boolean
    ADD CONSTRAINT evb_pk PRIMARY KEY (id);


--
-- Name: evb_uk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_value_boolean
    ADD CONSTRAINT evb_uk UNIQUE (attribute_id, entity_id);


--
-- Name: evc_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_value_character
    ADD CONSTRAINT evc_pk PRIMARY KEY (id);


--
-- Name: evc_uk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_value_character
    ADD CONSTRAINT evc_uk UNIQUE (attribute_id, entity_id);


--
-- Name: evd_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_value_double
    ADD CONSTRAINT evd_pk PRIMARY KEY (id);


--
-- Name: evd_uk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_value_double
    ADD CONSTRAINT evd_uk UNIQUE (attribute_id, entity_id);


--
-- Name: evi_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_value_integer
    ADD CONSTRAINT evi_pk PRIMARY KEY (id);


--
-- Name: evi_uk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_value_integer
    ADD CONSTRAINT evi_uk UNIQUE (attribute_id, entity_id);


--
-- Name: evs_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_value_select
    ADD CONSTRAINT evs_pk PRIMARY KEY (id);


--
-- Name: evs_uk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_value_select
    ADD CONSTRAINT evs_uk UNIQUE (attribute_id, entity_id);


--
-- Name: evtm_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_value_timestamp
    ADD CONSTRAINT evtm_pk PRIMARY KEY (id);


--
-- Name: evtm_uk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_value_timestamp
    ADD CONSTRAINT evtm_uk UNIQUE (attribute_id, entity_id);


--
-- Name: evtxt_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_value_text
    ADD CONSTRAINT evtxt_pk PRIMARY KEY (id);


--
-- Name: evtxt_uk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY entity_value_text
    ADD CONSTRAINT evtxt_uk UNIQUE (attribute_id, entity_id);


--
-- Name: features_entity_definitions_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY features_entity_definitions
    ADD CONSTRAINT features_entity_definitions_pk PRIMARY KEY (id);


--
-- Name: features_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY features
    ADD CONSTRAINT features_pk PRIMARY KEY (id);


--
-- Name: financial_plan_entity_definition_price_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY financial_plan_entity_definition_price
    ADD CONSTRAINT financial_plan_entity_definition_price_pk PRIMARY KEY (id);


--
-- Name: financial_plan_entity_definition_price_uk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY financial_plan_entity_definition_price
    ADD CONSTRAINT financial_plan_entity_definition_price_uk UNIQUE (financial_plan_id, entity_definition_id, price_id);


--
-- Name: financial_plan_pkey; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY financial_plan
    ADD CONSTRAINT financial_plan_pkey PRIMARY KEY (id);


--
-- Name: price pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY price
    ADD CONSTRAINT "price pk" PRIMARY KEY (id);


--
-- Name: reservation_entity_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY reservation_entity
    ADD CONSTRAINT reservation_entity_pk PRIMARY KEY (id);


--
-- Name: reservation_entity_uk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY reservation_entity
    ADD CONSTRAINT reservation_entity_uk UNIQUE (guest_id, reservation_id, entity_id);


--
-- Name: reservation_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY reservations
    ADD CONSTRAINT reservation_pk PRIMARY KEY (id);


--
-- Name: rezervation_status_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY reservation_status
    ADD CONSTRAINT rezervation_status_pk PRIMARY KEY (id);


--
-- Name: role_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_pk PRIMARY KEY (id);


--
-- Name: role_task_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY role_task
    ADD CONSTRAINT role_task_pk PRIMARY KEY (id);


--
-- Name: role_task_uk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY role_task
    ADD CONSTRAINT role_task_uk UNIQUE (role_id, task_id);


--
-- Name: status_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY status
    ADD CONSTRAINT status_pk PRIMARY KEY (id);


--
-- Name: task_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY task
    ADD CONSTRAINT task_pk PRIMARY KEY (id);


--
-- Name: title_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY title
    ADD CONSTRAINT title_pk PRIMARY KEY (id);


--
-- Name: users_pk; Type: CONSTRAINT; Schema: public; Owner: hotel; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT users_pk PRIMARY KEY (id);


--
-- Name: fki_entity_definition_fk; Type: INDEX; Schema: public; Owner: hotel; Tablespace: 
--

CREATE INDEX fki_entity_definition_fk ON entity_definition USING btree (entity_type_id);


--
-- Name: fki_entity_entity_definition_fk; Type: INDEX; Schema: public; Owner: hotel; Tablespace: 
--

CREATE INDEX fki_entity_entity_definition_fk ON entity USING btree (definition_id);


--
-- Name: fki_eta_at_fk; Type: INDEX; Schema: public; Owner: hotel; Tablespace: 
--

CREATE INDEX fki_eta_at_fk ON entity_type_attribute USING btree (attribute_id);


--
-- Name: fki_fed_features_fk; Type: INDEX; Schema: public; Owner: hotel; Tablespace: 
--

CREATE INDEX fki_fed_features_fk ON features_entity_definitions USING btree (feature_id);


--
-- Name: fki_re_entity_fk; Type: INDEX; Schema: public; Owner: hotel; Tablespace: 
--

CREATE INDEX fki_re_entity_fk ON reservation_entity USING btree (entity_id);


--
-- Name: fki_reservation_entity_reservation_fk; Type: INDEX; Schema: public; Owner: hotel; Tablespace: 
--

CREATE INDEX fki_reservation_entity_reservation_fk ON reservation_entity USING btree (reservation_id);


--
-- Name: res_num_trigg; Type: TRIGGER; Schema: public; Owner: hotel
--

CREATE TRIGGER res_num_trigg BEFORE INSERT ON reservations FOR EACH ROW EXECUTE PROCEDURE res_num_trigg_func();


--
-- Name: aov_fk; Type: FK CONSTRAINT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY attribute_option_values
    ADD CONSTRAINT aov_fk FOREIGN KEY (attribute_id) REFERENCES attribute(id) ON DELETE CASCADE;


--
-- Name: edvb_ed_fk; Type: FK CONSTRAINT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_definition_value_boolean
    ADD CONSTRAINT edvb_ed_fk FOREIGN KEY (entity_definition_id) REFERENCES entity_definition(id) ON DELETE CASCADE;


--
-- Name: edvc_ed_fk; Type: FK CONSTRAINT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_definition_value_character
    ADD CONSTRAINT edvc_ed_fk FOREIGN KEY (entity_definition_id) REFERENCES entity_definition(id) ON DELETE CASCADE;


--
-- Name: edvd_ed_fk; Type: FK CONSTRAINT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_definition_value_double
    ADD CONSTRAINT edvd_ed_fk FOREIGN KEY (entity_definition_id) REFERENCES entity_definition(id) ON DELETE CASCADE;


--
-- Name: edvi_ed_fk; Type: FK CONSTRAINT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_definition_value_integer
    ADD CONSTRAINT edvi_ed_fk FOREIGN KEY (entity_definition_id) REFERENCES entity_definition(id) ON DELETE CASCADE;


--
-- Name: edvts_ed_fk; Type: FK CONSTRAINT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_definition_value_timestamp
    ADD CONSTRAINT edvts_ed_fk FOREIGN KEY (entity_definition_id) REFERENCES entity_definition(id) ON DELETE CASCADE;


--
-- Name: edvtx_ed_fk; Type: FK CONSTRAINT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_definition_value_text
    ADD CONSTRAINT edvtx_ed_fk FOREIGN KEY (entity_definition_id) REFERENCES entity_definition(id) ON DELETE CASCADE;


--
-- Name: entity_definition_fk; Type: FK CONSTRAINT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_definition
    ADD CONSTRAINT entity_definition_fk FOREIGN KEY (entity_type_id) REFERENCES entity_type(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: entity_definition_value_select_fk; Type: FK CONSTRAINT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_definition_value_select
    ADD CONSTRAINT entity_definition_value_select_fk FOREIGN KEY (entity_definition_id) REFERENCES entity_definition(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: entity_fk; Type: FK CONSTRAINT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity
    ADD CONSTRAINT entity_fk FOREIGN KEY (definition_id) REFERENCES entity_definition(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: eta_at_fk; Type: FK CONSTRAINT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_type_attribute
    ADD CONSTRAINT eta_at_fk FOREIGN KEY (attribute_id) REFERENCES attribute(id) ON DELETE CASCADE;


--
-- Name: eta_et_fk; Type: FK CONSTRAINT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_type_attribute
    ADD CONSTRAINT eta_et_fk FOREIGN KEY (entity_type_id) REFERENCES entity_type(id) ON DELETE CASCADE;


--
-- Name: evb_attributes_fk; Type: FK CONSTRAINT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_value_boolean
    ADD CONSTRAINT evb_attributes_fk FOREIGN KEY (attribute_id) REFERENCES attribute(id) ON DELETE CASCADE;


--
-- Name: evb_entity_fk; Type: FK CONSTRAINT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_value_boolean
    ADD CONSTRAINT evb_entity_fk FOREIGN KEY (entity_id) REFERENCES entity(id);


--
-- Name: evc_attribute_fk; Type: FK CONSTRAINT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_value_character
    ADD CONSTRAINT evc_attribute_fk FOREIGN KEY (attribute_id) REFERENCES attribute(id) ON DELETE CASCADE;


--
-- Name: evc_entity_fk; Type: FK CONSTRAINT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_value_character
    ADD CONSTRAINT evc_entity_fk FOREIGN KEY (entity_id) REFERENCES entity(id) ON DELETE CASCADE;


--
-- Name: evd_attribute_fk; Type: FK CONSTRAINT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_value_double
    ADD CONSTRAINT evd_attribute_fk FOREIGN KEY (attribute_id) REFERENCES attribute(id) ON DELETE CASCADE;


--
-- Name: evd_entity_fk; Type: FK CONSTRAINT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_value_double
    ADD CONSTRAINT evd_entity_fk FOREIGN KEY (entity_id) REFERENCES entity(id) ON DELETE CASCADE;


--
-- Name: evi_entity_fk; Type: FK CONSTRAINT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_value_integer
    ADD CONSTRAINT "evi_entity_fk" FOREIGN KEY (entity_id) REFERENCES entity(id) ON DELETE CASCADE;


--
-- Name: evi_attribute_fk; Type: FK CONSTRAINT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_value_integer
    ADD CONSTRAINT evi_attribute_fk FOREIGN KEY (attribute_id) REFERENCES attribute(id) ON DELETE CASCADE;


--
-- Name: evs_attribute_fk; Type: FK CONSTRAINT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_value_select
    ADD CONSTRAINT evs_attribute_fk FOREIGN KEY (attribute_id) REFERENCES attribute(id) ON DELETE CASCADE;


--
-- Name: evs_entity_fk; Type: FK CONSTRAINT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_value_select
    ADD CONSTRAINT evs_entity_fk FOREIGN KEY (entity_id) REFERENCES entity(id) ON DELETE CASCADE;


--
-- Name: evtm_attribute_fk; Type: FK CONSTRAINT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_value_timestamp
    ADD CONSTRAINT evtm_attribute_fk FOREIGN KEY (attribute_id) REFERENCES attribute(id) ON DELETE CASCADE;


--
-- Name: evtm_entity_fk; Type: FK CONSTRAINT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_value_timestamp
    ADD CONSTRAINT evtm_entity_fk FOREIGN KEY (entity_id) REFERENCES entity(id) ON DELETE CASCADE;


--
-- Name: evtxt_attribute_fk; Type: FK CONSTRAINT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_value_text
    ADD CONSTRAINT evtxt_attribute_fk FOREIGN KEY (attribute_id) REFERENCES attribute(id) ON DELETE CASCADE;


--
-- Name: evtxt_entity_fk; Type: FK CONSTRAINT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY entity_value_text
    ADD CONSTRAINT evtxt_entity_fk FOREIGN KEY (entity_id) REFERENCES entity(id) ON DELETE CASCADE;


--
-- Name: re_entity_fk; Type: FK CONSTRAINT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY reservation_entity
    ADD CONSTRAINT re_entity_fk FOREIGN KEY (entity_id) REFERENCES entity(id) ON DELETE CASCADE;


--
-- Name: reservation_entity_reservation_fk; Type: FK CONSTRAINT; Schema: public; Owner: hotel
--

ALTER TABLE ONLY reservation_entity
    ADD CONSTRAINT reservation_entity_reservation_fk FOREIGN KEY (reservation_id) REFERENCES reservations(id) ON DELETE CASCADE;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--


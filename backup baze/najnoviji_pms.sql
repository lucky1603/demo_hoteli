--
-- PostgreSQL database dump
--

-- Database: hotel

DROP DATABASE hotel;

CREATE DATABASE hotel
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

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
    statustext character varying(50),
    statusvalue character varying(20)
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

INSERT INTO attribute VALUES (65, 'sport', 'Sport', 'select', 1, NULL, false, false, 1);
INSERT INTO attribute VALUES (66, 'lights', 'Has Lights', 'boolean', 1, NULL, false, false, 2);
INSERT INTO attribute VALUES (54, 'counter', 'Counter', 'character', 1, NULL, true, false, 2);
INSERT INTO attribute VALUES (55, 'sbeds', 'Number of single beds', 'integer', 2, NULL, false, true, 1);
INSERT INTO attribute VALUES (56, 'dbeds', 'Number of double beds', 'integer', 2, NULL, false, true, 1);
INSERT INTO attribute VALUES (57, 'bathroom', 'Bathroom type', 'select', 3, NULL, false, false, 1);
INSERT INTO attribute VALUES (58, 'positioning', 'Positioning', 'select', 4, NULL, false, false, 2);
INSERT INTO attribute VALUES (59, 'floor', 'Floor', 'select', 5, NULL, false, false, 2);
INSERT INTO attribute VALUES (60, 'pax', 'PAX', 'integer', 7, NULL, false, false, 1);
INSERT INTO attribute VALUES (61, 'clima', 'Has Clima', 'boolean', 8, NULL, false, false, 1);
INSERT INTO attribute VALUES (62, 'roomcount', 'Count of rooms', 'integer', 16, NULL, false, false, 1);
INSERT INTO attribute VALUES (63, 'view', 'View', 'select', 20, NULL, false, false, 2);
INSERT INTO attribute VALUES (64, 'balcony', 'Balcony Type', 'select', 21, NULL, false, false, 2);


--
-- Name: attribute_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('attribute_id_seq', 66, true);


--
-- Data for Name: attribute_option_values; Type: TABLE DATA; Schema: public; Owner: hotel
--

INSERT INTO attribute_option_values VALUES (68, 65, 1, 'Tennis');
INSERT INTO attribute_option_values VALUES (69, 65, 2, 'Basketball');
INSERT INTO attribute_option_values VALUES (70, 65, 3, 'Squash');
INSERT INTO attribute_option_values VALUES (71, 65, 4, 'Bowling');
INSERT INTO attribute_option_values VALUES (54, 57, 0, 'Own bathroom');
INSERT INTO attribute_option_values VALUES (55, 57, 1, 'Shared bathroom');
INSERT INTO attribute_option_values VALUES (56, 58, 0, 'Near elevator');
INSERT INTO attribute_option_values VALUES (57, 58, 1, 'Away from elevator');
INSERT INTO attribute_option_values VALUES (58, 59, 1, 'I');
INSERT INTO attribute_option_values VALUES (59, 59, 2, 'II');
INSERT INTO attribute_option_values VALUES (60, 59, 3, 'III');
INSERT INTO attribute_option_values VALUES (61, 63, 1, 'Street');
INSERT INTO attribute_option_values VALUES (62, 63, 2, 'Parking');
INSERT INTO attribute_option_values VALUES (63, 63, 3, 'Sea');
INSERT INTO attribute_option_values VALUES (64, 63, 4, 'Hills area');
INSERT INTO attribute_option_values VALUES (65, 64, 1, 'No Balcony');
INSERT INTO attribute_option_values VALUES (66, 64, 2, 'Balcony');
INSERT INTO attribute_option_values VALUES (67, 64, 3, 'Terrace');


--
-- Name: attribute_option_values_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('attribute_option_values_id_seq', 71, true);


--
-- Data for Name: business; Type: TABLE DATA; Schema: public; Owner: hotel
--

INSERT INTO business VALUES (1, 'Small Hotel on the Beach', 'This is our small hotel, where we rent rooms and other stuff.', 'Hotel & Co.', 'Hollywood Boulevard 14234, CA, Los Angeles', '+1 555 333 222', 'hotel@hollywood.rs', 'John', 'Isner');


--
-- Name: business_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('business_id_seq', 1, true);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: hotel
--

INSERT INTO categories VALUES (0, 'Vrsta', 'Kakav je tip sobe', -1);
INSERT INTO categories VALUES (1, 'Soba', 'Obicna soba', 0);
INSERT INTO categories VALUES (2, 'Apartman', 'Apartman sa vise soba', 0);
INSERT INTO categories VALUES (4, 'Pogled', 'Gde gleda soba', -1);
INSERT INTO categories VALUES (5, 'Na more', 'Pogled na more', 4);
INSERT INTO categories VALUES (6, 'Na grad', 'Pogled na grad', 4);
INSERT INTO categories VALUES (7, 'Na parking', 'Pogled na parking hotela.', 4);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('categories_id_seq', 1, false);


--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: hotel
--

INSERT INTO clients VALUES (2, 'Louis', 'Winthorpe III', 'Address 2', NULL, 'Philadelphia', NULL, 'USA', '22222222', NULL, NULL, 'louiwinthorpe@example.com', 'Mr  ', NULL, NULL);
INSERT INTO clients VALUES (3, 'Randolph', 'Duke', 'Address 3', NULL, 'Philadelphia', NULL, 'USA', '333333333333', NULL, NULL, 'randyduke@example.com', 'Mr  ', NULL, NULL);
INSERT INTO clients VALUES (4, 'Mortimer', 'Duke', 'Address 4', NULL, 'Philadelphia', NULL, 'USA', '444444444', NULL, NULL, 'mortyduke@example.com', 'Mr  ', NULL, NULL);
INSERT INTO clients VALUES (16, 'Dragana', 'Milojević', 'Prva ulica br.11', 'asdfasdf', 'Belgrade', '11070', 'Serbia', '+381 11 238 2232', '+381 11 238 2232', '+381 11 238 2232', 'dragana@tu.com', NULL, NULL, NULL);
INSERT INTO clients VALUES (1, 'Billy Ray', 'Valentine', 'Feet Street 2', 'Sole Street 3', 'Philadelphia', '1232412', 'USA', '+381 11 238 2232', '+381 11 238 2232', '+381 11 238 2232', 'billiray@example.com', NULL, NULL, NULL);
INSERT INTO clients VALUES (12, 'Siniša', 'Ristić', 'Dušana Vukasovića 63', 'Dr. Agostina Neta 48', 'Beograd', '11070', 'SRB', '+381 11 7184763', '+381 63 297167', '+381 11 7184763', 'sinisa.ristic@gmail.com', NULL, NULL, NULL);
INSERT INTO clients VALUES (17, 'Tatjana', 'Matic', 'Jurija Gagarina 123', '', 'Beograd', '11070', 'Serbia', '234123412', '', '', 'ma@il.rs', NULL, NULL, NULL);
INSERT INTO clients VALUES (19, 'Milijana', 'Markovic', 'Kotorska 12', '', 'Podgorica', '1234124', 'Crna Gora', '23412341', '', '', 'aa@bb.cg', NULL, NULL, NULL);
INSERT INTO clients VALUES (20, 'Nemanja', 'Stankovic', '', '', '', '', '', '333243', '', '', '', NULL, NULL, NULL);
INSERT INTO clients VALUES (21, 'Slavisa', 'Mijuskovic', 'Milutina Milankovica 123', '', 'Beograd', '11000', 'Srbija', '+381 11 22 33 344', '', '', 'slavisa@mail.rs', NULL, NULL, NULL);
INSERT INTO clients VALUES (22, 'Miki', 'Markovic', 'Glavna 22', '', 'Zemun', '11080', 'Srbija', '234 234 234', '', '', 'sinisa@mail.rs', NULL, NULL, NULL);
INSERT INTO clients VALUES (23, 'Predrag', 'Živković', 'Pere Velimirovića 33', '', 'Beograd', '11000', 'Serbia', '324234234', '', '', 'pz@maxi.rs', NULL, NULL, NULL);
INSERT INTO clients VALUES (24, 'Gorica', 'Popovic', 'Mike Alasa 33', '', 'Beograd', '11000', 'Srbija', '12341234123', '', '', 'goca@mail.rs', NULL, NULL, NULL);
INSERT INTO clients VALUES (25, 'Neko', 'Novi', 'Glavna 23', '', 'Beograd', '11000', 'Srbija', '23412341234', '', '', 'sinisa.ristic@gmail.com', NULL, NULL, NULL);
INSERT INTO clients VALUES (26, 'Jorgovanka', 'Tabakovic', 'Prva 22', '', 'Zemun', '11080', 'Srbija', '1234 1234', '', '', 'mail@moj.rs', NULL, NULL, NULL);
INSERT INTO clients VALUES (27, 'Svetlana', 'Prljic', 'Dobanovska 156', '', 'Zemun', '11080', 'Srbija', '12341234', '', '', 'mail@moj.rs', NULL, NULL, NULL);
INSERT INTO clients VALUES (28, 'Goran', 'Vesic', 'Sumatovacka 55', '', 'Smederevo', '21000', 'Serbia', '123451234', '', '', 'amb@mcd.rs', NULL, NULL, NULL);
INSERT INTO clients VALUES (29, 'Milica', 'Pavlovic', 'Dvorska 22b', '', 'Mladenovac', '17000', 'Serbia', '017 888 22 33', '', '', 'mica@maril.rs', NULL, NULL, NULL);
INSERT INTO clients VALUES (30, 'Mirko', 'Roncevic', 'Agostina Neta 48', '', 'Beograd', '11070', 'Serbia', '12341234', '', '', 'mirko@mail.rs', NULL, NULL, NULL);
INSERT INTO clients VALUES (31, 'Dragoslav', 'Pavlovic', 'Pavla Petrovica 53', '', 'Beograd', '11000', 'Serbia', '+381 11 222 333', '', '', 'pavle@mail.kk', NULL, NULL, NULL);
INSERT INTO clients VALUES (32, 'Jovan', 'Petrovic', 'DUSANA VUKASOVICA 63/1', 'DUSANA VUKASOVICA 63/1', 'BEOGRAD', '11000', 'Србија', '+381113184763', '+381113184763', NULL, 'sinisa.ristic@gmail.com', NULL, NULL, NULL);
INSERT INTO clients VALUES (7, 'Billy', 'Jean', 'First street 22', 'Second str. 33', 'New York', '1234123', 'USA', '+1 555-333-222', '+1 555-333-222', NULL, 'bjean@mail.us', NULL, NULL, NULL);
INSERT INTO clients VALUES (33, 'Svetlana', 'Selimovic', 'Nasih Boraca 15', '', 'Beograd', '11000', 'Serbia', '+381 11 222 333', '', NULL, 'mos-misliti@mail.rs', NULL, NULL, NULL);
INSERT INTO clients VALUES (18, 'Barbara', 'Vidakovic', 'Dusana Vukasovica 63', '', 'Beograd', '11070', 'Srbija', '12341234', '', NULL, 'ma@il.rs', NULL, NULL, NULL);


--
-- Name: clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('clients_id_seq', 33, true);


--
-- Data for Name: entity; Type: TABLE DATA; Schema: public; Owner: hotel
--

INSERT INTO entity VALUES (38, 35, 'Available', '102', 2);
INSERT INTO entity VALUES (54, 39, 'Available', '303', 2);
INSERT INTO entity VALUES (42, 37, 'In Use', '202', 1);
INSERT INTO entity VALUES (55, 39, NULL, '304', 1);
INSERT INTO entity VALUES (61, 44, NULL, 'T3', 1);
INSERT INTO entity VALUES (63, 44, NULL, 'T5', 1);
INSERT INTO entity VALUES (64, 44, NULL, 'T6', 1);
INSERT INTO entity VALUES (60, 44, 'Available', 'T2', 2);
INSERT INTO entity VALUES (59, 44, 'Available', 'T1', 2);
INSERT INTO entity VALUES (62, 44, 'Available', 'T4', 2);
INSERT INTO entity VALUES (43, 38, 'In Use', '203', 1);
INSERT INTO entity VALUES (39, 36, 'In Use', '103', 1);
INSERT INTO entity VALUES (41, 37, 'Available', '201', 1);
INSERT INTO entity VALUES (37, 35, 'Available', '101', 2);
INSERT INTO entity VALUES (45, 39, 'In Use', '301', 2);
INSERT INTO entity VALUES (46, 39, 'In Use', '302', 2);
INSERT INTO entity VALUES (40, 36, 'Available', '104', 2);
INSERT INTO entity VALUES (44, 38, 'Available', '204', 2);


--
-- Data for Name: entity_category; Type: TABLE DATA; Schema: public; Owner: hotel
--



--
-- Name: entity_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('entity_category_id_seq', 1, false);


--
-- Data for Name: entity_definition; Type: TABLE DATA; Schema: public; Owner: hotel
--

INSERT INTO entity_definition VALUES (37, 22, 'Twin Room', 'TWIN', 'Room with two single beds, own bathroom and clima.', NULL, 1);
INSERT INTO entity_definition VALUES (38, 22, 'Double Room', 'DOUBLE', 'Room with a large double bed, bathroom and clima.', NULL, 1);
INSERT INTO entity_definition VALUES (39, 22, 'Studio', 'STUDIO', 'Studio with one large room with one large double bed and one single bed, kitchen, bathroom and clima.', NULL, 1);
INSERT INTO entity_definition VALUES (41, 23, 'Basketball court', 'BCOURT', 'Basketball court', NULL, 1);
INSERT INTO entity_definition VALUES (42, 23, 'Bowling court', 'BOWCOURT', 'Bowling court', NULL, 1);
INSERT INTO entity_definition VALUES (43, 23, 'Squash court', 'SQOURT', 'Squash court.', NULL, 1);
INSERT INTO entity_definition VALUES (35, 22, 'Single Room', 'SINGLE', 'Room with a single bed and a shared bathroom.', NULL, 1);
INSERT INTO entity_definition VALUES (36, 22, 'Single De Louxe Room', 'SINGLE+', 'Room with a double bed, own bathroom and clima.', NULL, 1);
INSERT INTO entity_definition VALUES (44, 23, 'Tennis Court', 'TCOURT', 'Tennis court in our hotel.', NULL, 1);


--
-- Name: entity_definition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('entity_definition_id_seq', 44, true);


--
-- Data for Name: entity_definition_value_boolean; Type: TABLE DATA; Schema: public; Owner: hotel
--

INSERT INTO entity_definition_value_boolean VALUES (148, 37, 61, true);
INSERT INTO entity_definition_value_boolean VALUES (153, 38, 61, true);
INSERT INTO entity_definition_value_boolean VALUES (158, 39, 61, true);
INSERT INTO entity_definition_value_boolean VALUES (138, 35, 61, false);
INSERT INTO entity_definition_value_boolean VALUES (143, 36, 61, true);


--
-- Data for Name: entity_definition_value_character; Type: TABLE DATA; Schema: public; Owner: hotel
--



--
-- Name: entity_definition_value_character_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('entity_definition_value_character_id_seq', 11, true);


--
-- Data for Name: entity_definition_value_double; Type: TABLE DATA; Schema: public; Owner: hotel
--



--
-- Data for Name: entity_definition_value_integer; Type: TABLE DATA; Schema: public; Owner: hotel
--

INSERT INTO entity_definition_value_integer VALUES (145, 37, 55, 2);
INSERT INTO entity_definition_value_integer VALUES (146, 37, 56, 0);
INSERT INTO entity_definition_value_integer VALUES (147, 37, 60, 2);
INSERT INTO entity_definition_value_integer VALUES (149, 37, 62, 1);
INSERT INTO entity_definition_value_integer VALUES (150, 38, 55, 0);
INSERT INTO entity_definition_value_integer VALUES (151, 38, 56, 1);
INSERT INTO entity_definition_value_integer VALUES (152, 38, 60, 2);
INSERT INTO entity_definition_value_integer VALUES (154, 38, 62, 1);
INSERT INTO entity_definition_value_integer VALUES (155, 39, 55, 1);
INSERT INTO entity_definition_value_integer VALUES (156, 39, 56, 1);
INSERT INTO entity_definition_value_integer VALUES (157, 39, 60, 3);
INSERT INTO entity_definition_value_integer VALUES (159, 39, 62, 2);
INSERT INTO entity_definition_value_integer VALUES (135, 35, 55, 1);
INSERT INTO entity_definition_value_integer VALUES (136, 35, 56, 0);
INSERT INTO entity_definition_value_integer VALUES (137, 35, 60, 1);
INSERT INTO entity_definition_value_integer VALUES (139, 35, 62, 1);
INSERT INTO entity_definition_value_integer VALUES (140, 36, 55, 0);
INSERT INTO entity_definition_value_integer VALUES (141, 36, 56, 1);
INSERT INTO entity_definition_value_integer VALUES (142, 36, 60, 1);
INSERT INTO entity_definition_value_integer VALUES (144, 36, 62, 1);


--
-- Data for Name: entity_definition_value_select; Type: TABLE DATA; Schema: public; Owner: hotel
--

INSERT INTO entity_definition_value_select VALUES (22, 37, 57, 0);
INSERT INTO entity_definition_value_select VALUES (23, 38, 57, 0);
INSERT INTO entity_definition_value_select VALUES (24, 39, 57, 0);
INSERT INTO entity_definition_value_select VALUES (26, 41, 65, 2);
INSERT INTO entity_definition_value_select VALUES (27, 42, 65, 4);
INSERT INTO entity_definition_value_select VALUES (28, 43, 65, 3);
INSERT INTO entity_definition_value_select VALUES (20, 35, 57, 1);
INSERT INTO entity_definition_value_select VALUES (21, 36, 57, 0);
INSERT INTO entity_definition_value_select VALUES (29, 44, 65, 1);


--
-- Name: entity_definition_value_select_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('entity_definition_value_select_id_seq', 29, true);


--
-- Data for Name: entity_definition_value_text; Type: TABLE DATA; Schema: public; Owner: hotel
--



--
-- Name: entity_definition_value_text_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('entity_definition_value_text_id_seq', 17, true);


--
-- Data for Name: entity_definition_value_timestamp; Type: TABLE DATA; Schema: public; Owner: hotel
--



--
-- Name: entity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('entity_id_seq', 64, true);


--
-- Data for Name: entity_type; Type: TABLE DATA; Schema: public; Owner: hotel
--

INSERT INTO entity_type VALUES (23, 'COURT', 'Courts for sporting activities in our hotel.', 1);
INSERT INTO entity_type VALUES (22, 'ACUNIT', 'Hotel accomodation unit. A room, an appartment, a suite, a studio, penthouse etc.', 2);


--
-- Data for Name: entity_type_attribute; Type: TABLE DATA; Schema: public; Owner: hotel
--

INSERT INTO entity_type_attribute VALUES (36, 22, 54);
INSERT INTO entity_type_attribute VALUES (37, 22, 55);
INSERT INTO entity_type_attribute VALUES (38, 22, 56);
INSERT INTO entity_type_attribute VALUES (39, 22, 57);
INSERT INTO entity_type_attribute VALUES (40, 22, 58);
INSERT INTO entity_type_attribute VALUES (41, 22, 59);
INSERT INTO entity_type_attribute VALUES (42, 22, 60);
INSERT INTO entity_type_attribute VALUES (43, 22, 61);
INSERT INTO entity_type_attribute VALUES (44, 22, 62);
INSERT INTO entity_type_attribute VALUES (45, 22, 63);
INSERT INTO entity_type_attribute VALUES (46, 22, 64);
INSERT INTO entity_type_attribute VALUES (47, 23, 65);
INSERT INTO entity_type_attribute VALUES (48, 23, 66);


--
-- Name: entity_type_attribute_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('entity_type_attribute_id_seq', 48, true);


--
-- Name: entity_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('entity_type_id_seq', 23, true);


--
-- Data for Name: entity_value_boolean; Type: TABLE DATA; Schema: public; Owner: hotel
--

INSERT INTO entity_value_boolean VALUES (3, 66, 61, false);
INSERT INTO entity_value_boolean VALUES (5, 66, 63, true);
INSERT INTO entity_value_boolean VALUES (6, 66, 64, true);
INSERT INTO entity_value_boolean VALUES (2, 66, 60, false);
INSERT INTO entity_value_boolean VALUES (1, 66, 59, false);
INSERT INTO entity_value_boolean VALUES (4, 66, 62, true);


--
-- Name: entity_value_boolean_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('entity_value_boolean_id_seq', 159, true);


--
-- Name: entity_value_boolean_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('entity_value_boolean_id_seq1', 6, true);


--
-- Data for Name: entity_value_character; Type: TABLE DATA; Schema: public; Owner: hotel
--

INSERT INTO entity_value_character VALUES (20, 54, 55, 'A304');
INSERT INTO entity_value_character VALUES (9, 54, 38, '102');
INSERT INTO entity_value_character VALUES (14, 54, 43, 'D203');
INSERT INTO entity_value_character VALUES (10, 54, 39, '103');
INSERT INTO entity_value_character VALUES (12, 54, 41, 'T201');
INSERT INTO entity_value_character VALUES (8, 54, 37, '101');
INSERT INTO entity_value_character VALUES (16, 54, 45, 'S301');
INSERT INTO entity_value_character VALUES (17, 54, 46, 'S302');
INSERT INTO entity_value_character VALUES (11, 54, 40, 'A104');
INSERT INTO entity_value_character VALUES (15, 54, 44, 'D204');
INSERT INTO entity_value_character VALUES (19, 54, 54, 'A303');
INSERT INTO entity_value_character VALUES (13, 54, 42, 'T202');


--
-- Name: entity_value_character_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('entity_value_character_id_seq', 20, true);


--
-- Data for Name: entity_value_double; Type: TABLE DATA; Schema: public; Owner: hotel
--



--
-- Name: entity_value_double_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('entity_value_double_id_seq', 1, false);


--
-- Data for Name: entity_value_integer; Type: TABLE DATA; Schema: public; Owner: hotel
--



--
-- Name: entity_value_integer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('entity_value_integer_id_seq', 1, false);


--
-- Data for Name: entity_value_select; Type: TABLE DATA; Schema: public; Owner: hotel
--

INSERT INTO entity_value_select VALUES (59, 58, 55, 1);
INSERT INTO entity_value_select VALUES (60, 59, 55, 3);
INSERT INTO entity_value_select VALUES (61, 63, 55, 3);
INSERT INTO entity_value_select VALUES (62, 64, 55, 2);
INSERT INTO entity_value_select VALUES (15, 58, 38, 0);
INSERT INTO entity_value_select VALUES (16, 59, 38, 1);
INSERT INTO entity_value_select VALUES (17, 63, 38, 1);
INSERT INTO entity_value_select VALUES (18, 64, 38, 1);
INSERT INTO entity_value_select VALUES (43, 58, 45, 1);
INSERT INTO entity_value_select VALUES (44, 59, 45, 3);
INSERT INTO entity_value_select VALUES (45, 63, 45, 3);
INSERT INTO entity_value_select VALUES (46, 64, 45, 3);
INSERT INTO entity_value_select VALUES (47, 58, 46, 1);
INSERT INTO entity_value_select VALUES (48, 59, 46, 3);
INSERT INTO entity_value_select VALUES (49, 63, 46, 3);
INSERT INTO entity_value_select VALUES (50, 64, 46, 3);
INSERT INTO entity_value_select VALUES (35, 58, 43, 1);
INSERT INTO entity_value_select VALUES (36, 59, 43, 2);
INSERT INTO entity_value_select VALUES (37, 63, 43, 3);
INSERT INTO entity_value_select VALUES (38, 64, 43, 3);
INSERT INTO entity_value_select VALUES (23, 58, 40, 1);
INSERT INTO entity_value_select VALUES (24, 59, 40, 1);
INSERT INTO entity_value_select VALUES (25, 63, 40, 3);
INSERT INTO entity_value_select VALUES (26, 64, 40, 3);
INSERT INTO entity_value_select VALUES (39, 58, 44, 1);
INSERT INTO entity_value_select VALUES (40, 59, 44, 2);
INSERT INTO entity_value_select VALUES (41, 63, 44, 4);
INSERT INTO entity_value_select VALUES (42, 64, 44, 3);
INSERT INTO entity_value_select VALUES (19, 58, 39, 1);
INSERT INTO entity_value_select VALUES (20, 59, 39, 1);
INSERT INTO entity_value_select VALUES (21, 63, 39, 3);
INSERT INTO entity_value_select VALUES (22, 64, 39, 3);
INSERT INTO entity_value_select VALUES (55, 58, 54, 1);
INSERT INTO entity_value_select VALUES (56, 59, 54, 3);
INSERT INTO entity_value_select VALUES (57, 63, 54, 3);
INSERT INTO entity_value_select VALUES (58, 64, 54, 3);
INSERT INTO entity_value_select VALUES (27, 58, 41, 0);
INSERT INTO entity_value_select VALUES (28, 59, 41, 2);
INSERT INTO entity_value_select VALUES (29, 63, 41, 2);
INSERT INTO entity_value_select VALUES (30, 64, 41, 2);
INSERT INTO entity_value_select VALUES (11, 58, 37, 0);
INSERT INTO entity_value_select VALUES (12, 59, 37, 1);
INSERT INTO entity_value_select VALUES (13, 63, 37, 1);
INSERT INTO entity_value_select VALUES (14, 64, 37, 1);
INSERT INTO entity_value_select VALUES (31, 58, 42, 0);
INSERT INTO entity_value_select VALUES (32, 59, 42, 2);
INSERT INTO entity_value_select VALUES (33, 63, 42, 4);
INSERT INTO entity_value_select VALUES (34, 64, 42, 2);


--
-- Name: entity_value_select_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('entity_value_select_id_seq', 62, true);


--
-- Data for Name: entity_value_text; Type: TABLE DATA; Schema: public; Owner: hotel
--



--
-- Name: entity_value_text_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('entity_value_text_id_seq', 1, false);


--
-- Data for Name: entity_value_timestamp; Type: TABLE DATA; Schema: public; Owner: hotel
--



--
-- Name: entity_value_timestamp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('entity_value_timestamp_id_seq', 1, false);


--
-- Data for Name: features; Type: TABLE DATA; Schema: public; Owner: hotel
--



--
-- Data for Name: features_entity_definitions; Type: TABLE DATA; Schema: public; Owner: hotel
--



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



--
-- Data for Name: financial_plan_entity_definition_price; Type: TABLE DATA; Schema: public; Owner: hotel
--



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



--
-- Name: price_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('price_id_seq', 1, false);


--
-- Data for Name: reservation_entity; Type: TABLE DATA; Schema: public; Owner: hotel
--

INSERT INTO reservation_entity VALUES (76, 16, 46, 89, '2016-01-07 12:00:00', '2016-01-11 12:00:00');
INSERT INTO reservation_entity VALUES (70, 18, 44, 83, '2016-01-05 12:00:00', '2016-01-10 12:00:00');
INSERT INTO reservation_entity VALUES (69, 18, 42, 82, '2015-12-29 12:00:00', '2016-01-01 12:00:00');
INSERT INTO reservation_entity VALUES (73, 5, 43, 86, '2015-12-23 12:00:00', '2015-12-27 12:00:00');
INSERT INTO reservation_entity VALUES (78, 19, 44, 91, '2016-01-16 12:00:00', '2016-01-19 12:00:00');
INSERT INTO reservation_entity VALUES (81, 4, 38, 94, '2016-01-16 12:00:00', '2016-01-19 12:00:00');
INSERT INTO reservation_entity VALUES (74, 20, 44, 87, '2015-12-30 12:00:00', '2016-01-03 12:00:00');
INSERT INTO reservation_entity VALUES (75, 2, 41, 88, '2015-12-30 12:00:00', '2016-01-02 12:00:00');
INSERT INTO reservation_entity VALUES (80, 16, 42, 93, '2016-01-16 12:00:00', '2016-01-19 12:00:00');
INSERT INTO reservation_entity VALUES (79, 17, 43, 92, '2016-01-16 12:00:00', '2016-01-22 12:00:00');
INSERT INTO reservation_entity VALUES (83, 21, 44, 96, '2016-01-19 12:00:00', '2016-01-23 12:00:00');
INSERT INTO reservation_entity VALUES (106, 2, 45, 121, '2016-01-22 08:00:00', '2016-01-24 01:00:00');
INSERT INTO reservation_entity VALUES (103, 26, 46, 115, '2016-01-21 12:00:00', '2016-01-25 12:00:00');
INSERT INTO reservation_entity VALUES (102, 25, 54, 114, '2016-01-22 12:00:00', '2016-01-25 12:00:00');
INSERT INTO reservation_entity VALUES (82, 22, 41, 95, '2016-01-19 12:00:00', '2016-01-23 12:00:00');
INSERT INTO reservation_entity VALUES (71, 18, 40, 84, '2016-01-18 12:00:00', '2016-01-22 12:00:00');
INSERT INTO reservation_entity VALUES (99, 2, 39, 111, '2016-01-19 12:00:00', '2016-01-21 12:00:00');
INSERT INTO reservation_entity VALUES (100, 2, 40, 112, '2016-01-23 12:00:00', '2016-01-26 12:00:00');
INSERT INTO reservation_entity VALUES (87, 23, 38, 100, '2016-01-20 12:00:00', '2016-01-25 12:00:00');
INSERT INTO reservation_entity VALUES (98, 16, 44, 110, '2016-01-24 12:00:00', '2016-01-26 12:00:00');
INSERT INTO reservation_entity VALUES (67, 16, 38, 80, '2015-12-29 12:00:00', '2016-01-04 12:00:00');
INSERT INTO reservation_entity VALUES (66, 12, 37, 80, '2015-12-29 12:00:00', '2016-01-04 12:00:00');
INSERT INTO reservation_entity VALUES (128, 4, 60, 143, '2016-02-01 10:00:00', '2016-02-01 13:00:00');
INSERT INTO reservation_entity VALUES (139, 16, 40, 154, '2016-02-09 12:00:00', '2016-02-16 12:00:00');
INSERT INTO reservation_entity VALUES (141, 12, 38, 156, '2016-02-09 12:00:00', '2016-02-15 12:00:00');
INSERT INTO reservation_entity VALUES (101, 2, 42, 113, '2016-02-12 12:00:00', '2016-02-16 12:00:00');
INSERT INTO reservation_entity VALUES (137, 31, 43, 152, '2016-02-09 12:00:00', '2016-02-13 12:00:00');
INSERT INTO reservation_entity VALUES (136, 23, 44, 151, '2016-02-09 12:00:00', '2016-02-13 12:00:00');
INSERT INTO reservation_entity VALUES (115, 17, 44, 130, '2016-01-26 12:00:00', '2016-01-31 12:00:00');
INSERT INTO reservation_entity VALUES (114, 12, 40, 129, '2016-01-26 12:00:00', '2016-01-30 12:00:00');
INSERT INTO reservation_entity VALUES (91, 24, 37, 103, '2016-01-25 14:00:00', '2016-01-30 14:00:00');
INSERT INTO reservation_entity VALUES (110, 26, 42, 125, '2016-01-25 12:00:00', '2016-01-28 12:00:00');
INSERT INTO reservation_entity VALUES (116, 27, 41, 131, '2016-01-26 12:00:00', '2016-01-28 12:00:00');
INSERT INTO reservation_entity VALUES (126, 2, 59, 141, '2016-02-01 10:00:00', '2016-02-01 13:00:00');
INSERT INTO reservation_entity VALUES (127, 3, 59, 142, '2016-02-01 13:00:00', '2016-02-01 17:00:00');
INSERT INTO reservation_entity VALUES (131, 27, 40, 146, '2016-02-06 12:00:00', '2016-02-09 12:00:00');
INSERT INTO reservation_entity VALUES (132, 24, 41, 147, '2016-02-06 12:00:00', '2016-02-09 12:00:00');
INSERT INTO reservation_entity VALUES (130, 24, 62, 145, '2016-02-01 13:00:00', '2016-02-01 14:00:00');
INSERT INTO reservation_entity VALUES (129, 27, 62, 144, '2016-02-01 11:00:00', '2016-02-01 12:00:00');
INSERT INTO reservation_entity VALUES (125, 24, 42, 140, '2016-02-03 12:00:00', '2016-02-06 12:00:00');
INSERT INTO reservation_entity VALUES (117, 28, 42, 132, '2016-01-29 12:00:00', '2016-02-03 12:00:00');
INSERT INTO reservation_entity VALUES (123, 29, 45, 138, '2016-02-01 12:00:00', '2016-02-06 12:00:00');
INSERT INTO reservation_entity VALUES (122, 30, 44, 137, '2016-02-01 12:00:00', '2016-02-05 12:00:00');
INSERT INTO reservation_entity VALUES (124, 27, 54, 139, '2016-02-01 12:00:00', '2016-02-04 12:00:00');
INSERT INTO reservation_entity VALUES (118, 29, 40, 133, '2016-01-31 12:00:00', '2016-02-03 12:00:00');
INSERT INTO reservation_entity VALUES (135, 26, 55, 150, '2016-02-12 12:00:00', '2016-02-15 12:00:00');
INSERT INTO reservation_entity VALUES (134, 29, 54, 149, '2016-02-12 12:00:00', '2016-02-16 12:00:00');
INSERT INTO reservation_entity VALUES (143, 19, 41, 158, '2016-02-09 12:00:00', '2016-02-13 12:00:00');
INSERT INTO reservation_entity VALUES (140, 21, 39, 155, '2016-02-10 12:00:00', '2016-02-15 12:00:00');
INSERT INTO reservation_entity VALUES (133, 29, 45, 148, '2016-02-08 12:00:00', '2016-02-17 14:00:00');
INSERT INTO reservation_entity VALUES (138, 20, 46, 153, '2016-02-09 12:00:00', '2016-02-17 14:00:00');
INSERT INTO reservation_entity VALUES (142, 1, 37, 157, '2016-02-10 12:00:00', '2016-02-18 12:00:00');
INSERT INTO reservation_entity VALUES (77, 21, 45, 90, '2016-01-15 12:00:00', '2016-01-19 12:00:00');
INSERT INTO reservation_entity VALUES (145, 21, 40, 166, '2016-02-19 12:00:00', '2016-02-25 12:00:00');
INSERT INTO reservation_entity VALUES (148, 28, 42, 174, '2016-02-21 12:00:00', '2016-02-24 12:00:00');
INSERT INTO reservation_entity VALUES (144, 12, 42, 160, '2016-02-17 14:00:00', '2016-02-21 12:00:00');
INSERT INTO reservation_entity VALUES (147, 33, 44, 169, '2016-02-21 12:00:00', '2016-02-25 12:00:00');
INSERT INTO reservation_entity VALUES (146, 25, 54, 168, '2016-02-19 12:00:00', '2016-02-25 12:00:00');
INSERT INTO reservation_entity VALUES (150, 26, 55, 176, '2016-02-22 12:00:00', '2016-02-27 12:00:00');
INSERT INTO reservation_entity VALUES (151, 22, 42, 177, '2016-02-25 12:00:00', '2016-02-29 12:00:00');
INSERT INTO reservation_entity VALUES (149, 20, 38, 175, '2016-02-22 12:00:00', '2016-02-27 12:00:00');


--
-- Name: reservation_entity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('reservation_entity_id_seq', 151, true);


--
-- Data for Name: reservation_status; Type: TABLE DATA; Schema: public; Owner: hotel
--

INSERT INTO reservation_status VALUES (1, 'Inquiery', 'inquiery');
INSERT INTO reservation_status VALUES (2, 'Confirmed', 'confirmed');
INSERT INTO reservation_status VALUES (3, 'Cancelled', 'cancelled');
INSERT INTO reservation_status VALUES (7, 'Archive', 'archive');
INSERT INTO reservation_status VALUES (4, 'Using', 'inhouse');
INSERT INTO reservation_status VALUES (6, 'Finished(Checkout)', 'checkout');


--
-- Data for Name: reservations; Type: TABLE DATA; Schema: public; Owner: hotel
--

INSERT INTO reservations VALUES (89, '0000000089', 'Checked Out', '2016-01-07 00:00:00', '2016-01-17 00:00:00', 16, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (83, '0000000083', 'Checked Out', '2015-12-29 00:00:00', '2016-01-17 00:00:00', 18, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (104, '0000000104', 'Checked Out', '2016-01-17 00:00:00', '2016-01-18 00:00:00', 17, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (91, '0000000091', 'Checked Out', '2016-01-16 00:00:00', '2016-01-18 00:00:00', 19, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (82, '0000000082', 'Cancelled', '2015-12-29 00:00:00', '2015-12-29 00:00:00', 18, 0, 0, 0, NULL, 3);
INSERT INTO reservations VALUES (86, '0000000086', 'Ckeckout', '2015-12-30 00:00:00', '2015-12-30 00:00:00', 5, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (94, '0000000094', 'Checked Out', '2016-01-16 00:00:00', '2016-01-18 00:00:00', 4, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (124, '0000000124', 'Confirmed', '2016-01-23 00:00:00', '2016-01-23 00:00:00', 2, 0, 0, 0, NULL, 2);
INSERT INTO reservations VALUES (87, '0000000087', 'Ckeckout', '2015-12-30 00:00:00', '2016-01-07 00:00:00', 20, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (88, '0000000088', 'Ckeckout', '2015-12-30 00:00:00', '2016-01-07 00:00:00', 2, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (85, '0000000085', 'Ckeckout', '2015-12-29 00:00:00', '2016-01-07 00:00:00', 19, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (93, '0000000093', 'Finished(Checkout)', '2016-01-16 00:00:00', '2016-01-19 00:00:00', 16, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (116, '0000000116', 'Inquiery', '2016-01-21 00:00:00', '2016-01-21 00:00:00', 2, 0, 0, 0, NULL, 1);
INSERT INTO reservations VALUES (117, '0000000117', 'Inquiery', '2016-01-21 00:00:00', '2016-01-21 00:00:00', 2, 0, 0, 0, NULL, 1);
INSERT INTO reservations VALUES (118, '0000000118', 'Inquiery', '2016-01-21 00:00:00', '2016-01-21 00:00:00', 2, 0, 0, 0, NULL, 1);
INSERT INTO reservations VALUES (119, '0000000119', 'Finished(Checkout)', '2016-01-21 00:00:00', '2016-01-21 00:00:00', 2, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (120, '0000000120', 'Finished(Checkout)', '2016-01-21 00:00:00', '2016-01-21 00:00:00', 3, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (122, '0000000122', 'Inquiery', '2016-01-22 00:00:00', '2016-01-22 00:00:00', 18, 0, 0, 0, NULL, 1);
INSERT INTO reservations VALUES (123, '0000000123', 'Confirmed', '2016-01-23 00:00:00', '2016-01-23 00:00:00', 3, 0, 0, 0, NULL, 2);
INSERT INTO reservations VALUES (126, '0000000126', 'Confirmed', '2016-01-26 00:00:00', '2016-01-26 00:00:00', 2, 0, 0, 0, NULL, 2);
INSERT INTO reservations VALUES (127, '0000000127', 'Inquiery', '2016-01-26 00:00:00', '2016-01-26 00:00:00', 3, 0, 0, 0, NULL, 1);
INSERT INTO reservations VALUES (128, '0000000128', 'Confirmed', '2016-01-26 00:00:00', '2016-01-26 00:00:00', 4, 0, 0, 0, NULL, 2);
INSERT INTO reservations VALUES (92, '0000000092', 'Finished(Checkout)', '2016-01-16 00:00:00', '2016-01-26 00:00:00', 17, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (96, '0000000096', 'Finished(Checkout)', '2016-01-17 00:00:00', '2016-01-26 00:00:00', 21, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (121, '0000000121', 'Finished(Checkout)', '2016-01-22 00:00:00', '2016-01-26 00:00:00', 12, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (115, '0000000115', 'Finished(Checkout)', '2016-01-21 00:00:00', '2016-01-26 00:00:00', 26, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (114, '0000000114', 'Finished(Checkout)', '2016-01-20 00:00:00', '2016-01-26 00:00:00', 25, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (95, '0000000095', 'Finished(Checkout)', '2016-01-17 00:00:00', '2016-01-26 00:00:00', 22, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (84, '0000000084', 'Finished(Checkout)', '2015-12-29 00:00:00', '2016-01-26 00:00:00', 18, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (111, '0000000111', 'Finished(Checkout)', '2016-01-19 00:00:00', '2016-01-26 00:00:00', 2, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (112, '0000000112', 'Finished(Checkout)', '2016-01-19 00:00:00', '2016-01-26 00:00:00', 2, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (100, '0000000100', 'Finished(Checkout)', '2016-01-17 00:00:00', '2016-01-26 00:00:00', 23, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (110, '0000000110', 'Finished(Checkout)', '2016-01-19 00:00:00', '2016-01-26 00:00:00', 16, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (151, '0000000151', 'Finished(Checkout)', '2016-02-09 00:00:00', '2016-02-17 00:00:00', 23, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (140, '0000000140', 'Finished(Checkout)', '2016-02-01 00:00:00', '2016-02-17 00:00:00', 24, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (147, '0000000147', 'Finished(Checkout)', '2016-02-05 00:00:00', '2016-02-17 00:00:00', 24, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (146, '0000000146', 'Finished(Checkout)', '2016-02-05 00:00:00', '2016-02-17 00:00:00', 27, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (138, '0000000138', 'Finished(Checkout)', '2016-02-01 00:00:00', '2016-02-17 00:00:00', 29, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (130, '0000000130', 'Finished(Checkout)', '2016-01-26 00:00:00', '2016-02-01 00:00:00', 17, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (134, '0000000134', 'Confirmed', '2016-01-29 00:00:00', '2016-01-29 00:00:00', 30, 0, 0, 0, NULL, 2);
INSERT INTO reservations VALUES (135, '0000000135', 'Using', '2016-01-29 00:00:00', '2016-01-29 00:00:00', 17, 0, 0, 0, NULL, 4);
INSERT INTO reservations VALUES (136, '0000000136', 'Confirmed', '2016-01-29 00:00:00', '2016-01-29 00:00:00', 12, 0, 0, 0, NULL, 2);
INSERT INTO reservations VALUES (129, '0000000129', 'Finished(Checkout)', '2016-01-26 00:00:00', '2016-02-01 00:00:00', 12, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (103, '0000000103', 'Finished(Checkout)', '2016-01-17 00:00:00', '2016-02-01 00:00:00', 24, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (125, '0000000125', 'Finished(Checkout)', '2016-01-23 00:00:00', '2016-02-01 00:00:00', 26, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (131, '0000000131', 'Finished(Checkout)', '2016-01-26 00:00:00', '2016-02-01 00:00:00', 27, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (141, '0000000141', 'Using', '2016-02-01 00:00:00', '2016-02-01 00:00:00', 2, 0, 0, 0, NULL, 4);
INSERT INTO reservations VALUES (142, '0000000142', 'Confirmed', '2016-02-01 00:00:00', '2016-02-01 00:00:00', 3, 0, 0, 0, NULL, 2);
INSERT INTO reservations VALUES (161, '0000000161', 'Inquiery', '2016-02-17 00:00:00', '2016-02-17 00:00:00', 2, 0, 0, 0, NULL, 1);
INSERT INTO reservations VALUES (150, '0000000150', 'Finished(Checkout)', '2016-02-09 00:00:00', '2016-02-17 00:00:00', 26, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (145, '0000000145', 'Confirmed', '2016-02-01 00:00:00', '2016-02-01 00:00:00', 24, 0, 0, 0, NULL, 2);
INSERT INTO reservations VALUES (144, '0000000144', 'Finished(Checkout)', '2016-02-01 00:00:00', '2016-02-01 00:00:00', 27, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (137, '0000000137', 'Finished(Checkout)', '2016-02-01 00:00:00', '2016-02-05 00:00:00', 30, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (139, '0000000139', 'Finished(Checkout)', '2016-02-01 00:00:00', '2016-02-05 00:00:00', 27, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (133, '0000000133', 'Finished(Checkout)', '2016-01-27 00:00:00', '2016-02-05 00:00:00', 29, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (162, '0000000162', 'Inquiery', '2016-02-17 00:00:00', '2016-02-17 00:00:00', 2, 0, 0, 0, NULL, 1);
INSERT INTO reservations VALUES (154, '0000000154', 'Finished(Checkout)', '2016-02-09 00:00:00', '2016-02-17 00:00:00', 16, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (163, '0000000163', 'Inquiery', '2016-02-17 00:00:00', '2016-02-17 00:00:00', 2, 0, 0, 0, NULL, 1);
INSERT INTO reservations VALUES (80, '0000000080', 'Finished(Checkout)', '2015-12-29 00:00:00', '2016-02-17 00:00:00', 12, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (159, '0000000159', 'Inquiery', '2016-02-17 00:00:00', '2016-02-17 00:00:00', 2, 0, 0, 0, NULL, 1);
INSERT INTO reservations VALUES (168, '0000000168', 'Using', '2016-02-19 00:00:00', '2016-02-22 00:00:00', 2, 0, 0, 0, NULL, 4);
INSERT INTO reservations VALUES (158, '0000000158', 'Cancelled', '2016-02-09 00:00:00', '2016-02-17 00:00:00', 19, 0, 0, 0, NULL, 3);
INSERT INTO reservations VALUES (143, '0000000143', 'Finished(Checkout)', '2016-02-01 00:00:00', '2016-02-17 00:00:00', 4, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (152, '0000000152', 'Finished(Checkout)', '2016-02-09 00:00:00', '2016-02-17 00:00:00', 31, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (156, '0000000156', 'Finished(Checkout)', '2016-02-09 00:00:00', '2016-02-17 00:00:00', 12, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (113, '0000000113', 'Finished(Checkout)', '2016-01-19 00:00:00', '2016-02-17 00:00:00', 2, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (132, '0000000132', 'Finished(Checkout)', '2016-01-27 00:00:00', '2016-02-17 00:00:00', 28, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (149, '0000000149', 'Finished(Checkout)', '2016-02-09 00:00:00', '2016-02-17 00:00:00', 29, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (155, '0000000155', 'Cancelled', '2016-02-09 00:00:00', '2016-02-17 00:00:00', 21, 0, 0, 0, NULL, 3);
INSERT INTO reservations VALUES (153, '0000000153', 'Finished(Checkout)', '2016-02-09 00:00:00', '2016-02-17 00:00:00', 20, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (157, '0000000157', 'Finished(Checkout)', '2016-02-09 00:00:00', '2016-02-19 00:00:00', 1, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (164, '0000000164', 'Inquiery', '2016-02-17 00:00:00', '2016-02-17 00:00:00', 2, 0, 0, 0, NULL, 1);
INSERT INTO reservations VALUES (165, '0000000165', 'Inquiery', '2016-02-17 00:00:00', '2016-02-17 00:00:00', 2, 0, 0, 0, NULL, 1);
INSERT INTO reservations VALUES (148, '0000000148', 'Finished(Checkout)', '2016-02-05 00:00:00', '2016-02-17 00:00:00', 29, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (167, '0000000167', 'Inquiery', '2016-02-19 00:00:00', '2016-02-19 00:00:00', 23, 0, 0, 0, NULL, 1);
INSERT INTO reservations VALUES (90, '0000000090', 'Finished(Checkout)', '2016-01-15 00:00:00', '2016-02-19 00:00:00', 21, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (170, '0000000170', 'Inquiery', '2016-02-19 00:00:00', '2016-02-19 00:00:00', 2, 0, 0, 0, NULL, 1);
INSERT INTO reservations VALUES (171, '0000000171', 'Inquiery', '2016-02-19 00:00:00', '2016-02-19 00:00:00', 2, 0, 0, 0, NULL, 1);
INSERT INTO reservations VALUES (172, '0000000172', 'Inquiery', '2016-02-19 00:00:00', '2016-02-19 00:00:00', 2, 0, 0, 0, NULL, 1);
INSERT INTO reservations VALUES (173, '0000000173', 'Inquiery', '2016-02-19 00:00:00', '2016-02-19 00:00:00', 2, 0, 0, 0, NULL, 1);
INSERT INTO reservations VALUES (166, '0000000166', 'Using', '2016-02-19 00:00:00', '2016-02-22 00:00:00', 21, 0, 0, 0, NULL, 4);
INSERT INTO reservations VALUES (174, '0000000174', 'Using', '2016-02-19 00:00:00', '2016-02-22 00:00:00', 28, 0, 0, 0, NULL, 4);
INSERT INTO reservations VALUES (160, '0000000160', 'Finished(Checkout)', '2016-02-17 00:00:00', '2016-02-22 00:00:00', 12, 0, 0, 0, NULL, 6);
INSERT INTO reservations VALUES (169, '0000000169', 'Using', '2016-02-19 00:00:00', '2016-02-22 00:00:00', 2, 0, 0, 0, NULL, 4);
INSERT INTO reservations VALUES (176, '0000000176', 'Confirmed', '2016-02-22 00:00:00', '2016-02-22 00:00:00', 26, 0, 0, 0, NULL, 2);
INSERT INTO reservations VALUES (177, '0000000177', 'Inquiery', '2016-02-22 00:00:00', '2016-02-22 00:00:00', 22, 0, 0, 0, NULL, 1);
INSERT INTO reservations VALUES (175, '0000000175', 'Finished(Checkout)', '2016-02-22 00:00:00', '2016-02-26 00:00:00', 20, 0, 0, 0, NULL, 6);


--
-- Name: reservations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('reservations_id_seq', 177, true);


--
-- Name: rezervation_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('rezervation_status_id_seq', 7, true);


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: hotel
--

INSERT INTO role VALUES (1, 'sysadmin', 'System administrator. Can do all.');
INSERT INTO role VALUES (2, 'poweruser', 'Power user. Can read, write to db and change the dabase structure.');
INSERT INTO role VALUES (3, 'user', 'Normal user. Can read and write to db.');


--
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('role_id_seq', 1, false);


--
-- Data for Name: role_task; Type: TABLE DATA; Schema: public; Owner: hotel
--

INSERT INTO role_task VALUES (1, 1, 1);
INSERT INTO role_task VALUES (2, 1, 2);
INSERT INTO role_task VALUES (3, 1, 3);
INSERT INTO role_task VALUES (4, 1, 4);
INSERT INTO role_task VALUES (5, 2, 2);
INSERT INTO role_task VALUES (6, 2, 3);
INSERT INTO role_task VALUES (7, 2, 4);
INSERT INTO role_task VALUES (8, 3, 3);
INSERT INTO role_task VALUES (9, 3, 4);


--
-- Name: role_task_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('role_task_id_seq', 1, true);


--
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: hotel
--

INSERT INTO status VALUES (3, 'Maintenance');
INSERT INTO status VALUES (5, 'Out of order');
INSERT INTO status VALUES (4, 'Cleaning');
INSERT INTO status VALUES (1, 'Available');
INSERT INTO status VALUES (2, 'In Use');


--
-- Name: status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('status_id_seq', 5, true);


--
-- Data for Name: task; Type: TABLE DATA; Schema: public; Owner: hotel
--

INSERT INTO task VALUES (1, 'sysconfig', 'Configures the system variables.');
INSERT INTO task VALUES (2, 'dbread', 'Reads the database data.');
INSERT INTO task VALUES (3, 'dbwrite', 'Writes the data to database.');
INSERT INTO task VALUES (4, 'dbchange', 'Changes the dabase structure.');


--
-- Name: task_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('task_id_seq', 1, false);


--
-- Data for Name: title; Type: TABLE DATA; Schema: public; Owner: hotel
--

INSERT INTO title VALUES (1, 'Mr.');
INSERT INTO title VALUES (2, 'Mrs.');
INSERT INTO title VALUES (3, 'Ms.');


--
-- Name: title_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('title_id_seq', 3, true);


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: hotel
--

INSERT INTO "user" VALUES (1, 'Administrator', '523af537946b79c4f8369ed39ba78605', 'admin@example.com', 1);
INSERT INTO "user" VALUES (14, 'Office', '8bf8854bebe108183caeb845c7676ae4', 'office@mail.rs', 2);
INSERT INTO "user" VALUES (12, 'Reception', '12eccbdd9b32918131341f38907cbbb5', 'info@hotel.rs', 3);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hotel
--

SELECT pg_catalog.setval('users_id_seq', 14, true);


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


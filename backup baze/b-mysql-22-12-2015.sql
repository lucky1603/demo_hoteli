# Converted with pg2mysql-1.9
# Converted on Sun, 27 Dec 2015 17:12:33 -0500
# Lightbox Technologies Inc. http://www.lightbox.ca

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone="+00:00";

CREATE TABLE attribute (
    id int(11) NOT NULL,
    code varchar(20),
    label varchar(50),
    `type` varchar(20),
    sort_order int(11),
    unit varchar(20),
    `unique` BOOLEAN DEFAULT 0 NOT NULL,
    nullable BOOLEAN DEFAULT 1 NOT NULL,
    scope int(11) DEFAULT 1 NOT NULL
) ENGINE=MyISAM;

CREATE TABLE attribute_option_values (
    id int(11) NOT NULL,
    attribute_id int(11),
    value int(11),
    text varchar(50)
) ENGINE=MyISAM;

CREATE TABLE business (
    id int(11) NOT NULL,
    name varchar(100),
    description text,
    company_name varchar(100),
    address text,
    phone varchar(50),
    email varchar(255),
    contact_first_name varchar(50),
    contact_last_name varchar(50)
) ENGINE=MyISAM;

CREATE TABLE categories (
    id int(11) NOT NULL,
    name varchar(100),
    description text,
    parent_id int(11)
) ENGINE=MyISAM;

CREATE TABLE clients (
    id int(11) NOT NULL,
    first_name varchar(100) NOT NULL,
    last_name varchar(100),
    address1 varchar(100),
    address2 varchar(100),
    city varchar(100),
    zipcode varchar(20),
    country varchar(10),
    phone varchar(100),
    mobile varchar(100),
    fax varchar(100),
    email varchar(255),
    title varchar(4),
    guest_class varchar(10),
    title_id int(11)
) ENGINE=MyISAM;

CREATE TABLE ct (
    id int(11) NOT NULL,
    rowid text,
    attribute text,
    value text
) ENGINE=MyISAM;

CREATE TABLE entity (
    id int(11) NOT NULL,
    definition_id int(11) NOT NULL,
    `status` varchar(255),
    guid varchar(10),
    status_id int(11)
) ENGINE=MyISAM;

CREATE TABLE entity_category (
    id int(11) NOT NULL,
    entity_id int(11),
    category_id int(11)
) ENGINE=MyISAM;

CREATE TABLE entity_definition (
    id int(11) NOT NULL,
    entity_type_id int(11) NOT NULL,
    name varchar(100) NOT NULL,
    code varchar(10),
    description text,
    price numeric(10,2),
    pax smallint DEFAULT 1
) ENGINE=MyISAM;

CREATE TABLE entity_definition_value_BOOLEANean (
    id int(11) NOT NULL,
    entity_definition_id int(11),
    attribute_id int(11),
    value BOOLEAN
) ENGINE=MyISAM;

CREATE TABLE entity_definition_value_character (
    id int(11) NOT NULL,
    entity_definition_id int(11),
    attribute_id int(11),
    value varchar(255)
) ENGINE=MyISAM;

CREATE TABLE entity_definition_value_double (
    id int(11) auto_increment NOT NULL,
    entity_definition_id int(11),
    attribute_id int(11),
    value double precision
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE entity_definition_value_integer (
    id int(11) auto_increment NOT NULL,
    entity_definition_id int(11),
    attribute_id int(11),
    value int(11)
, PRIMARY KEY(`id`)
) ENGINE=MyISAM;

CREATE TABLE entity_definition_value_select (
    id int(11) NOT NULL,
    entity_definition_id int(11),
    attribute_id int(11),
    value int(11)
) ENGINE=MyISAM;

CREATE TABLE entity_definition_value_text (
    id int(11) NOT NULL,
    entity_definition_id int(11),
    attribute_id int(11),
    value text
) ENGINE=MyISAM;

CREATE TABLE entity_definition_value_timestamp (
    id int(11) NOT NULL,
    entity_definition_id int(11),
    attribute_id int(11),
    value timestamp
) ENGINE=MyISAM;

CREATE TABLE entity_type (
    id int(11) NOT NULL,
    name varchar(100) NOT NULL,
    description text,
    time_resolution int(11) DEFAULT 0
) ENGINE=MyISAM;

CREATE TABLE entity_type_attribute (
    id int(11) NOT NULL,
    entity_type_id int(11) NOT NULL,
    attribute_id int(11) NOT NULL
) ENGINE=MyISAM;

CREATE TABLE entity_value_BOOLEANean (
    id int(11) NOT NULL,
    attribute_id int(11),
    entity_id int(11),
    value BOOLEAN
) ENGINE=MyISAM;

CREATE TABLE entity_value_character (
    id int(11) NOT NULL,
    attribute_id int(11),
    entity_id int(11),
    value varchar(100)
) ENGINE=MyISAM;

CREATE TABLE entity_value_double (
    id int(11) NOT NULL,
    attribute_id int(11),
    entity_id int(11),
    value double precision
) ENGINE=MyISAM;

CREATE TABLE entity_value_integer (
    id int(11) NOT NULL,
    attribute_id int(11),
    entity_id int(11),
    value int(11)
) ENGINE=MyISAM;

CREATE TABLE entity_value_select (
    id int(11) NOT NULL,
    attribute_id int(11),
    entity_id int(11),
    value int(11)
) ENGINE=MyISAM;

CREATE TABLE entity_value_text (
    id int(11) NOT NULL,
    attribute_id int(11),
    entity_id int(11),
    value text
) ENGINE=MyISAM;

CREATE TABLE entity_value_timestamp (
    id int(11) NOT NULL,
    attribute_id int(11),
    entity_id int(11),
    value timestamp
) ENGINE=MyISAM;

CREATE TABLE features (
    id int(11) NOT NULL,
    name varchar(100),
    description text
) ENGINE=MyISAM;

CREATE TABLE features_entity_definitions (
    id int(11) NOT NULL,
    feature_id int(11),
    entity_definition_id int(11)
) ENGINE=MyISAM;

CREATE TABLE financial_plan (
    id int(11) NOT NULL,
    name varchar(50),
    description text
) ENGINE=MyISAM;

CREATE TABLE financial_plan_entity_definition_price (
    id int(11) NOT NULL,
    financial_plan_id int(11),
    entity_definition_id int(11),
    price_id int(11)
) ENGINE=MyISAM;

CREATE TABLE price (
    id int(11) NOT NULL,
    value double precision,
    currency varchar(3),
    description varchar(50)
) ENGINE=MyISAM;

CREATE TABLE reservation_entity (
    id int(11) NOT NULL,
    guest_id int(11),
    entity_id int(11) NOT NULL,
    reservation_id int(11) NOT NULL,
    date_start bigint NOT NULL,
    date_end int(11) NOT NULL,
    date_from timestamp,
    date_to timestamp
) ENGINE=MyISAM;

CREATE TABLE reservation_status (
    id int(11) NOT NULL,
    statustext varchar(50)
) ENGINE=MyISAM;

CREATE TABLE reservations (
    id int(11) NOT NULL,
    reservation_id varchar(100) NOT NULL,
    `status` varchar(100),
    created_at timestamp(0),
    modified_at timestamp(0),
    client_id int(11) NOT NULL,
    pax_a smallint DEFAULT 0,
    pax_y smallint DEFAULT 0,
    pax_c smallint DEFAULT 0,
    comment text,
    status_id int(11)
) ENGINE=MyISAM;

CREATE TABLE role (
    id int(11) NOT NULL,
    name varchar(50) NOT NULL,
    description text
) ENGINE=MyISAM;

CREATE TABLE role_task (
    id int(11) NOT NULL,
    role_id int(11) NOT NULL,
    task_id int(11)
) ENGINE=MyISAM;

CREATE TABLE status (
    id int(11) NOT NULL,
    value varchar(50)
) ENGINE=MyISAM;

CREATE TABLE task (
    id int(11) NOT NULL,
    name varchar(50) NOT NULL,
    description text
) ENGINE=MyISAM;

CREATE TABLE title (
    id int(11) NOT NULL,
    title varchar(20)
) ENGINE=MyISAM;

CREATE TABLE `user` (
    id int(11) NOT NULL,
    username varchar(20) NOT NULL,
    password varchar(100) NOT NULL,
    email varchar(255),
    role_id int(11) DEFAULT 1
) ENGINE=MyISAM;

ALTER TABLE attribute_option_values
    ADD CONSTRAINT attribute_option_value_pk PRIMARY KEY (id);
ALTER TABLE attribute
    ADD CONSTRAINT attribute_pk PRIMARY KEY (id);
ALTER TABLE business
    ADD CONSTRAINT business_pk PRIMARY KEY (id);
ALTER TABLE categories
    ADD CONSTRAINT categories_pk PRIMARY KEY (id);
ALTER TABLE clients
    ADD CONSTRAINT clients_pk PRIMARY KEY (id);
ALTER TABLE ct
    ADD CONSTRAINT ct_pk PRIMARY KEY (id);
ALTER TABLE entity_category
    ADD CONSTRAINT entity_category_pk PRIMARY KEY (id);
ALTER TABLE entity_definition_value_character
    ADD CONSTRAINT entity_definition_value_character_pk PRIMARY KEY (id);
ALTER TABLE entity_definition_value_double
    ADD CONSTRAINT entity_definition_value_double_pk PRIMARY KEY (id);
ALTER TABLE entity_definition_value_integer
    ADD CONSTRAINT entity_definition_value_integer_pk PRIMARY KEY (id);
ALTER TABLE entity_definition_value_BOOLEANean
    ADD CONSTRAINT entity_definition_value_pk PRIMARY KEY (id);
ALTER TABLE entity_definition_value_select
    ADD CONSTRAINT entity_definition_value_select_pk PRIMARY KEY (id);
ALTER TABLE entity_definition_value_text
    ADD CONSTRAINT entity_definition_value_text_pk PRIMARY KEY (id);
ALTER TABLE entity_definition_value_timestamp
    ADD CONSTRAINT entity_definition_value_timestamp_pk PRIMARY KEY (id);
ALTER TABLE entity_definition
    ADD CONSTRAINT entity_definiton_pk PRIMARY KEY (id);
ALTER TABLE entity
    ADD CONSTRAINT entity_pk PRIMARY KEY (id);
ALTER TABLE entity_type_attribute
    ADD CONSTRAINT entity_type_attribute_pk PRIMARY KEY (id);
ALTER TABLE entity_type
    ADD CONSTRAINT entity_type_pk PRIMARY KEY (id);
ALTER TABLE entity_value_BOOLEANean
    ADD CONSTRAINT evb_pk PRIMARY KEY (id);
ALTER TABLE entity_value_character
    ADD CONSTRAINT evc_pk PRIMARY KEY (id);
ALTER TABLE entity_value_double
    ADD CONSTRAINT evd_pk PRIMARY KEY (id);
ALTER TABLE entity_value_integer
    ADD CONSTRAINT evi_pk PRIMARY KEY (id);
ALTER TABLE entity_value_select
    ADD CONSTRAINT evs_pk PRIMARY KEY (id);
ALTER TABLE entity_value_timestamp
    ADD CONSTRAINT evtm_pk PRIMARY KEY (id);
ALTER TABLE entity_value_text
    ADD CONSTRAINT evtxt_pk PRIMARY KEY (id);
ALTER TABLE features_entity_definitions
    ADD CONSTRAINT features_entity_definitions_pk PRIMARY KEY (id);
ALTER TABLE features
    ADD CONSTRAINT features_pk PRIMARY KEY (id);
ALTER TABLE financial_plan_entity_definition_price
    ADD CONSTRAINT financial_plan_entity_definition_price_pk PRIMARY KEY (id);
ALTER TABLE financial_plan
    ADD CONSTRAINT financial_plan_pkey PRIMARY KEY (id);
ALTER TABLE price
    ADD CONSTRAINT "price pk" PRIMARY KEY (id);
ALTER TABLE reservation_entity
    ADD CONSTRAINT reservation_entity_pk PRIMARY KEY (id);
ALTER TABLE reservations
    ADD CONSTRAINT reservation_pk PRIMARY KEY (id);
ALTER TABLE reservation_status
    ADD CONSTRAINT rezervation_status_pk PRIMARY KEY (id);
ALTER TABLE role
    ADD CONSTRAINT role_pk PRIMARY KEY (id);
ALTER TABLE role_task
    ADD CONSTRAINT role_task_pk PRIMARY KEY (id);
ALTER TABLE status
    ADD CONSTRAINT status_pk PRIMARY KEY (id);
ALTER TABLE task
    ADD CONSTRAINT task_pk PRIMARY KEY (id);
ALTER TABLE title
    ADD CONSTRAINT title_pk PRIMARY KEY (id);
ALTER TABLE `user`
    ADD CONSTRAINT users_pk PRIMARY KEY (id);
ALTER TABLE `entity_definition` ADD INDEX ( entity_type_id ) ;
ALTER TABLE `entity` ADD INDEX ( definition_id ) ;
ALTER TABLE `entity_type_attribute` ADD INDEX ( attribute_id ) ;
ALTER TABLE `features_entity_definitions` ADD INDEX ( feature_id ) ;
ALTER TABLE `reservation_entity` ADD INDEX ( entity_id ) ;
ALTER TABLE `reservation_entity` ADD INDEX ( reservation_id ) ;

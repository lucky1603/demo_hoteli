CREATE TABLE entity_value_text
(
  id serial NOT NULL,
  entity_id integer,
  entity_definition_id integer,
  attribute_id integer,
  value text,
  CONSTRAINT entity_value_text_pk PRIMARY KEY (id),
  CONSTRAINT entity_value_text_uk UNIQUE (entity_id, attribute_id, entity_definition_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE entity_value_text
  OWNER TO hotel;

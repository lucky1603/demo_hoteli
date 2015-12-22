CREATE VIEW roomlist AS
SELECT  
e.guid, eavi.value
FROM 
entity as e,
attribute as a,
entity_value_integer as eavi
WHERE 
eavi.entity_id = e.id AND
eavi.attribute_id = a.id

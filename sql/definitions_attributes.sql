SELECT 
	ed.code as "Entity Code",
	ed.name as "Entity Name",
	at.label as "Attribute",
	at.type
FROM 
	entity_definition as ed,
	attribute as at, 
	entity_definition_attribute as eda
WHERE
	ed.id = eda.entity_definition_id AND
	at.id = eda.attribute_id
	
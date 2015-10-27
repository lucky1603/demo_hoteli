SELECT 
	ed.code as "Entity Code",
	ed.name as "Entity Name",
	at.label as "Attribute",
	at.type as "Datatype", 
	eav.value as "Value"
FROM 
	entity_definition as ed,
	attribute as at, 
	entity_definition_attribute as eda,
	entity_definition_value_boolean as eav
WHERE
	ed.id = eda.entity_definition_id AND
	at.id = eda.attribute_id AND
	eav.attribute_id = at.id AND
	eav.entity_definition_id = ed.id and
	ed.code = 'SUI'
	
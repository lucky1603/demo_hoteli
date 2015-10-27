SELECT 
	et.guid as "Room Number", 
	ed.code as "Room Type", 
	et.status, 
	at.label as "Parameter", 
	eav.value, 
	eavd.value,
	eavb.value
FROM 
	entity as et, 
	entity_definition as ed, 
	attribute as at, 
	entity_definition_attribute as ea, 
	entity_definition_value_integer as eav,
	entity_definition_value_boolean as eavb,
	entity_definition_value_double as eavd
WHERE 	
	et.definition_id = ed.id AND 
	ea.attribute_id = at.id AND 
	ea.entity_definition_id = ed.id AND 
	eav.attribute_id = at.id AND 
	eav.entity_definition_id = ed.id AND
	(eavd.attribute_id = at.id AND
	eavd.entity_definition_id = ed.id) OR
	(eavb.attribute_id = at.id AND
	eavb.entity_definition_id = ed.id)
	
ORDER BY 
	et.guid
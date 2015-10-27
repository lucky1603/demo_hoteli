SELECT et.guid as "Room Number", ed.code as "Room Type", et.status, at.label, eav.value, at.unit 
FROM entity as et, entity_definition as ed, attribute as at, entity_definition_attribute as ea, entity_definition_value_double as eav 
WHERE (et.definition_id = ed.id AND ea.attribute_id = at.id AND ea.entity_definition_id = ed.id AND eav.attribute_id = at.id AND 
eav.entity_definition_id = ed.id)
ORDER BY (et.guid)
SELECT  eav.value 
FROM entity as et, entity_definition as ed, attribute as at, entity_definition_attribute as ea, entity_definition_value_boolean as eav 
WHERE (et.definition_id = ed.id AND ea.attribute_id = at.id AND ea.entity_definition_id = ed.id AND eav.attribute_id = at.id AND 
eav.entity_definition_id = ed.id and et.guid='101')
ORDER BY (et.guid)
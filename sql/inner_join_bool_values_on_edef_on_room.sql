﻿SELECT 	e.guid, v.id, ed.code,a.label,v.value 
FROM entity_definition_value_boolean as v
INNER JOIN attribute as a 
ON v.attribute_id = a.id
INNER JOIN entity_definition as ed
ON v.entity_definition_id = ed.id
INNER JOIN entity as e
ON v.entity_definition_id = e.definition_id
WHERE e.guid = '101'

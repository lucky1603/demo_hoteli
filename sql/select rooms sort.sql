SELECT
	et.guid as "Room Number", ed.code as "Room Type", et.status 
FROM 
	entity as et, entity_definition as ed 
WHERE 
	et.definition_id = ed.id
ORDER BY
	et.guid
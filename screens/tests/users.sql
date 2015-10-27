select p.id, p.username, q.name, q.description from users as p, role as q where p.role_id = q.id;

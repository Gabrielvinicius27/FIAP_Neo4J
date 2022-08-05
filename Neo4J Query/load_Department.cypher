LOAD CSV WITH HEADERS FROM 'file:///Department.csv' as file
WITH file WHERE file._id IS NOT NULL
MERGE (:Department {_id:file._id, name:file.name, number:file.number, _Section:file._Section});
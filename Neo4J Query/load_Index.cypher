LOAD CSV WITH HEADERS FROM 'file:///Index.csv' as file
WITH file WHERE file._id IS NOT NULL
MERGE (:Index {_id:file._id, code:file.code, name:file.name, _IndexGroup:file._IndexGroup});
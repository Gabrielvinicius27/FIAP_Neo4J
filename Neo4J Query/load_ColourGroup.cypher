LOAD CSV WITH HEADERS FROM 'file:///ColourGroup.csv' as file
WITH file WHERE file._id IS NOT NULL
MERGE (:ColourGroup {_id:file._id, code:file.code, name:file.name});
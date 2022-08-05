LOAD CSV WITH HEADERS FROM 'file:///GarmentGroup.csv' as file
WITH file WHERE file._id IS NOT NULL
MERGE (:GarmentGroup {_id:file._id, name:file.name, number:file.number});
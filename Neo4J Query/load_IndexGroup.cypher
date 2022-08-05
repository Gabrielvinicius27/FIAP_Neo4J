LOAD CSV WITH HEADERS FROM 'file:///IndexGroup.csv' AS line 
MERGE(:IndexGroup {_id:line._id, name:line.name, number:line.number});

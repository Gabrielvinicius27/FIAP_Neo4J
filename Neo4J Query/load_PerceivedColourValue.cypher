LOAD CSV WITH HEADERS FROM 'file:///PerceivedColourValue.csv' AS line 
MERGE(:PerceivedColourValue {_id:line._id, id:line.id, name:line.name});
LOAD CSV WITH HEADERS FROM 'file:///GraphicalAppearance.csv' AS line 
MERGE(:GraphicalAppearance {_id:line._id, name:line.name, number:line.number});
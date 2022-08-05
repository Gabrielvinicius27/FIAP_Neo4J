MATCH (a:Index) 
MATCH(b:IndexGroup) 
WHERE a.`_IndexGroup` = b.`_id` 
CREATE (a) -[r:PERTENCE_A]-> (b)  Return a,r,b

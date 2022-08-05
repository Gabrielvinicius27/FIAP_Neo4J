CALL {
MATCH (c:Customer {_id:$id})-[r:COMPROU]->(p:Product)<-[r2:COMPROU]-(c2:Customer)-[r3:COMPROU]->(p2:Product) 
WHERE c<>c2 AND NOT exists((c)-[:COMPROU]->(p2))
RETURN c, p2, count(p2) AS frequency
ORDER BY frequency DESC LIMIT 1
} 
MATCH (c)-[r:COMPROU]->(p:Product)<-[r2:COMPROU]-(c2:Customer)-[r3:COMPROU]->(p2) 
return *
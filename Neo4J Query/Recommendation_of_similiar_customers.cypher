// Recomendação com base em clientes que compraram o mesmo produto que eu, 
// mas eu não comprei o mesmo produto que eles
// retorna o produto que mais foi comprado por outros clientes, mas eu não comprei.

CALL {
MATCH (c:Customer {_id:$id})-[r:COMPROU]->(p:Product)<-[r2:COMPROU]-(c2:Customer)-[r3:COMPROU]->(p2:Product) 
WHERE c<>c2 AND NOT exists((c)-[:COMPROU]->(p2))
RETURN c, p2, count(p2) AS frequency
ORDER BY frequency DESC LIMIT 1
} 
MATCH (c)-[r:COMPROU]->(p:Product)<-[r2:COMPROU]-(c2:Customer)-[r3:COMPROU]->(p2) 
return *
// Recomendação com base no produto que eu mais comprei
// Retorna produtos com as mesmas caracteristicas do produto mais comprado por mim

CALL {
MATCH (c:Customer {_id:'1000001'})-[r:COMPROU]->(p:Product) 
RETURN c, p, count(p) AS frequency 
ORDER BY frequency DESC, p.name ASC 
LIMIT 1
} 
MATCH (p)-[r2:HAS_Department]->(d:Department)<-[r3:HAS_Department]-(p2) 
MATCH (p)-[r4:HAS_ColourGroup]->(cg:ColourGroup)<-[r5:HAS_ColourGroup]-(p2)
MATCH (p)-[r6:HAS_GarmentGroup]->(gg:GarmentGroup)<-[r7:HAS_GarmentGroup]-(p2) 
MATCH (p)-[r8:HAS_ProductType]->(pt:ProductType)<-[r9:HAS_ProductType]-(p2)
RETURN * LIMIT 20
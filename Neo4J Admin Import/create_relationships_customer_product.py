import pandas as pd

base_path = 'C:\\Users\\Bruna\\.Neo4jDesktop\\relate-data\\dbmss\\dbms-bd187d2e-6cf7-400f-bd40-0fa0ca6b5e04\\import'
# Ler arquivo Customer-001.csv
df = pd.read_csv(f'{base_path}/Customer-001.csv')

# Criar DataFrame relationships, deve conter as propriedades da relationship e os IDs de ligação
relationships_header = [':START_ID', ':END_ID', 'Price:float', 'Sales_Channel:int', 'Transaction_Date:date', ':TYPE']
#df_relationships_header = pd.DataFrame(relationships_header)
#df_relationships_header.to_csv(f'{base_path}/customer_products_relationship_header.csv', index=False, header=False)

df_relationships = df.drop(['active', 'age', 'club_member_status', 'fn', 'id', 'postal_code'], axis=1)
df_relationships['type'] = "COMPROU"
df_relationships.to_csv(f'{base_path}/customer_products_relationship.csv', index=False, header=relationships_header)
import pandas as pd

base_path = 'C:\\Users\\Bruna\\.Neo4jDesktop\\relate-data\\dbmss\\dbms-bd187d2e-6cf7-400f-bd40-0fa0ca6b5e04\\import'
# Ler arquivo Customer-001.csv
df = pd.read_csv(f'{base_path}/Customer-001.csv')

# Customer data columns
customer_data_columns = ['_id', 'active', 'age', 'club_member_status', 'fn', 'id', 'postal_code']

# Criar DataFrame customer_data, deve conter ID cliente e propriedades do cliente
customer_data_header = ["_id:ID", "active:float", 'age:int', 'club_member_status', 'fn:float', 'id', 'postal_code', ':LABEL']
#df_customer_data_header = pd.DataFrame(customer_data_header)
#df_customer_data_header.to_csv(f'{base_path}/customer_data_header.csv', index=False, header=False)

df_customer_data = df[customer_data_columns].drop_duplicates()
df_customer_data['label'] = "Customer"
df_customer_data.to_csv(f'{base_path}/customer_data.csv', index=False, header=customer_data_header)



import pandas as pd

base_path = 'C:\\Users\\Bruna\\.Neo4jDesktop\\relate-data\\dbmss\\dbms-bd187d2e-6cf7-400f-bd40-0fa0ca6b5e04\\import'
# Ler arquivo Product.csv
df = pd.read_csv(f'{base_path}/Product.csv', escapechar='\\')

# product data columns
product_data_columns = ['_id', 'code', 'description', 'name']

# Criar DataFrame product_data, deve conter ID cliente e propriedades do cliente
product_data_header = ["_id:ID", "code", 'description', 'name', ':LABEL']
#df_product_data_header = pd.DataFrame(product_data_header)
#df_product_data_header.to_csv(f'{base_path}/product_data_header.csv', index=False, header=False)

df_product_data = df[product_data_columns].drop_duplicates()
df_product_data['label'] = "Product"
df_product_data.to_csv(f'{base_path}/product_data.csv', index=False, header=product_data_header)



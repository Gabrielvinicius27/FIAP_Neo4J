import pandas as pd

base_path = 'C:\\Users\\Bruna\\.Neo4jDesktop\\relate-data\\dbmss\\dbms-bd187d2e-6cf7-400f-bd40-0fa0ca6b5e04\\import'
# Ler arquivo Product.csv
df = pd.read_csv(f'{base_path}/Product.csv', escapechar='\\')

columns = [column for column in df.columns if (str(column[0]) == '_' and column != '_id')]

for column in columns:
    df_temp = df[['_id', column]]
    df_temp = df_temp.rename(columns={'_id':':START_ID', column:':END_ID'})
    df_temp[':TYPE'] = f'HAS{column}'
    df_temp.to_csv(f'{base_path}/products{column}_relationship.csv', index=False, header=True)
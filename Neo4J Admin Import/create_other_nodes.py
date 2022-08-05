import pandas as pd

base_path = 'C:\\Users\\Bruna\\.Neo4jDesktop\\relate-data\\dbmss\\dbms-bd187d2e-6cf7-400f-bd40-0fa0ca6b5e04\\import'
nodes = ['ColourGroup', 'GraphicalAppearance', 'GarmentGroup', 'PerceivedColourValue', 'PerceivedColourMaster', 'Index', 'ProductType', \
    'Section', 'ProductGroup', 'IndexGroup', 'Department']

for node in nodes:
    # Ler arquivo csv
    df = pd.read_csv(f'{base_path}/{node}.csv')
    df.rename(columns={"_id":"_id:ID"}, inplace=True)

    columns = [column for column in df.columns if (str(column)[0] != '_' or str(column) == "_id:ID")]
    
    df_data = df[columns].drop_duplicates()
    df_data[':LABEL'] = node
    df_data.to_csv(f'{base_path}/{node}_node.csv', index=False, header=True)
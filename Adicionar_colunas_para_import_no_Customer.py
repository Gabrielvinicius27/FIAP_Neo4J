import pandas as pd

df = pd.read_csv('C:\\Users\\Bruna\\.Neo4jDesktop\\relate-data\\dbmss\\dbms-bd187d2e-6cf7-400f-bd40-0fa0ca6b5e04\\import\\Customer-001.csv')
df['Label'] = 'Customer'
print(df.head())

path = 'C:\\Users\\Bruna\\.Neo4jDesktop\\relate-data\\dbmss\\dbms-bd187d2e-6cf7-400f-bd40-0fa0ca6b5e04\\import\\Customer.csv'
df.to_csv(path, index=True, header=False)
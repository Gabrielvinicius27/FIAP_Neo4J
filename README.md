# FIAP_Neo4j

## Contexto 

Uma organização do segmento de varejo possui um conjunto de marcas e negócios com mais de 50 lojas online e 4500 lojas físicas gerando um alto volume de interações de seus clientes com diferentes tipos de produtos.

Esta organização possui uma aplicação web voltada para atender as vendas dos produtos de todas as suas marcas e negócios, com um sistema de compras para priorizar o envio dos produtos a partir de suas lojas, criando assim uma estrutura de armazenamento distribuído e aumentando a capacidade de envio e entrega de pedidos.

As marcas possuem formas de venda a seus clientes na web com site próprio interligado com a aplicação web da organização. Social media é utilizado de forma abrangente para cada marca para vendas.

Dentre os problemas encontrados na plataforma estão o tempo excessivo gasto pelos clientes para encontrarem os produtos e as marcas desejadas, além da realização de muitas devoluções de produtos.

## Desafio

A equipe de tecnologia da organização se depara com a necessidade de modernizar a arquitetura utilizada na sua aplicação web, com o objetivo de entregar melhor experiência de compra para seus clientes com mecanismos eficazes de recomendações de produtos.

Melhores recomendações teriam um impacto positivo em sustentabilidade, já que diminuiria a quantidade de produtos retornados e consequentemente reduziria as emissões que viriam pelo transporte destes produtos.

A equipe deverá buscar um caminho para realizar esse processo atendendo alguns requisitos:

a)    Construir um mecanismo para recomendações em real time;

b)    Tempo de indisponibilidade reduzido ou sem indisponibilidade para a plataforma web de vendas;

c)     Garantir a resiliência da aplicação, apresentando um caminho alternativo para um cenário de falha; e,

d)    Realizar a menor quantidade possível de alterações a nível da aplicação.

## Solução Proposta

Neste desafio vamos focar na utilização do Neo4j e nos mecânismos de recomendação, respondenda as questões de tempo de indisponibilidade, resiliência de aplicação e menor quantidade possível de alterações a nível de aplicação garantindo escalabilidade da aplicação o ideal seria a utilização do Neo4j na nuvem, uma sugestão é utilizar o Neo4j em um ambiente Kubernets na Google Cloud Platform, dessa forma em poucos minutos é possível criar um cluster com a image Enterprise do Neo4j para trabalhar com um grande volume de dados em nível empresarial 

Caso deseje seguir por esse caminho acesse esse artigo:
https://medium.com/google-cloud/launching-neo4j-on-googles-kubernetes-marketplace-97c23c94e960

![image 50%](https://user-images.githubusercontent.com/49615846/183983810-ef255c16-e112-4129-8a07-b07b467224c5.png)

Neste Repo a intenção é utilizar o Neo4j Desktop

### Relacionamento dos dados

As tabelas que iremos utilizar para criação dos grafos são tabelas sobre consumidores e produtos, podemos ver relacionamentos de compra, e propriedades do produto comprado, com base nas tabelas disponibilizadas nós desenvolvemos o seguinte modelo relacional:

![Modelo Dimensional ferramenta CASE](https://user-images.githubusercontent.com/49615846/183986994-1251cec4-e8bd-437a-8c13-715dbd8405e3.png)

### Ingestão dos dados

A partir desse modelo iremos fazer a ingestão das tabelas no Neo4j com uso do Neo4j-admin import, uma ferramenta que já vem pronta, é necessário disponibilizar as tabelas de nós e relacionamento no formato CSV.

Primeiro com base no modelo relacional nós definimos quais seriam nossos nós e relacionamentos
- Nós:
  * Customer
  * Product
  * ProductType
  * Department
  * Section
  * ColourGroup
  * GarmentGroup
  * GraphicalAppearance
  * Index
  * IndexGroup
  * PerceivedColourMaster
  * PerceivedColourValue
- Relacionamentos:
  * (:Customer)-[:COMPROU]->(:Product)
  * (:Product)-[:HAS_Department]->(:Department)
  * (:Product)-[:HAS_ProductType]->(:ProductType)
  * (:Product)-[:HAS_ColourGroup]->(:ColourGroup)
  * (:Product)-[:HAS_GarmentGroup]->(:GarmentGroup)
  * (:Product)-[:HAS_GraphicalAppearance]->(:GraphicalAppearance)
  * (:Product)-[:HAS_Index]->(:Index)
  * (:Product)-[:HAS_PerceivedColourValue]->(:PerceivedColourValue)
  * (:Product)-[:HAS_PerceivedColourMaster]->(:PerceivedColourMaster)
  * (:Department)-[:HAS_Section]->(:Section)
  * (:ProductType)-[:HAS_ProductGroup]->(:ProductGroup)
  * (:Index)-[:HAS_IndexGroup]->(:IndexGroup)
 
Com o mapeamento feito nós desenvolvemos scripts para criar os arquivos CSV de cada nó e relacionamento.

Os arquivos de nó precisara ter seu header renomeado, adicionando o tipo de dado no nome da coluna, por exemplo coluna age se tornou age:INT, e adicionando :ID na coluna que define qual o id único da tabela. 

Os arquivos de relacionamento foram criados e seu header precisou receber :START_ID para o ID do inicio do relacionamento e :END_ID para o ID do fim do relacionamento, esses arquivos também receberam as propriedades do relacionamento.

Os arquivos dentro da pasta Neo4j Admin Import criam essas tabelas mencionadas acima, o código abaixo faz a criação da tabela de nó produto a partir da tabela Product que foi disponibilizada no desafio

*Neo4J Admin Import/create_products_data.python*
```python
import pandas as pd

base_path = '$HOME\\.Neo4jDesktop\\relate-data\\dbmss\\dbms-bd187d2e-6cf7-400f-bd40-0fa0ca6b5e04\\import'
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
```
  
Este código faz a criação de todas as tabelas de relacionamento do nó product

*Neo4J Admin Import/create_products_data.python*
```python
import pandas as pd

base_path = '$HOME\\.Neo4jDesktop\\relate-data\\dbmss\\dbms-bd187d2e-6cf7-400f-bd40-0fa0ca6b5e04\\import'
# Ler arquivo Product.csv
df = pd.read_csv(f'{base_path}/Product.csv', escapechar='\\')

columns = [column for column in df.columns if (str(column[0]) == '_' and column != '_id')]

for column in columns:
    df_temp = df[['_id', column]]
    df_temp = df_temp.rename(columns={'_id':':START_ID', column:':END_ID'})
    df_temp[':TYPE'] = f'HAS{column}'
    df_temp.to_csv(f'{base_path}/products{column}_relationship.csv', index=False, header=True)
```

No Neo4j terminal copiar o que está no arquivo *import_all.bat* e colar na linha de comando na pasta \bin, será executada a execução do Neo4j-adimn

```
neo4j-admin import --nodes=import/customer_data.csv --nodes=import/product_data.csv --nodes=import/ColourGroup_node.csv --nodes=import/GraphicalAppearance_node.csv --nodes=import/GarmentGroup_node.csv --nodes=import/PerceivedColourValue_node.csv --nodes=import/PerceivedColourMaster_node.csv --nodes=import/Index_node.csv --nodes=import/ProductType_node.csv --nodes=import/Section_node.csv --nodes=import/ProductGroup_node.csv --nodes=import/IndexGroup_node.csv --nodes=import/Department_node.csv --relationships=import/customer_products_relationship.csv --relationships=import/products_ColourGroup_relationship.csv --relationships=import/products_GraphicalAppearance_relationship.csv --relationships=import/products_GarmentGroup_relationship.csv --relationships=import/products_PerceivedColourValue_relationship.csv --relationships=import/products_PerceivedColourMaster_relationship.csv --relationships=import/products_Index_relationship.csv --relationships=import/products_Department_relationship.csv --relationships=import/products_ProductType_relationship.csv --relationships=import/index_IndexGroup_relationship.csv --relationships=import/department_Section_relationship.csv --relationships=import/productType_ProductGroup_relationship.csv --force
```

Como resultado final teremos a ingestão de todos os nós e relações:

![image](https://user-images.githubusercontent.com/49615846/183993203-bc342d4a-d2ef-4281-b775-4b621104ee2a.png)

O modelo de grafos final usando um cliente e produto como exemplo:

![image](https://user-images.githubusercontent.com/49615846/183996706-c046925f-e78f-4fa2-85f9-68db3dd4b653.png)






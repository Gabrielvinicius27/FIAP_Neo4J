LOAD DATA INFILE '/Users/Bruna/.Neo4jDesktop/relate-data/dbmss/dbms-bd187d2e-6cf7-400f-bd40-0fa0ca6b5e04/import/Customer-001.csv' INTO TABLE
    fiap.customers 
    FIELDS TERMINATED BY ',' 
    LINES TERMINATED BY '\n' 
    IGNORE 1 ROWS 
    (_id,active,age,club_member_status,fn,id,postal_code,_Product,Price,Sales_Channel,Transaction_Date)

    
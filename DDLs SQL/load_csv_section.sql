LOAD DATA INFILE '/Users/Bruna/.Neo4jDesktop/relate-data/dbmss/dbms-bd187d2e-6cf7-400f-bd40-0fa0ca6b5e04/import/Section.csv' INTO TABLE
    fiap.section
    FIELDS TERMINATED BY ','
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS
    (_id, name, number);

   
LOAD DATA INFILE '/Users/Bruna/.Neo4jDesktop/relate-data/dbmss/dbms-bd187d2e-6cf7-400f-bd40-0fa0ca6b5e04/import/PerceivedColourMaster.csv' INTO TABLE
    fiap.perceived_colour_master
    FIELDS TERMINATED BY ','
    OPTIONALLY ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS
    (_id, id, name);

   

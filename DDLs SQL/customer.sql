CREATE TABLE IF NOT EXISTS fiap.customers (
    uniqueid INT NOT NULL AUTO_INCREMENT,
    _id INT NOT NULL,
    active FLOAT,
    age INT,
    club_member_status VARCHAR(255),
    fn FLOAT,
    id VARCHAR(255),
    postal_code VARCHAR(255),
    _Product INT,
    Price FLOAT,
    Sales_Channel INT,
    Transaction_Date DATE,
    PRIMARY KEY (uniqueid),
    FOREIGN KEY (_Product) REFERENCES fiap.products(_id)
);
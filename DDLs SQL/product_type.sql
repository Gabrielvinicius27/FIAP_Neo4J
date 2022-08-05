CREATE TABLE IF NOT EXISTS fiap.product_type (
    _id INT NOT NULL,
    name VARCHAR(255),
    number INT,
    _ProductGroup INT,
    PRIMARY KEY (_id),
    FOREIGN KEY (_ProductGroup) REFERENCES fiap.product_group (_id)
);
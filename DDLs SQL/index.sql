CREATE TABLE IF NOT EXISTS fiap.index (
    _id INT NOT NULL,
    code VARCHAR(255),
    name VARCHAR(255),
    _IndexGroup INT,
    PRIMARY KEY (_id),
    FOREIGN KEY (_IndexGroup) REFERENCES fiap.index_group (_id)
);
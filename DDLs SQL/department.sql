CREATE TABLE IF NOT EXISTS fiap.department (
    _id INT NOT NULL,
    name VARCHAR(255),
    number VARCHAR(255),
    _Section INT,
    PRIMARY KEY (_id),
    FOREIGN KEY (_Section) REFERENCES fiap.section(_id)
);
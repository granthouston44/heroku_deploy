DROP TABLE transactions;
DROP TABLE merchants;
DROP TABLE tags;

CREATE TABLE merchants
(
  id SERIAL8 PRIMARY KEY,
  merchant_name VARCHAR
);

CREATE TABLE tags
(
  id SERIAL8 PRIMARY KEY,
  tag_name VARCHAR 
);

CREATE TABLE transactions
(
  id SERIAL8 PRIMARY KEY,
  merchant_id INT REFERENCES merchants(id),
  tag_id INT REFERENCES tags(id),
  date_of_transaction VARCHAR,
  amount DECIMAL(6,2)
);

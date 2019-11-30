DROP TABLE transactions;
DROP TABLE merchants;
DROP TABLE tags;

CREATE TABLE merchants
(
  id SERIAL8 PRIMARY KEY,
  merchant_name VARCHAR not null
);

CREATE TABLE tags
(
  id SERIAL8 PRIMARY KEY,
  tag_name VARCHAR not null
);

CREATE TABLE transactions
(
  id SERIAL8 PRIMARY KEY,
  merchant_id INT REFERENCES merchants(id),
  tag_id INT REFERENCES tags(id),
  date_of_transaction DATE,
  amount DECIMAL(6,2)
);

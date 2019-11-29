DROP TABLE merchants;
DROP TABLE tags;

CREATE TABLE merchants
(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR not null
);

CREATE TABLE tags
(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR not null
);

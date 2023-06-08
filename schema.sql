CREATE TABLE books (
  id INT PRIMARY KEY,
  genre VARCHAR(255),
  author VARCHAR(255),
  source VARCHAR(255),
  label_id INT,
  publish_date DATE,
  publisher VARCHAR(255),
  cover_state VARCHAR(255),
  archived BOOLEAN,
  FOREIGN KEY (label_id) REFERENCES labels(id)
);

CREATE TABLE labels (
  id INT PRIMARY KEY,
  name VARCHAR(255)
);

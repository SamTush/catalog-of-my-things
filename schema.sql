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

CREATE TABLE musicalbum (
    id INT GENERATED ALWAYS AS IDENTITY,
    publish_date DATE,
    on_spotify BOOLEAN,
    archived BOOLEAN,
    genre_id INT,
    PRIMARY KEY(id),
    CONSTRAINT fk_genre FOREIGN KEY(genre_id) REFERENCES genre(id)
);
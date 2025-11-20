CREATE Table authors (
    author_id SERIAL PRIMARY KEY,
    author_name VARCHAR(255) NOT NULL
);

CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    published_year DATE,
    author_id INT NOT NULL,
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

ALTER TABLE books ADD COLUMN genre VARCHAR(100);
ALTER TABLE books ADD CONSTRAINT check_published_year CHECK (EXTRACT(YEAR FROM published_year) < 2025);

ALTER TABLE books DROP COLUMN author_id;

CREATE TABLE book_authors (
    author_id INT NOT NULL,
    book_id INT NOT NULL,
    PRIMARY KEY (author_id, book_id),
    FOREIGN KEY(author_id) REFERENCES authors(author_id),
    FOREIGN KEY(book_id) REFERENCES books(book_id)
);

create table temp_table (
    temp_column INT NOT NULL
);


DROP TABLE temp_table
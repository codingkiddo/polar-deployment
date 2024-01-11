CREATE TABLE book (
    id BIGSERIAL PRIMARY KEY NOT NULL,
    author varchar(255) NOT NULL,
    isbn varchar(255) UNIQUE NOT NULL,
    price float8 NOT NULL,
    title varchar(255) NOT NULL,
    created_date timestamp NOT NULL,
    last_modified_date timestamp NOT NULL,
    version integer NOT NULL
);

ALTER TABLE book ADD COLUMN publisher varchar(255);

INSERT INTO  book (id, author, isbn, price, title, created_date, last_modified_date, version, publisher) values (1, 'Vinod', '78978979', 3.3, 'Kumar', now(), now(), 1, 'Manning');
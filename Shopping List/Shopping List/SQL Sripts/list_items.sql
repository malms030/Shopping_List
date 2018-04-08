DROP TABLE list_items;

CREATE TABLE list_items(
id INTEGER REFERENCES Users,
item_name VARCHAR(100) NOT null,
qty INTEGER,
store VARCHAR(100),
dept VARCHAR(50),
description VARCHAR(500));

INSERT INTO list_items VALUES (1, 'Baby Carrots', 1, 'Cub', 'produce', 'organic');
SELECT item_name as Item, qty as QTY, store as Store, dept AS Department, description as Notes from list_items where id = 1;
INSERT INTO list_items VALUES (1, 'Milk', 1, 'Cub', 'dairy', 'organic milk is the best ya know');
DELETE FROM list_items WHERE id = 1 AND item_name LIKE '%milk%';
DELETE FROM list_items WHERE id = 1 AND item_name LIKE '%Baby Carrots%';
SELECT* FROM list_items;

DELETE FROM list_items;
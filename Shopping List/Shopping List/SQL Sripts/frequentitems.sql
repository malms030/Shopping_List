DROP TABLE freq_item;

CREATE TABLE freq_item(
id INTEGER REFERENCES users,
item_name VARCHAR(100) NOT NULL,
last_purchase_date DATE NOT NULL DEFAULT GETDATE());

SELECT * FROM freq_item;
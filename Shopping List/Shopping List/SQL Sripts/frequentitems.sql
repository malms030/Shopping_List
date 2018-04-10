DROP TABLE freq_item;

CREATE TABLE freq_item(
id INTEGER REFERENCES users,
item_name VARCHAR(100) NOT NULL,
description VARCHAR(500),
last_purchase_date DATE NOT NULL DEFAULT GETDATE());

SELECT * FROM freq_item;
DELETE FROM freq_item WHERE item_name LIKE '';
INSERT INTO freq_item VALUES(1, 'Strawberry', 'red', '3/12/2018')
UPDATE freq_item SET last_purchase_date = GETDATE() WHERE id =1;
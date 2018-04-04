DROP TABLE Users;
CREATE TABLE Users(
username VARCHAR(50) PRIMARY KEY ,
password VARCHAR(50) NOT null);


SELECT * FROM users;

SELECT * FROM users WHERE username LIKE 'test1' AND password LIKE '123';
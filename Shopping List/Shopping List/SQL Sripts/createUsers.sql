﻿DROP TABLE users;

CREATE TABLE users(
username VARCHAR(50) PRIMARY KEY,
firstname VARCHAR(50),
lastname VARCHAR(50),
email VARCHAR(50) NOT NULL,
password VARCHAR(50) NOT NULL);
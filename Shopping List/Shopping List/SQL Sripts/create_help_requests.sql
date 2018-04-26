DROP TABLE help_requests;

CREATE table help_requests(
id INT IDENTITY(1,1) PRIMARY KEY,
status VARCHAR(100) NOT NULL,
type VARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL,
phone_number VARCHAR(100),
details VARCHAR(5000) NOT NULL,
comments VARCHAR(5000) DEFAULT '',
date_opened DATE DEFAULT GETDATE());

SELECT * FROM help_requests;